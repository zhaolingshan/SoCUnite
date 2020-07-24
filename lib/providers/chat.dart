//import 'package:SoCUniteTwo/screens/study.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:SoCUniteTwo/providers/studyjio.dart';

class Chat {
  String documentId;
  String title;
  String description; 
  String ownerId;

  Chat(
    this.documentId,
    this.title,
    this.description,
    this.ownerId,
  );

  Chat.fromSnapshot(DocumentSnapshot snapshot) : 
  title = snapshot['title'],
  description = snapshot['description'],
  documentId = snapshot['documentId'],
  ownerId = snapshot['ownerId'];
}
