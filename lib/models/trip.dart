import 'package:bus_book/models/driver.dart';
import 'package:bus_book/shared/Appcubitt/appcubit.dart';
import 'package:intl/intl.dart';
import 'package:mysql1/mysql1.dart';
import '../models/bus.dart';
import '../models/driver.dart';
import '../shared/lists.dart';

class Trip {
  int? trip_id;
  String trip_name;
  String trip_type;
  Duration trip_time;
  DateTime trip_date;
  double trip_price;
  int driver_id;

  int bus_id;

  Trip({
    this.trip_id,
    required this.trip_name,
    required this.trip_type,
    required this.trip_time,
    required this.trip_date,
    required this.trip_price,
    required this.driver_id,
    required this.bus_id,
  });

  static Trip FromDB(ResultRow row) {
    return Trip(
      trip_id: row[0],
        trip_name: row[1],
        trip_type: row[2],
        trip_time: row[3],
        trip_date:row[4],
        trip_price: row[5],
        driver_id: row[6],
        bus_id: row[7]
        /* driver:Lists.drivers.where(
             (element) => element.driver_id== row[6]).first,
     bus:Lists.buses.where(
          (element) => element.bus_id== row[6]).first,*/
        );
  }


  @override
  String toString() {
    return "$trip_id ,"
        "$trip_name ,"
        "$trip_time ,"
        "$trip_date ,"
        "$trip_type, "
        "$trip_price";
  }
}
