import 'package:flutter/material.dart';
import 'package:maintenance_home_application/screens/ServiceProvider/signin.dart';
import 'package:maintenance_home_application/screens/ServiceProvider/signup.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({Key? key}) : super(key: key);

  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {

  bool showSignIn = true;
  void toggleView(){
    setState(() {
      showSignIn =! showSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    if(showSignIn){
      return PSignIn(toggle: toggleView);
    }else{
      return PSignUp(toggle: toggleView);
    }
  }
}
