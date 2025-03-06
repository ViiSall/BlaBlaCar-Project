import 'package:week_3_blabla_project/model/ride/locations.dart';
import 'package:week_3_blabla_project/model/ride/ride.dart';

import 'package:week_3_blabla_project/model/ride/ride_filter.dart';
import 'package:week_3_blabla_project/model/ride_pref/ride_pref.dart';
import 'package:week_3_blabla_project/repository/ride_repository.dart';



import '../../model/user/user.dart';

class MockRidesRepository extends RidesRepository {
  final List<Ride> _allRides = [];

  MockRidesRepository() {
    // FAKE USERS

    User kanika = User(firstName: "Kannika");
    User chaylim = User(firstName: "Chaylim");
    User mengtech = User(firstName: "Mengtech");
    User limhao = User(firstName: "Limhao");
    User sovanda = User(firstName: "Sovanda");

    // FAKE LOCATIONS

    Location battambang = Location(name: "Battambang", country: Country.cambodia);
    Location siemReap = Location(name: "Siem Reap", country: Country.cambodia);

    // FAKE RIDES

    Ride ride1 = Ride(
        departureLocation: battambang,
        departureDate: DateTime.now().copyWith(hour: 17, minute: 30),
        arrivalLocation: siemReap,
        arrivalDateTime: DateTime.now().copyWith(hour: 19, minute: 30),
        driver: kanika,
        availableSeats: 2,
        pricePerSeat: 10,
        acceptPets: false);

    Ride ride2 = Ride(
        departureLocation: battambang,
        departureDate: DateTime.now().copyWith(hour: 20, minute: 00),
        arrivalLocation: siemReap,
        arrivalDateTime: DateTime.now().copyWith(hour: 22, minute: 00),
        driver: chaylim,
        availableSeats: 0,
        pricePerSeat: 10,
        acceptPets: false);

    Ride ride3 = Ride(
        departureLocation: battambang,
        departureDate: DateTime.now().copyWith(hour: 17, minute: 00),
        arrivalLocation: siemReap,
        arrivalDateTime: DateTime.now().copyWith(hour: 21, minute: 00),
        driver: mengtech,
        availableSeats: 1,
        pricePerSeat: 10,
        acceptPets: false);

    Ride ride4 = Ride(
        departureLocation: battambang,
        departureDate: DateTime.now().copyWith(hour: 20, minute: 00),
        arrivalLocation: siemReap,
        arrivalDateTime: DateTime.now().copyWith(hour: 22, minute: 00),
        driver: limhao,
        availableSeats: 2,
        pricePerSeat: 10,
        acceptPets: true);

    Ride ride5 = Ride(
        departureLocation: battambang,
        departureDate: DateTime.now().copyWith(hour: 17, minute: 00),
        arrivalLocation: siemReap,
        arrivalDateTime: DateTime.now().copyWith(hour: 20, minute: 00),
        driver: sovanda,
        availableSeats: 1,
        pricePerSeat: 10,
        acceptPets: false);

    _allRides.addAll([ride1, ride2, ride3, ride4, ride5]);
  }

  @override
  List<Ride> getRidesFor(RidePreference prefs, RideFilter? filter) {
    return _allRides
        .where((ride) =>

            // Filter on departure / arrival
            ride.departureLocation == prefs.departure &&
            ride.arrivalLocation == prefs.arrival &&

            // Filter on pets if required
            (filter != null && filter.onlyPets ? ride.acceptPets : true) &&

            // Filter on rides with available seat only
            ride.availableSeats > 0)
        .toList();
  }
}
