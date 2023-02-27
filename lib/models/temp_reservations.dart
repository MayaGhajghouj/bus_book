import 'package:mysql1/mysql1.dart';

class TempReservations {
  int? id, userId, type;
  String? TripType;
  DateTime? date;

  TempReservations(
      {this.id,
      required this.userId,
      required this.TripType,
      required this.date,
      required this.type});

  static TempReservations fromDB(ResultRow row) {
    return TempReservations(
        id: row[0],
        userId: row[1],
        TripType: row[2],
        date: (row[3] as DateTime).toLocal(),
        type: row[4]);
  }
}
