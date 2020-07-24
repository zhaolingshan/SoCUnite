import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';

// import 'package:SoCUniteTwo/screens/chat_screens/studyjio_chat_screen.dart';

class ChatScreen {
  String title;

  ChatScreen(
    this.title,
  );

  // static navigateIntoChatroom(BuildContext context) {
  //   Navigator.push(
  //     context, 
  //     MaterialPageRoute(
  //       builder: (context) => StudyjioChatScreen(),
  //     )
  //   ); 
  // }

  ChatScreen.fromSnapshot(DocumentSnapshot snapshot) : 
  title = snapshot['title'];
}