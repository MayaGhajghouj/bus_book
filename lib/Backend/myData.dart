import 'package:bus_book/models/manager.dart';
import 'package:bus_book/models/user.dart';
import 'package:drop_down_list/model/selected_list_item.dart';

import '../models/myTrip.dart';
import '../models/temp_reservations.dart';
import '../models/weekDayData.dart';

class MyData {
  static List<MyTrip> FutureTripList = [];
  static List<MyTrip> PreTripList = [];
  static User? user;
  static Manager? mymanager;
  static List<SelectedListItem> timeItems = [];
  static Map<int, WeekDayData> week = {};
}
