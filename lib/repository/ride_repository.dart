import 'package:week_3_blabla_project/model/ride_pref/ride_pref.dart';

import '../model/ride/ride.dart';
import '../model/ride/ride_filter.dart';

abstract class RidesRepository {
  //List<Ride> getRides(RidePreference ridePreference);

  List<Ride> getRidesFor(RidePreference ridePreference, RideFilter? rideFilter);
}
