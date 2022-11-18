import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maintenance_home_application/screens/ServiceProvider/pdrawer.dart';
import 'package:maintenance_home_application/screens/Services/auth.dart';

import '../Widgets/widget.dart';

class PasswordReset extends StatefulWidget {
  @override
  _PasswordResetState createState() => _PasswordResetState();
}

class _PasswordResetState extends State<PasswordReset> {

  MyAuthMethods myAuthMethods = MyAuthMethods();

  final GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  TextEditingController userEmailController = new TextEditingController();
  TextEditingController currentPasswordController = new TextEditingController();
  TextEditingController newPasswordController = new TextEditingController();
  TextEditingController userConformPwdController = new TextEditingController();
  bool _isObscure = true;

  /// Search User Data from Firebase
  void resetPassword(String currentPassword, String newPassword) async {
    ///
    if (formKey.currentState!.validate()) {
      User? user = FirebaseAuth.instance.currentUser;
      final FirebaseAuth auth = FirebaseAuth.instance;
      AuthCredential credential = EmailAuthProvider.credential(
          email: userEmailController.text, password: currentPassword);
      await user?.reauthenticateWithCredential(credential).then((value) async {
        await myAuthMethods.updatePassword(newPassword).then((value) async {
          QuerySnapshot snapshot = await myAuthMethods
              .getUserByUserPassword(currentPasswordController.text);
          if (snapshot != null) {
            Map<String, dynamic> userPassword = ({
              "Password": newPassword,
            });
            await myAuthMethods.uploadUserResetPassword(userPassword);

            /// On Complete
            showToaster("Password reset successfully");
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => MyDrawer()));
          }
        });
      }).catchError((onError) => showToaster("Credentials Error"));
    } else {
      showToaster("Something went wrong!");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 20.0),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.10,
                  width: MediaQuery.of(context).size.width * 0.25,
                  decoration:  BoxDecoration(
                    gradient: LinearGradient(
                        colors: [
                          Colors.red,
                          Colors.teal,
                        ]
                    ),
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(30.0),
                      bottomLeft: Radius.circular(30.0),
                    ),
                  ),
                  child: Center(
                    child: Icon(Icons.password_outlined, size: 50.0, color: Colors.white,),
                  ),
                ),
              ),

              /// Text
              Padding(
                padding: EdgeInsets.only(top: 100.0, left: 30.0),
                child: Text(
                  "Hi !\nReset Your Password.",
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              /// View Password
              Padding(
                padding: EdgeInsets.only(top: 160.0, right: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // ignore: deprecated_member_use
                    IconButton(
                      onPressed: () => setState(() => _isObscure = !_isObscure),
                      color: Colors.teal,
                      iconSize: 30.0,
                      icon: Icon(
                        _isObscure
                            ? Icons.visibility
                            : Icons.visibility_off_outlined,
                      ),
                    ),
                  ],
                ),
              ),

              /// Forms
              Padding(
                padding: EdgeInsets.only(top: 200.0, left: 20.0, right: 20.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      /// Email
                      TextFormField(
                        controller: userEmailController,
                        validator: (val) {
                          return RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                          ).hasMatch(val!)
                              ? null
                              : "Valid email required";
                        },
                        style: TextStyle(color: Colors.black87, fontSize: 15, fontWeight: FontWeight.w400),
                        decoration: InputDecoration(
                          labelText: "email".tr,
                          labelStyle: TextStyle(color: Colors.black),
                          prefixIcon: Icon(Icons.email, color: Colors.black,)
                        )
                      ),
                      SizedBox(height: 20.0),

                      /// Current Password
                      TextFormField(
                        controller: currentPasswordController,
                        validator: (val) {
                          return val!.isEmpty || val.length < 6
                              ? 'Minimum 6 characters required'
                              : null;
                        },
                        style: TextStyle(color: Colors.black87, fontSize: 15, fontWeight: FontWeight.w400),
                        obscureText: _isObscure,
                        decoration: InputDecoration(
                          labelText: "currentpassword".tr,
                          labelStyle: TextStyle(color: Colors.black),
                          prefixIcon: Icon(Icons.vpn_key, color: Colors.black,),
                        )
                      ),
                      SizedBox(height: 20.0),

                      /// New Password
                      TextFormField(
                        controller: newPasswordController,
                        validator: (val) {
                          return val!.isEmpty || val.length < 6
                              ? 'Minimum 6 characters required'
                              : null;
                        },
                        style: TextStyle(color: Colors.black87, fontSize: 15, fontWeight: FontWeight.w400),
                        obscureText: _isObscure,
                        decoration: InputDecoration(
                          labelText: "newpassword".tr,
                          labelStyle: TextStyle(color: Colors.black),
                          prefixIcon: Icon(Icons.remove_red_eye, color: Colors.black,),
                        )
                      ),
                      SizedBox(height: 20.0),

                      /// Conform Password
                      TextFormField(
                        controller: userConformPwdController,
                        validator: (val) {
                          return val == newPasswordController.text
                              ? null
                              : 'Password did\'nt matched';
                        },
                        style: TextStyle(color: Colors.black87, fontSize: 15, fontWeight: FontWeight.w400),
                        obscureText: _isObscure,
                        decoration: InputDecoration(
                          labelText: "confirmpassword".tr,
                          labelStyle: TextStyle(color: Colors.black),
                          prefixIcon: Icon(Icons.lock, color: Colors.black,),
                        ),
                      ),
                      SizedBox(height: 30.0),

                      /// Button
                      Center(
                        // ignore: deprecated_member_use
                        child: FlatButton(
                          color: Colors.teal,
                          shape: StadiumBorder(),
                          onPressed: () => resetPassword(
                              currentPasswordController.text,
                              newPasswordController.text),
                          child: Text("resetpassword".tr,
                              style: TextStyle(fontSize: 16.0, color: Colors.white)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}