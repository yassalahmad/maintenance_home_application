import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import 'dart:io';

import '../ServiceProvider/signin.dart';



String p = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
RegExp regExp = new RegExp(p);

class UserAuthenticationProvider with ChangeNotifier {

  FirebaseAuth auth = FirebaseAuth.instance;
  User? user = FirebaseAuth.instance.currentUser;



  bool isLoad = false;

  // Service Providers List
  final professionList =
  ["electrician".tr, "plumber".tr, "freezermechanic".tr, "tvmechanic".tr, "carmechanic".tr, "carpenter".tr, "masonry".tr, "painter".tr, "ceiling".tr];
  var value;



  /// Active image file
  File? _imageFile;
  String? imageSnap;

  /// Select an image via gallery
  Future pickImage(ImageSource source) async {
    XFile? selected = (await ImagePicker().pickImage(source: source)) as XFile;
    // setState(() {
    //   _imageFile = selected;
    // });
    /// Upload Image to Firebase
    final file = File(selected.path);
    final destination = "${emailController.text}/${DateTime.now()}.png";
    Reference reference =
    FirebaseStorage.instance.ref("Profile_Images").child(destination);
    UploadTask _uploadTask = reference.putFile(file);
    _uploadTask.whenComplete(() async {
      try {
        String uploadedImageUrl = await reference.getDownloadURL();
        imageSnap = uploadedImageUrl;
        // showToaster("Image uploaded successfully");
        print("This is URL: $imageSnap");
      } catch (e) {
        print(e.toString());
      }
    });
  }


  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController areaController = TextEditingController();

  var setLocation;

  void validator(context) async{
    if(nameController.text.isEmpty || nameController.text.length <= 3){
      Fluttertoast.showToast(msg: "Please Enter Username greater than 3");
    }else if(emailController.text.isEmpty){
      Fluttertoast.showToast(msg: "Please Provide Your Email");
    }else if(!emailController.text.contains(regExp)){
      Fluttertoast.showToast(msg: "Please Provide Valid Email");
    }else if(passwordController.text.isEmpty){
      Fluttertoast.showToast(msg: "Please Provider Your Password");
    }else if(mobileController.text.isEmpty || mobileController.text.length < 6){
      Fluttertoast.showToast(msg: "Please Provider Your Mobile Number Greater Than 6");
    }else if(areaController.text.isEmpty){
      Fluttertoast.showToast(msg: "Please Enter Your Area Name");
    }else if(cityController.text.isEmpty){
      Fluttertoast.showToast(msg: "Please Enter Your City Name");
    } else if(setLocation?.longitude == null){
      Fluttertoast.showToast(msg: "SetLocation is Empty");
    } else {
      isLoad = true;
      notifyListeners();
      try{
        if (user!= null && user!.emailVerified) {
          await user!.sendEmailVerification();
        }
        auth.createUserWithEmailAndPassword(
            email: emailController.text,
            password: passwordController.text,
        ).then((signedInUser) {
          user!.sendEmailVerification();
          FirebaseFirestore.instance.collection('Service Provider')
              .doc(signedInUser.user!.uid)
              .set({
            "username": nameController.text,
            "email": emailController.text,
            "password": passwordController.text,
            "mobileNo": mobileController.text,
            "area": areaController.text,
            "city": cityController.text,
            "profession": value,
            'profileImage': imageSnap,
            'latitude': setLocation.latitude,
            'longitude': setLocation.longitude,
            'rating': 0.0,
            
          }).then((signedInUser) {
            print("Success");
            Fluttertoast.showToast(msg: "Success");
            Fluttertoast.showToast(msg: "Verification Link Sent To Your Email");
          });
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => PSignIn()));
        });
      }catch(e){
        print(e.toString());
      }
    }
  }
  }