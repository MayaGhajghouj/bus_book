import 'package:bus_book/models/temp_reservations.dart';
import 'package:flutter/material.dart';

class WeekDayData {
  DateTime? dateTime;
  TextEditingController goTime = TextEditingController(), backTime = TextEditingController();
  bool selected = false, founded = false;
  int? goID, backID;
}
