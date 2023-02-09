import 'package:mysql1/mysql1.dart';

class Trip {
  int? tripId;
  String tripName, tripType;
  DateTime tripDate;
  double price;

  Trip({
    this.tripId,
    required this.tripName,
    required this.tripType,
    required this.tripDate,
    required this.price,
  });

  static Trip fromDB(ResultRow row) {
    return Trip(
      tripId: row[0],
      tripName: row[1],
      tripType: row[2],
      tripDate: (row[3] as DateTime).toLocal(),
      price: row[4],
    );
  }
}
