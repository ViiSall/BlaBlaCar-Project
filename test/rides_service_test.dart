import 'package:flutter_test/flutter_test.dart';  
import 'package:week_3_blabla_project/model/ride/locations.dart';
import 'package:week_3_blabla_project/model/ride/ride_filter.dart';
import 'package:week_3_blabla_project/model/ride_pref/ride_pref.dart';
import 'package:week_3_blabla_project/repository/mock/mock_rides_repository.dart';
import 'package:week_3_blabla_project/service/rides_service.dart';


void main() {
  group('RidesService Tests', () {
    // Initialize RidesService with MockRidesRepository
    final mockRepository = MockRidesRepository();
    RidesService.initialize(mockRepository);
    final ridesService = RidesService.instance;

    // Shared locations
    final battambang = Location(name: "Battambang", country: Country.cambodia);
    final siemReap = Location(name: "Siem Reap", country: Country.cambodia);

    test('T1: Create a ride preference with no filters', () {
      final ridePreference = RidePreference(
        departure: battambang,
        arrival: siemReap,
        departureDate: DateTime.now(),
        requestedSeats: 1,
      );

      final results = ridesService.getRidesFor(ridePreference, null);

      // Expect 5 results
      expect(results.length, 5);

      // Assert ride with no seats is included in warning
      final fullRides =
          results.where((ride) => ride.availableSeats == 0).toList();
      expect(fullRides.length, 1);
      expect(fullRides.first.driver.firstName, 'Chaylim');

      print("Warning: 1 ride is full!");
    });

    test('T2: Create a ride preference with pet filter', () {
      final ridePreference = RidePreference(
        departure: battambang,
        arrival: siemReap,
        departureDate: DateTime.now(),
        requestedSeats: 1,
      );

      final rideFilter = RideFilter(onlyPets: true);

      final results = ridesService.getRidesFor(ridePreference, rideFilter);

      // Expect only 1 result (Mengtech)
      expect(results.length, 1);
      expect(results.first.driver.firstName, 'Limhao');
    });
  });
}
