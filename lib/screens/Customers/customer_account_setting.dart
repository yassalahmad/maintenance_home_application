import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maintenance_home_application/screens/Customers/cust_login.dart';
import 'package:maintenance_home_application/screens/ServiceProvider/deleteAccount.dart';
import 'package:maintenance_home_application/screens/ServiceProvider/resetPassword.dart';
import 'package:maintenance_home_application/screens/ServiceProvider/signin.dart';
import 'package:maintenance_home_application/screens/Services/auth.dart';
import 'package:maintenance_home_application/welcome_screen.dart';

import '../Customers/customer_password_reset.dart';

class CustAccountSetting extends StatefulWidget {

  @override
  _CustAccountSettingState createState() => _CustAccountSettingState();
}

class _CustAccountSettingState extends State<CustAccountSetting> {

  MyAuthMethods myAuthMethods = MyAuthMethods();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white12,
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    width: 90,
                    height: 120,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [
                            Colors.red,
                            Colors.teal,
                          ]
                      ),
                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 100,),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "account".tr,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      letterSpacing: 1.5,
                    ),

                  ),
                ),
              ),
              SizedBox(height: 60),
              Align(
                alignment: Alignment.center,
                child: GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> DeleteAccount()));
                  },
                  child: Container(
                    width: 280, height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      gradient: LinearGradient(
                          colors: [
                            Colors.redAccent, Colors.black87,
                          ]
                      ),
                    ),
                    child:Row(
                      children: [
                        SizedBox(width: 50,),
                        Text("deleteaccount".tr, style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold),),
                        SizedBox(width: 60,),
                        Icon(Icons.arrow_forward, color: Colors.white,)
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30,),
              Align(
                alignment: Alignment.center,
                child: GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> CustPasswordReset()));
                  },
                  child: Container(
                    width: 290, height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      gradient: LinearGradient(
                          colors: [
                            Colors.teal, Colors.black87,
                          ]
                      ),
                    ),
                    child: Row(
                      children: [
                        SizedBox(width: 30,),
                        Text("passwordreset".tr, style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold),),
                        SizedBox(width: 60,),
                        Icon(Icons.arrow_forward, color: Colors.white,)
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30,),
              Align(
                alignment: Alignment.center,
                child: GestureDetector(
                  onTap: (){
                    myAuthMethods.signOut();
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> CustLoginScreen()));
                  },
                  child: Container(
                    width: 290, height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      gradient: LinearGradient(
                          colors: [
                            Colors.black, Colors.amber,
                          ]
                      ),
                    ),
                    child: Row(
                      children: [
                        SizedBox(width: 50,),
                        Text("logout".tr, style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold),),
                        SizedBox(width: 120,),
                        Icon(Icons.arrow_forward, color: Colors.white,)
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 70),
              Text(
                "homemaintenanceapp".tr,
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87, fontSize: 25, shadows: [
                  Shadow(color: Colors.teal, offset: Offset(0, 5), blurRadius: 20)
                ]),)
            ],
          ),
        ),
      ),
    );
  }
}
