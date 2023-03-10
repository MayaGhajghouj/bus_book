import 'package:mysql1/mysql1.dart';

class Reservations {
  int? reservatin_trip_id, resrervation_user_id;
  Duration reservation_arrive_time;

  Reservations(
      {this.reservatin_trip_id,
      this.resrervation_user_id,
      required this.reservation_arrive_time});

  static Reservations fromDB(ResultRow row) {
    return Reservations(
        reservatin_trip_id: row[0],
        resrervation_user_id: row[1],
        reservation_arrive_time: row[2]);
  }
}
