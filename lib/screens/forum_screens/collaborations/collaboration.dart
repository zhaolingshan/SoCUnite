import 'package:cloud_firestore/cloud_firestore.dart';

class Collaboration { //for forums
  String title;
  String experience; //personal experience
  String contact; //phone no. / email/ tele handle
  String name;
  String content; //details on project
  String link;
  String timestamp;
  String username;
  String profilePicture;
  String documentid;
  String ownerid;
  Map<String, dynamic> saved = {};
  Map<String, dynamic> upvotes = {};
  Map<String, dynamic> reported = {};
  

  Collaboration(
    this.title,
    this.content,
    this.timestamp,
    this.name,
    this.link,
    this.experience,
    this.contact, 
    this.username,
    this.profilePicture,
    this.documentid,
    this.saved,
    this.ownerid,
    this.upvotes,
    this.reported
  );

  Collaboration.fromSnapshot(DocumentSnapshot snapshot) : 
  title = snapshot["title"],
  content = snapshot['content'],
  timestamp = snapshot['timestamp'],
  username = snapshot['username'],
  profilePicture = snapshot['profilePicture'],
  documentid = snapshot['documentid'],
  experience = snapshot['experience'],
  contact = snapshot['contact'],
  name = snapshot['name'],
  link = snapshot['link'],
  upvotes = snapshot['upvotes'],
  saved = snapshot['saved'];
}