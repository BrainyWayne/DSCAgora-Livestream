import 'package:flutter/material.dart';

class Picker {
  Future<TimeOfDay> pickTime(BuildContext context) async {
    TimeOfDay time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    return time;
  }

  Future<DateTime> pickDate(BuildContext context, {DateTime startFrom}) async {
    if (startFrom == null) {
      startFrom = DateTime.now().subtract(Duration(days: 1));
    }
    DateTime date = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: (startFrom),
        lastDate: DateTime(3000).toLocal());

    return date;
  }
}
