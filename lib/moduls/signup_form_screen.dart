// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, unused_local_variable, use_key_in_widget_constructors, must_be_immutable, prefer_const_literals_to_create_immutables

import 'package:bus_book/Backend/database.dart';
import 'package:bus_book/Backend/db_states.dart';
import 'package:bus_book/shared/Appcubitt/appcubit.dart';
import 'package:bus_book/shared/Appcubitt/appstates.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../shared/componants.dart';

class SignUpFormScreen extends StatefulWidget {
  @override
  State<SignUpFormScreen> createState() => _SignUpFormScreenState();
}

class _SignUpFormScreenState extends State<SignUpFormScreen> {
  @override
  void initState() {
    DataBase.get(context).connect();
    super.initState();
  }

  var formkey = GlobalKey<FormState>();
  var Namecontroller = TextEditingController();
  var Emailcontroller = TextEditingController();
  var passwordcontroller = TextEditingController();
  var Phonecontroller = TextEditingController();
  var Addresscontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    AppCubit MyLogincubit = AppCubit.get(context);
    return BlocConsumer<AppCubit, AppStates>(
      listener: (BuildContext context, Object? state) {
        if (state is Connected) {
          mySnackBar('connected_State', context, Colors.yellow, Colors.black);
        } else if (state is ErrorConnectingDataState)
          mySnackBar('Error_Connect', context, Colors.red, Colors.white);
      },
      builder: (BuildContext context, state) {
        return Form(
          key: formkey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                DefoultFormField(
                  controller: Namecontroller,
                  myhinttext: 'الاسم ',
                  suffixicon: Icons.account_circle,
                  typeofkeybord: TextInputType.text,
                  mytextalign: TextAlign.end,
                  validate: (String? m) {
                    if (m!.isEmpty) return "يجب ادخال الاسم ";
                    return null;
                  },
                ),
                DefoultFormField(
                  controller: Emailcontroller,
                  myhinttext: 'الايميل ',
                  suffixicon: Icons.email,
                  typeofkeybord: TextInputType.emailAddress,
                  mytextalign: TextAlign.end,
                  validate: (String? m) {
                    if (m!.isEmpty) return "يجب ادخال الايميل ";
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
                    if (m!.isEmpty || (m.length < 3 && m.length > 10))
                      return " يجب ادخال كلمة مرور من حرفين إلى عشر محارف ";
                    return null;
                  },
                ),
                DefoultFormField(
                  controller: Phonecontroller,
                  myhinttext: 'رقم الهاتف ',
                  suffixicon: Icons.phone,
                  typeofkeybord: TextInputType.phone,
                  mytextalign: TextAlign.end,
                  validate: (String? m) {
                    if (m!.isEmpty) return "يجب ادخال رقم الهاتف الخاص بك  ";
                    return null;
                  },
                ),
                DefoultFormField(
                    controller: Addresscontroller,
                    myhinttext: 'ادخل العنوان ',
                    typeofkeybord: TextInputType.text,
                    suffixicon: Icons.location_city,
                    validate: (String? m) {
                      if (m!.isEmpty) return "يجب ادخال العنوان الخاص بك  ";
                      return null;
                    },
                    ontap: () {
                      MyDropdown(
                        controller: Addresscontroller,
                        mylist: MyLogincubit.mymenue,
                        context: this.context,
                        title: "العنوان ",
                      );
                    }),
                DefaultMaterialButton(
                  context: context,
                  onpressed: () {
                    if (formkey.currentState!.validate()) {
                      print('*****************************************');
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
  } // builde method

}
