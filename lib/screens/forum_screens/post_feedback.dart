import 'package:cloud_firestore/cloud_firestore.dart';

class PostFeedback {
  String yearTaken;
  String expectedGrade;
  String actualGrade;
  String professor;
  String difficulty;
  String preparationTips; 
  String content;
  String profilePicture;
  String username; 
  String timestamp;
  String documentid;
  String ownerid;
  Map<String, dynamic> saved = {};
  Map<String, dynamic> upvotes = {};
  Map<String, dynamic> reported = {};
  

  PostFeedback(
    this.yearTaken,
    this.expectedGrade,
    this.actualGrade,
    this.professor,
    this.difficulty,
    this.preparationTips,
    this.content,
    this.profilePicture,
    this.username,
    this.timestamp,
    this.documentid,
    this.ownerid,
    this.saved,
    this.upvotes,
    this.reported,
  );

  PostFeedback.fromSnapshot(DocumentSnapshot snapshot) : 
  yearTaken = snapshot["yearTaken"],
  expectedGrade = snapshot['expectedGrade'],
  actualGrade = snapshot['actualGrade'],
  professor = snapshot['professor'],
  difficulty = snapshot['difficulty'],
  preparationTips = snapshot['preparationTips'],
  content = snapshot['content'],
  profilePicture = snapshot['profilePicture'],
  username = snapshot['username'],
  timestamp = snapshot['timestamp'],
  documentid = snapshot['documentid'],
  ownerid = snapshot['ownerid'],
  saved = snapshot['saved'],
  upvotes = snapshot['upvotes'];

}