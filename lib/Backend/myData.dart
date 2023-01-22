import 'package:bus_book/models/driver.dart';
import 'package:bus_book/models/bus.dart';
import 'package:bus_book/models/trip.dart';
import 'package:drop_down_list/model/selected_list_item.dart';

import '../models/manager.dart';

class MyData {
  static Map<int, Driver> driversList = {};
  static Map<int, Trip> tripList = {};
  static Map<int, Trip> tripListOnPast = {};
  // static Map<int, User> userList = {};
  static Map<int, Bus> busList = {};
  static Manager? manager;
  static List<SelectedListItem> timeItems = [];
}
