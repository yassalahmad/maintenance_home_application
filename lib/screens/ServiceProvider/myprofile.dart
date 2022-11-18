import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maintenance_home_application/screens/ChatRooms/chat_room.dart';
import 'package:maintenance_home_application/screens/ServiceProvider/deleteAccount.dart';

class MyProfileScreen extends StatefulWidget {

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {

  Widget textfield({@required hintText}) {
    return Material(
      elevation: 4,
      shadowColor: Colors.grey,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(
              letterSpacing: 2,
              color: Colors.black54,
              fontWeight: FontWeight.bold,
            ),
            fillColor: Colors.white30,
            filled: true,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide.none)),
      ),
    );
  }

  String name = "Loading.....";
  String email = "Loading....";
  String profession = "Loading....";
  String profile = "Loading....";
  String mobileNo = "Loading....";
  String city = "Loading....";

  Future getData() async{
    User? user = await FirebaseAuth.instance.currentUser;
    var variable = await FirebaseFirestore.instance.collection("Service Provider").doc(user?.uid).get();

    setState(() {
      profile = variable.data()!['profileImage'];
      name = variable.data()!['username'];
      email = variable.data()!['email'];
      profession = variable.data()!['profession'];
      mobileNo = variable.data()!['mobileNo'];
      city = variable.data()!['city'];
    });
  }


  // Update Data


  @override
  void initState() {
    getData();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                height: 410,
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    textfield(
                      hintText:  name,
                    ),
                    textfield(
                      hintText: email,
                    ),
                    textfield(
                      hintText: profession,
                    ),
                    textfield(hintText: mobileNo),
                    textfield(hintText: city),

                    SizedBox(height: 20),
                  ],
                ),
              )
            ],
          ),
          CustomPaint(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
            ),
            painter: HeaderCurvedContainer(),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                  "profile".tr,
                  style: TextStyle(
                    fontSize: 35,
                    letterSpacing: 1.5,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              CircleAvatar(
                radius: 80,
                backgroundColor: Colors.teal,
                backgroundImage: NetworkImage(profile),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class HeaderCurvedContainer extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = Colors.teal;
    Path path = Path()
      ..relativeLineTo(0, 100)
      ..quadraticBezierTo(size.width / 2, 225, size.width, 100)
      ..relativeLineTo(0, -150)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
