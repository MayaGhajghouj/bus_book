// ignore_for_file: curly_braces_in_flow_control_structures, non_constant_identifier_names

import 'package:bus_book/Backend/myData.dart';
import 'package:bus_book/shared/Appcubitt/appstates.dart';
import 'package:bus_book/shared/Constants/mycolors.dart';
import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/weekDayData.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(InitialAppState());

  static AppCubit get(context) => BlocProvider.of(context);

  //==============  tab bar ============================================
  late TabController controller;

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
  TextEditingController Type_AdditionalTrip = TextEditingController();
  TextEditingController Date_AdditionalTrip = TextEditingController();
  TextEditingController Time_AdditionalTrip = TextEditingController();
  List<SelectedListItem> Type_AdditionalTRipMenue = [
    SelectedListItem(
      name: "ذهاب",
    ),
    SelectedListItem(
      name: "اياب",
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

  //************************ CheckValue ************************************
  bool checkvalueSaterday = false;
  bool checkvalueSunday = false;
  bool checkvalueMonday = false;
  bool checkvalueTusday = false;
  bool checkvalueWEdnesday = false;

  void ChangeMyCheckValueInWeekTable(bool selescted, int index) {
    MyData.week[index]!.selected = selescted;
    emit(ChangeSelectedDayInWeekTable());
  }

  //***************************** BottomNavigationBar ***************************************************** */
  int selectedBottomIndex = 0;

  // void changebottomnavbarScreen(int index) {
  //   selectedBottomIndex = index;
  // }

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
