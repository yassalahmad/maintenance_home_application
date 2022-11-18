import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maintenance_home_application/screens/ChatRooms/chat_room.dart';
import 'package:maintenance_home_application/screens/Customers/cust_profile.dart';
import 'package:maintenance_home_application/screens/Customers/service_providers.dart';
import 'package:maintenance_home_application/screens/ServiceProvider/myprofile.dart';

import '../ServiceProvider/accountSetting.dart';
import 'customer_account_setting.dart';

class CustMyDrawer extends StatefulWidget {
  @override
  _CustMyDrawerState createState() => _CustMyDrawerState();
}

class _CustMyDrawerState extends State<CustMyDrawer> {
  var currentPage = DrawerSections.myProfile;


  String name = "Loading.....";
  String email = "Loading....";

  Future getData() async{
    User? user = await FirebaseAuth.instance.currentUser;
    var variable = await FirebaseFirestore.instance.collection("Customers").doc(user?.uid).get();

    setState(() {
      name = variable.data()!['username'];
      email = variable.data()!['email'];
    });
  }


  @override
  void initState() {
    getData();
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    var container;
    if (currentPage == DrawerSections.myProfile) {
      container = CustProfileScreen();
    } else if (currentPage == DrawerSections.accountSetting) {
      container = CustAccountSetting();
    } else if(currentPage == DrawerSections.ServiceProviders){
      container = ServicesProviders();
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text(
          "My Dashboard",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
      body: container,
      drawer: Drawer(
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
              Colors.teal,
              Color(0xff5f9ea0),
            ])),
            child: Column(
              children: [
                UserAccountsDrawerHeader(
                  accountName: Text(
                    name,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w800),
                  ),
                  accountEmail: Text(
                    email,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
                MyDrawerList(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget MyDrawerList() {
    return Container(
      padding: EdgeInsets.only(top: 40),
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          Colors.teal,
          Color(0xff5f9ea0),
        ])),
        child: Column(
          // shows the list of menu drawer
          children: [
            menuItem(1, "My Profile", Icons.person,
                currentPage == DrawerSections.myProfile ? true : false),
            Divider(thickness: 2),
            menuItem(2, "Account Setting", Icons.settings,
                currentPage == DrawerSections.accountSetting ? true : false),
            Divider(thickness: 2),
            menuItem(3, "Service Providers", Icons.home_repair_service_sharp,
              currentPage == DrawerSections.ServiceProviders ? true : false
            ),
            Divider(thickness: 2),
          ],
        ),
      ),
    );
  }

  Widget menuItem(int id, String title, IconData icon, bool selected) {
    return Material(
      color: selected ? Colors.black : Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
          setState(() {
            if (id == 1) {
              currentPage = DrawerSections.myProfile;
            } else if (id == 2) {
              currentPage = DrawerSections.accountSetting;
            } else if(id == 3){
              currentPage = DrawerSections.ServiceProviders;
            }
            else {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text("Wrong Choice")));
            }
          });
        },
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Row(
            children: [
              Expanded(
                child: Icon(
                  icon,
                  size: 20,
                  color: Colors.white,
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  title,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w700),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

enum DrawerSections {
  myProfile,
  accountSetting,
  ServiceProviders,
}
