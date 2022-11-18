import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:maintenance_home_application/screens/modal/user.dart';
import 'package:flutter/material.dart';

class MyAuthMethods{
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Usser? _usserFromFirebaseUser(User user){
    return user != null ? Usser(userId: user.uid) : null;
  }

 // Sign In Method
 Future signInWithEmailAndPassword(String email, String password) async{
  try{
    UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email, password: password
    );
    User? user = userCredential.user;
    if(user!.emailVerified) {
      return _usserFromFirebaseUser(user);
    } else {
      Fluttertoast.showToast(msg: "Verify Your Email by clicking the link");
      return null;
    }
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
    Fluttertoast.showToast(msg: 'No User Found for that Email');
    } else if (e.code == 'wrong-password') {
     Fluttertoast.showToast(msg: "Wrong Password Provided by User");
    }

  }
}

 // Sign UP Method
 Future signUpWithEmailAndPassword(String email, String password) async{
    try{
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password
      );
      User? user = userCredential.user;
      return _usserFromFirebaseUser(user!);
    }catch(e){
      print(e.toString());
    }
 }

 // Reset Password Method
 Future resetPasswordWithEmail(String email) async{
    try{
       return await _auth.sendPasswordResetEmail(email: email);
    }catch(e){
      print(e.toString());
    }
 }


  // Sign Out Method
 Future signOut() async{
    try{
      return await _auth.signOut();
    }catch(e){
      print(e.toString());
    }
 }

  /// TODO update current password
  Future<void> updatePassword(String newPwd) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;
    user?.updatePassword(newPwd);
  }

  /// Get user record using Password
  getUserByUserPassword(String currentPassword) {
    try {
      return FirebaseFirestore.instance.collection("Service Providers")
          .where('Password', isEqualTo: currentPassword)
          .get();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  /// Upload user reset password
  uploadUserResetPassword(userMap) async {
    await FirebaseFirestore.instance.collection("Service Providers")
        .doc(_auth.currentUser!.email)
        .update(userMap)
        .catchError((e) => print(e.toString()));
  }

}

