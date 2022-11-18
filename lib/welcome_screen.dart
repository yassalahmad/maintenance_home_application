import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maintenance_home_application/screens/Customers/cust_login.dart';
import 'package:maintenance_home_application/screens/Language/lanugage_Screen.dargt.dart';
import 'package:maintenance_home_application/screens/Language/welcome_change_screen.dart';
import 'package:maintenance_home_application/screens/ServiceProvider/signin.dart';


class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
          child: ListView(
            children: [
              SizedBox(height: 10),
              Center(
                child: Text(
                  "homemaintenanceapp".tr,
                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
                  textScaleFactor: 1.5,
                ),
              ),
              SizedBox(height: 10),
              Center(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  height: 350,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/electrician.png"),
                      ),
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(500), bottomRight: Radius.circular(700))
                  ),
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: Text(
                  "selectusertype".tr,
                  style:  TextStyle(color: Colors.black87),
                  textScaleFactor: 1.3,
                ),
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> CustLoginScreen()));
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 65),
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.black87
                  ),
                  child: ListTile(
                    title: Text(
                      "customer".tr,
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
                      textScaleFactor: 1.0,
                    ),
                    leading: Icon(Icons.person,color: Colors.white,),
                  ),
                ),
              ),
              SizedBox(height: 10),
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> PSignIn()));
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 65),
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.black87
                  ),
                  child: ListTile(
                    title: Text(
                      "serviceprovider".tr,
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
                      textScaleFactor: 1.0,
                    ),
                    leading: Icon(Icons.person ,color: Colors.white,),
                  ),
                ),
              ),
              SizedBox(height: 10),
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> WelLanguageScreen()));
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 65),
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.black87
                  ),
                  child: ListTile(
                    title: Text(
                      "chooselanguage".tr,
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
                      textScaleFactor: 1.0,
                    ),
                    leading: Icon(Icons.language ,color: Colors.white,),
                  ),
                ),
              ),
            ],
          )
      ),
    );
  }
}