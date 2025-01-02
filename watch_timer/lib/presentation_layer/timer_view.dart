import 'package:flutter/material.dart';
import 'dart:async';

class TimerTab extends StatefulWidget {
  @override
  _TimerTabState createState() => _TimerTabState();
}

class _TimerTabState extends State<TimerTab> {
  final List<Map<String, dynamic>> frequentTimers = [
    {'name': 'Brush teeth', 'duration': Duration(minutes: 2)},
    {'name': 'Face mask', 'duration': Duration(minutes: 15)},
    {'name': 'Boil eggs', 'duration': Duration(minutes: 10)},
    {'name': 'Nap', 'duration': Duration(minutes: 30)},
  ];

  Duration selectedDuration = Duration.zero;
  Duration currentDuration = Duration.zero;
  bool isRunning = false;
  Timer? timer;

  // Time components
  int hours = 0;
  int minutes = 0;
  int seconds = 0;

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void startTimer() {
    if (currentDuration.inSeconds > 0) {
      setState(() {
        isRunning = true;
      });

      timer = Timer.periodic(Duration(seconds: 1), (timer) {
        setState(() {
          if (currentDuration.inSeconds > 0) {
            currentDuration = currentDuration - Duration(seconds: 1);
          } else {
            timer.cancel();
            isRunning = false;
            // Here you could add sound/vibration for timer completion
          }
        });
      });
    }
  }

  void pauseTimer() {
    setState(() {
      isRunning = false;
      timer?.cancel();
    });
  }

  void resetTimer() {
    setState(() {
      isRunning = false;
      timer?.cancel();
      currentDuration = selectedDuration;
    });
  }

  void updateTime(String unit, bool increment) {
    setState(() {
      switch (unit) {
        case 'hours':
          hours = increment ? (hours + 1) % 24 : (hours - 1 + 24) % 24;
          break;
        case 'minutes':
          minutes = increment ? (minutes + 1) % 60 : (minutes - 1 + 60) % 60;
          break;
        case 'seconds':
          seconds = increment ? (seconds + 1) % 60 : (seconds - 1 + 60) % 60;
          break;
      }
      selectedDuration =
          Duration(hours: hours, minutes: minutes, seconds: seconds);
      currentDuration = selectedDuration;
    });
  }

  void selectPresetTimer(Duration duration) {
    setState(() {
      selectedDuration = duration;
      currentDuration = duration;
      hours = duration.inHours;
      minutes = (duration.inMinutes % 60);
      seconds = (duration.inSeconds % 60);
    });
  }

  Widget _buildTimeColumn(String unit, String value) {
    String topValue = ((int.parse(value) + 1) % (unit == 'hours' ? 24 : 60))
        .toString()
        .padLeft(2, '0');
    String bottomValue = ((int.parse(value) - 1 + (unit == 'hours' ? 24 : 60)) %
            (unit == 'hours' ? 24 : 60))
        .toString()
        .padLeft(2, '0');

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: () => updateTime(unit, true),
          child: Text(topValue,
              style: TextStyle(color: Colors.white24, fontSize: 32)),
        ),
        Text(value,
            style: TextStyle(
                color: Colors.white,
                fontSize: 48,
                fontWeight: FontWeight.w300)),
        GestureDetector(
          onTap: () => updateTime(unit, false),
          child: Text(bottomValue,
              style: TextStyle(color: Colors.white24, fontSize: 32)),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    String hoursStr = currentDuration.inHours.toString().padLeft(2, '0');
    String minutesStr =
        (currentDuration.inMinutes % 60).toString().padLeft(2, '0');
    String secondsStr =
        (currentDuration.inSeconds % 60).toString().padLeft(2, '0');

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildTimeColumn('hours', hoursStr),
                        Text(':',
                            style:
                                TextStyle(color: Colors.white, fontSize: 48)),
                        _buildTimeColumn('minutes', minutesStr),
                        Text(':',
                            style:
                                TextStyle(color: Colors.white, fontSize: 48)),
                        _buildTimeColumn('seconds', secondsStr),
                      ],
                    ),
                    SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (!isRunning) ...[
                          GestureDetector(
                            onTap: startTimer,
                            child: Container(
                              width: 64,
                              height: 64,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.blue,
                              ),
                              child: Icon(Icons.play_arrow,
                                  color: Colors.white, size: 32),
                            ),
                          ),
                        ] else ...[
                          GestureDetector(
                            onTap: pauseTimer,
                            child: Container(
                              width: 64,
                              height: 64,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.orange,
                              ),
                              child: Icon(Icons.pause,
                                  color: Colors.white, size: 32),
                            ),
                          ),
                        ],
                        SizedBox(width: 20),
                        GestureDetector(
                          onTap: resetTimer,
                          child: Container(
                            width: 64,
                            height: 64,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.red,
                            ),
                            child:
                                Icon(Icons.stop, color: Colors.white, size: 32),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Frequently used timers',
                          style: TextStyle(color: Colors.white, fontSize: 18)),
                      TextButton(
                        onPressed: () {},
                        child: Text('Add',
                            style: TextStyle(color: Colors.blue, fontSize: 16)),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  ...frequentTimers.map((timer) => GestureDetector(
                        onTap: () => selectPresetTimer(timer['duration']),
                        child: _buildTimerItem(
                          timer['name'],
                          timer['duration'],
                        ),
                      )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTimerItem(String name, Duration duration) {
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(name, style: TextStyle(color: Colors.white, fontSize: 16)),
          Text(
              '${duration.inMinutes.toString().padLeft(2, '0')}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}',
              style: TextStyle(color: Colors.white, fontSize: 16)),
        ],
      ),
    );
  }
}
