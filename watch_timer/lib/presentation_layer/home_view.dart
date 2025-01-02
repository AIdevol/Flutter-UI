import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:watch_timer/constants/colors.dart';

import 'clock_view.dart';
import 'stopwatch_view.dart';
import 'timer_view.dart';

class ClockScreen extends StatefulWidget {
  const ClockScreen({super.key});

  @override
  _ClockScreenState createState() => _ClockScreenState();
}

class _ClockScreenState extends State<ClockScreen> {
  int _selectedIndex = 0;

  final List<Widget> _tabs = [
    TimeTab(),
    StopwatchTab(),
    TimerTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: _getGradient(),
          ),
        ),
      ),
      body: Column(
        children: [
          // Tab Selector
          Container(
            decoration: BoxDecoration(gradient: _getGradient()),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildTabButton('Time', 0),
                _buildTabButton('Stopwatch', 1),
                _buildTabButton('Timer', 2),
                InkWell(
                  onTap: () {},
                  child: Icon(
                    Icons.more_vert,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
          // Active Tab Content
          Expanded(
            child: _tabs[_selectedIndex],
          ),
        ],
      ),
    );
  }

  // Tab button builder
  Widget _buildTabButton(String title, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
      },
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(
              color: _selectedIndex == index ? Colors.white : Colors.white54,
              fontWeight: FontWeight.bold,
            ),
          ),
          if (_selectedIndex == index)
            Container(
              margin: EdgeInsets.only(top: 5),
              height: 3,
              width: 60,
              color: Colors.white,
            ),
        ],
      ),
    );
  }

  // Gradient color based on selected index
  LinearGradient _getGradient() {
    switch (_selectedIndex) {
      case 0:
        return timerColor; // Stopwatch gradient
      case 1:
        return stopWatchColor; // Timer gradient
      case 2:
        return timer1Color;
      default:
        return timerColor; // Default gradient for Time
    }
  }
}
