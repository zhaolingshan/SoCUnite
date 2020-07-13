import 'package:cloud_firestore/cloud_firestore.dart';
//import 'dart:collection';

class Post { //for forums
  String title;
  String content;
  String timestamp;
  String imageurl;
  String username;
  String profilePicture;
  String documentid;
  String ownerid;
  Map<String, dynamic> saved = {};
  Map<String, dynamic> upvotes = {};
  


  Post(
    this.title,
    this.content,
    this.timestamp,
    this.imageurl,
    this.username,
    this.profilePicture,
    this.documentid,
    this.ownerid,
    this.saved,
    this.upvotes
    //this.image
  );

  Post.fromSnapshot(DocumentSnapshot snapshot) : 
  title = snapshot["title"],
  content = snapshot['content'],
  timestamp = snapshot['timestamp'],
  imageurl = snapshot['imageurl'],
  username = snapshot['username'],
  profilePicture = snapshot['profilePicture'],
  documentid = snapshot['documentid'],
  upvotes = snapshot['upvotes'],
  ownerid = snapshot['ownerid'],
  saved = snapshot['saved'];
}
