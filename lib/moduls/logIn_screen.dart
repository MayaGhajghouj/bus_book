// ignore_for_file: file_names, must_be_immutable, prefer_const_constructors

import 'package:bus_book/Backend/database.dart';
import 'package:bus_book/Backend/db_states.dart';
import 'package:bus_book/moduls/signup_form_screen.dart';
import 'package:bus_book/moduls/login_form_screen.dart';
import 'package:bus_book/shared/Appcubitt/appcubit.dart';
import 'package:bus_book/shared/Appcubitt/appstates.dart';
import 'package:bus_book/shared/Constants/mycolors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../Backend/myData.dart';
import '../shared/componants.dart';
import 'mainpage.dart';

class LogInScreen extends StatefulWidget {
  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    AppCubit.get(context).controller = TabController(length: 2, vsync: this);

    AppCubit.get(context).controller.addListener(() {
      setState(() {});
    });
    DataBase.get(context).connect();
    print(
        '=================================== initilization ========================================================');
    super.initState();
  }

  //**************************************************************
  List<Widget> Mylabels = [
    // ignore: prefer_const_constructors
    Tab(
      text: 'إنشاء حساب',
    ),
    Tab(
      text: 'تسجيل دخول ',
    ),
  ];

  final SignUpFormScreen signupObject = SignUpFormScreen();
  final LogInFormScreen loginObject = LogInFormScreen();
//************************************************************************

  @override
  Widget build(BuildContext context) {
    //====================================================================================
    return BlocConsumer<AppCubit, AppStates>(
      listener: (BuildContext context, Object? state) {},
      builder: (BuildContext context, state) {
        AppCubit myCubit = AppCubit.get(context);
        return DefaultTabController(
          length: 2,
          child: Scaffold(
            body: BlocConsumer<DataBase, DatabaseStates>(
              listener: (context, state) {
                if (state is ErrorConnectingDataState ||
                    state is ErrorInsertingDataState ||
                    state is ErrorSelectingDataState) {
                  mySnackBar(state.msg, context, Colors.red, Colors.white);
                } else if (state is SelectedData) {
                  Navigator.pop(context);

                  GoforWard(context, MainPage());
                  //   mySnackBar(state.msg, context, Colors.blue, Colors.white);
                } else if (state is InsertedData) {
                  AppCubit.get(context).controller.index = 1;
                  mySnackBar(state.msg, context, Colors.blue, Colors.white);
                } else if (state is Connected)
                  mySnackBar(state.msg, context, Colors.blue, Colors.white);
              },
              builder: (context, state) {
                if (state is LoadingState) {
                  return myLoading();
                } else if (state is ErrorConnectingDataState) {
                  return myError(
                      msg: state.msg,
                      onPressed: () {
                        DataBase.get(context).connect();
                      });
                }
                return Stack(
                  children: [
                    Column(
                      children: [
                        Expanded(
                          child: Container(
                            width: double.infinity,
                            color: Color(0xff7FBCD2),
                            margin: EdgeInsetsDirectional.only(
                              top: 23.0,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(40.0),
                              child: Text(
                                myCubit.controller.index == 0
                                    ? 'مرحبا بك '
                                    : 'اهلا بعودتك من جديد ',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 30.0,
                                  fontFamily: "Almarai",
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            color: Color(0XFfFFEEAF), //
                          ),
                        ),
                      ],
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Container(
                          height: myCubit.controller.index == 1
                              ? HieghtOfScreen(context) * 0.5
                              : HieghtOfScreen(context) * 0.70,
                          decoration: BoxDecoration(
                            color: Color(0XFffecf3f9),
                            borderRadius: BorderRadiusDirectional.all(
                              Radius.circular(50.0),
                            ),
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 30.0,
                                spreadRadius: 3.0,
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                // this container  for tabBar labels
                                height: 70.0,
                                child: TabBar(
                                  controller: myCubit.controller,
                                  labelColor: mycolor.blue,
                                  unselectedLabelColor: Color(0xff61000000),
                                  labelPadding: EdgeInsets.all(5.0),
                                  indicatorColor: mycolor.blue,
                                  indicatorSize: TabBarIndicatorSize.label,
                                  indicatorWeight: 5.0,
                                  labelStyle: TextStyle(
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20.0,
                                  ),
                                  tabs: Mylabels,
                                ),
                              ),
                              Expanded(
                                // ignore: prefer_const_literals_to_create_immutables
                                child: TabBarView(
                                    controller: myCubit.controller,
                                    children: [signupObject, loginObject]),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ], //stack
                );
              },
            ),
          ),
        );
      },
    );
  }
}
