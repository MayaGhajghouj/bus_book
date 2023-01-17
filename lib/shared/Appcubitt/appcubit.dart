// ignore_for_file: curly_braces_in_flow_control_structures, non_constant_identifier_names

import 'dart:io';
import 'package:bus_book/models/bus.dart';
import 'package:bus_book/models/driver.dart';
import 'package:bus_book/models/reservation.dart';
import 'package:bus_book/models/trip.dart';
import 'package:bus_book/moduls/app/my_account_screen.dart';
import 'package:bus_book/shared/Appcubitt/appstates.dart';
import 'package:bus_book/shared/constant.dart';
import 'package:bus_book/shared/lists.dart';
import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:dropdown_plus/dropdown_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mysql1/mysql1.dart';
import '../../moduls/app/week_table_screen.dart';
import '../componants.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(InitialAppState());

  static AppCubit get(context) => BlocProvider.of(context);

//************************************************************************

  List<Widget> MyTabLabels = [
    // ignore: prefer_const_constructors
    Tab(
      text: 'الرحلات السابقة',
    ),
    Tab(
      text: 'الرحلات اللاحقة  ',
    ),
  ];

////*********************************************************
  DropdownEditingController<String> TripGoTimeController =
      DropdownEditingController(); // موعد ذهاب الرحلة
  DropdownEditingController<String> TripBackTimeController =
      DropdownEditingController(); // موعد عودة الرحلة

  DropdownEditingController<String> AdditionalDayTrip =
      DropdownEditingController(); // اختر اليوم في اشتراك رحلة اضافية
  DropdownEditingController<String> AdditionaTypelTrip =
      DropdownEditingController(); // اختر نوع الرحلة اضافية
  DropdownEditingController<String> AdditionalTimeTrip =
      DropdownEditingController(); // اختر وقت الرحلة اضافية
  //************************ CheckValue ************************************
  bool checkvalueSaterday = false;
  bool checkvalueSunday = false;
  bool checkvalueMonday = false;
  bool checkvalueTusday = false;
  bool checkvalueWEdnesday = false;

  void ChangeMyCheckValueInWeekTable(bool selescted, String day) {
    if (day == 'السبت')
      checkvalueSaterday = selescted;
    else if (day == 'اللأحد')
      checkvalueSunday = selescted;
    else if (day == 'الاثنين')
      checkvalueMonday = selescted;
    else if (day == 'الثلاثاء')
      checkvalueTusday = selescted;
    else
      checkvalueWEdnesday = selescted;

    emit(ChangeSelectedDayInWeekTable());
  }

  //***************************** BottomNavigationBar ***************************************************** */
  int selectedBottomIndex = 0;

  void changebottomnavbarScreen(int index) {
    selectedBottomIndex = index;
  }

  List<DotNavigationBarItem> NavBarItems = [
    DotNavigationBarItem(
      icon: Text('إشتراك رحلة أسبوعية'),
      selectedColor: mycolor.blue,
    ),
    DotNavigationBarItem(
      icon: Text('إشتراك رحلة إضافية'),
      selectedColor: mycolor.blue,
    ),
  ];

  //****************************** DAtaBase connection **************************************************

  var settings =  ConnectionSettings(
      host: '10.0.2.2',
      port: 3306,
      user: 'root',
      password: '1234',
      db: 'bus_app_db');
  MySqlConnection? conn;
  List<String> mydata = [];

  Future<void> connectToDB() async
  {
    emit(ConnectingToMySql());
    conn = await MySqlConnection.connect(settings);
    emit(ConnectedToMySql());

  }
  Future<void> getdata()async{
    await  getDriver();
    await  getBus();
    await  getTrip();
    await  getReservation();
    emit(GetDataFromDB());

  }
  Future<void> disconnectToDB() async
  {
    emit(DisConnectingToMySql());
    await conn!.close();
    emit(DisConnectedToMySql());
    print('Disconnected ****************');
  }

//*****************************************************
  Future<void> getDriver() async
  {
    if(conn==null) {
      print("null             null");
      return;
    }
    Lists.drivers.clear();
      Results res = await conn!.query('select * from driver');
    for (var row in res) {
      Lists.drivers.add(Driver.FromDB(row));
    }
  }
  //*****************************************************
  Future<void> getBus() async
  {
    Lists.buses.clear();
    Results res = await conn!.query('select * from bus');
    for (var row in res){
      Lists.buses.add(Bus.FromDB(row));
    }

  }
  //*****************************************************
  Future<void> getTrip() async
  {
    Lists.trips.clear();
    Results res = await conn!.query('select * from trip');
    for (var row in res)
      Lists.trips.add(Trip.FromDB(row));

  }
  //*****************************************************
  Future<void> getReservation() async
  {
    Lists.reserves.clear();
    Results res = await conn!.query('select * from reservation where resrervation_user_id=? ',[4]);
    for (var row in res)
      Lists.reserves.add(Reservation.FromDB(row));

  }
  //*****************************************************
  // 1.id 2.name 3.phone 4.address 5.email 6.password
  Future<void> insertSignUp(List<String> Controllers)async
  {/*
     var r= await conn!.query('');
    if(Controllers[3])
    var r= await conn!.query('insert into user value(?,?,?) ',[
      Controllers[0],Controllers[1],Controllers[2],Controllers[3],Controllers[4]],
    );*/

  }

}



