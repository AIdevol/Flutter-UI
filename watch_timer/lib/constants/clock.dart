import 'package:flutter/material.dart';
import 'package:analog_clock/analog_clock.dart';
import 'package:intl/intl.dart';

class CustomClockView extends StatelessWidget {
  const CustomClockView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              Container(
                width: 250,
                height: 250,
                decoration: BoxDecoration(),
                child: AnalogClock(
                  decoration: BoxDecoration(
                    border: Border.all(width: 0.0, color: Colors.transparent),
                    color: Colors.transparent,
                  ),
                  width: 250.0,
                  isLive: true,
                  hourHandColor: Colors.white,
                  minuteHandColor: Colors.white,
                  secondHandColor: Colors.white,
                  showSecondHand: true,
                  numberColor: Colors.white.withOpacity(0.6),
                  showNumbers: false,
                  showAllNumbers: false,
                  textScaleFactor: 1.4,
                  showTicks: true,
                  tickColor: Colors.white.withOpacity(0.6),
                ),
              ),
              // const SizedBox(height: 20),
              StreamBuilder(
                stream: Stream.periodic(const Duration(seconds: 1)),
                builder: (context, snapshot) {
                  return Text(
                    DateFormat('HH:mm').format(DateTime.now()),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                      fontWeight: FontWeight.w300,
                    ),
                  );
                },
              ),

              // Date Display
              StreamBuilder(
                stream: Stream.periodic(const Duration(seconds: 1)),
                builder: (context, snapshot) {
                  return Text(
                    DateFormat('E, MMMM d').format(DateTime.now()),
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                      fontSize: 10,
                      fontWeight: FontWeight.w300,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
