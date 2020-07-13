import 'package:cloud_firestore/cloud_firestore.dart';

class Comments {
  String content;
  String profilePicture;
  String username;
  String timestamp;
  String documentid;
  String ownerid;
  Map<String, dynamic> upvotes = {};


  Comments(
    this.content,
    this.username,
    this.profilePicture,
    this.timestamp,
    this.documentid,
    this.ownerid,
    this.upvotes,
  );

  Comments.fromSnapshot(DocumentSnapshot snapshot) :
  content = snapshot['content'],
  //imageurl = snapshot['imageurl'],
  profilePicture = snapshot['profilePicture'],
  username = snapshot['username'],
  timestamp = snapshot['timestamp'],
  documentid = snapshot['documentid'],
  ownerid = snapshot['ownerid'],
  upvotes = snapshot['upvotes'];
}