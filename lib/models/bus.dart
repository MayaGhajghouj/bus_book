import 'package:mysql1/mysql1.dart';

class Bus {

 int? bus_id;
 int bus_number;
 int bus_seats;
 String bus_type;
Bus({
  this.bus_id,
 required this. bus_number,
  required this. bus_seats,
 required this. bus_type,
});
 static Bus FromDB (ResultRow row)
 {
   return Bus(
    bus_id: row[0],
       bus_number:row[1],
       bus_seats: row[2],
       bus_type: row[3]);
 }
@override
  String toString() {
    return "$bus_id ,$bus_type , $bus_number , $bus_seats ";
  }


}






