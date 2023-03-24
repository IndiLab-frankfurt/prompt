import 'dart:math';

import 'package:flutter/material.dart';
import 'package:prompt/shared/ui_helper.dart';

class TimePickerGridDialog extends StatefulWidget {
  @override
  _TimePickerGridDialogState createState() => _TimePickerGridDialogState();
}

class _TimePickerGridDialogState extends State<TimePickerGridDialog> {
  final _startTime = TimeOfDay(hour: 18, minute: 0);
  final _endTime = TimeOfDay(hour: 24, minute: 00);
  final _timeIncrement = const Duration(minutes: 30);

  TimeOfDay? _selectedTime;

  @override
  void initState() {
    super.initState();
    _selectedTime = _startTime;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        height: 400,
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: GridView.builder(
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0,
                    childAspectRatio: 1.5),
                itemCount: _getGridItemCount(),
                itemBuilder: (BuildContext context, int index) {
                  final time = _getTimeForIndex(index);
                  return GestureDetector(
                    onTap: () => _onTimeSelected(time),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        color:
                            time == _selectedTime ? Colors.blue : Colors.white,
                      ),
                      child: Center(
                        child: Text(
                          time.format(context),
                          style: TextStyle(
                            fontSize: 16.0,
                            color: time == _selectedTime
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            UIHelper.verticalSpaceMedium,
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(_selectedTime),
                  child: Text('OK'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  int _getGridItemCount() {
    final startTimeDuration =
        Duration(hours: _startTime.hour, minutes: _startTime.minute);
    final endTimeDuration =
        Duration(hours: _endTime.hour, minutes: _endTime.minute);
    return (endTimeDuration - startTimeDuration).inMinutes ~/
        _timeIncrement.inMinutes;
  }

  TimeOfDay _getTimeForIndex(int index) {
    final startTimeDuration =
        Duration(hours: _startTime.hour, minutes: _startTime.minute);
    final timeDuration = startTimeDuration +
        Duration(minutes: (index * _timeIncrement.inMinutes));
    final time =
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day)
            .add(timeDuration);
    return TimeOfDay(hour: time.hour, minute: time.minute);
  }

  void _onTimeSelected(TimeOfDay time) {
    setState(() {
      _selectedTime = time;
    });
    Navigator.of(context).pop(_selectedTime);
  }
}
