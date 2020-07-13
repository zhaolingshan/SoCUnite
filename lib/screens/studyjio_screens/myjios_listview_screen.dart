import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:SoCUniteTwo/providers/studyjio.dart';
import 'package:SoCUniteTwo/widgets/studyjios/joinstudyjio.dart';
import 'package:SoCUniteTwo/widgets/provider_widget.dart';

class MyjiosListviewScreen extends StatefulWidget {

  @override
  _MyjiosListviewScreenState createState() => _MyjiosListviewScreenState();
}

class _MyjiosListviewScreenState extends State<MyjiosListviewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(    
      backgroundColor: Colors.grey[900],
      body: Container(
        child: StreamBuilder(
          stream: getUsersMyStudyjiosSnapshot(context),
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
          => buildMyJios(context, snapshot.data.documents[index]),
          itemCount: snapshot.data.documents.length,
        );
          }
        ),
      ),
    );
  }

  Stream<QuerySnapshot> getUsersMyStudyjiosSnapshot(BuildContext context) async* {
    final uid = await Provider.of(context).auth.getCurrentUID();
    yield* Firestore.instance.collection('users').document(uid)
    .collection('my_studyjios').snapshots();
  }

  Widget buildMyJios(BuildContext context, DocumentSnapshot studyjio) {
    final myJio = Studyjio.fromSnapshot(studyjio);
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



