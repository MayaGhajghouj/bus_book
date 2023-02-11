import 'package:bus_book/Backend/db_states.dart';
import 'package:bus_book/Backend/myData.dart';
import 'package:bus_book/models/myTrip.dart';
import 'package:bus_book/shared/Constants/connectionDB.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mysql1/mysql1.dart';
import '../models/manager.dart';
import '../models/user.dart';

class DataBase extends Cubit<DatabaseStates> {
  DataBase() : super(InitialState());
  static DataBase get(context) => BlocProvider.of(context);

  MySqlConnection? _myDB;

  //====================== connect =====================================

  Future<void> connect() async {
    emit(LoadingState());
    await MySqlConnection.connect(ConnectionDB.settings).then((value) {
      _myDB = value;
      emit(Connected());
    }).catchError((error, stackTrace) {
      emit(ErrorConnectingDataState('[Error_connect_] $error'));
      print("maya connect :($error) \n $stackTrace");
    });
  }

  //====================== disconnect =====================================

  Future<void> disConnect() async {
    emit(LoadingState());
    await _myDB!.close().then((value) {
      emit(DisConnected());
    }).catchError((error, stackTrace) {
      emit(ErrorDisConnectingDataState('[disConnect] $error'));
      print("maya disConnect :($error) \n $stackTrace");
    });
  }

  //===================== sign up insert user to database ======================================

  Future<void> insertUser(User u, context) async {
    emit(LoadingState());
    await _myDB!.query(
        'insert into user (user_name,user_phone,user_address,user_email,user_password) values ( ?, ?,?,?,?);',
        [
          u.userName,
          u.userPhone,
          u.userAddress,
          u.userEmail,
          u.userPassword
        ]).then((value) {
      emit(
          InsertedData(" يرجى تسجيل الدخول ، تم اضافة بيانات المستخدم الجديد"));
    }).catchError((error, stackTrace) {
      print(
          "=========================inside USER SIGN UP ERROR FUNCTION ====>>($error) \n $stackTrace");
      emit(ErrorInsertingDataState('[insert_User_error] $error'));
    });
  }
  //================= user login ==========================================

  Future<void> UserLogin(String email, String password, context) async {
    emit(LoadingState());
//select * from bus_app_db.user where user_email ='maya@gmail.com' && user_password='12345'
    await _myDB!.query(
        'select * from user where (user_email,user_password)=(?,?)',
        [email, password]).then((value) {
      if (value.isNotEmpty) {
        print('===================================================');
        print('****** تم نجاح عملية تسجيل الدخوول *************** ');
        getUserTrips(email, password);
        print('===================================================');

        emit(SelectedData("تم تسجيل الدخول بنجاح "));
      } else {
        throw Exception(' الايميل او كلمة المرور غلط او ليس لديك حساب بعد');
        // mySnackBar('لبس لديك حساب ', context, Colors.red, Colors.white);
      }
    }).catchError((error, stackTrace) {
      emit(ErrorSelectingDataState('False login here $error'));
      print("inside USER LOGIN ERROR FUNCTION  :($error) \n $stackTrace");
    });
  }
  //==================================================================================

  int Future_Trip_key = 0;
  int Pre_Trip_Key = 0;

//==================================================================================
  Future<void> getUserTrips(String email, String password) async {
    Future_Trip_key = 0;
    Pre_Trip_Key = 0;
    emit(LoadingState());
    await _myDB!.query('''
       select t.trip_name,t.trip_type,t.trip_date,t.trip_price,
      d.driver_name,d.driver_phone,
      b.bus_number,b.bus_type,
      r.reservation_arrive_time,
      u.user_name
      from bus_app_db.trip t,bus_app_db.driver d , bus_app_db.bus b, bus_app_db.reservation r ,bus_app_db.user u
      where
       t.trip_driver_id=d.driver_id 
       and t.trip_bus_id=b.bus_id
       and r.reservatin_trip_id=t.trip_id
       and r.resrervation_user_id=(
        select user_id from bus_app_db.user where (user_email,user_password)=(?,?)'
       )''', [email, password]).then((value) {
      // raw : trip_name, trip_type, trip_date, trip_price, driver_name, driver_phone, bus_number, bus_type, reservation_arrive_time, user_name
      for (var row in value) {
        MyTrip t = MyTrip.fromDB(row);
        if (t.trip.tripDate.year <= DateTime.now().year &&
            t.trip.tripDate.month <= DateTime.now().month &&
            t.trip.tripDate.day <= DateTime.now().day) {
          MyData.PreTripList[Pre_Trip_Key] = t;
          Pre_Trip_Key++;
        } else {
          MyData.FutureTripList[Future_Trip_key] = t;
          Future_Trip_key++;
        }
      }
      emit(SelectedData("تم جلب رحلات المستخدم:"));
    }).catchError((error) {
      emit(ErrorSelectingDataState('[get_User_Trips_error ] $error'));
      print("maya getUserTrips function error :($error) \n");
    });
  }

  //===========================================================
  //===========================================================
  Future<void> getManager() async {
    emit(LoadingState());
    await _myDB!.query('select * from manager').then((value) {
      MyData.manager = Manager.fromDB(value.first);
      emit(SelectedData("تم جلب بيانات المدير"));
    }).catchError((error, stackTrace) {
      emit(ErrorSelectingDataState('[getManager] $error'));
      print("Owis getManager :($error) \n $stackTrace");
    });
  }
  //===========================================================
}
