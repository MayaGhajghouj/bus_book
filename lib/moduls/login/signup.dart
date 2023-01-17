// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, unused_local_variable, use_key_in_widget_constructors, must_be_immutable, prefer_const_literals_to_create_immutables

import 'package:bus_book/moduls/login/cubit/cubit.dart';
import 'package:bus_book/moduls/login/cubit/logincubitstate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/componants.dart';

class SignUpFormScreen extends StatefulWidget {
  @override
  State<SignUpFormScreen> createState() => _SignUpFormScreenState();
}

class _SignUpFormScreenState extends State<SignUpFormScreen> {
  @override
  Widget build(BuildContext context) {
    LoginCubit MyLogincubit = LoginCubit.get(context);
    return BlocConsumer<LoginCubit, LoginStates>(
      listener: (BuildContext context, Object? state) {
        if (state is ChaangePasswordVisibility) {
          print('******************************************************* ');
        }
      },
      builder: (BuildContext context, state) {
        return Form(
          key: MyLogincubit.formkey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                DefoultFormField(
                  controller: MyLogincubit.Namecontroller,
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
                  controller: MyLogincubit.Emailcontroller,
                  myhinttext: 'الايميل ',
                  suffixicon: Icons.email,
                  typeofkeybord: TextInputType.emailAddress,
                  mytextalign: TextAlign.end,
                  validate: () {},
                ),
                DefoultFormField(
                  controller: MyLogincubit.passwordcontroller,
                  myhinttext: 'كلمة المرور ',
                  suffixicon: Icons.remove_red_eye_outlined,
                  typeofkeybord: TextInputType.text,
                  mytextalign: TextAlign.end,
                  prefix: LoginCubit.get(context).prefix,
                  ispassword: LoginCubit.get(context).ispassword,
                  prefixpressed: () {
                    LoginCubit.get(context).changepasswordvisibility();
                  },
                  validate: () {},
                ),
                DefoultFormField(
                  controller: MyLogincubit.Phonecontroller,
                  myhinttext: 'رقم الهاتف ',
                  suffixicon: Icons.phone,
                  typeofkeybord: TextInputType.phone,
                  mytextalign: TextAlign.end,
                  validate: () {},
                ),
                DefoultFormField(
                    controller: MyLogincubit.Addresscontroller,
                    myhinttext: 'ادخل العنوان ',
                    typeofkeybord: TextInputType.text,
                    suffixicon: Icons.location_city,
                    validate: (String? value) {},
                    ontap: () {
                      MyDropdown(
                        controller: MyLogincubit.Addresscontroller,
                        mylist: MyLogincubit.mymenue,
                        context: this.context,
                        title: "العنوان ",
                      );
                    }),
                //===============DROPDawn====================================
                // Container(
                //   width: double.infinity,
                //   padding: EdgeInsets.all(10.0),
                //   margin: EdgeInsets.all(10.0),
                //   decoration: BoxDecoration(
                //     color: Color(0xff7FBCD2),
                //     borderRadius: BorderRadius.all(Radius.circular(50.0)),
                //   ),
                //   child: DropdownButton(
                //     onTap: () {
                //       print('tap*****************');
                //     },
                //     iconEnabledColor: Colors.white,
                //     iconSize: 40.0,
                //     isExpanded: true,
                //     disabledHint: Container(
                //       padding: EdgeInsets.only(right: 10.0),
                //       width: double.infinity,
                //       child: Text(
                //         "ادخل العنوان الخاص بك",
                //         textDirection: TextDirection.rtl,
                //         textAlign: TextAlign.right,
                //         style: TextStyle(
                //           color: Colors.white,
                //           fontSize: 20.0,
                //         ),
                //       ),
                //     ),
                //     hint: Container(
                //       padding: EdgeInsets.only(right: 10.0),
                //       width: double.infinity,
                //       child: Text(
                //         "ادخل العنوان الخاص بك",
                //         textDirection: TextDirection.rtl,
                //         textAlign: TextAlign.right,
                //         style: TextStyle(
                //           color: Colors.white,
                //           fontSize: 20.0,
                //         ),
                //       ),
                //     ),
                //     dropdownColor: Color(0xffFFEEAF),
                //     // underline: Divider(
                //     //   thickness: 0.0,
                //     // ),
                //     // icon: Icon(
                //     //   Icons.arrow_drop_down,
                //     //   size: 30.0,
                //     // ),
                //     value: selectedaddres,
                //     items: mymenue
                //         .map((e) => DropdownMenuItem(
                //               child: Text(
                //                 ' $e',
                //                 style: TextStyle(
                //                   fontWeight: FontWeight.bold,
                //                   color: Color(0xff61000000),
                //                 ),
                //               ),
                //               value: e,
                //             ))
                //         .toList(),
                //     onChanged: (String? value) {
                //       setState(() {
                //         if (value != null) {
                //           selectedaddres = value;
                //           print("======================$value===============");
                //         }
                //       });
                //     },
                //   ),
                // ),
                //==========================dropdawn 2=======================================
                // Container(
                //   width: double.infinity,
                //   margin: EdgeInsets.all(5.0),
                //   child: TextDropdownFormField(
                //     options: mymenue,
                //     decoration: InputDecoration(

                //       focusedBorder: OutlineInputBorder(
                //         borderSide: BorderSide(
                //           color: Color(0XFF7fbcd2),
                //           style: BorderStyle.solid,
                //           width: 3.0,
                //         ),
                //         borderRadius: BorderRadius.all(
                //           Radius.circular(50.0),
                //         ),
                //       ),
                //       enabledBorder: OutlineInputBorder(
                //         borderSide: BorderSide(
                //           color: Color(0xff61000000),
                //           style: BorderStyle.solid,
                //         ),
                //         borderRadius: BorderRadius.all(
                //           Radius.circular(50.0),
                //         ),
                //       ),
                //       suffixIcon: Icon(Icons.arrow_drop_down),
                //       labelText: "العنوان",
                //     ),
                //     dropdownHeight: 120,
                //     validator: (value) {},
                //     controller: Addresscontroller,
                //     onSaved: (String? value) {
                //       print('***************************************');
                //       print(Addresscontroller);
                //       print('***************************************');
                //     },
                //   ),
                // ),
                //====================dropdown 3==================================
              ],
            ),
          ),
        );
      },
    );
  } // builde method

}
