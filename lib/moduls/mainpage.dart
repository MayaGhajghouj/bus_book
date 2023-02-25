import 'package:bus_book/Backend/database.dart';
import 'package:bus_book/Backend/db_states.dart';
import 'package:bus_book/moduls/my_account_screen.dart';
import 'package:bus_book/moduls/week_table_screen.dart';
import 'package:bus_book/shared/Appcubitt/appcubit.dart';
import 'package:bus_book/shared/Appcubitt/appstates.dart';
import 'package:bus_book/shared/componants.dart';
import 'package:bus_book/shared/Constants/mycolors.dart';
import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Backend/myData.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

//=============================================================================
class _MainPageState extends State<MainPage>
    with SingleTickerProviderStateMixin {
  late TabController _controller;

  bool _hasCallSupport = false;
  Future<void>? _launched;
//****************************************
  @override
  void initState() {
    _controller = TabController(length: 2, vsync: this);
    _controller.addListener(() {
      setState(() {});
    });

    canLaunchUrl(Uri(scheme: 'tel', path: '123')).then((bool result) {
      setState(() {
        _hasCallSupport = result;
      });
    }).then((value) {
      DataBase.get(context).getUserTrips(MyData.user!.userId);
      DataBase.get(context).getManager();
    });
    //=================== initilization =============================================

    //=================== initilization =============================================

    super.initState();
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

//****************************************
  Widget build(BuildContext context) {
    AppCubit MyAppcubit = AppCubit.get(context);
    return BlocConsumer<AppCubit, AppStates>(
      listener: (BuildContext context, Object? state) {},
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
                body: BlocConsumer<DataBase, DatabaseStates>(
                  listener: (context, state) {
                    if (state is ErrorSelectingDataState ||
                        state is ErrorUpdatingDataState ||
                        state is ErrorInsertingDataState)
                      mySnackBar(
                          state.msg, context, Colors.orange, Colors.black);
                    else if (state is SelectedData ||
                        state is UpdatedData ||
                        state is InsertedData)
                      mySnackBar(
                          state.msg, context, Colors.yellow, Colors.black);
                  },
                  builder: (context, state) {
                    if (state is LoadingState) return myLoading();
                    return Column(
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
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        shape: RoundedRectangleBorder(
                                            side: BorderSide(
                                                color: mycolor.blue, width: 3),
                                            borderRadius:
                                                BorderRadius.circular(30)),
                                        content: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            myvalues('اسم المدير',
                                                MyData.mymanager!.name),
                                            myvalues('رقم الهاتف',
                                                MyData.mymanager!.phone),
                                            ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                primary: mycolor.blue,
                                                side: BorderSide(
                                                  width: 3.0,
                                                  color: mycolor.lightwight,
                                                ),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          50.0),
                                                ),
                                              ),
                                              onPressed: _hasCallSupport
                                                  ? () => setState(() {
                                                        _launched =
                                                            _makePhoneCall(
                                                                MyData
                                                                    .mymanager!
                                                                    .phone);
                                                      })
                                                  : null,
                                              child: _hasCallSupport
                                                  ? const Text('انقر للاتصال ')
                                                  : const Text(
                                                      'الاتصال غير متاح'),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: TabBarView(controller: _controller, children: [
                            MyList_Pre_Trip(this.context),
                            MyList_Future_Trip(this.context),
                          ]),
                        ),
                      ],
                    );
                  },
                ),
                // BottomnavigationBar
                bottomNavigationBar: DotNavigationBar(
                  selectedItemColor: mycolor.blue,
                  currentIndex: MyAppcubit.selectedBottomIndex,
                  onTap: (p0) {
                    // MyAppcubit.changebottomnavbarScreen(p0);
                    if (p0 == 0) {
                      DataBase.get(context).getimes();
                      GoforWard(
                        context,
                        WeekTable(),
                      );
                    } else {
                      AdditonalTrip(
                        context: context,
                        Type_AdditionalTrip: MyAppcubit.Type_AdditionalTrip,
                        Date_AdditionalTrip: MyAppcubit.Date_AdditionalTrip,
                        Time_AdditionalTrip: MyAppcubit.Time_AdditionalTrip,
                      );
                    }
                  },
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
