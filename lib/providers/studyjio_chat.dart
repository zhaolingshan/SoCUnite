//import 'package:SoCUniteTwo/screens/chat_screens/studyjio_chat_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:SoCUniteTwo/providers/chat.dart';
import 'package:SoCUniteTwo/providers/studyjio.dart';

class StudyjioChat {
  String documentId;
  String title;
  String description;
  //StudyjioChatScreen chatScreen;
  Studyjio studyjio;

  StudyjioChat(
    this.documentId,
    this.title,
    this.description,
    //this.chatScreen,
    //this.studyjio,
  );

  StudyjioChat.fromSnapshot(DocumentSnapshot snapshot) : 
    title = snapshot['title'],
    description = snapshot['description'],
    documentId = snapshot['documentId'];
    //chatScreen = snapshot['chatScreen'];
    //studyjio = snapshot['studyjio'];
}