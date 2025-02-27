import 'package:week_3_blabla_project/service/rides_service.dart';

import 'model/ride/ride.dart';

void main() {
  DateTime today = DateTime.now();

  // Filter rides for today
  List<Ride> todayRides = RidesService.availableRides.where((ride) {
    return ride.departureDate.year == today.year &&
        ride.departureDate.month == today.month &&
        ride.departureDate.day == today.day;
  }).toList();

  // Display the rides
  print(
      "Rides available today (${today.toLocal().toIso8601String().split('T').first}):");
  if (todayRides.isEmpty) {
    print("No rides available today.");
  } else {
    for (var ride in todayRides) {
      print("""
Ride:
  From: ${ride.departureLocation.name}
  To: ${ride.arrivalLocation.name}
  Departure: ${ride.departureDate}
  Arrival: ${ride.arrivalDateTime}
  Driver: ${ride.driver.firstName} ${ride.driver.lastName}
  Available Seats: ${ride.availableSeats}
  Price per Seat: €${ride.pricePerSeat}
""");
    }
  }
}
