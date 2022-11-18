import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods{

  getUserByUserName(String username) async{
   return await FirebaseFirestore.instance.collection("Service Providers")
       .where("Username", isEqualTo: username).get();
  }

  getUserByUserEmail(String userEmail) async{
    return await FirebaseFirestore.instance.collection("Service Providers")
        .where("Email", isEqualTo: userEmail).get();
  }

  // Upload Data of User In Firebase Collection
  uploadUserInfo(userMap){
    FirebaseFirestore.instance.collection("Service Providers").add(userMap).catchError((e){
      print(e.toString());
    });
  }

  // ChatRoom Created Here
  createChatRoom(String chatRoomId, chatRoomMap){
    FirebaseFirestore.instance.collection("ChatRoom").doc(chatRoomId).set(chatRoomMap).catchError((e){
      print(e.toString());
    });
  }

  // Add Conversation Messages in the Firebase Database
  addConversationMessages(String chatRoomId, messageMap){
    FirebaseFirestore.instance.collection("ChatRoom").doc(chatRoomId)
        .collection("chats")
        .add(messageMap).catchError((e){
          print(e.toString());
    });
  }

  // Get Conversation Messages in the Firebase Database
  getConversationMessages(String chatRoomId) async{
   return await FirebaseFirestore.instance.collection("ChatRoom").doc(chatRoomId)
        .collection("chats")
        .orderBy("time")
        .snapshots();
    }

    //Get ChatRooms
    getChatRoom(String userName) async{
    return await FirebaseFirestore.instance
        .collection("ChatRoom")
        .where("users", arrayContains: userName)
        .snapshots();
    }
  }