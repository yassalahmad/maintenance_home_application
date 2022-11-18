import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maintenance_home_application/screens/ServiceProvider/signin.dart';
import 'package:maintenance_home_application/welcome_screen.dart';

import '../Helper/helperfunction.dart';
import '../Widgets/widget.dart';

class DeleteAccount extends StatefulWidget {
  @override
  _DeleteAccountState createState() => _DeleteAccountState();
}

class _DeleteAccountState extends State<DeleteAccount> {
  /// Variables
  final GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  TextEditingController userEmailController = new TextEditingController();
  TextEditingController userPasswordController = new TextEditingController();
  FirebaseFirestore _user = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Map<String, dynamic>? userAccountMap;
  bool _isObscure = true;

  /// Conform Choice
  conformDelete(String email, String pwd) async {
    formKey.currentState!.validate()
        ? await _user
        .collection("Service Providers")
        .where("Email", isEqualTo: userEmailController.text)
        .get()
        .then((result) async {
      setState(() => userAccountMap = result.docs[0].data());
      print(userAccountMap);

      /// Create a credential
      AuthCredential credential =
      EmailAuthProvider.credential(email: email, password: pwd);

      /// Re Authenticate
      await _auth.currentUser
          ?.reauthenticateWithCredential(credential)
          .then((value) => value.user?.delete())
          .catchError((onError) => showToaster("Credentials Error"));

      /// Delete user account details
      HelperFunction.saveUserLoggedInSharedPreference(false);
      DocumentReference userAccount =
      _user.collection('Service Providers').doc(email);
      userAccount.delete();

      ///
      showToaster("Account deleted successfully");
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => WelcomeScreen()));
    })
        : showToaster("Enter correct credentials");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(10.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              /// Warning tile
              ListTile(
                tileColor: Colors.teal,
                shape: StadiumBorder(),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Warning...!!", style: TextStyle(
                        fontSize: 16.0, color: Colors.white, fontWeight: FontWeight.w600)),
                    Icon(Icons.warning, color: Colors.yellow)
                  ],
                ),
              ),

              /// Text
              Padding(
                padding: EdgeInsets.only(
                    left: 30.0, right: 30.0, top: 50.0, bottom: 20.0),
                child: Text(
                  "Are you sure you want to delete your account permanently ?"
                      "\n\nIf you delete your account. "
                      "All of your credentials will be lost "
                      "and can't be recovered again...!!",
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                      fontSize: 16.0, color: Colors.black, fontWeight: FontWeight.w600),
                ),
              ),

              /// Form
              Padding(
                padding: EdgeInsets.only(left: 20.0, right: 20.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      // email
                      TextFormField(
                          controller: userEmailController,
                          validator: (val) {
                            return RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                            ).hasMatch(val!)
                                ? null
                                : "Valid email required";
                          },
                        style: TextStyle(
                            fontSize: 16.0, color: Colors.black),
                        decoration: InputDecoration(
                          focusedBorder:
                          UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                          enabledBorder:
                          UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                          prefixIcon: Icon(Icons.email, color: Colors.black,),
                          labelText: "Email",
                          labelStyle: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ),
                      SizedBox(height: 10.0),
                      // password
                      TextFormField(
                        style: TextStyle(
                          fontSize: 15.0, color: Colors.black),
                        obscureText: _isObscure,
                        decoration: passwordViewInputDecoration(
                          'PASSWORD',
                          Icon(Icons.vpn_key, color: Colors.black),
                          GestureDetector(
                            onTap: () =>
                                setState(() => _isObscure = !_isObscure),
                            child: Icon(
                              _isObscure
                                  ? Icons.visibility
                                  : Icons.visibility_off_outlined,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        controller: userPasswordController,
                        validator: (val) {
                          return val!.isEmpty || val.length < 6
                              ? 'Minimum 6 characters required'
                              : null;
                        },
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 50.0),

              /// Conform and Cancel Button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  /// Cancel
                  // ignore: deprecated_member_use
                  FlatButton.icon(
                    onPressed: () => Navigator.of(context).pop(),
                    shape: StadiumBorder(),
                    label: Text("Return to page",
                        style: TextStyle(color: Colors.white)),
                    icon: Icon(Icons.cancel_outlined, color: Colors.white),
                    color: Colors.teal[600],
                  ),

                  /// Conform
                  // ignore: deprecated_member_use
                  FlatButton.icon(
                    onPressed: () => conformDelete(
                        userEmailController.text, userPasswordController.text),
                    shape: StadiumBorder(),
                    label: Text("Conform Delete",
                        style: TextStyle(color: Colors.white)),
                    icon: Icon(Icons.done_outline, color: Colors.white),
                    color: Colors.red[700],
                  ),
                ],
              ),
              SizedBox(height: 112.0),
              /// App Name
              Center(
                child: Text(
                  'Home Maintenance App',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87, fontSize: 25, shadows: [
                    Shadow(color: Colors.teal, offset: Offset(0, 2), blurRadius: 20)
                  ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
