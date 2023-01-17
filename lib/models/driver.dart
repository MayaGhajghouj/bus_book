import 'package:bus_book/shared/Appcubitt/appcubit.dart';
import 'package:mysql1/mysql1.dart';
import 'package:mysql1/mysql1.dart';
class Driver {
  int? driver_id ;
  String driver_name;
  String driver_phone;
  Driver({
    this.driver_id,
    required this.driver_name ,
    required this.driver_phone}
      );

 static Driver FromDB (ResultRow row)
 {
   return Driver( driver_id:row[0] ,driver_name: row[1], driver_phone: row[2]);
 }

 @override
  String toString() {
    return "$driver_id , $driver_name , $driver_phone ";
  }

}