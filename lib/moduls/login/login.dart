// ignore_for_file: non_constant_identifier_names

import 'package:bus_book/moduls/login/cubit/cubit.dart';
import 'package:bus_book/moduls/login/cubit/logincubitstate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../shared/componants.dart';

class LogInFormScreen extends StatefulWidget {
  @override
  State<LogInFormScreen> createState() => _LogInFormScreenState();
}

class _LogInFormScreenState extends State<LogInFormScreen> {
  //**************************************************************
  var formkey = GlobalKey<FormState>();
  var Emailcontroller = TextEditingController();
  var passwordcontroller = TextEditingController();
//**************************************************************
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginStates>(
      listener: (BuildContext context, Object? state) {},
      builder: (BuildContext context, state) {
        return Form(
          key: formkey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                DefoultFormField(
                  controller: Emailcontroller,
                  myhinttext: 'الايميل ',
                  suffixicon: Icons.email,
                  typeofkeybord: TextInputType.emailAddress,
                  mytextalign: TextAlign.end,
                  validate: (String value) {
                    if (value.isEmpty) {
                      return "يجب ادخال الايميل ";
                    }
                    return null;
                  },
                ),
                DefoultFormField(
                  controller: passwordcontroller,
                  myhinttext: 'كلمة المرور ',
                  suffixicon: Icons.remove_red_eye_outlined,
                  typeofkeybord: TextInputType.text,
                  mytextalign: TextAlign.end,
                  prefix: LoginCubit.get(context).prefix,
                  ispassword: LoginCubit.get(context).ispassword,
                  prefixpressed: () {
                    LoginCubit.get(context).changepasswordvisibility();
                  },
                  validate: (String value) {
                    if (value.isEmpty) {
                      return "يجب ادخال كلمة السر ";
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
