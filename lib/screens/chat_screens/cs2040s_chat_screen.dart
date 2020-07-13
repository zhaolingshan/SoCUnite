import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import 'package:SoCUniteTwo/widgets/chat/messages_cs2040s.dart';
import 'package:SoCUniteTwo/widgets/chat/new_message_cs2040s.dart';

class CS2040SChatScreen extends StatefulWidget {
  @override
  _CS2040SChatScreenState createState() => _CS2040SChatScreenState();
}

class _CS2040SChatScreenState extends State<CS2040SChatScreen> {
  @override
  void initState() {
    final fbm = FirebaseMessaging();
    fbm.requestNotificationPermissions();
    fbm.configure(onMessage: (msg) {
      print(msg);
      return;
    }, onLaunch: (msg) {
      print(msg);
      return;
    }, onResume: (msg) {
      print(msg);
      return;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        backgroundColor: Colors.grey[850],
        title: Text('CS2040S Chatroom',),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.more_horiz, color: Colors.tealAccent,),
            onPressed: () {
              // details: members, media
            },
          ),
        ],
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Messagescs2040s(),
            ),  
            NewMessageCS2040S(),
         ],
        ),
      )
    );
  }
}


