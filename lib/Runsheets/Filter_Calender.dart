import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void showDemoDialog(
    {required BuildContext context,
    required Function(DateTime) onDateSelected}) {
  showDialog(
    context: context,
    builder: (BuildContext context) =>
        CalendarDialog(onDateSelected: onDateSelected),
  );
}

class CalendarDialog extends StatefulWidget {
  final Function(DateTime) onDateSelected;

  CalendarDialog({required this.onDateSelected});

  @override
  _CalendarDialogState createState() => _CalendarDialogState();
}

class _CalendarDialogState extends State<CalendarDialog> {
  late DateTime selectedDate;

  @override
  void initState() {
    super.initState();
    selectedDate = DateTime.now();
  }

  Future<void> _selectDate(BuildContext context) async {
    final initialDate = selectedDate;
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2021),
      lastDate: DateTime(2025),
    );
    if (pickedDate != null && pickedDate != initialDate) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Select Date'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: Text(
              'Selected Date: ${DateFormat('dd MMM, yyyy').format(selectedDate)}',
            ),
            trailing: const Icon(Icons.calendar_today_outlined),
            onTap: () => _selectDate(context),
          ),
        ],
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            widget.onDateSelected(
                selectedDate); // Pass the selected date back to the parent widget
            Navigator.of(context).pop();
          },
          child: const Text('OK'),
        ),
      ],
    );
  }
}
