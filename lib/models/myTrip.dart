import 'package:bus_book/models/bus.dart';
import 'package:bus_book/models/reservations.dart';
import 'package:bus_book/models/trip.dart';
import 'package:bus_book/models/user.dart';
import 'package:mysql1/mysql1.dart';
import 'driver.dart';

class MyTrip {
  Trip trip;
  Driver driver;
  Bus bus;
  Reservations reservation;
  User user;
// raw : trip_name, trip_type, trip_date, trip_price, driver_name, driver_phone, bus_number, bus_type, reservation_arrive_time, user_name
  MyTrip(
      {required this.trip,
      required this.driver,
      required this.bus,
      required this.reservation,
      required this.user});

  static MyTrip fromDB(ResultRow row) {
    return MyTrip(
      trip: Trip(
          tripName: row[0],
          tripType: row[1],
          tripDate: (row[2] as DateTime).toLocal(),
          price: row[3]),
      driver: Driver(driverName: row[4], driverPhone: row[5]),
      bus: Bus(busNumber: row[6], busType: row[7]),
      reservation: Reservations(reservation_arrive_time: row[8]),
      user: User(userName: row[9]),
    );
  }
}
