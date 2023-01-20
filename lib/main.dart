import 'package:bus_book/DAtabase.dart';
import 'package:bus_book/moduls/app/week_table_screen.dart';
import 'package:bus_book/moduls/login/cubit/cubit.dart';
import 'package:bus_book/moduls/login/logIn_screen.dart';
import 'package:bus_book/shared/Appcubitt/appcubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'moduls/app/mainpage.dart';
import 'moduls/app/my_account_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: MultiBlocProvider(
        providers: [
          BlocProvider<LoginCubit>(
            create: (context) => LoginCubit(),
          ),
          BlocProvider<AppCubit>(
            create: (context) => AppCubit(),
          )
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: LogInScreen(),
        ),
      ),
    );
  }
}
