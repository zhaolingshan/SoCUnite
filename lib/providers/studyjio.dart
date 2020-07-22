import 'package:cloud_firestore/cloud_firestore.dart';

class Studyjio {
  String documentId;
  String username;
  String profilePicture;
  String title;
  String description;
  bool isOffline;
  String modules; 
  String date;
  String startTime;
  String endTime;
  int capacity;
  bool bookRoom;
  String location; // location = 'online' for online sessions
  int currentCount; 
  String ownerId; 
  Map<String, dynamic> joinedUsers = {};
  GeoPoint locationOnMap;


   Studyjio(
  this.documentId,
   this.username,
    this.profilePicture,
    this.title,
    this.description,
   this.isOffline,
    this.modules,
    this.date,
    this.startTime,
    this.endTime,
    this.capacity,
    this.bookRoom,
   this.location,
    this.currentCount,
   this.ownerId,
   this.joinedUsers,
   this.locationOnMap,
   );

  Studyjio.fromSnapshot(DocumentSnapshot snapshot) : 
  documentId = snapshot['documentId'],
  username = snapshot['username'],
  profilePicture = snapshot['profilePicture'],
  title = snapshot['title'],
  description = snapshot['description'],
  isOffline = snapshot['isOffline'],
  modules = snapshot['modules'],
  date = snapshot['date'],
  startTime = snapshot['startTime'],
  endTime = snapshot['endTime'],
  capacity = snapshot['capacity'],
  bookRoom = snapshot['bookRoom'],
  location = snapshot['location'],
  currentCount = snapshot['currentCount'],
  ownerId = snapshot['ownerId'],
  locationOnMap = snapshot['locationOnMap'],
  joinedUsers = snapshot['joinedUsers']; 

  /* void toggleJoinStatus() {
    isJoined = !isJoined;
    notifyListeners();
  } */
}