import 'package:cloud_firestore/cloud_firestore.dart';

class Offer { //for forums
  String title;
  String company; 
  String contact; //phone no. / email/ tele handle
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
  

  Offer(
    this.title,
    this.content,
    this.timestamp,
    this.link,
    this.company,
    this.contact, 
    this.username,
    this.profilePicture,
    this.documentid,
    this.ownerid,
    this.saved,
    this.upvotes,
    this.reported,
  );

  Offer.fromSnapshot(DocumentSnapshot snapshot) : 
  title = snapshot["title"],
  content = snapshot['content'],
  timestamp = snapshot['timestamp'],
  username = snapshot['username'],
  profilePicture = snapshot['profilePicture'],
  documentid = snapshot['documentid'],
  ownerid = snapshot['ownerid'],
  contact = snapshot['contact'],
  link = snapshot['link'],
  company = snapshot['company'],
  upvotes = snapshot['upvotes'],
  saved = snapshot['saved'];
}