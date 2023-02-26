import 'package:bus_book/Backend/database.dart';
import 'package:bus_book/Backend/myData.dart';
import 'package:bus_book/models/temp_reservations.dart';
import 'package:bus_book/shared/Appcubitt/appcubit.dart';
import 'package:bus_book/shared/Appcubitt/appstates.dart';
import 'package:bus_book/shared/componants.dart';
import 'package:bus_book/shared/Constants/mycolors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class WeekTable extends StatefulWidget {
  @override
  State<WeekTable> createState() => _WeekTableState();
}

class _WeekTableState extends State<WeekTable> {
  // const WeekTable({super.key});

  Map<int, DateTime> weekDate = {};
  /* static const int monday = 1;
  static const int tuesday = 2;
  static const int wednesday = 3;
  static const int thursday = 4;
  static const int friday = 5;
  static const int saturday = 6;
  static const int sunday = 7; */
  Map<int, String> weekdays = {
    1: "الاثنين",
    2: 'الثلاثاء',
    3: 'الاربعاء',
    4: 'الخميس',
    5: 'الجمعة',
    6: 'السبت',
    7: 'الأحد'
  };
  Map<int, TextEditingController> Gocontrollars = {
    1: TextEditingController(),
    2: TextEditingController(),
    3: TextEditingController(),
    4: TextEditingController(),
    5: TextEditingController(),
    6: TextEditingController(),
    7: TextEditingController(),
  };
  Map<int, TextEditingController> Backcontrollars = {
    1: TextEditingController(),
    2: TextEditingController(),
    3: TextEditingController(),
    4: TextEditingController(),
    5: TextEditingController(),
    6: TextEditingController(),
    7: TextEditingController(),
  };
  List<TempReservations> ww = [];
  @override
  Widget build(BuildContext context) {
    AppCubit MyAppcubit = AppCubit.get(context);
    return BlocConsumer<AppCubit, AppStates>(
      listener: (BuildContext context, Object? state) {},
      builder: (BuildContext context, state) {
        var dateNow = DateTime(
            DateTime.now().year, DateTime.now().month, DateTime.now().day);
        for (int i = 1; i <= 7; i++) {
          DateTime temp = dateNow.add(Duration(days: i));
          weekDate[temp.weekday] = temp;
        }
        //===============================================================
        List<Widget> children = List.generate(8, (index) {
          if (index != 0 && index != 4 && index != 5) {
            var time = Gocontrollars[index]!.text.split(':');
            Duration x = Duration(
                hours: int.parse(time[0]), minutes: int.parse(time[1]));
            TempReservations a = new TempReservations(
                userId: MyData.user!.userId,
                TripType: 'ذهاب',
                date: weekDate[index]!.add(x),
                type: 0);
            ww.add(a);
            return BuildItemofWeekTable(
                GOcontroller: Gocontrollars[index]!,
                Backcontroller: Backcontrollars[index]!,
                context: context,
                day: weekdays[index],
                date: weekDate[index]);
          }
          return Container();
        });
        children.add(DefaultMaterialButton(
          context: context,
          text: 'إرسال ',
          onpressed: () {
            //   DataBase.get(context).insertTrip(trip:);

            for (var i = 0; i < Gocontrollars.length; i++) {
              print(
                  '======================${weekdays[i]}==================================');
              print(Gocontrollars[i]);
              print('========================================================');
            }
            // List<TempReservations> ww = [];
            // if (AppCubit.get(context).checkvalueSaterday) {
            //   ww.add(TempReservations(
            //     userId: MyData.user!.userId,
            //     TripType: 'ذهاب',
            //     date: DateTime.parse(
            //       DateFormat('EEEE').format(
            //         DateTime.now().add(
            //           Duration(
            //             days: 7,
            //           ),
            //         ),
            //       ),
            //     ),
            //     type: 0,
            //   ));

            //   ww.add(TempReservations(
            //     userId: MyData.user!.userId,
            //     TripType: 'إياب',
            //     date: DateTime.parse(
            //       DateFormat('EEEE').format(
            //         DateTime.now().add(
            //           Duration(
            //             days: 7,
            //           ),
            //         ),
            //       ),
            //     ),
            //     type: 0,
            //   ));
            // }
          },
        ));
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
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, 0.541),
                            blurRadius: 15,
                          ),
                        ],
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.white),
                    margin: EdgeInsets.all(15),
                    height: 0.07 * MediaQuery.of(context).size.height,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.arrow_back_outlined,
                            color: mycolor.blue,
                          ),
                        ),
                        Text(
                          'جدول الرحلات الأسبوعية',
                          textAlign: TextAlign.center,
                          //  textDirection: TextDirection.rtl,
                          style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: mycolor.lightblack),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: children,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
