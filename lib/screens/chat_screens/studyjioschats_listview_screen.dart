import 'package:SoCUniteTwo/screens/chat_screens/studyjio_chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:SoCUniteTwo/providers/studyjio.dart';
import 'package:SoCUniteTwo/widgets/provider_widget.dart';

class StudyjiosChatsListviewScreen extends StatefulWidget {
  @override
  _StudyjiosChatsListviewScreenState createState() => _StudyjiosChatsListviewScreenState();
}

class _StudyjiosChatsListviewScreenState extends State<StudyjiosChatsListviewScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(    
      backgroundColor: Colors.grey[900],
      body: Container(
        child: StreamBuilder(
          stream: getStudyjioChatsSnapshot(context),
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
          => buildStudyjioChats(context, snapshot.data.documents[index]),
          itemCount: snapshot.data.documents.length,
        );
          }
        ),
      ),
    );
  }

  Stream<QuerySnapshot> getStudyjioChatsSnapshot(BuildContext context) async* {
    final uid = await Provider.of(context).auth.getCurrentUID();
    yield* Firestore.instance.collection('users').document(uid)
    .collection('my_studyjios_chats')
    .snapshots();
  }

  Widget buildStudyjioChats(BuildContext context, DocumentSnapshot studyjio) {
    final studyjioforEachChat = Studyjio.fromSnapshot(studyjio);
    String description = 'Description: ' + studyjio['description'];
    print(studyjioforEachChat);
    return Container(
      child: Builder(
        builder: (context) {
          return Card(
            color: Colors.grey[850],
            child: InkWell(
              onTap: () async { 
                Navigator.push(
                  context, 
                  MaterialPageRoute(
                    builder: (context) => StudyjioChatScreen(studyjio: studyjioforEachChat,),
                  )
                );
              },
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 4, bottom: 4),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(top: 0, bottom: 0),
                          child: Row(
                            children: <Widget>[
                              SizedBox(width: 20,),
                              // FutureBuilder( 
                              //   future: Firestore.instance.collection('browse_jios').document(studyjio['documentId']).get(),
                              //   builder: (context, snapshot) {
                              //     if (snapshot.data != null) {
                              //       return Text(snapshot.data['title'], style: TextStyle(fontWeight: FontWeight.bold,
                              //         fontSize: 17, decoration: TextDecoration.underline, color: Colors.blue[300]),
                              //       );
                              //     } else {
                              //       return CircularProgressIndicator();
                              //     }           
                              //   }, 
                              // ),
                              Text(
                                studyjio['title'], 
                                style: TextStyle(
                                  fontSize: 17, 
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline,
                                  color: Colors.blue[300]
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20,),
                        //Expanded(child:
                        Padding(
                          padding: EdgeInsets.only(top: 0, bottom: 0),
                          child: 
                          Row(
                            children: <Widget>[
                              SizedBox(width: 20,),
                              //Flexible(child: 
                              Text(
                                description, 
                                style: TextStyle(
                                  fontSize: 15, 
                                  color: Colors.grey[100],
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                              //),
                            ],
                          ),
                        ),
                        //),
                        SizedBox(height: 10,),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      )
    );         
  }
}