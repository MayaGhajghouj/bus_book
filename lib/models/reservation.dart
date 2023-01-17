import 'package:mysql1/mysql1.dart';

class Reservation {
  int?  reservatin_trip_id ;
  int ?resrervation_user_id;
  Duration reservation_arrive_time;


  Reservation ({this.reservatin_trip_id,
     this.resrervation_user_id ,
    required  this.reservation_arrive_time });

  static Reservation FromDB (ResultRow row)
  {
    return Reservation( reservatin_trip_id: row[0],resrervation_user_id: row[1] , reservation_arrive_time:row[2]);
  }
  @override
  String toString() {
    return " $reservatin_trip_id  , $resrervation_user_id ,$reservation_arrive_time";
  }

  }

