import '../models/manager.dart';
import '../models/myTrip.dart';

class MyData {
  static Map<int, MyTrip> FutureTripList = {};
  static Map<int, MyTrip> PreTripList = {};

  static Manager? manager;
}
