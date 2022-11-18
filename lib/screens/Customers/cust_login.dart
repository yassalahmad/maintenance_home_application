// import 'dart:ui';
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:get/get.dart';
//
// import '../Helper/helperfunction.dart';
// import '../Services/auth.dart';
// import '../Services/database.dart';
// import 'background.dart';
// import 'cust_drawer.dart';
// import 'cust_forgot_password.dart';
// import 'cust_register.dart';
//
// class CustLoginScreen extends StatefulWidget {
//   @override
//   State<CustLoginScreen> createState() => _CustLoginScreenState();
// }
//
// class _CustLoginScreenState extends State<CustLoginScreen> {
//
//   TextEditingController phoneController = TextEditingController();
//   TextEditingController otpController = TextEditingController();
//
//   FirebaseAuth auth = FirebaseAuth.instance;
//   bool otpVisibility = false;
//   String verificationID = "";
//
//   bool isLoading = false;
//
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//
//     return Scaffold(
//       body: Background(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Container(
//               alignment: Alignment.centerLeft,
//               padding: EdgeInsets.symmetric(horizontal: 40),
//               child: Text(
//                 "custlogin".tr,
//                 style: TextStyle(
//                     fontWeight: FontWeight.bold,
//                     color: Color(0xFF2661FA),
//                     fontSize: 36
//                 ),
//                 textAlign: TextAlign.left,
//               ),
//             ),
//             SizedBox(height: size.height * 0.03),
//             Container(
//               margin: EdgeInsets.all(10),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                     child: TextField(
//                       controller: phoneController,
//                       decoration: InputDecoration(
//                         hintText: 'Phone Number',
//                         prefixIcon: Icon(Icons.phone),
//                         enabledBorder: UnderlineInputBorder(
//                           borderSide: BorderSide(color: Colors.teal),
//                         ),
//                         focusedBorder: UnderlineInputBorder(
//                           borderSide: BorderSide(color: Colors.black),
//                         ),
//                         prefix: Padding(
//                           padding: EdgeInsets.all(4),
//                           child: Text('+92'),
//                         ),
//                       ),
//                       maxLength: 10,
//                       keyboardType: TextInputType.phone,
//                     ),
//                   ),
//                   Visibility(
//                     child: Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                       child: TextField(
//                         controller: otpController,
//                         decoration: InputDecoration(
//                           hintText: 'OTP',
//                           prefixIcon: Icon(Icons.confirmation_num_outlined),
//                           enabledBorder: UnderlineInputBorder(
//                             borderSide: BorderSide(color: Colors.teal),
//                           ),
//                           focusedBorder: UnderlineInputBorder(
//                             borderSide: BorderSide(color: Colors.black),
//                           ),
//                           prefix: Padding(
//                             padding: EdgeInsets.all(4),
//                             child: Text(''),
//                           ),
//                         ),
//                         maxLength: 6,
//                         keyboardType: TextInputType.number,
//                       ),
//                     ),
//                     visible: otpVisibility,
//                   ),
//                   SizedBox(
//                     height: 10,
//                   ),
//                   MaterialButton(
//                     color: Colors.indigo,
//                     shape: StadiumBorder(),
//                     onPressed: () {
//                       if (otpVisibility) {
//                         verifyOTP();
//                       } else {
//                         loginWithPhone();
//                       }
//                     },
//                     child: Text(
//                       otpVisibility ? "Verify" : "Login",
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 20,
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 20,),
//                   Row(
//                     children: [
//                       SizedBox(width: 15,),
//                       Text("If you don't have account?"),
//                       SizedBox(width: 8.0),
//                       GestureDetector(
//                         onTap: (){
//                           Navigator.push(context, MaterialPageRoute(builder: (context) => CustRegisterScreen()));
//                         },
//                         child: Text(
//                           "REGISTER YOURSELF",
//                           style: TextStyle(
//                               color: Colors.indigo,
//                               fontWeight: FontWeight.bold,
//                             decoration: TextDecoration.underline,
//                           ),
//                         ),
//                       ),
//                     ],
//                   )
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   void loginWithPhone() async {
//     auth.verifyPhoneNumber(
//       phoneNumber: "+92" + phoneController.text,
//       verificationCompleted: (PhoneAuthCredential credential) async {
//         await auth.signInWithCredential(credential).then((value) {
//           print("You are logged in successfully");
//         });
//       },
//       verificationFailed: (FirebaseAuthException e) {
//         print(e.message);
//       },
//       codeSent: (String verificationId, int? resendToken) {
//         otpVisibility = true;
//         verificationID = verificationId;
//         setState(() {});
//       },
//       codeAutoRetrievalTimeout: (String verificationId) {},
//     );
//   }
//
//   void verifyOTP() async {
//     PhoneAuthCredential credential = PhoneAuthProvider.credential(
//         verificationId: verificationID, smsCode: otpController.text);
//
//     await auth.signInWithCredential(credential).then(
//           (value) {
//         print("You are logged in successfully");
//         Fluttertoast.showToast(
//           msg: "You are logged in successfully",
//           toastLength: Toast.LENGTH_SHORT,
//           gravity: ToastGravity.CENTER,
//           timeInSecForIosWeb: 1,
//           backgroundColor: Colors.red,
//           textColor: Colors.white,
//           fontSize: 16.0,
//         );
//       },
//     ).whenComplete(
//           () {
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(
//             builder: (context) => CustMyDrawer(),
//           ),
//         );
//       },
//     );
//   }
//
// }

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:maintenance_home_application/screens/Customers/cust_drawer.dart';
import 'package:maintenance_home_application/screens/Customers/cust_register.dart';
import '../Helper/helperfunction.dart';
import '../Services/auth.dart';
import '../Services/database.dart';
import 'background.dart';
import 'cust_forgot_password.dart';
import 'cust_login.dart';


class CustLoginScreen extends StatefulWidget {
  @override
  State<CustLoginScreen> createState() => _CustLoginScreenState();
}

String p = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
RegExp regExp = new RegExp(p);
String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
RegExp _regExp = RegExp(pattern);


class _CustLoginScreenState extends State<CustLoginScreen> {



  bool isLoading = false;
  final formKey = GlobalKey<FormState>();
  MyAuthMethods myAuthMethods = MyAuthMethods();
  HelperFunction helperFunction = HelperFunction();
  DatabaseMethods databaseMethods = DatabaseMethods();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  QuerySnapshot<Map<String, dynamic>>? snapshotUserInfo;

  // Sign In Function
  signIn(){
    if(formKey.currentState!.validate()){
      HelperFunction.saveUserEmailLoggedInSharedPreference(emailController.text);
      setState(() {
        isLoading = true;
      });

      databaseMethods.getUserByUserEmail(emailController.text).then((val){
        snapshotUserInfo = val;
        HelperFunction.saveUserNameLoggedInSharedPreference(snapshotUserInfo?.docs[0].data()["Username"]);
      });

      myAuthMethods.signInWithEmailAndPassword(
          emailController.text, passwordController.text).then((value){
        if(value !=null){
          HelperFunction.saveUserLoggedInSharedPreference(true);
          Navigator.push(context, MaterialPageRoute(builder: (context)=> CustMyDrawer()));
        }
      });

    }
  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Background(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: Text(
                  "custlogin".tr,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2661FA),
                      fontSize: 36
                  ),
                  textAlign: TextAlign.left,
                ),
              ),

              SizedBox(height: size.height * 0.03),
              Form(
                key: formKey,
                child: Column(
                  children: [
                    SizedBox(height: size.height * 0.03),
                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.symmetric(horizontal: 50),
                      child: TextFormField(
                        controller: emailController,
                        validator: (val){
                          return regExp.hasMatch(val!) ? null : "Please Provide Valid Email";
                        },
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.email),
                            labelText: "email".tr
                        ),
                      ),
                    ),
                    SizedBox(height: size.height * 0.03),
                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.symmetric(horizontal: 50),
                      child: TextFormField(
                        controller: passwordController,
                        validator: (val){
                          return val!.isEmpty || val.length < 6 ? "Please Provide Greater Than 6" : null;
                        },
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.lock_sharp),
                            labelText: "password".tr
                        ),
                        obscureText: true,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: size.height * 0.02),
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> CustForgetPasswordPage()));
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
              Container(
                alignment: Alignment.centerRight,
                margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                child: MaterialButton(
                  onPressed: () {
                    signIn();
                  },
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
                  textColor: Colors.white,
                  padding: const EdgeInsets.all(0),
                  child: Container(
                    alignment: Alignment.center,
                    height: 50.0,
                    width: size.width * 0.5,
                    decoration: new BoxDecoration(
                        borderRadius: BorderRadius.circular(80.0),
                        gradient: new LinearGradient(
                            colors: [
                              Color.fromARGB(255, 255, 136, 34),
                              Color.fromARGB(255, 255, 177, 41)
                            ]
                        )
                    ),
                    padding: const EdgeInsets.all(0),
                    child: Text(
                      "custlogin".tr,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ),
              ),

              Container(
                alignment: Alignment.centerRight,
                margin: EdgeInsets.symmetric(horizontal: 40, vertical: 5),
                child: GestureDetector(
                  onTap: () => {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => CustRegisterScreen()))
                  },
                  child: Text(
                    "donthaveaccount".tr,
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2661FA)
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}