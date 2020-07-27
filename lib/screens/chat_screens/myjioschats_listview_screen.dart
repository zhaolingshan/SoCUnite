import 'package:SoCUniteTwo/screens/chat_screens/public_chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:SoCUniteTwo/providers/chat.dart';

class MyjiosChatsListviewScreen extends StatefulWidget {
  @override
  _MyjiosChatsListviewScreenState createState() => _MyjiosChatsListviewScreenState();
}

class _MyjiosChatsListviewScreenState extends State<MyjiosChatsListviewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(    
      backgroundColor: Colors.grey[900],
      body: Container(
        child: StreamBuilder(
          stream: getPublicChatsSnapshot(context),
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
          => buildPublicChats(context, snapshot.data.documents[index]),
          itemCount: snapshot.data.documents.length,
        );
          }
        ),
      ),
    );
  }

  Stream<QuerySnapshot> getPublicChatsSnapshot(BuildContext context) async* {
    yield* Firestore.instance.collection('public_chats').snapshots();
  }

  Widget buildPublicChats(BuildContext context, DocumentSnapshot chat) {
    final publicChat = Chat.fromSnapshot(chat);
    String description = 'Description: ' + chat['description'];
    return Container(
      child: Builder(
        builder: (context) {
          return Card(
            color: Colors.grey[850],
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context, 
                  MaterialPageRoute(
                    builder: (context) => PublicChatScreen(publicChat: publicChat,) 
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
                              Text(
                                chat['title'], 
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
                        Padding(
                          padding: EdgeInsets.only(top: 0, bottom: 0),
                          child: Row(
                            children: <Widget>[
                              SizedBox(width: 20,),
                              //Expanded(child:
                              Text(
                                description, 
                                style: TextStyle(
                                  fontSize: 15, 
                                  color: Colors.grey[100],
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                              //),
                            ],
                          ),
                        ),
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