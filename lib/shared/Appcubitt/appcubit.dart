// ignore_for_file: curly_braces_in_flow_control_structures, non_constant_identifier_names

import 'package:bus_book/shared/Appcubitt/appstates.dart';
import 'package:bus_book/shared/Constants/mycolors.dart';
import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:dropdown_plus/dropdown_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
}
