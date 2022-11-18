// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:maintenance_home_application/screens/ChatRooms/conversion_screen.dart';
// import 'package:maintenance_home_application/screens/ChatRooms/search.dart';
// import 'package:maintenance_home_application/screens/Helper/authenticate.dart';
// import 'package:maintenance_home_application/screens/Helper/constant.dart';
// import 'package:maintenance_home_application/screens/Helper/helperfunction.dart';
// import 'package:maintenance_home_application/screens/Services/auth.dart';
// import 'package:maintenance_home_application/screens/Services/database.dart';
// import 'package:maintenance_home_application/welcome_screen.dart';
//
// class ChatRoom extends StatefulWidget {
//   @override
//   _ChatRoomState createState() => _ChatRoomState();
// }
//
// class _ChatRoomState extends State<ChatRoom> {
//
//   MyAuthMethods myAuthMethods = MyAuthMethods();
//   DatabaseMethods databaseMethods = DatabaseMethods();
//   Stream<QuerySnapshot>? chatRoom;
//
//   Widget chatRoomList(){
//     return StreamBuilder(
//       stream: chatRoom,
//       builder: (context, AsyncSnapshot snapshot){
//         return snapshot.hasData ? ListView.builder(
//           itemCount: snapshot.data.docs.length,
//           itemBuilder: (context, index){
//             return ChatRoomTile(
//               userName: snapshot.data.docs[index].data()["chatroomId"]
//                   .toString().replaceAll("_", "")
//                   .replaceAll(Constants.myName, ""),
//               chatRoomId: snapshot.data.docs[index].data()["chatroomId"],
//             );
//           },
//         ) : Container();
//       },
//     );
//   }
//
//   @override
//   void initState() {
//     getUserInfo();
//     super.initState();
//   }
//
//   getUserInfo() async{
//     Constants.myName = (await HelperFunction.getUserNameLoggedInSharedPreference())!;
//     databaseMethods.getChatRoom(Constants.myName).then((value){
//       setState(() {
//         chatRoom= value;
//       });
//     });
//     setState(() {});
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // appBar: AppBar(
//       //   title: Image.asset("assets/images/logo.png", height: 50,),
//       //   actions: [
//       //     GestureDetector(
//       //       onTap: (){
//       //         myAuthMethods.signOut();
//       //         Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx) => WelcomeScreen()));
//       //       },
//       //       child: Container(
//       //           padding: EdgeInsets.symmetric(horizontal: 16),
//       //           child: Icon(Icons.exit_to_app)),
//       //     ),
//       //   ],
//       // ),
//       body: chatRoomList(),
//       floatingActionButton: FloatingActionButton(
//         onPressed: (){
//           Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx) => SearchScreen()));
//         },
//         child: Icon(Icons.search),
//       ),
//     );
//   }
// }
//
// class ChatRoomTile extends StatelessWidget {
//   final String userName;
//   final String chatRoomId;
//   ChatRoomTile({required this.userName, required this.chatRoomId});
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: (){
//         Navigator.push(context, MaterialPageRoute(builder: (context)=> Chat(chatRoomId: chatRoomId)));
//       },
//       child: Container(
//         decoration: BoxDecoration(
//             gradient: LinearGradient(
//                 colors: [
//                   Colors.teal,
//                   Color(0xff5f9ea0),
//                 ]
//             )
//         ),
//         padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
//         child: Row(
//           children: [
//             Container(
//               height: 40,
//               width: 40,
//               alignment: Alignment.center,
//               decoration: BoxDecoration(
//                 color: Colors.teal,
//                 borderRadius: BorderRadius.circular(40),
//               ),
//               child: Text("${userName.substring(0, 1).toUpperCase()}",
//                 style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.w600),),
//             ),
//             SizedBox(width: 8.0),
//             Text(userName, style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.w600),),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
