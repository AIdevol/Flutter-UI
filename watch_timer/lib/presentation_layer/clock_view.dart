import 'package:flutter/material.dart';
import 'package:watch_timer/constants/colors.dart';

import '../constants/alarm_add.dart';
import '../constants/clock.dart';

class TimeTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: timerColor // Example gradient
          ),
      child: Column(
        children: [
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(child: CustomClockView()),
                ],
              ),
            ),
          ),
          Expanded(child: AlarmScreen()),
        ],
      ),
    );
  }
}

class AlarmScreen extends StatefulWidget {
  @override
  _AlarmScreenState createState() => _AlarmScreenState();
}

class _AlarmScreenState extends State<AlarmScreen> {
  bool _isTapped = false;
  final List<Map<String, dynamic>> alarms = [
    {'time': '08:00', 'description': 'Every day', 'isActive': true},
    {'time': '09:00', 'description': 'Every day', 'isActive': false},
    {
      'time': '10:30',
      'description': 'Sun, Mon, Tue, Wed, Thu, Fri',
      'isActive': true
    },
    {'time': '21:10', 'description': 'Every day', 'isActive': true},
    {'time': '22:00', 'description': 'Every day', 'isActive': false},
  ];

  // Build Alarm Tile Widget
  Widget _buildAlarmTile(
      BuildContext context, String time, String description, bool isActive) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      child: ListTile(
        title: Text(
          time,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(description),
        trailing: Switch(
          value: isActive,
          onChanged: (value) {
            setState(() {
              // Update the alarm state
              final index = alarms.indexWhere((alarm) =>
                  alarm['time'] == time && alarm['description'] == description);
              if (index != -1) alarms[index]['isActive'] = value;
            });
          },
        ),
        onTap: () {
          // Show bottom sheet when the tile is tapped
          _bottomSwitchView(context, time, description, isActive, (value) {
            setState(() {
              // Update the alarm state in bottom sheet
              final index = alarms.indexWhere((alarm) =>
                  alarm['time'] == time && alarm['description'] == description);
              if (index != -1) alarms[index]['isActive'] = value;
            });
          });
        },
      ),
    );
  }

  // Show Bottom Sheet with Alarm Details
  void _bottomSwitchView(BuildContext context, String time, String description,
      bool isActive, Function(bool) onChanged) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 20, 16, 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(
                  time,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    description,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14,
                    ),
                  ),
                ),
                trailing: Switch.adaptive(
                  value: isActive,
                  onChanged: onChanged,
                  activeColor: Theme.of(context).primaryColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: alarms.length,
                  itemBuilder: (context, index) {
                    final alarm = alarms[index];
                    return _buildAlarmTile(context, alarm['time'],
                        alarm['description'], alarm['isActive']);
                  },
                ),
              ),
            ],
          ),
        ),
        Positioned(bottom: 50, right: 25, child: _customeWidgetView(context))
      ],
    );
  }

  Widget _customeWidgetView(BuildContext context) {
    return Container(
      height: 60,
      width: 60,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: timerColor,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade100,
            blurRadius: 10,
            blurStyle: BlurStyle.outer,
            spreadRadius: 2.0,
          )
        ],
      ),
      child: IconButton(
        onPressed: () {
          // _isTapped ? showAlarmPicker(context) : null;
          setState(() {
            _isTapped = !_isTapped;
            showAlarmPicker(context);
          });
        },
        icon: Icon(
          _isTapped ? Icons.close : Icons.add,
          size: 40,
          color: Colors.white,
        ),
      ),
    );
  }
}

void showAlarmPicker(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => ModernAlarmTimePicker(
      onSave: (time, name, isWorkdays, vibrate) {
        print('Time: ${time.format(context)}');
        print('Name: $name');
        print('Workdays: $isWorkdays');
        print('Vibrate: $vibrate');
      },
    ),
  );
}
