import 'package:bus_book/shared/loginCubit/logincubitstate.dart';
import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());
  static LoginCubit get(context) => BlocProvider.of(context);

  bool ispassword = true;
  IconData prefix = Icons.visibility_off_outlined;
  void changepasswordvisibility() {
    ispassword = !ispassword;
    prefix =
        ispassword ? Icons.visibility_off_outlined : Icons.visibility_outlined;
    emit(ChaangePasswordVisibility());
  }

//************************************************************************
  var formkey = GlobalKey<FormState>();
  var Namecontroller = TextEditingController();
  var Emailcontroller = TextEditingController();
  var passwordcontroller = TextEditingController();
  var Phonecontroller = TextEditingController();
  var Addresscontroller = TextEditingController();
  //************************************************************************ */
  List<SelectedListItem> mymenue = [
    SelectedListItem(
      name: "غربي شارع الهبشة",
    ),
    SelectedListItem(
      name: "غربي شارع أبو سيفو",
    ),
    SelectedListItem(
      name: "غربي شارع باسط",
    ),
    SelectedListItem(
      name: "غربي شارع المدارس ",
    ),
    SelectedListItem(
      name: "غربي شارع السكنة ",
    ),
    SelectedListItem(
      name: "غربي شارع المجمع",
    ),
    SelectedListItem(
      name: "شرقي شارع ثمانة اذار ",
    ),
    SelectedListItem(
      name: "شرقي شارع النهر ",
    ),
  ];
  String selectedaddres = "غربي شارع المجمع";
//************************************************************************

}
