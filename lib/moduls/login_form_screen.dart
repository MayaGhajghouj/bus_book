// ignore_for_file: non_constant_identifier_names

import 'package:bus_book/Backend/database.dart';
import 'package:bus_book/Backend/db_states.dart';
import 'package:bus_book/shared/Appcubitt/appcubit.dart';
import 'package:bus_book/shared/Appcubitt/appstates.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../shared/componants.dart';

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
    AppCubit MyLogincubit = AppCubit.get(context);
    DataBase myDB = DataBase.get(context);
    return BlocConsumer<DataBase, DatabaseStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return BlocConsumer<AppCubit, AppStates>(
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
                      prefix: MyLogincubit.prefix,
                      ispassword: MyLogincubit.ispassword,
                      prefixpressed: () {
                        MyLogincubit.changepasswordvisibility();
                      },
                      validate: (String? m) {
                        if (m!.isEmpty || (m.length < 3 || m.length > 10))
                          return " يجب ادخال كلمة مرور من ثلاث إلى عشر محارف ";
                        return null;
                      },
                    ),
                    DefaultMaterialButton(
                      context: context,
                      onpressed: () {
                        if (formkey.currentState!.validate()) {
                          myDB.UserLogin(Emailcontroller.text,
                                  passwordcontroller.text, this.context)
                              .then((value) {
                            Emailcontroller.clear();
                            passwordcontroller.clear();
                          });
                        }
                      },
                      text: "حفظ",
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
