import 'package:flutter/material.dart';
import 'package:week_3_blabla_project/theme/theme.dart';

import '../actions/bla_button.dart';

class SeatNumberSpinner extends StatefulWidget {
  final int
      initialValue; // The spinner can be triggered with an existing number of seats

  const SeatNumberSpinner({
    super.key,
    required this.initialValue,
  });

  @override
  State<SeatNumberSpinner> createState() => _SeatNumberSpinnerState();
}

class _SeatNumberSpinnerState extends State<SeatNumberSpinner> {
  late int selectedSeats;

  @override
  void initState() {
    super.initState();
    selectedSeats = widget.initialValue;
  }

  void onBackSelected() {
    Navigator.of(context).pop();
  }

  void onSeatsSelected() {
    Navigator.of(context)
        .pop(selectedSeats); // Return the selected number of seats
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
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Number of seats",
                      style: BlaTextStyles.body.copyWith(
                        color: BlaColors.textNormal,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Decrement button
                        Container(
                          decoration: ShapeDecoration(
                            color: Colors.white,
                            shape: CircleBorder(
                              side: BorderSide(
                                  color: BlaColors.greyLight, width: 1),
                            ),
                          ),
                          child: IconButton(
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(
                                minWidth: 50, minHeight: 50),
                            icon: Icon(
                              Icons.remove,
                              color: selectedSeats > 1
                                  ? BlaColors.primary
                                  : BlaColors.greyLight,
                              size: 24,
                            ),
                            onPressed: selectedSeats > 1
                                ? () {
                                    setState(() {
                                      selectedSeats--;
                                    });
                                  }
                                : null,
                          ),
                        ),
                        const SizedBox(width: 24),
                        // Selected seat number
                        Text(
                          selectedSeats.toString(),
                          style: BlaTextStyles.heading.copyWith(
                            fontSize: 48,
                            color: BlaColors.neutralDark,
                          ),
                        ),
                        const SizedBox(width: 24),
                        // Increment button
                        Container(
                          decoration: ShapeDecoration(
                            color: Colors.white,
                            shape: CircleBorder(
                              side: BorderSide(
                                  color: BlaColors.primary, width: 1),
                            ),
                          ),
                          child: IconButton(
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(
                                minWidth: 50, minHeight: 50),
                            icon: Icon(
                              Icons.add,
                              color: BlaColors.primary,
                              size: 24,
                            ),
                            onPressed: () {
                              setState(() {
                                selectedSeats++;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // Confirm button
            Padding(
              padding: const EdgeInsets.all(BlaSpacings.m),
              child: BlaButton(
                text: 'Confirm',
                onPressed: onSeatsSelected, // Pass the selected number of seats
              ),
            ),
          ],
        ),
      ),
    );
  }
}