import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

import '../constants/colors.dart';

class StopwatchTab extends StatefulWidget {
  @override
  _StopwatchTabState createState() => _StopwatchTabState();
}

class _StopwatchTabState extends State<StopwatchTab> {
  Stopwatch _stopwatch = Stopwatch();
  Timer? _timer;
  String _formattedTime = "00:00.00";

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(milliseconds: 16), _updateTime);
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _updateTime(Timer timer) {
    if (_stopwatch.isRunning) {
      setState(() {
        _formattedTime = _formatTime(_stopwatch.elapsedMilliseconds);
      });
    }
  }

  String _formatTime(int milliseconds) {
    int hundreds = (milliseconds / 10).truncate() % 100;
    int seconds = (milliseconds / 1000).truncate() % 60;
    int minutes = (milliseconds / (1000 * 60)).truncate();

    return "${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}.${hundreds.toString().padLeft(2, '0')}";
  }

  void _toggleStopwatch() {
    setState(() {
      if (_stopwatch.isRunning) {
        _stopwatch.stop();
      } else {
        _stopwatch.start();
      }
    });
  }

  void _resetStopwatch() {
    setState(() {
      _stopwatch.reset();
      _formattedTime = "00:00.00";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: stopWatchColor),
      child: Column(
        children: [
          // Padding(
          //   padding: const EdgeInsets.symmetric(vertical: 16.0),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: [
          //       _buildTabButton('Time', false),
          //       _buildTabButton('Stopwatch', true),
          //       _buildTabButton('Timer', false),
          //     ],
          //   ),
          // ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomPaint(
                  size: Size(350, 350), // Increased size
                  painter: StopwatchPainter(
                    progress: _stopwatch.elapsedMilliseconds /
                        (60 * 1000), // One-minute cycle
                    formattedTime: _formattedTime,
                  ),
                ),
                SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildControlButton(
                      icon: Icons.stop,
                      onPressed: _resetStopwatch,
                    ),
                    SizedBox(width: 32),
                    _buildControlButton(
                      icon:
                          _stopwatch.isRunning ? Icons.pause : Icons.play_arrow,
                      onPressed: _toggleStopwatch,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabButton(String text, bool isSelected) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: isSelected ? Colors.white : Colors.white.withOpacity(0.5),
        ),
      ),
    );
  }

  Widget _buildControlButton({
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
      ),
      child: IconButton(
        icon: Icon(icon),
        onPressed: onPressed,
        color: Color(0xFF483078),
        iconSize: 24,
      ),
    );
  }
}

class StopwatchPainter extends CustomPainter {
  final double progress;
  final String formattedTime;

  StopwatchPainter({required this.progress, required this.formattedTime});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = min(size.width, size.height) / 2;

    // Draw tick marks
    final tickPaint = Paint()
      ..color = Colors.white.withOpacity(0.3)
      ..strokeWidth = 1;

    for (int i = 0; i < 60; i++) {
      final angle = (2 * pi * i) / 60;
      final outerPoint = Offset(
        center.dx + (radius - 10) * cos(angle),
        center.dy + (radius - 10) * sin(angle),
      );
      final innerPoint = Offset(
        center.dx + (radius - 20) * cos(angle),
        center.dy + (radius - 20) * sin(angle),
      );
      canvas.drawLine(innerPoint, outerPoint, tickPaint);
    }

    // Draw progress arc
    final progressPaint = Paint()
      ..color = Colors.white
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke;

    final progressAngle = 2 * pi * progress;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius - 15),
      -pi / 2,
      progressAngle,
      false,
      progressPaint,
    );

    // Draw formatted time in the middle
    final textPainter = TextPainter(
      text: TextSpan(
        text: formattedTime,
        style: TextStyle(
          fontSize: 32,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    final textOffset = Offset(
      center.dx - textPainter.width / 2,
      center.dy - textPainter.height / 2,
    );
    textPainter.paint(canvas, textOffset);
  }

  @override
  bool shouldRepaint(StopwatchPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.formattedTime != formattedTime;
  }
}
