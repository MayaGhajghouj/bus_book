import 'package:bus_book/Backend/db_states.dart';
import 'package:bus_book/Backend/myData.dart';
import 'package:bus_book/models/myTrip.dart';
import 'package:bus_book/models/temp_reservations.dart';
import 'package:bus_book/shared/Constants/connectionDB.dart';
import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mysql1/mysql1.dart';
import '../models/manager.dart';
import '../models/user.dart';
import '../models/weekDayData.dart';

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
        [u.userName, u.userPhone, u.userAddress, u.userEmail, u.userPassword]).then((value) {
      emit(InsertedData(" يرجى تسجيل الدخول ، تم اضافة بيانات المستخدم الجديد"));
    }).catchError((error, stackTrace) {
      if (error.toString().contains('Duplicate entry'))
        emit(ErrorInsertingDataState('هذا حساب مكرر .. يرجى استخدام ايميل جديد '));
      else {
        print(
            "=========================inside USER SIGN UP ERROR FUNCTION ====>>($error) \n $stackTrace");
        emit(ErrorInsertingDataState('[insert_User_error] $error'));
      }
    });
  }

  //================= user login ==========================================

  Future<void> UserLogin(String email, String password, context) async {
    emit(LoadingState());
//select * from bus_app_db.user where user_email ='maya@gmail.com' && user_password='12345'
    await _myDB!
        .query('select * from user where (user_email,user_password)=(?,?)', [email, password]).then(
            (value) {
      if (value.isNotEmpty) {
        for (var row in value) {
          MyData.user = User.fromDB(row);
        }
        print('===================================================');
        print('****** تم نجاح عملية تسجيل الدخوول *************** ');

        print('===================================================');

        emit(SelectedData("تم تسجيل الدخول بنجاح "));
      } else {
        throw Exception(' الايميل او كلمة المرور غلط او ليس لديك حساب بعد');
      }
    }).catchError((error, stackTrace) {
      emit(ErrorSelectingDataState('False login here $error'));
      print("inside USER LOGIN ERROR FUNCTION  :($error) \n");
    });
  }

//==================================================================================
  Future<void> getUserTrips(int? user_id) async {
    emit(LoadingState());
    // await Future.delayed(Duration(seconds: 5));
    await _myDB!.query('''
       select t.trip_name,t.trip_type,t.trip_date,t.trip_price,
      d.driver_name,d.driver_phone,
      b.bus_number,b.bus_type,
      r.reservation_arrive_time,
      u.user_name
      from trip t,driver d ,bus b,reservation r ,user u
      where
       t.trip_driver_id=d.driver_id 
       and t.trip_bus_id=b.bus_id
       and r.reservatin_trip_id=t.trip_id
       and r.resrervation_user_id= u.user_id
       and u.user_id=(?);
       ''', [user_id]).then((value) {
      // raw : trip_name, trip_type, trip_date, trip_price, driver_name, driver_phone, bus_number, bus_type, reservation_arrive_time, user_name
      MyData.FutureTripList.clear();
      MyData.PreTripList.clear();
      for (var row in value) {
        MyTrip t = MyTrip.fromDB(row);
        var now = DateTime.now();
        var time = t.trip.tripDate;
        if (now.compareTo(time) == 1) {
          MyData.PreTripList.add(t);
        } else {
          MyData.FutureTripList.add(t);
        }
      }
      emit(SelectedData("تم جلب رحلات المستخدم:"));
    }).catchError((error) {
      emit(ErrorSelectingDataState('[get_User_Trips_error ] $error'));
      print("maya getUserTrips function error :($error) \n");
    });
  }

//======================== update account informations ===============================
  Future<void> UpdateAccountInfo(User u) async {
    emit(LoadingState());
    await _myDB!.query(
        'UPDATE user SET user_name = ?, user_phone = ?, user_address = ?, user_email = ?, user_password = ? WHERE user_id = ?',
        [
          u.userName,
          u.userPhone,
          u.userAddress,
          u.userEmail,
          u.userPassword,
          u.userId
        ]).then((value) {
      emit(UpdatedData('تم تحديث بيانات الحساب الخاصة بك'));
    }).catchError((onError) {
      emit(ErrorUpdatingDataState('حصل خطأ في تعديل بياناات  الحساب'));
    });
  }

  //===========================================================
  Future<void> getManager() async {
    emit(LoadingState());
    //await Future.delayed(Duration(seconds: 5));
    await _myDB!.query('select * from manager').then((value) {
      MyData.mymanager = Manager.fromDB(value.last);
      emit(SelectedData("تم جلب بيانات المدير"));
    }).catchError((error) {
      emit(ErrorSelectingDataState('[getManager] $error'));
      print("Owis getManager :($error) \n ");
    });
  }

  //===========================================================

  Future<void> getimes() async {
    emit(LoadingState());
    MyData.timeItems.clear();
    await _myDB!.query('select * from trip_time').then((value) {
      for (var row in value) {
        MyData.timeItems.add(SelectedListItem(name: row[1]));
      }
      emit(SelectedData('تم جلب الأوقات'));
    }).catchError((error) {
      emit(ErrorSelectingDataState('خطأ في جلب الأوقات '));
      print("maya getTime :($error) \n ");
    });
  }

  //================ Add  trip =====================================
  Future<void> insertTrip({required List<TempReservations> trip}) async {
    emit(LoadingState());
    if (trip.first.type == 1) {
      await _myDB!.query('''
    INSERT INTO temp_reservation
    (
    temp_reservation_user_id,
    temp_reservation_trip_type,
    temp_reservation_date,
    temp_reservation_type)
    VALUES(?,?,?,?);
    ''', [
        trip.first.userId,
        trip.first.TripType!,
        trip.first.date!.toUtc(),
        trip.first.type,
      ]).then((value) {
        emit(InsertedData("تم اضافة بيانات الرحلة الاضافية "));
      }).catchError((error, stackTrace) {
        emit(ErrorInsertingDataState('[insertTrip] $error'));
        print("خطأ في تابع ادراج رحلة اضافية :($error) \n $stackTrace");
      });
    } else {
      List<List<dynamic>> te = List.empty(growable: true);
      for (var x in trip) {
        te.add([x.userId, x.TripType, x.date, x.type]);
      }
      await _myDB!.queryMulti('''INSERT INTO temp_reservation(
    temp_reservation_user_id,
    temp_reservation_trip_type,
    temp_reservation_date,
    temp_reservation_type)
    VALUES(?,?,?,?);''', te);
    } // else
  }

  //***************************************************************************

  Future<void> getTempReservation() async {
    await getimes();
    emit(LoadingState());
    MyData.week.clear();
    for (int i = 1; i <= 7; i++) {
      DateTime d = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day)
          .add(Duration(days: i));
      if (d.weekday != 4 && d.weekday != 5) {
        MyData.week[d.weekday] = WeekDayData()..dateTime = d;
      }
    }
    await _myDB!.query('''
        select * from temp_reservation where temp_reservation_user_id=? and temp_reservation_type=0 ;
    ''', [MyData.user!.userId]).then((value) {
      for (var row in value) {
        TempReservations x = TempReservations.fromDB(row);
        if (x.TripType == 'ذهاب') {
          MyData.week[x.date!.weekday]!.goTime.text = '${x.date!.hour}:${x.date!.minute}';
          MyData.week[x.date!.weekday]!.goID = x.id;
        } else {
          MyData.week[x.date!.weekday]!.backTime.text = '${x.date!.hour}:${x.date!.minute}';
          MyData.week[x.date!.weekday]!.backID = x.id;
        }
        MyData.week[x.date!.weekday]!.selected = true;
        MyData.week[x.date!.weekday]!.founded = true;
      }

      emit(SelectedData('Done'));
    }).catchError((error) {
      emit(ErrorSelectingDataState('خطأ في جلب الحجوزات حاول مجددا '));
      print("maya getReservation :($error) \n ");
    });
  }

  //***************************************************************************
  Future<void> insertReservation() async {
    emit(LoadingState());
    await _myDB!.transaction((p0) async {
      for (var x in MyData.week.values) {
        if (x.selected) {
          var temp = x.goTime.text.split(':');
          Duration goTime = Duration(hours: int.parse(temp[0]), minutes: int.parse(temp[1]));
          temp = x.backTime.text.split(':');
          Duration backTime = Duration(hours: int.parse(temp[0]), minutes: int.parse(temp[1]));
          if (x.founded) {
            p0.query('''
             UPDATE temp_reservation
              SET
              temp_reservation_date = ?
              WHERE temp_reservation_id = ?;
            ''', [x.dateTime!.add(goTime).toUtc(), x.goID]);
            p0.query('''
             UPDATE temp_reservation
              SET
              temp_reservation_date = ?
              WHERE temp_reservation_id = ?;
            ''', [x.dateTime!.add(backTime).toUtc(), x.backID]);
          } else {
            p0.query('''
              INSERT INTO temp_reservation
              (
              temp_reservation_user_id,
              temp_reservation_trip_type,
              temp_reservation_date,
              temp_reservation_type)
              VALUES(?,?,?,?);
          ''', [MyData.user!.userId, 'ذهاب', x.dateTime!.add(goTime).toUtc(), 0]);
            p0.query('''
              INSERT INTO temp_reservation
              (
              temp_reservation_user_id,
              temp_reservation_trip_type,
              temp_reservation_date,
              temp_reservation_type)
              VALUES(?,?,?,?);
          ''', [MyData.user!.userId, 'اياب', x.dateTime!.add(backTime).toUtc(), 0]);
          }
        } else {
          if (x.founded) {
            p0.query(''' DELETE FROM temp_reservation
                WHERE temp_reservation_id=? ''', [x.goID]);
            p0.query(''' DELETE FROM temp_reservation
                WHERE temp_reservation_id=? ''', [x.backID]);
          }
        }
      }
    }).then((value) {
      emit(InsertedData('تم حفظ الجدول الاسبوعي'));
    });
  }
}
//==========================================================================
