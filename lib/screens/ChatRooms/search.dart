import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:maintenance_home_application/screens/Helper/constant.dart';
import 'package:maintenance_home_application/screens/Services/database.dart';
import 'package:maintenance_home_application/screens/Widgets/widget.dart';

import 'conversion_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  DatabaseMethods databaseMethods = DatabaseMethods();
  TextEditingController searchController = TextEditingController();
  QuerySnapshot<Map<String, dynamic>>? searchSnapshot;

  initiateSearch(){
    databaseMethods.getUserByUserName(searchController.text).then((val){
      setState(() {
        searchSnapshot = val;
      });
      });
  }

  /// Create ChatRoom, Send User To Conversation Screen, PushReplacement
  createChatRoomAndStartConversation({required String userName}){
   if(userName != Constants.myName){
     String chatRoomId = getChatRoomId(userName, Constants.myName);
     List<String> users = [userName, Constants.myName];
     Map<String, dynamic> chatRoomMap = {
       "users": users,
       "chatroomId": chatRoomId,
     };
     databaseMethods.createChatRoom(chatRoomId, chatRoomMap);
     Navigator.push(context, MaterialPageRoute(builder: (context) => Chat(chatRoomId: chatRoomId)));
   }else{
     print("You can't send message to yourself");
     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("You can't send message to yourself")));
   }
  }

  Widget searchList(){
    return searchSnapshot != null ? ListView.builder(
      itemCount: searchSnapshot?.docs.length,
      shrinkWrap: true,
      itemBuilder: (context, index){
        return SearchTile(
            userName: searchSnapshot?.docs[index].data()["Username"],
            userEmail: searchSnapshot?.docs[index].data()["Email"],
        );
      },
    ) : Container() ;
  }
  Widget SearchTile({required String userName, required String userEmail}){
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(userName, style: TextStyle(color: Colors.black, fontSize: 17, fontWeight: FontWeight.w600),),
              SizedBox(height: 4.0,),
              Text(userEmail, style: TextStyle(color: Colors.black, fontSize: 17, fontWeight: FontWeight.w600),),
            ],
          ),
          Spacer(),
          GestureDetector(
            onTap: (){
              createChatRoomAndStartConversation(userName: userName);
            },
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  gradient: LinearGradient(
                      colors: [
                        Colors.teal,
                        Color(0xff5f9ea0),
                      ]
                  )
              ),
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Text("Message", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold
              ),),
            ),
          )
        ],
      ),
    );
  }


  getChatRoomId(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
          child: appBarMain(context)),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 8),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Color(0xff009999),
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: searchController,
                        style: TextStyle(color: Colors.white),
                        cursorColor: Colors.white,
                        decoration: InputDecoration(
                          hintText: "Search Username",
                          hintStyle: TextStyle(color: Colors.white,),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        initiateSearch();
                      },
                      child: Container(
                        height: 40,
                          width: 40,
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.teal,
                                Color(0xff002424),
                              ]
                            ),
                            borderRadius: BorderRadius.circular(40),
                          ),
                          child: Image.asset("assets/images/search_white.png")),
                    ),
                  ],
                ),
              ),
              searchList()
            ],
          ),
        ),
      ),
    );
  }
}


