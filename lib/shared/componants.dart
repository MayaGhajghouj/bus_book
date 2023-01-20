// ignore_for_file: non_constant_identifier_names, prefer_const_constructors

import 'package:bus_book/models/reservation.dart';
import 'package:bus_book/models/trip.dart';
import 'package:bus_book/shared/Appcubitt/appcubit.dart';
import 'package:bus_book/shared/constant.dart';
import 'package:bus_book/shared/lists.dart';
import 'package:drop_down_list/drop_down_list.dart';
import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:dropdown_plus/dropdown_plus.dart';
import 'package:flutter/material.dart';
import 'package:msh_checkbox/msh_checkbox.dart';

import '../models/bus.dart';
import '../models/driver.dart';

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

//==============================================================
Widget submitbutton({
  //for login signup screen
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

//====================================================================================
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

//************************************************************************* */

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

//******************************************************************** */
void myShowDialog(context) {
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
            myvalues('اسم المدير', 'محمد أحمد'),
            myvalues('رقم الهاتف', '0994033360'),
          ],
        ),
      );
    },
  );
}
//******************************************************************** */

mycard({
  context,
  required Driver driver,
  required Bus bus,
  required Trip trip,
  required Reservation reservation,
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
                myvalues('السائق', driver.driver_name),
                myvalues(' رقم الهاتف', driver.driver_phone),
                myvalues('نوع الباص', bus.bus_type),
                myvalues('رقم الباص', bus.bus_number.toString()),
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                    onPressed: () {},
                    color: mycolor.blue,
                    icon: Icon(Icons.delete_forever)),
                IconButton(
                    onPressed: () {},
                    color: mycolor.blue,
                    icon: Icon(Icons.edit)),
              ],
            ),
          ),
          Expanded(
              flex: 3,
              child:
                  Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                myvalues(
                    'وقت الرحلة ', trip.trip_time.toString().substring(0, 8)),
                myvalues(
                    'تاريخ الرحلة', trip.trip_date.toString().substring(0, 10)),
                myvalues(
                    'وقت وصول الباص',
                    reservation.reservation_arrive_time
                        .toString()
                        .substring(0, 8)),
                myvalues('نوع الرحلة', trip.trip_type),
              ]))
        ],
      ),
    ),
  );
}

//*************************************************************
Widget MyListOfTrips(context) {
// code meshooooooooooooooooooooooooo
  return ListView.separated(
    itemBuilder: (context, index) {
      Reservation r = Lists.reserves[index];
      Trip t = Lists.trips
          .where((element) => element.trip_id == r.reservatin_trip_id)
          .first;
      Bus b = Lists.buses.where((element) => element.bus_id == t.bus_id).first;
      Driver d = Lists.drivers
          .where((element) => element.driver_id == t.driver_id)
          .first;
      return mycard(
        context: context,
        driver: d,
        bus: b,
        reservation: r,
        trip: t,
      );
    },
    separatorBuilder: (context, index) {
      return SizedBox(
        height: 0.0,
      );
    },
    itemCount: Lists.reserves.length,
  );
}
//******************BuildItemofWeekTable***********************************

Widget BuildItemofWeekTable({
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
              child: Container(
                padding: EdgeInsets.all(5.0),
                margin: EdgeInsets.all(5.0),
                child: TextDropdownFormField(
                  controller: AppCubit.get(context).TripBackTimeController,
                  options: ["10.0", "12.0", "14.0", "16.0"],
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(
                        Icons.arrow_drop_down,
                      ),
                      labelText: "أوقات العودة"),
                  dropdownHeight: 100,
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(5.0),
                margin: EdgeInsets.all(5.0),
                child: TextDropdownFormField(
                  controller: AppCubit.get(context).TripGoTimeController,
                  options: ["8.0", "10.0", "12.0", "14.0"],
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(Icons.arrow_drop_down),
                      labelText: "أوقات الذهاب"),
                  dropdownHeight: 100,
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

//********owisButton************************************ */
Widget owbutton({
  required Function onpress,
}) {
  return Container(
    margin: EdgeInsets.all(15),
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
  // i dont use this
  required context,
  String? text,
  required Function onpressed,
}) {
  return Container(
    decoration: BoxDecoration(boxShadow: [
      BoxShadow(
        color: Color.fromRGBO(0, 0, 0, 0.541),
        blurRadius: 15,
      ),
    ], borderRadius: BorderRadius.circular(50), color: mycolor.lightwight),
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
            fontSize: 25.0, fontWeight: FontWeight.bold, color: mycolor.blue),
      ),
    ),
  );
}

//===========================AdditionalTrip============================================
void AdditonalTrip(context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
            side: BorderSide(color: mycolor.blue, width: 5),
            borderRadius: BorderRadius.circular(30)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'اختر موعد رحلتك الإضافية ',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
                color: mycolor.blue,
              ),
            ),
            Container(
              margin: EdgeInsets.all(10.0),
              child: TextDropdownFormField(
                controller: AppCubit.get(context).AdditionaTypelTrip,
                options: ["ذهاب", "عودة"],
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(
                      Icons.arrow_drop_down,
                    ),
                    labelText: "نوع الرحلة"),
                dropdownHeight: 100,
              ),
            ),
            Container(
              margin: EdgeInsets.all(10.0),
              child: TextDropdownFormField(
                controller: AppCubit.get(context).AdditionalDayTrip,
                options: ["السبت", "الأحد", "الاثنين", "الثلاثاء", "الأربعاء"],
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(
                      Icons.arrow_drop_down,
                    ),
                    labelText: "اليوم"),
                dropdownHeight: 100,
              ),
            ),
            Container(
              margin: EdgeInsets.all(10.0),
              child: TextDropdownFormField(
                controller: AppCubit.get(context).AdditionalTimeTrip,
                options: ["8:0", "10:0", "12:0", "14:0", "16:0"],
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.arrow_drop_down),
                    labelText: "أوقات الرحلة"),
                dropdownHeight: 100,
              ),
            ),
            submitbutton(mytext: 'إرسال', pressthisbutton: () {}),
          ],
        ),
      );
    },
  );
}

//=============================Snakbar=================================
mySnackBar(String content, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(
      content,
      style: const TextStyle(color: Colors.white),
    ),
    backgroundColor: Colors.red,
    duration: const Duration(seconds: 1),
  ));
}
