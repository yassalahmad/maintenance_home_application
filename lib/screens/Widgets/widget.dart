import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

Widget appBarMain(BuildContext context){
  return AppBar(
    title: Image.asset("assets/images/logo.png", height: 50,),
  );
}

InputDecoration textFieldInputDecoration(String hintText, String labelText,){
  return InputDecoration(
      hintText: hintText,
      labelText: labelText,
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.teal),
      ),
      enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black)
      )
  );
}

/// User /////////////////////////////////////
showToaster(String msg) {
  return Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: Colors.grey.shade700,
    textColor: Colors.white,
  );
}


/// Password View on Login and Register Page ////////////////
InputDecoration passwordViewInputDecoration(
    String labelText, Icon preIconType, Widget postIconType) {
  return InputDecoration(
    focusedBorder:
    UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
    enabledBorder:
    UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
    prefixIcon: preIconType,
    suffix: postIconType,
    labelText: labelText,
    labelStyle: TextStyle(
      color: Colors.grey,
      fontFamily: 'Montserrat',
      fontWeight: FontWeight.bold,
    ),
  );
}
