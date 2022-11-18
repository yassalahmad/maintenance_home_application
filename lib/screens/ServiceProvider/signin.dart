import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:maintenance_home_application/screens/Helper/helperfunction.dart';
import 'package:maintenance_home_application/screens/ServiceProvider/pdrawer.dart';
import 'package:maintenance_home_application/screens/ServiceProvider/signup.dart';
import 'package:maintenance_home_application/screens/Services/auth.dart';
import 'package:maintenance_home_application/screens/Services/database.dart';
import 'package:maintenance_home_application/screens/Widgets/widget.dart';
import 'forgotpassword.dart';


class PSignIn extends StatefulWidget {
  final Function? toggle;
  PSignIn({this.toggle});

  @override
  _PSignInState createState() => _PSignInState();
}

String p = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
RegExp regExp = new RegExp(p);

class _PSignInState extends State<PSignIn> {

  final formKey = GlobalKey<FormState>();
  MyAuthMethods myAuthMethods = MyAuthMethods();
  HelperFunction helperFunction = HelperFunction();
  DatabaseMethods databaseMethods = DatabaseMethods();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isLoading = false;
  QuerySnapshot<Map<String, dynamic>>? snapshotUserInfo;
  FirebaseAuth _auth=FirebaseAuth.instance;

  // Sign In Function
  // signIn(){
  //   if(formKey.currentState!.validate()){
  //     HelperFunction.saveUserEmailLoggedInSharedPreference(emailController.text);
  //     setState(() {
  //       isLoading = true;
  //     });
  //
  //     databaseMethods.getUserByUserEmail(emailController.text).then((val){
  //       snapshotUserInfo = val;
  //       HelperFunction.saveUserNameLoggedInSharedPreference(snapshotUserInfo?.docs[0].data()["Username"]);
  //     });
  //
  //     myAuthMethods.signInWithEmailAndPassword(
  //         emailController.text, passwordController.text).then((value){
  //        if(value !=null){
  //          HelperFunction.saveUserLoggedInSharedPreference(true);
  //          Navigator.push(context, MaterialPageRoute(builder: (context)=> MyDrawer()));
  //        }
  //     });
  //
  //   }
  // }

  userlogin() async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(email: emailController.text, password: passwordController.text);
      User? user = result.user;
      if (user!.emailVerified) {
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> MyDrawer()));
      }
      else{
        Navigator.of(context).pop();
       Fluttertoast.showToast(msg: "Please Verify Your account by clicking on link");
      }
      //
      // Navigator.pushReplacement(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => Waiting(),
      //   ),
      // );
    // ignore: nullable_type_in_catch_clause
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
       Fluttertoast.showToast(msg: "No User Found for that email");
      } else if (e.code == 'wrong-password') {
       Fluttertoast.showToast(msg: "Incorrect Password");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("loginscreen".tr, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),))
      ),
      body: Container(
        alignment: Alignment.bottomCenter,
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 35),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: emailController,
                        validator: (val){
                          return regExp.hasMatch(val!) ? null : "Please Provide Valid Email";
                        },
                        decoration: textFieldInputDecoration("enteryouremail".tr, "email".tr),
                      ),
                      TextFormField(
                        controller: passwordController,
                        obscureText: true,
                        validator: (val) {
                          return val!.isEmpty || val.length < 6
                              ? 'Minimum 6 characters required'
                              : null;
                        },
                        decoration: textFieldInputDecoration("enteryourpassword".tr, "password".tr),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 8.0),
                GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> ForgetPasswordPage()));
                  },
                  child: Container(
                    alignment: Alignment.centerRight,
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      child: Text(
                        "forgotpassword".tr,
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, decoration: TextDecoration.underline),),
                    ),
                  ),
                ),
                SizedBox(height: 8.0),
                GestureDetector(
                  onTap: (){
                    userlogin();
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(vertical: 15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      gradient: LinearGradient(
                        colors: [
                          Colors.teal,
                          Color(0xff5f9ea0),
                        ]
                      )
                    ),
                    child: Text(
                        "signin".tr,
                      style: TextStyle(fontSize: 17, color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("donthaveaccount".tr),
                    SizedBox(width: 3.5),
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => PSignUp()));
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                            "signup".tr,
                          style: TextStyle(
                            color: Colors.teal,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 80,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
