import 'package:flutter/material.dart';

class ModernAlarmTimePicker extends StatefulWidget {
  final Function(TimeOfDay, String, bool, bool) onSave;

  const ModernAlarmTimePicker({
    Key? key,
    required this.onSave,
  }) : super(key: key);

  @override
  State<ModernAlarmTimePicker> createState() => _ModernAlarmTimePickerState();
}

class _ModernAlarmTimePickerState extends State<ModernAlarmTimePicker> {
  TimeOfDay _selectedTime = TimeOfDay.now();
  String _alarmName = '';
  bool _isWorkdays = false;
  bool _vibrate = true;
  String _ringtone = 'Default alarm sound';
  String _snoozeInterval = '5 minutes, 3 times';

  final List<int> hours = List.generate(24, (index) => index);
  final List<int> minutes = List.generate(60, (index) => index);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Text(
                    'New Alarm',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      widget.onSave(
                          _selectedTime, _alarmName, _isWorkdays, _vibrate);
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Save',
                      style: TextStyle(
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Time display
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text(
                'Ring in 1 day',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ),

            // Time picker
            Container(
              height: 200,
              margin: const EdgeInsets.symmetric(vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildWheelPicker(
                    items: hours,
                    selectedItem: _selectedTime.hour,
                    onChanged: (value) {
                      setState(() {
                        _selectedTime = TimeOfDay(
                            hour: value, minute: _selectedTime.minute);
                      });
                    },
                    suffix: 'h',
                  ),
                  const SizedBox(width: 8),
                  Text(
                    ':',
                    style: theme.textTheme.displaySmall?.copyWith(
                      color: theme.colorScheme.onSurface.withOpacity(0.5),
                    ),
                  ),
                  const SizedBox(width: 8),
                  _buildWheelPicker(
                    items: minutes,
                    selectedItem: _selectedTime.minute,
                    onChanged: (value) {
                      setState(() {
                        _selectedTime =
                            TimeOfDay(hour: _selectedTime.hour, minute: value);
                      });
                    },
                    suffix: 'min',
                  ),
                ],
              ),
            ),

            // Repeat options
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildOptionButton(
                    icon: Icons.alarm,
                    label: 'Once',
                    isSelected: !_isWorkdays,
                    onTap: () => setState(() => _isWorkdays = false),
                  ),
                  const SizedBox(width: 12),
                  _buildOptionButton(
                    icon: Icons.calendar_today,
                    label: 'Workdays',
                    isSelected: _isWorkdays,
                    onTap: () => setState(() => _isWorkdays = true),
                  ),
                ],
              ),
            ),

            // Settings
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Divider(),
            ),

            _buildSettingTile(
              icon: Icons.edit,
              title: 'Alarm name',
              value: _alarmName.isEmpty ? 'Add name' : _alarmName,
              onTap: _showNameDialog,
            ),
            _buildSettingTile(
              icon: Icons.music_note,
              title: 'Ringtone',
              value: _ringtone,
              onTap: () {
                // Show ringtone picker
              },
            ),
            _buildSettingTile(
              icon: Icons.vibration,
              title: 'Vibrate',
              value: _vibrate ? 'On' : 'Off',
              onTap: () => setState(() => _vibrate = !_vibrate),
            ),
            _buildSettingTile(
              icon: Icons.snooze,
              title: 'Snooze',
              value: _snoozeInterval,
              onTap: () {
                // Show snooze settings
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWheelPicker({
    required List<int> items,
    required int selectedItem,
    required Function(int) onChanged,
    required String suffix,
  }) {
    return Container(
      width: 80,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.3),
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListWheelScrollView(
        itemExtent: 50,
        diameterRatio: 1.7,
        physics: const FixedExtentScrollPhysics(),
        onSelectedItemChanged: onChanged,
        controller: FixedExtentScrollController(initialItem: selectedItem),
        children: items.map((item) {
          final isSelected = item == selectedItem;
          return Center(
            child: Text(
              '${item.toString().padLeft(2, '0')}$suffix',
              style: TextStyle(
                fontSize: isSelected ? 24 : 18,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                color: isSelected
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildOptionButton({
    required IconData icon,
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(32),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: isSelected
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.surfaceVariant,
            borderRadius: BorderRadius.circular(32),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                size: 20,
                color: isSelected
                    ? Theme.of(context).colorScheme.onPrimary
                    : Theme.of(context).colorScheme.onSurfaceVariant,
              ),
              const SizedBox(width: 8),
              Text(
                label,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: isSelected
                      ? Theme.of(context).colorScheme.onPrimary
                      : Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSettingTile({
    required IconData icon,
    required String title,
    required String value,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: Theme.of(context).colorScheme.onSurfaceVariant,
      ),
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.w500),
      ),
      subtitle: Text(
        value,
        style: TextStyle(
          color: Theme.of(context).colorScheme.onSurfaceVariant,
        ),
      ),
      trailing: Icon(
        Icons.chevron_right,
        color: Theme.of(context).colorScheme.onSurfaceVariant,
      ),
      onTap: onTap,
    );
  }

  Future<void> _showNameDialog() async {
    final controller = TextEditingController(text: _alarmName);
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Alarm name'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            hintText: 'Enter alarm name',
            border: OutlineInputBorder(),
          ),
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              setState(() => _alarmName = controller.text);
              Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}
