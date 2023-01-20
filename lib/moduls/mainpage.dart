import 'package:bus_book/moduls/my_account_screen.dart';
import 'package:bus_book/moduls/week_table_screen.dart';
import 'package:bus_book/shared/Appcubitt/appcubit.dart';
import 'package:bus_book/shared/Appcubitt/appstates.dart';
import 'package:bus_book/shared/componants.dart';
import 'package:bus_book/shared/constant.dart';
import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

//=============================================================================
class _MainPageState extends State<MainPage>
    with SingleTickerProviderStateMixin {
  late TabController _controller;

//****************************************
  @override
  void initState() {
    _controller = TabController(length: 2, vsync: this);
    _controller.addListener(() {
      setState(() {});
    });
    AppCubit.get(context).connectToDB();
    super.initState();
  }

  @override
  void dispose() {
    // AppCubit.get(context).disconnectToDB();
    super.dispose();
  }

//****************************************
  Widget build(BuildContext context) {
    AppCubit MyAppcubit = AppCubit.get(context);
    return BlocConsumer<AppCubit, AppStates>(
      listener: (BuildContext context, Object? state) {
        mySnackBar(state.toString(), context);
        if (state is ConnectedToMySql) {
          MyAppcubit.getdata();
        }
      },
      builder: (BuildContext context, state) {
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
            child: DefaultTabController(
              length: 2,
              child: Scaffold(
                extendBody: false,
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
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.account_circle,
                              size: 30.0,
                              color: mycolor.blue,
                            ),
                            onPressed: () {
                              GoforWard(context, MyAccountSccreen());
                            },
                          ),
                          //**************************** */
                          Expanded(
                            //tabbarLabels
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
                                fontSize: 18.0,
                              ),
                              tabs: MyAppcubit.MyTabLabels,
                            ),
                          ),
                          //************************************* */
                          IconButton(
                            icon: Icon(
                              Icons.message_rounded,
                              size: 30.0,
                              color: mycolor.blue,
                            ),
                            onPressed: () {
                              myShowDialog(context);
                            },
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: TabBarView(controller: _controller, children: [
                        MyListOfTrips(context),
                        MyListOfTrips(context),
                      ]),
                    ),
                  ],
                ),
                // BottomnavigationBar
                bottomNavigationBar: DotNavigationBar(
                  selectedItemColor: mycolor.blue,
                  currentIndex: MyAppcubit.selectedBottomIndex,
                  onTap: (p0) {
                    MyAppcubit.changebottomnavbarScreen(p0);
                    if (MyAppcubit.selectedBottomIndex == 0)
                      GoforWard(
                        context,
                        WeekTable(),
                      );
                    else {
                      AdditonalTrip(context);
                    }
                  },
                  //   dotIndicatorColor: Colors.black,
                  //enableFloatingNavBar: true,
                  items: MyAppcubit.NavBarItems,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
