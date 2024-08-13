import 'package:flutter/material.dart';

class DatePicker extends StatefulWidget {
  @override
  _DatePicker createState() => _DatePicker();
}

class _DatePicker extends State<DatePicker> {
  DateTime? _selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
          _selectedDate = pickedDate;
      });

      if (pickedDate != null) {
        // Then, show the time picker
        final TimeOfDay? pickedTime = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.fromDateTime(now),
        );

        if (pickedTime != null) {
          // Combine the date and time
          final DateTime selectedDateTime = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime.hour,
            pickedTime.minute,
          );

          setState(() {
              _selectedDate = selectedDateTime;
          });

          _showDateAlert(context, selectedDateTime);
        }

      }
    }
  }

  void _showDateAlert(BuildContext context, DateTime date) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Selected Date'),
          content: Text('You selected: ${date.toLocal()}'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () => _selectDate(context),
        child: Text('Pick a date'),
      ),
    );
  }
}
