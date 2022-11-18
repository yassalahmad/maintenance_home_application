import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'background.dart';
import 'cust_login.dart';


class CustRegisterScreen extends StatefulWidget {
  @override
  State<CustRegisterScreen> createState() => _CustRegisterScreenState();
}

String p = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
RegExp regExp = new RegExp(p);
String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
RegExp _regExp = RegExp(pattern);


class _CustRegisterScreenState extends State<CustRegisterScreen> {



  bool isLoading = false;
  final formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileNoController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

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

  // Register User
  Future register() async {
    if (formKey.currentState!.validate()) {
      FirebaseAuth auth = FirebaseAuth.instance;
      User? user = await FirebaseAuth.instance.currentUser;
      try {
        auth.createUserWithEmailAndPassword(
            email: emailController.text, password: passwordController.text)
            .then((signedInUser) {
          if (user!= null) {
            user.sendEmailVerification();
          } else if(imageSnap == null){
            Fluttertoast.showToast(msg: "Please Provider Your Image");
          }
          FirebaseFirestore.instance.collection("Customers").doc(
              signedInUser.user?.uid).set({
            "username": nameController.text,
            "email": emailController.text,
            "mobileNo": mobileNoController.text,
            "password": passwordController.text,
            "customerImage": imageSnap,
          }).then((signedInUser)
          {
            print("Success");
            Fluttertoast.showToast(msg: "Success");
            Fluttertoast.showToast(msg: "Verification Link Sent To Your Email");
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => CustLoginScreen()));
          });
        });
      } catch (e) {
        print(e.toString());
      }
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
                  "custregister".tr,
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
                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.symmetric(horizontal: 50),
                      child: TextFormField(
                        controller: nameController,
                          validator: (val){
                            return val!.isEmpty || val.length <3 ? "Please Provide Your Valid Name" : null;
                          },
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.person),
                            labelText: "username".tr
                        ),
                      ),
                    ),
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
                        controller: mobileNoController,
                        validator: (val){
                          if(mobileNoController.text.length > 11){
                            return "Please Enter the valid mobile number";
                          }
                        },
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.phone_enabled_rounded),
                            labelText: "mobileno".tr
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
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            alignment: Alignment.topLeft,
                            child: Text("uploadimage".tr, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.teal),
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              pickImage(ImageSource.gallery);
                            },
                            child: CircleAvatar(
                                radius: 26,
                                backgroundColor: Colors.teal,
                                child: Icon(Icons.image_outlined, size: 30, color: Colors.white,)),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: size.height * 0.02),

              Container(
                alignment: Alignment.centerRight,
                margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                child: MaterialButton(
                  onPressed: () {
                    register();
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
                      "custsignup".tr,
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
                    Navigator.push(context, MaterialPageRoute(builder: (context) => CustLoginScreen()))
                  },
                  child: Text(
                    "alreadhaveaccount".tr,
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