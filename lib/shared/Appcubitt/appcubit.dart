// ignore_for_file: curly_braces_in_flow_control_structures, non_constant_identifier_names

import 'package:bus_book/shared/Appcubitt/appstates.dart';
import 'package:bus_book/shared/Constants/mycolors.dart';
import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:dropdown_plus/dropdown_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(InitialAppState());

  static AppCubit get(context) => BlocProvider.of(context);
  //===================== LOGin operations  =============================
  bool ispassword = true;
  IconData prefix = Icons.visibility_off_outlined;
  void changepasswordvisibility() {
    ispassword = !ispassword;
    prefix =
        ispassword ? Icons.visibility_off_outlined : Icons.visibility_outlined;
    emit(ChaangePasswordVisibility());
  }

  List<SelectedListItem> mymenue = [
    SelectedListItem(
      name: "غربي شارع الهبشة",
    ),
    SelectedListItem(
      name: "غربي شارع أبو سيفو",
    ),
    SelectedListItem(
      name: "غربي شارع باسط",
    ),
    SelectedListItem(
      name: "غربي شارع المدارس ",
    ),
    SelectedListItem(
      name: "غربي شارع السكنة ",
    ),
    SelectedListItem(
      name: "غربي شارع المجمع",
    ),
    SelectedListItem(
      name: "شرقي شارع ثمانة اذار ",
    ),
    SelectedListItem(
      name: "شرقي شارع النهر ",
    ),
  ];

//************************************************************************
  List<SelectedListItem> GoTimesMenue = [
    SelectedListItem(
      name: "8:0",
    ),
    SelectedListItem(
      name: "10:0",
    ),
    SelectedListItem(
      name: "12:0",
    ),
    SelectedListItem(
      name: "14:0",
    ),
  ];
  List<SelectedListItem> BackTimesMenue = [
    SelectedListItem(
      name: "10:0",
    ),
    SelectedListItem(
      name: "12:0",
    ),
    SelectedListItem(
      name: "14:0",
    ),
    SelectedListItem(
      name: "16:0",
    ),
  ];
  List<SelectedListItem> Time_AdditionalTRipMenue = [
    SelectedListItem(
      name: "8:0",
    ),
    SelectedListItem(
      name: "10:0",
    ),
    SelectedListItem(
      name: "12:0",
    ),
    SelectedListItem(
      name: "14:0",
    ),
    SelectedListItem(
      name: "16:0",
    ),
  ];

  List<SelectedListItem> Type_AdditionalTRipMenue = [
    SelectedListItem(
      name: "ذهاب",
    ),
    SelectedListItem(
      name: "إياب",
    ),
  ];
  List<SelectedListItem> Day_AdditionalTRipMenue = [
    SelectedListItem(
      name: "السبت",
    ),
    SelectedListItem(
      name: "الأحد",
    ),
    SelectedListItem(
      name: "الإثنين",
    ),
    SelectedListItem(
      name: "الثلاثاء",
    ),
    SelectedListItem(
      name: "الأربعاء",
    ),
    SelectedListItem(
      name: "الخميس",
    ),
    SelectedListItem(
      name: "الجمعة",
    ),
  ];
  //=============================================================================
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
