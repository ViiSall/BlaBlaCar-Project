import 'package:flutter/material.dart';
import 'package:week_3_blabla_project/theme/theme.dart';

import '../actions/bla_button.dart';

///
/// This full-screen modal is in charge of providing (if confirmed) a selected date.
///
class BlaDatePicker extends StatefulWidget {
  final DateTime?
      initialDate; // The picker can be triggered with an existing date

  const BlaDatePicker({super.key, this.initialDate});

  @override
  State<BlaDatePicker> createState() => _BlaDatePickerState();
}

class _BlaDatePickerState extends State<BlaDatePicker> {
  late DateTime selectedDate;

  @override
  void initState() {
    super.initState();
    selectedDate = widget.initialDate ?? DateTime.now();
  }

  void onBackSelected() {
    Navigator.of(context).pop();
  }

  void onDateSelected(DateTime date) {
    Navigator.of(context).pop(date);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(
          left: BlaSpacings.m,
          right: BlaSpacings.m,
          top: BlaSpacings.s,
        ),
        child: Column(
          children: [
            Expanded(
              child: CalendarDatePicker(
                initialDate: selectedDate,
                firstDate: DateTime.now(),
                lastDate: DateTime.now().add(const Duration(days: 365)),
                onDateChanged: (date) {
                  setState(() {
                    selectedDate = date;
                  });
                },
              ),
            ),

            // Confirm button
            Padding(
              padding: const EdgeInsets.all(BlaSpacings.m),
              child: BlaButton(
                text: 'Confirm',
                onPressed: () => onDateSelected(selectedDate),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
