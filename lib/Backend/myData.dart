import 'package:bus_book/models/manager.dart';
import 'package:bus_book/models/user.dart';
import 'package:bus_book/models/weekdaydata.dart';
import 'package:drop_down_list/model/selected_list_item.dart';

import '../models/myTrip.dart';

class MyData {
  static List<MyTrip> FutureTripList = [];
  static List<MyTrip> PreTripList = [];
  static User? user;
  static Manager? mymanager;
  static List<SelectedListItem> timeItems = [];
  static Map<int, WeekDayData> weekdata = {};
}
