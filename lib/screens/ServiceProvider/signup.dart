import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:maintenance_home_application/screens/Providers/UserAuthentication_Provider.dart';
import 'package:maintenance_home_application/screens/Providers/checkout_provider.dart';
import 'package:maintenance_home_application/screens/ServiceProvider/signin.dart';
import 'package:maintenance_home_application/screens/Widgets/widget.dart';

import 'package:provider/provider.dart';

import 'googleMap.dart';


class PSignUp extends StatefulWidget {
  final Function? toggle;
  PSignUp({this.toggle});

  @override
  _PSignUpState createState() => _PSignUpState();
}

String p = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
RegExp regExp = new RegExp(p);


class _PSignUpState extends State<PSignUp> {

  bool isLoading = false;

  // bool isLoading = false;
  // MyAuthMethods myAuthMethods = MyAuthMethods();
  // DatabaseMethods databaseMethods = DatabaseMethods();
  // final formKey = GlobalKey<FormState>();
  // TextEditingController nameController = TextEditingController();
  // TextEditingController emailController = TextEditingController();
  // TextEditingController passwordController = TextEditingController();
  //
  //
  // final professionList =
  // ["Electrician", "Plumber", "Freezer Mechanic", "Tv Mechanic", "Car Mechanic", "Barber"];
  //
  // /// Active image file
  // File? _imageFile;
  // String? imageSnap;
  //
  // /// Select an image via gallery
  // Future _pickImage(ImageSource source) async {
  //   XFile? selected = (await ImagePicker().pickImage(source: source)) as XFile;
  //   // setState(() {
  //   //   _imageFile = selected;
  //   // });
  //   /// Upload Image to Firebase
  //   final file = File(selected.path);
  //   final destination = "${emailController.text}/${DateTime.now()}.png";
  //   Reference reference =
  //   FirebaseStorage.instance.ref("Profile_Images").child(destination);
  //   UploadTask _uploadTask = reference.putFile(file);
  //   _uploadTask.whenComplete(() async {
  //     try {
  //       String uploadedImageUrl = await reference.getDownloadURL();
  //       imageSnap = uploadedImageUrl;
  //       // showToaster("Image uploaded successfully");
  //       print("This is URL: $imageSnap");
  //     } catch (e) {
  //       print(e.toString());
  //     }
  //   });
  // }

  // Register User
  // Future register() async {
  //   if (formKey.currentState!.validate()) {
  //     FirebaseAuth auth = FirebaseAuth.instance;
  //     User? user = await FirebaseAuth.instance.currentUser;
  //     try {
  //       if (user!= null && !user.emailVerified) {
  //         await user.sendEmailVerification();
  //       }
  //       auth.createUserWithEmailAndPassword(
  //           email: emailController.text, password: passwordController.text)
  //           .then((SignedInUser) {
  //         FirebaseFirestore.instance.collection("Service Providers").doc(
  //             SignedInUser.user?.uid).set({
  //           "Username": nameController.text,
  //           "Email": emailController.text,
  //           "Password": passwordController.text,
  //           "Profession": value,
  //           "ProfileImage": imageSnap,
  //         }).then((SignedInUser) =>
  //         {
  //           print("Success"),
  //           Fluttertoast.showToast(msg: "Success"),
  //           Navigator.push(context,
  //               MaterialPageRoute(builder: (context) => PSignIn())),
  //         });
  //       });
  //     } catch (e) {
  //       print(e.toString());
  //     }
  //   }
  // }


  @override
  Widget build(BuildContext context) {
    UserAuthenticationProvider userAuthenticationProvider = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
          title: Center(child: Text("registerscreen".tr, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),))
      ),
      body: Container(
        alignment: Alignment.bottomCenter,
        child: isLoading ? Container(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ) : SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 35),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Column(
                  children: [
                    TextFormField(
                      keyboardType: TextInputType.text,
                      // validator: (val){
                      //   return val!.isEmpty || val.length <3 ? "Please Provide Your Valid Name" : null;
                      // },
                      controller: userAuthenticationProvider.nameController,
                      decoration: textFieldInputDecoration("enterusername".tr, "username".tr),
                    ),
                    SizedBox(height: 5.0),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      // validator: (val){
                      //   return regExp.hasMatch(val!) ? null : "Please Provide Valid Email";
                      // },
                      controller: userAuthenticationProvider.emailController,
                      decoration: textFieldInputDecoration("enteryouremail".tr, "email".tr),
                    ),
                    SizedBox(height: 5.0),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      controller: userAuthenticationProvider.mobileController,
                      decoration: textFieldInputDecoration("enteryourmobileno".tr, "mobileno".tr),
                    ),
                    SizedBox(height: 5.0),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      // validator: (val){
                      //   return regExp.hasMatch(val!) ? null : "Please Provide Valid Email";
                      // },
                      controller: userAuthenticationProvider.areaController,
                      decoration: textFieldInputDecoration("enteryourareaname".tr, "areaname".tr),
                    ),
                    SizedBox(height: 5.0),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      // validator: (val){
                      //   return regExp.hasMatch(val!) ? null : "Please Provide Valid Email";
                      // },
                      controller: userAuthenticationProvider.cityController,
                      decoration: textFieldInputDecoration("enteryourcity".tr, "city".tr),
                    ),
                    SizedBox(height: 30.0),
                    Container(
                        alignment: Alignment.topLeft,
                        child: Text("selectprofession".tr, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.teal),)),
                    SizedBox(height: 15.0),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: DropdownButton<String>(
                        value: userAuthenticationProvider.value,
                        isExpanded: true,
                        icon: Icon(Icons.arrow_drop_down, color: Colors.teal, size: 36,),
                        items: userAuthenticationProvider.professionList.map(buildMenuProfesionList).toList(),
                        onChanged: (value) => setState(() => userAuthenticationProvider.value= value,
                        ),
                      ),
                    ),
                    SizedBox(height: 10.0),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      obscureText: true,
                      // validator: (val) {
                      //   return val!.isEmpty || val.length < 6
                      //       ? 'Minimum 6 characters required'
                      //       : null;
                      // },
                      controller: userAuthenticationProvider.passwordController,
                      decoration: textFieldInputDecoration("enteryourpassword".tr, "password".tr),
                    ),
                    SizedBox(height: 20.0),
                    InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> GoogleMapScreen()));
                      },
                      child: Container(
                        height: 47,
                        width: double.infinity,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            userAuthenticationProvider.setLocation == null ?
                            Text("setmylocation".tr,  style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 17
                            ),
                            ) : Text("Done!"),
                          ],
                        ),
                      ),
                    ),
                    Divider(color: Colors.black,),
                    SizedBox(height: 30,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          alignment: Alignment.topLeft,
                          child: Text("uploadimage".tr, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.teal),
                          ),
                        ),
                        GestureDetector(
                          onTap: (){
                            userAuthenticationProvider.pickImage(ImageSource.gallery);
                          },
                          child: CircleAvatar(
                              radius: 26,
                              backgroundColor: Colors.teal,
                              child: Icon(Icons.image_outlined, size: 30, color: Colors.white,)),
                        )
                      ],
                    )
                  ],
                ),
                SizedBox(height: 20.0),
                GestureDetector(
                  onTap: (){
                    userAuthenticationProvider.validator(context);
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
                      "signup".tr,
                      style: TextStyle(fontSize: 17, color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                // Container(
                //   alignment: Alignment.center,
                //   width: MediaQuery.of(context).size.width,
                //   padding: EdgeInsets.symmetric(vertical: 15),
                //   decoration: BoxDecoration(
                //       borderRadius: BorderRadius.circular(14),
                //       gradient: LinearGradient(
                //           colors: [
                //             Color(0xff002424),
                //             Colors.black
                //           ]
                //       )
                //   ),
                //   child: Text(
                //     "signupwithgoogle".tr,
                //     style: TextStyle(fontSize: 17, color: Colors.white, fontWeight: FontWeight.bold),
                //   ),
                // ),
                SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("alreadhaveaccount".tr),
                    SizedBox(width: 3.5),
                    GestureDetector(
                      onTap: (){
                        // widget.toggle();
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> PSignIn()));
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          "signin".tr,
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

DropdownMenuItem<String> buildMenuProfesionList(String item) => DropdownMenuItem(
  value: item,
  child: Text(
    item,
    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
  ),
);