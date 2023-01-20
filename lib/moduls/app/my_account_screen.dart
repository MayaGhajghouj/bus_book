import 'package:bus_book/shared/loginCubit/cubit.dart';
import 'package:bus_book/shared/loginCubit/logincubitstate.dart';
import 'package:bus_book/shared/componants.dart';
import 'package:bus_book/shared/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyAccountSccreen extends StatefulWidget {
  const MyAccountSccreen({super.key});

  @override
  State<MyAccountSccreen> createState() => _MyAccountSccreenState();
}

class _MyAccountSccreenState extends State<MyAccountSccreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginStates>(
      builder: (BuildContext context, state) {
        LoginCubit MyLogincubit = LoginCubit.get(context);
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
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: SingleChildScrollView(
                child: Column(
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
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(
                              Icons.arrow_back_outlined,
                              color: mycolor.blue,
                            ),
                          ),
                          Text(
                            'حسابي',
                            textAlign: TextAlign.center,
                            textDirection: TextDirection.rtl,
                            style: TextStyle(
                                fontSize: 30.0,
                                fontWeight: FontWeight.bold,
                                color: mycolor.blue),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black54,
                              blurRadius: 15,
                            ),
                          ],
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white),
                      child: Form(
                        key: MyLogincubit.formkey,
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
                              validate: (String? m) {
                                if (m!.isEmpty) return "يجب ادخال الايميل ";
                                return null;
                              },
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
                                LoginCubit.get(context)
                                    .changepasswordvisibility();
                              },
                              validate: (String? m) {
                                if (m!.isEmpty ||
                                    (m.length <= 10 && m.length > 15))
                                  return "يجب ادخال كلمة أكثر من 10  محارف  ";
                                return null;
                              },
                            ),
                            DefoultFormField(
                              controller: MyLogincubit.Phonecontroller,
                              myhinttext: 'رقم الهاتف ',
                              suffixicon: Icons.phone,
                              typeofkeybord: TextInputType.phone,
                              mytextalign: TextAlign.end,
                              validate: (String? m) {
                                if (m!.isEmpty) return "يجب ادخال رقم الهاتف ";
                                return null;
                              },
                            ),
                            DefoultFormField(
                                controller: MyLogincubit.Addresscontroller,
                                myhinttext: 'ادخل العنوان ',
                                typeofkeybord: TextInputType.text,
                                suffixicon: Icons.location_city,
                                validate: (String? m) {
                                  if (m!.isEmpty) return "يجب اختيار عنوان ";
                                  return null;
                                },
                                ontap: () {
                                  MyDropdown(
                                    controller: MyLogincubit.Addresscontroller,
                                    mylist: MyLogincubit.mymenue,
                                    context: this.context,
                                    title: "العنوان ",
                                  );
                                }),
                            owbutton(onpress: () {
                              if (MyLogincubit.formkey.currentState!
                                  .validate()) {
                                print(MyLogincubit.Emailcontroller);
                              }
                            }),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
      listener: (BuildContext context, Object? state) {},
    );
  }
}
