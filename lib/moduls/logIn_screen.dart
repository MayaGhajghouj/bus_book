// ignore_for_file: file_names, must_be_immutable, prefer_const_constructors

import 'package:bus_book/shared/loginCubit/logincubit.dart';
import 'package:bus_book/shared/loginCubit/logincubitstate.dart';
import 'package:bus_book/moduls/signup_form_screen.dart';
import 'package:bus_book/moduls/login_form_screen.dart';
import 'package:bus_book/shared/Constants/mycolors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../shared/componants.dart';

class LogInScreen extends StatefulWidget {
  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen>
    with SingleTickerProviderStateMixin {
  late TabController _controller;

  @override
  void initState() {
    _controller = TabController(length: 2, vsync: this);

    _controller.addListener(() {
      setState(() {});
    });

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
    return BlocConsumer<LoginCubit, LoginStates>(
      listener: (BuildContext context, Object? state) {},
      builder: (BuildContext context, state) {
        return DefaultTabController(
          length: 2,
          child: Scaffold(
            body: Stack(
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
                            _controller.index == 0
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
                      height: _controller.index == 1
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
                              controller: _controller,
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
                                controller: _controller,
                                children: [signupObject, loginObject]),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ], //stack
            ),
          ),
        );
      },
    );
  }
}
