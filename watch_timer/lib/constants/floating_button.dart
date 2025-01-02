import 'package:flutter/material.dart';
import 'package:analog_clock/analog_clock.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:intl/intl.dart';

class ClockWithFAB extends StatefulWidget {
  const ClockWithFAB({Key? key}) : super(key: key);

  @override
  State<ClockWithFAB> createState() => _ClockWithFABState();
}

class _ClockWithFABState extends State<ClockWithFAB> {
  final _key = GlobalKey<ExpandableFabState>();

  void _showTimePicker() async {
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (time != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Selected time: ${time.format(context)}')),
      );
    }
  }

  void _showDatePicker() async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (date != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content:
                Text('Selected date: ${DateFormat('MMM d, y').format(date)}')),
      );
    }
  }

  void _setAlarm() {
    // Add your alarm functionality here
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Setting alarm...')),
    );
  }

  void _setTimer() {
    // Add your timer functionality here
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Setting timer...')),
    );
  }

  void _toggleStopwatch() {
    // Add your stopwatch functionality here
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Opening stopwatch...')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ExpandableFab(
      key: _key,
      type: ExpandableFabType.fan,
      distance: 80,
      children: [
        FloatingActionButton.small(
          heroTag: 'alarm',
          child: const Icon(Icons.alarm),
          onPressed: _setAlarm,
        ),
        FloatingActionButton.small(
          heroTag: 'timer',
          child: const Icon(Icons.timer),
          onPressed: _setTimer,
        ),
        FloatingActionButton.small(
          heroTag: 'stopwatch',
          child: const Icon(Icons.timer_outlined),
          onPressed: _toggleStopwatch,
        ),
        FloatingActionButton.small(
          heroTag: 'time',
          child: const Icon(Icons.access_time),
          onPressed: _showTimePicker,
        ),
        FloatingActionButton.small(
          heroTag: 'date',
          child: const Icon(Icons.calendar_today),
          onPressed: _showDatePicker,
        ),
      ],
    );
  }
}
