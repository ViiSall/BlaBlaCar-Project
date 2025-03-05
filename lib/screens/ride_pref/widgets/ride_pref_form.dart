import 'package:flutter/material.dart';
import 'package:week_3_blabla_project/screens/ride_pref/widgets/ride_pref_input_tile.dart';
import 'package:week_3_blabla_project/utils/date_time_util.dart';
import 'package:week_3_blabla_project/widgets/inputs/bla_location_picker.dart';

import '../../../dummy_data/dummy_data.dart';
import '../../../model/ride/locations.dart';
import '../../../model/ride_pref/ride_pref.dart';
import '../../../theme/theme.dart';
import '../../../widgets/actions/bla_button.dart';
import '../../../widgets/display/bla_divider.dart';
import '../../ride/ride_screen.dart';

///
/// A Ride Preference From is a view to select:
///   - A depcarture location
///   - An arrival location
///   - A date
///   - A number of seats
///
/// The form can be created with an existing RidePref (optional).
///
class RidePrefForm extends StatefulWidget {
  // The form can be created with an optional initial RidePref.
  final RidePref? initRidePref;

  const RidePrefForm({super.key, this.initRidePref});

  @override
  State<RidePrefForm> createState() => _RidePrefFormState();
}

class _RidePrefFormState extends State<RidePrefForm> {
  Location? departure;
  late DateTime departureDate;
  Location? arrival;
  late int requestedSeats;

  // ----------------------------------
  // Initialize the Form attributes
  // ----------------------------------

  @override
  void initState() {
    super.initState();
    // TODO
    if (widget.initRidePref != null) {
      departure = widget.initRidePref!.departure;
      departureDate = widget.initRidePref!.departureDate;
      arrival = widget.initRidePref!.arrival;
      requestedSeats = widget.initRidePref!.requestedSeats;
    } else {
      departure = null;
      departureDate = DateTime.now();
      arrival = null;
      requestedSeats = 1; // default
    }
  }

  // ----------------------------------
  // Handle events
  // ----------------------------------

  void onDeparturePressed() async {
    // Select a location from BlaLocationPicker
    Location? selectedLocation = await Navigator.of(context).push<Location>(
        MaterialPageRoute(builder: (ctx) => BlaLocationPicker()));

    // Update the form
    if (selectedLocation != null) {
      setState(() {
        departure = selectedLocation;
      });
    }
  }

  void onArrivalPressed() async {
    // Select a location from BlaLocationPicker
    Location? selectedLocation = await Navigator.of(context).push<Location>(
        MaterialPageRoute(builder: (ctx) => BlaLocationPicker()));

    // Update the form
    if (selectedLocation != null) {
      setState(() {
        arrival = selectedLocation;
      });
    }
  }

  void onSwappingLocationPressed() {
    setState(() {
      // Switch only if both departure and arrival are defined
      if (departure != null && arrival != null) {
        Location temp = departure!;
        departure = Location.copy(arrival!);
        arrival = Location.copy(temp);
      }
    });
  }

  void _onSearchPressed() {
    if (departure != null && arrival != null) {
      RidePref ridePref = RidePref(
        departure: departure!,
        arrival: arrival!,
        departureDate: departureDate,
        requestedSeats: requestedSeats,
      );
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => RidesScreen(
            ridePref: ridePref,
            rides: fakeRides,
          ),
        ),
      );
    }
  }

  // ----------------------------------
  // Compute the widgets rendering
  // ----------------------------------

  String get departureLabel =>
      departure != null ? departure!.name : "Leaving from";
  String get arrivalLabel => arrival != null ? arrival!.name : "Going to";

  bool get showDeparturePLaceHolder => departure == null;
  bool get showArrivalPLaceHolder => arrival == null;

  String get dateLabel => DateTimeUtils.formatDateTime(departureDate);
  String get numberLabel => requestedSeats.toString();

  bool get switchVisible => arrival != null && departure != null;

  // ----------------------------------
  // Build the widgets
  // ----------------------------------
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: BlaSpacings.m),
          child: Column(
            children: [
              // Input the ride departure
              RidePrefInputTile(
                isPlaceHolder: showDeparturePLaceHolder,
                title: departureLabel,
                leftIcon: Icons.location_on,
                onPressed: onDeparturePressed,
                rightIcon: switchVisible ? Icons.swap_vert : null,
                onRightIconPressed:
                    switchVisible ? onSwappingLocationPressed : null,
              ),
              const BlaDivider(),

              // Input the ride arrival
              RidePrefInputTile(
                  isPlaceHolder: showArrivalPLaceHolder,
                  title: arrivalLabel,
                  leftIcon: Icons.location_on,
                  onPressed: onArrivalPressed),
              const BlaDivider(),

              // Input the ride date
              RidePrefInputTile(
                  title: dateLabel,
                  leftIcon: Icons.calendar_month,
                  onPressed: () => {}),
              const BlaDivider(),

              // Input the requested number of seats
              RidePrefInputTile(
                title: numberLabel,
                leftIcon: Icons.person_2_outlined,
                onPressed: () => {},
              )
            ],
          ),
        ),

        // Search BlaButton
        BlaButton(text: 'Search', onPressed: _onSearchPressed),
      ],
    );
  }
}
