import 'package:cloud_firestore/cloud_firestore.dart';

class Experience {
  String title;
  String company; 
  String role;
  String timePeriod; 
  String content; 
  String timestamp;
  String username;
  String profilePicture;
  String documentid;
  String ownerid;
  Map<String, dynamic> saved = {};
  Map<String, dynamic> upvotes = {};
  Map<String, dynamic> reported = {};
  

  Experience(
    this.title,
    this.timePeriod,
    this.role,
    this.content,
    this.timestamp,
    this.company,
    this.username,
    this.profilePicture,
    this.documentid,
    this.ownerid,
    this.saved,
    this.upvotes,
    this.reported,
  );

  Experience.fromSnapshot(DocumentSnapshot snapshot) : 
  title = snapshot["title"],
  content = snapshot['content'],
  timestamp = snapshot['timestamp'],
  role = snapshot['role'],
  username = snapshot['username'],
  profilePicture = snapshot['profilePicture'],
  documentid = snapshot['documentid'],
  timePeriod = snapshot['timePeriod'],
  ownerid = snapshot['ownerid'],
  company = snapshot['company'],
  upvotes = snapshot['upvotes'],
  saved = snapshot['saved'];
}