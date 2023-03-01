import 'package:bus_book/Backend/database.dart';
import 'package:bus_book/Backend/db_states.dart';
import 'package:bus_book/Backend/myData.dart';
import 'package:bus_book/shared/Appcubitt/appcubit.dart';
import 'package:bus_book/shared/Appcubitt/appstates.dart';
import 'package:bus_book/shared/componants.dart';
import 'package:bus_book/shared/Constants/mycolors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WeekTable extends StatefulWidget {
  @override
  State<WeekTable> createState() => _WeekTableState();
}

class _WeekTableState extends State<WeekTable> {
  var formkey = GlobalKey<FormState>();

  @override
  void initState() {
    DataBase.get(context).GetTempReservation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AppCubit mycubit = AppCubit.get(context);

    return BlocConsumer<AppCubit, AppStates>(
      listener: (BuildContext context, Object? state) {},
      builder: (BuildContext context, state) {
        return BlocBuilder<DataBase, DatabaseStates>(builder: (context, state) {
          if (state is LoadingState) return myLoading();
          if (state is ErrorSelectingDataState)
            return myError(
                msg: state.msg,
                onPressed: () {
                  DataBase.get(context).GetTempReservation();
                });
          List<Widget> children = [];
          for (var x in MyData.weekdata.values) {
            children.add(BuildItemofWeekTable(
                index: x.dateTime!.weekday, context: context));
          }
          children.add(DefaultMaterialButton(
            context: context,
            text: 'إرسال ',
            onpressed: () {
              if (formkey.currentState!.validate()) {
                DataBase.get(context).InsertWeekTable().then((value) {
                  Navigator.of(context).pop();
                });
              }
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
              child: Form(
                key: formkey,
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
                              textDirection: TextDirection.rtl,
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
            ),
          );
        });
      },
    );
  }
}
