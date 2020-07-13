import 'package:cloud_firestore/cloud_firestore.dart';

class PostNotes { //for forums
  String topic;
  String link;
  String content;
  String timestamp;
  String username;
  String profilePicture;
  String imageurl; //must be multiple
  String documentid;
  String ownerid;
  Map<String, dynamic> saved = {};
  Map<String, dynamic> upvotes = {};

  PostNotes(
    this.topic,
    this.link,
    this.content,
    this.timestamp,
    this.username,
    this.profilePicture,
    this.imageurl,
    this.documentid,
    this.ownerid,
    this.saved,
    this.upvotes
  );

  PostNotes.fromSnapshot(DocumentSnapshot snapshot) : 
  topic = snapshot["topic"],
  link = snapshot['link'],
  content = snapshot['content'],
  timestamp = snapshot['timestamp'],
  username = snapshot['username'],
  profilePicture = snapshot['profilePicture'],
  imageurl = snapshot['imageurl'],
  documentid = snapshot['documentid'],
  ownerid = snapshot['ownerid'],
  saved = snapshot['saved'],
  upvotes = snapshot['upvotes'];
}