import 'package:flutter/material.dart';
import 'package:maintenance_home_application/screens/Customers/carpenter.dart';
import 'package:maintenance_home_application/screens/Customers/ceiling.dart';
import 'package:maintenance_home_application/screens/Customers/freezer_mechanic.dart';
import 'package:maintenance_home_application/screens/Customers/masonry.dart';
import 'package:maintenance_home_application/screens/Customers/painter.dart';
import 'package:maintenance_home_application/screens/Customers/plumber.dart';
import 'package:maintenance_home_application/screens/Customers/tv_mechanic.dart';

import 'car_mechanic.dart';
import 'electrician_screen.dart';

class ServicesProviders extends StatefulWidget {
  const ServicesProviders({Key? key}) : super(key: key);

  @override
  _ServicesProvidersState createState() => _ServicesProvidersState();
}

class _ServicesProvidersState extends State<ServicesProviders> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GridView(
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(vertical: 50, horizontal: 12),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 2.0,
            mainAxisSpacing: 10.0,
          ),
          children: [
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => ElectriciansScreen()));
              },
              child: Card(
                color: Color(0xffeed4c3),
                shadowColor: Colors.black54,
                child: Column(
                  children: [
                    SizedBox(height: 15),
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.transparent,
                      backgroundImage: AssetImage("assets/images/electrician.png"),
                    ),
                    SizedBox(height: 12),
                    Text("Find Electricians", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> PlumberScreen()));
              },
              child: Card(
                color: Color(0xffc9e3b8),
                child: Column(
                  children: [
                    SizedBox(height: 15),
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.transparent,
                      backgroundImage: AssetImage("assets/images/plumber.png"),
                    ),
                    SizedBox(height: 12),
                    Text("Find Plumber", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> FreezerMechanic()));
              },
              child: Card(
                color: Color(0xffd3bdcd),
                child: Column(
                  children: [
                    SizedBox(height: 15),
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.transparent,
                      backgroundImage: AssetImage("assets/images/freezer.png"),
                    ),
                    SizedBox(height: 12),
                    Text("Freezer Mechanic", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> TvMechanic()));
              },
              child: Card(
                color: Color(0xffbed0dc),
                child: Column(
                  children: [
                    SizedBox(height: 15),
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.transparent,
                      backgroundImage: AssetImage("assets/images/tv.png"),
                    ),
                    SizedBox(height: 12),
                    Text("TV Mechanic", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> CarMechanic()));
              },
              child: Card(
                color: Color(0xffa39d98),
                child: Column(
                  children: [
                    SizedBox(height: 15),
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.transparent,
                      backgroundImage: AssetImage("assets/images/car.png"),
                    ),
                    SizedBox(height: 12),
                    Text("Car/Bike Mechanic", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> Carpenters()));
              },
              child: Card(
                color: Color(0xffeed4c3),
                child: Column(
                  children: [
                    SizedBox(height: 15),
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.transparent,
                      backgroundImage: AssetImage("assets/images/carpenter.png"),
                    ),
                    SizedBox(height: 12),
                    Text("Find Carpenter", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> Masonry()));
              },
              child: Card(
                color: Color(0xffc9e3b8),
                child: Column(
                  children: [
                    SizedBox(height: 15),
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.transparent,
                      backgroundImage: AssetImage("assets/images/masonry.png"),
                    ),
                    SizedBox(height: 12),
                    Text("Find Masonry", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> Painters()));
              },
              child: Card(
                color: Color(0xffd3bdcd),
                child: Column(
                  children: [
                    SizedBox(height: 15),
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.transparent,
                      backgroundImage: AssetImage("assets/images/painter.png"),
                    ),
                    SizedBox(height: 12),
                    Text("Find Painter", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> IndoorCeiling()));
              },
              child: Card(
                color: Color(0xffbed0dc),
                child: Column(
                  children: [
                    SizedBox(height: 15),
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.transparent,
                      backgroundImage: AssetImage("assets/images/ceiling.png"),
                    ),
                    SizedBox(height: 12),
                    Text("Indoor Ceiling", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


