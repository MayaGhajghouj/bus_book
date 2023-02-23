// ignore_for_file: non_constant_identifier_names, prefer_const_constructors

import 'package:bus_book/Backend/database.dart';
import 'package:bus_book/Backend/db_states.dart';
import 'package:bus_book/Backend/myData.dart';
import 'package:bus_book/models/temp_reservations.dart';
import 'package:bus_book/shared/Appcubitt/appcubit.dart';
import 'package:bus_book/shared/Constants/mycolors.dart';
import 'package:drop_down_list/drop_down_list.dart';
import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:dropdown_plus/dropdown_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:msh_checkbox/msh_checkbox.dart';

import '../models/myTrip.dart';

Widget DefoultFormField({
  required TextEditingController controller,
  required String myhinttext,
  required TextInputType typeofkeybord,
  required Function validate,
  IconData? suffixicon,
  bool ispassword = false,
  IconData? prefix,
  Function? ontap,
  Function? prefixpressed,
  TextAlign mytextalign = TextAlign.end,
  bool readonly = false,
}) {
  return Padding(
    padding: EdgeInsets.symmetric(
      vertical: 10.0,
      horizontal: 5.0,
    ),
    child: TextFormField(
      controller: controller,
      readOnly: readonly,
      textAlign: mytextalign,
      keyboardType: typeofkeybord,
      onTap: () {
        if (ontap != null) ontap();
      },
      validator: (s) {
        return validate(s);
      },
      obscureText: ispassword,
      decoration: InputDecoration(
        suffixIcon: Icon(suffixicon),
        prefixIcon: prefix != null
            ? IconButton(
                onPressed: () {
                  prefixpressed!();
                },
                icon: Icon(
                  prefix,
                ),
              )
            : null,
        hintText: myhinttext,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Color(0XFF7fbcd2),
            style: BorderStyle.solid,
            width: 3.0,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(50.0),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xff61000000),
            style: BorderStyle.solid,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(50.0),
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.red,
            style: BorderStyle.solid,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(50.0),
          ),
        ),
        focusColor: Color.fromARGB(255, 24, 237, 105),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.red,
            style: BorderStyle.solid,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(50.0),
          ),
        ),
      ),
    ),
  );
}

//====================================================================================

Widget myStandardScreen(context) {
  return Container(
    decoration: BoxDecoration(
        gradient: LinearGradient(
      colors: [
        mycolor.blue,
        mycolor.yello,
      ],
    )),
    child: SafeArea(
      bottom: false,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          children: [
            Container(
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.541),
                  blurRadius: 15,
                ),
              ], borderRadius: BorderRadius.circular(50), color: Colors.white),
              margin: EdgeInsets.all(15),
              height: 0.07 * MediaQuery.of(context).size.height,
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.zoom_in_rounded,
                    ),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.account_circle_outlined,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

//************************************************************** */
myvalues(String k, String v) {
  return Padding(
    padding: EdgeInsets.only(right: 10.0, top: 5.0, bottom: 5.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          '$v',
          style: TextStyle(
            fontSize: 19,
          ),
        ),
        Text(
          ' : $k',
          style: TextStyle(
              fontSize: 19, color: mycolor.blue, fontWeight: FontWeight.bold),
        ),
      ],
    ),
  );
}

//******************BuildItemofWeekTable***********************************

Widget BuildItemofWeekTable({
  required TextEditingController GOcontroller,
  required TextEditingController Backcontroller,
  context,
  String? day,
}) {
  return Container(
    decoration: BoxDecoration(boxShadow: [
      BoxShadow(
        color: Color.fromRGBO(0, 0, 0, 0.541),
        blurRadius: 15,
      ),
    ], borderRadius: BorderRadius.circular(20), color: Colors.white),
    margin: EdgeInsets.all(5.0),
    child: Column(
      children: [
        Container(
          margin: EdgeInsets.only(
            right: 20.0,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                day!,
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
              SizedBox(
                width: 10.0,
              ),
              MSHCheckbox(
                size: 25,
                value: day == 'السبت'
                    ? AppCubit.get(context).checkvalueSaterday
                    : day == 'اللأحد'
                        ? AppCubit.get(context).checkvalueSunday
                        : day == 'الاثنين'
                            ? AppCubit.get(context).checkvalueMonday
                            : day == 'الثلاثاء'
                                ? AppCubit.get(context).checkvalueTusday
                                : AppCubit.get(context).checkvalueWEdnesday,
                checkedColor: Colors.blue,
                style: MSHCheckboxStyle.fillScaleCheck,
                onChanged: (selected) {
                  AppCubit.get(context)
                      .ChangeMyCheckValueInWeekTable(selected, day);
                },
                uncheckedColor: mycolor.lightblack,
              ),
            ],
          ),
        ),
        Row(
          children: [
            Expanded(
              child: DefoultFormField(
                  controller: Backcontroller,
                  myhinttext: '',
                  typeofkeybord: TextInputType.text,
                  suffixicon: Icons.share_arrival_time,
                  validate: (String? m) {
                    if (m!.isEmpty) return "يجب اختيار وقت العودة ";
                    return null;
                  },
                  ontap: () {
                    MyDropdown(
                      controller: Backcontroller,
                      mylist: AppCubit.get(context).BackTimesMenue,
                      context: context,
                      title: "وقت العودة",
                    );
                  }),
            ),
            Expanded(
              child: DefoultFormField(
                  controller: GOcontroller,
                  myhinttext: '',
                  typeofkeybord: TextInputType.text,
                  suffixicon: Icons.share_arrival_time,
                  validate: (String? m) {
                    if (m!.isEmpty) return "يجب اختيار وقت الذهاب ";
                    return null;
                  },
                  ontap: () {
                    MyDropdown(
                      controller: GOcontroller,
                      mylist: AppCubit.get(context).GoTimesMenue,
                      context: context,
                      title: "وقت الذهاب",
                    );
                  }),
            ),
          ],
        ),
      ],
    ),
  );
}

//===========================AdditionalTrip============================================
void AdditonalTrip({
  context,
  required TextEditingController Time_AdditionalTrip,
  required TextEditingController Date_AdditionalTrip,
  required TextEditingController Type_AdditionalTrip,
}) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
            side: BorderSide(color: mycolor.blue, width: 5),
            borderRadius: BorderRadius.circular(30)),
        content: BlocConsumer<DataBase, DatabaseStates>(
          listener: (context, state) {
            if (state is InsertedData) {
              Navigator.of(context).pop();
            }
          },
          builder: (context, state) {
            if (state is LoadingState)
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [myLoading()],
              );
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'املأ معلومات الرحلة',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                    color: mycolor.blue,
                  ),
                ),
                DefoultFormField(
                    readonly: true,
                    controller: Time_AdditionalTrip,
                    myhinttext: 'اختر وقت الرحلة',
                    typeofkeybord: TextInputType.text,
                    validate: (String? m) {
                      if (m!.isEmpty) return "يجب اختيار وقت الرحلة ";
                      return null;
                    },
                    ontap: () async {
                      await DataBase.get(context).getimes();
                      MyDropdown(
                        controller: Time_AdditionalTrip,
                        mylist: MyData.timeItems,
                        context: context,
                        title: "اختر وقت الرحلة",
                      );
                    }),
                DefoultFormField(
                    controller: Date_AdditionalTrip,
                    myhinttext: 'اختر تاريخ الرحلة',
                    typeofkeybord: TextInputType.text,
                    validate: (String? m) {
                      if (m!.isEmpty) return "يجب اختيار التاريخ  ";
                      return null;
                    },
                    readonly: true,
                    ontap: () {
                      showDatePicker(
                              builder: (context, child) {
                                return Theme(
                                  data: Theme.of(context).copyWith(
                                    colorScheme: ColorScheme.light(
                                      primary: mycolor.blue,
                                    ),
                                    textButtonTheme: TextButtonThemeData(
                                      style: TextButton.styleFrom(
                                        foregroundColor: mycolor.blue,
                                      ),
                                    ),
                                  ),
                                  child: child ?? Container(),
                                );
                              },
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now(),
                              lastDate:
                                  DateTime.now().add(const Duration(days: 6)))
                          .then((value) {
                        if (value != null) {
                          Date_AdditionalTrip.text =
                              value.toString().substring(0, 10);
                        }
                      });
                    }),
                DefoultFormField(
                    controller: Type_AdditionalTrip,
                    myhinttext: 'اختر نوع الرحلة',
                    typeofkeybord: TextInputType.text,
                    readonly: true,
                    validate: (String? m) {
                      if (m!.isEmpty) return "يجب اختيار نوع الرحلة ";
                      return null;
                    },
                    ontap: () {
                      MyDropdown(
                        controller: Type_AdditionalTrip,
                        mylist: AppCubit.get(context).Type_AdditionalTRipMenue,
                        context: context,
                        title: "اختر نوع الرحلة",
                      );
                    }),
                submitbutton(
                    mytext: 'إرسال',
                    pressthisbutton: () {
                      var time = Time_AdditionalTrip.text.split(':');
                      Duration x = Duration(
                          hours: int.parse(time[0]),
                          minutes: int.parse(time[1]));
                      var tripDate =
                          DateTime.parse(Date_AdditionalTrip.text).add(x);
                      TempReservations AddTrip = new TempReservations(
                        userId: MyData.user!.userId,
                        TripType: Type_AdditionalTrip.text,
                        date: tripDate,
                        type: 1,
                      );
                      DataBase.get(context).insertTrip(AddTrip).then((value) {
                        Date_AdditionalTrip.clear();
                        Time_AdditionalTrip.clear();
                        Type_AdditionalTrip.clear();
                      });
                    }),
              ],
            );
          },
        ),
      );
    },
  );
}

//********owisButton************************************ */
Widget owbutton({
  required Function onpress,
}) {
  return Container(
    margin: EdgeInsets.all(20.0),
    child: MaterialButton(
      color: mycolor.blue,
      shape: StadiumBorder(),
      onPressed: () => onpress(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('حفظ',
              style: TextStyle(
                fontSize: 20,
              )),
          Icon(
            Icons.save_outlined,
          )
        ],
      ),
    ),
  );
}

//*****************************************material button ****************
Widget DefaultMaterialButton({
  // i use this in login and signup forms
  required context,
  String? text,
  required Function onpressed,
}) {
  return Container(
    decoration: BoxDecoration(boxShadow: [
      BoxShadow(
        color: Color.fromRGBO(0, 0, 0, 0.541),
        blurRadius: 10.0,
      ),
    ], borderRadius: BorderRadius.circular(70.0), color: mycolor.blue),
    margin: EdgeInsets.all(15),
    height: 50.0,
    width: WidthOfScreen(context),
    child: MaterialButton(
      onPressed: () => onpressed(),
      child: Text(
        text!,
        textAlign: TextAlign.center,
        textDirection: TextDirection.rtl,
        style: TextStyle(
            fontSize: 25.0,
            fontWeight: FontWeight.bold,
            color: mycolor.lightwight),
      ),
    ),
  );
}

//==============================================================
Widget submitbutton({
  //for Additional Trip
  required String mytext,
  Color? myfontcolor,
  required void Function() pressthisbutton,
}) {
  return FloatingActionButton(
    backgroundColor: Color(0XFF7fbcd2),
    onPressed: pressthisbutton,
    child: Text(
      mytext,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 15.0,
        color: myfontcolor,
      ),
    ),
  );
}

//******************************************************************************* */
void GoforWard(context, Widget myscreen) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) {
      return myscreen;
    }),
  );
}
//***************************MesureOfScreen**************************************** */

double HieghtOfScreen(context) {
  double Heightofscreen = MediaQuery.of(context).size.height;
  return Heightofscreen;
}

double WidthOfScreen(context) {
  double Widthtofscreen = MediaQuery.of(context).size.width;
  return Widthtofscreen;
}

//============================================================
Widget mysizedbox({
  double? myheight,
  double? mywidth,
}) {
  return SizedBox(
    height: myheight,
    width: mywidth,
  );
}

//=============================Snakbar=================================
mySnackBar(
    String content, BuildContext context, Color background, Color textColor) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(
      content,
      style: TextStyle(color: textColor),
    ),
    backgroundColor: background,
    duration: const Duration(seconds: 3),
  ));
}

//********************** */
//*************************************************************
Widget MyList_Future_Trip(context) {
// هذا التابع ليتم استدعائه في التاب بار فيو ويمثل الرحلات المستقبلية
  return ListView.separated(
    itemBuilder: (context, index) {
      MyTrip myTrip = MyData.FutureTripList[index];

      return mycard(
        context: context,
        myTrip: myTrip,
      );
    },
    separatorBuilder: (context, index) {
      return SizedBox(
        height: 0.0,
      );
    },
    itemCount: MyData.FutureTripList.length,
  );
}

Widget MyList_Pre_Trip(context) {
// هذا التابع ليتم استدعائه في التاب بار فيو ويمثل الرحلات السابقة
  return ListView.separated(
    itemBuilder: (context, index) {
      MyTrip myTrip = MyData.PreTripList[index];

      return mycard(
        context: context,
        myTrip: myTrip,
      );
    },
    separatorBuilder: (context, index) {
      return SizedBox(
        height: 0.0,
      );
    },
    itemCount: MyData.PreTripList.length,
  );
}
//=====================================================

//************************** Trip information ****************************************** */

mycard({
  context,
  required MyTrip myTrip,
}) {
  return InkWell(
    onTap: () {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                side: BorderSide(color: mycolor.blue, width: 3),
                borderRadius: BorderRadius.circular(30)),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                myvalues('السائق', myTrip.driver.driverName),
                myvalues(' رقم الهاتف', myTrip.driver.driverPhone),
                myvalues('نوع الباص', myTrip.bus.busType),
                myvalues('رقم الباص', myTrip.bus.busNumber.toString()),
              ],
            ),
          );
        },
      );
    },
    child: Card(
      elevation: 10,
      margin: EdgeInsets.fromLTRB(10, 5, 10, 0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
        myvalues(
            'موعد الرحلة ', myTrip.trip.tripDate.toString().substring(0, 16)),
        myvalues('سعر الرحلة', myTrip.trip.price.toString()),
        myvalues(
            'وقت وصول الباص',
            myTrip.reservation.reservation_arrive_time
                .toString()
                .substring(0, 5)),
        myvalues('نوع الرحلة', myTrip.trip.tripType),
      ]),
    ),
  );
}

//===================== error message ===================================
myError({required String msg, required VoidCallback onPressed}) {
  return Center(
    child: Card(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      elevation: 25,
      shadowColor: Colors.red,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(color: Colors.red, width: 2)),
      child: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 25, 10, 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              msg,
              style: const TextStyle(fontSize: 20, color: Colors.red),
            ),
            const SizedBox(height: 15),
            MaterialButton(
              color: Colors.redAccent,
              shape: const StadiumBorder(),
              onPressed: onPressed,
              child: const Text('حاول مجدداً',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  )),
            )
          ],
        ),
      )),
    ),
  );
}
//============================== loading state ===============================

myLoading() {
  return Container(
    color: mycolor.blue,
    child: Center(
      child: CircularProgressIndicator(
        backgroundColor: mycolor.lightwight,
        color: mycolor.blue,
      ),
    ),
  );
}

//===========================================================================
void MyDropdown({
  required TextEditingController controller,
  dynamic context,
  required List<SelectedListItem> mylist,
  String? title,
}) {
  DropDownState(
    DropDown(
      data: mylist,
      bottomSheetTitle: Text(
        title!,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20.0,
        ),
      ),
      dropDownBackgroundColor: Color(0XFffecf3f9),
      enableMultipleSelection: false,
      selectedItems: (List<dynamic> selectedList) {
        List<String> list = [];
        for (var item in selectedList) {
          if (item is SelectedListItem) {
            list.add(item.name);
          }
          controller.text = list[0].toString();
        }
      },
    ),
  ).showModal(context);
}
//************************************************************************* */



