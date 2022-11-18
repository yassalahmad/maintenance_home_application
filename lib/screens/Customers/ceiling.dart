import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:url_launcher/url_launcher.dart';

class IndoorCeiling extends StatefulWidget {
  const IndoorCeiling({Key? key}) : super(key: key);

  @override
  _IndoorCeilingState createState() => _IndoorCeilingState();
}

class _IndoorCeilingState extends State<IndoorCeiling> {


  double rating = 0;
  double myRating = 0;

  Widget buildRating() => RatingBar.builder(
      initialRating: rating,
      minRating: 0,
      updateOnDrag: true,
      itemBuilder: (context, _) => Icon(Icons.star, color: Colors.amber,),
      onRatingUpdate: (rating) => setState(() {
        myRating = this.rating = rating;
      })
  );


  void showRating() => showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text("Rate This App"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("Please leave a star rating....", style: TextStyle(fontSize: 18),),
          SizedBox(height: 26,),
          buildRating(),
        ],
      ),
      actions: [
        MaterialButton(
          onPressed: (){
            Navigator.pop(context);
          },
          child: Text("Ok", style: TextStyle(fontWeight: FontWeight.bold),),
        )
      ],
    ),
  );

  //Update Data
  updateData(id, myRating) async{
    await FirebaseFirestore.instance.collection('Service Provider').doc(id).update({
      'rating': myRating,
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Indoor Ceilings", style: TextStyle(color: Colors.white),)),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('Service Provider').where("profession", isEqualTo: "Ceiling").snapshots(),
          builder: (BuildContext context, AsyncSnapshot snapshot){
            if(!snapshot.hasData){
              return Center(child: CircularProgressIndicator(),);
            }return ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: snapshot.data.docs.length,
              itemBuilder: (context, index){
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 5.0),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      gradient: LinearGradient(colors: [
                        Colors.teal, Colors.black54,
                      ]),
                      boxShadow: [
                        BoxShadow(color: Colors.grey, offset: Offset(0.5, 0.5), blurRadius: 10),
                      ],
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 8.0,),
                          ExpansionTile(
                            title: Text(snapshot.data.docs[index]['username'],
                              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),),
                            leading: Image.network(snapshot.data.docs[index]['profileImage'], fit: BoxFit.fitHeight,),
                            trailing: Icon(Icons.arrow_drop_down_circle, size: 25, color: Colors.white,),
                            children: [
                              SizedBox(height: 15.0),
                              Align(
                                alignment: Alignment.topLeft,
                                child: Text("Profession is   \t\t\t  ${snapshot.data.docs[index]['profession']}",
                                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),),
                              ),
                              SizedBox(height: 7.0,),
                              Align(
                                alignment: Alignment.topLeft,
                                child: Row(
                                  children: [
                                    Text("Text me    \t\t\t  ${snapshot.data.docs[index]['mobileNo']}",
                                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),),
                                    SizedBox(width: 50,),
                                    MaterialButton(
                                      onPressed: (){
                                        launch("sms: ${snapshot.data.docs[index]['mobileNo']}");
                                      },
                                      shape: StadiumBorder(),
                                      minWidth: 30,
                                      color: Colors.deepOrangeAccent,
                                      child: Text("SmS", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(height: 7.0),
                              Align(
                                alignment: Alignment.topLeft,
                                child: Row(
                                  children: [
                                    Text("MobileNo is    \t\t\t  ${snapshot.data.docs[index]['mobileNo']}",
                                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),),
                                    SizedBox(width: 25,),
                                    MaterialButton(
                                      onPressed: (){
                                        launch("tel: ${snapshot.data.docs[index]['mobileNo']}");
                                      },
                                      shape: StadiumBorder(),
                                      minWidth: 30,
                                      color: Colors.deepOrangeAccent,
                                      child: Text("Call", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(height: 7.0),
                              Align(
                                alignment: Alignment.topLeft,
                                child: Text("Area is    \t\t\t\t\t\t\t\t\t\t\t\t  ${snapshot.data.docs[index]['area']}",
                                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),),
                              ),
                              SizedBox(height: 7.0),
                              Align(
                                alignment: Alignment.topLeft,
                                child: Text("City is    \t\t\t\t\t\t\t\t\t\t\t\t\t\t  ${snapshot.data.docs[index]['city']}",
                                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),),
                              ),
                              SizedBox(height: 40.0),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  MaterialButton(
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                    onPressed: () => showRating(),
                                    child: Text(
                                      "Rate My Work",
                                      style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 15),
                                    ),
                                  ),
                                  Text(
                                    "Rating: ${snapshot.data.docs[index]['rating']}", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                                  ),
                                ],
                              ),
                              SizedBox(height: 15.0,),
                              RatingBar.builder(
                                  minRating: 1,
                                  initialRating: snapshot.data.docs[index]['rating'],
                                  updateOnDrag: true,
                                  itemBuilder: (context, _) => Icon(Icons.star, color: Colors.amber,),
                                  onRatingUpdate: (rating) => setState(() {
                                    this.rating = rating;
                                  })
                              ),
                              MaterialButton(
                                onPressed: (){
                                  updateData(snapshot.data.docs[index].id, myRating);
                                  setState(() {});
                                },
                                color: Colors.amber,
                                child: Text("Send Rating", style: TextStyle(color: Colors.black),),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        )
    );
  }
}

