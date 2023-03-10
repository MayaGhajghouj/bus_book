import 'package:bus_book/Backend/database.dart';
import 'package:bus_book/moduls/logIn_screen.dart';
import 'package:bus_book/shared/Appcubitt/appcubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
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
          BlocProvider<AppCubit>(
            create: (context) => AppCubit(),
          ),
          BlocProvider<DataBase>(
            create: (context) => DataBase(),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: LogInScreen(),
        ),
      ),
    );
  }
}
