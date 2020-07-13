import 'package:flutter/material.dart';
//import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:SoCUniteTwo/providers/studyjio.dart';
import 'package:SoCUniteTwo/widgets/studyjios/joinstudyjio.dart';

class StudyjiosListviewScreen extends StatefulWidget {

  @override
  _StudyjiosListviewScreenState createState() => _StudyjiosListviewScreenState();
}

class _StudyjiosListviewScreenState extends State<StudyjiosListviewScreen> {

  /*String checkDate(String dateString) {

   DateTime checkedTime= DateTime.parse(dateString);
   DateTime currentTime= DateTime.now();

   if((currentTime.year == checkedTime.year)
          && (currentTime.month == checkedTime.month)
              && (currentTime.day == checkedTime.day)) {
        return "Today";
    }
   else if((currentTime.year == checkedTime.year)
              && (currentTime.month == checkedTime.month)) {
    if ((currentTime.day - checkedTime.day) == -1) {
      return "Tomorrow";
    } else {
      return DateFormat.MMMMd().format(DateTime.now());
    }
} 

 } */
  @override
  Widget build(BuildContext context) {
    return Scaffold(    
      backgroundColor: Colors.grey[900],
      body: Container(
        child: StreamBuilder(
          stream: getUsersBrowseStudyjiosSnapshot(context),
          builder: (context, snapshot) {
            if(!snapshot.hasData) return 
            Center(child: 
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
              CircularProgressIndicator()
            ],)); 
            return new ListView.builder(
          itemBuilder: (BuildContext context, int index) 
          => buildBrowseJios(context, snapshot.data.documents[index]),
          itemCount: snapshot.data.documents.length,
        );
          }
        ),
      ),
      );
  }

  Stream<QuerySnapshot> getUsersBrowseStudyjiosSnapshot(BuildContext context) async* {
    yield* Firestore.instance.collection('browse_jios').snapshots();
  }

  Widget buildBrowseJios(BuildContext context, DocumentSnapshot studyjio) {
    final browseJio = Studyjio.fromSnapshot(studyjio);
    return Container(
      child: Builder(
        builder: (context) {
          return ListTile(
            title: Text(
              studyjio['title'],
              style: TextStyle(color: Colors.blue[300], fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              studyjio['date']
              + '\n' + studyjio['startTime'] + " to " + studyjio['endTime']
              + "\n" + studyjio['location'],
              style: TextStyle( color: Colors.grey[100]),
            ),
            trailing: JoinStudyjio(),
            onTap: () {
              // go to detail page
            },
          );
        }
      ),
    );
  }
}