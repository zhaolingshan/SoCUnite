import 'package:flutter/material.dart';

class Chats extends StatefulWidget {
  @override
  _ChatsState createState() => _ChatsState();
}

class _ChatsState extends State<Chats> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: 
    AppBar(title: Text("Chats"),
     backgroundColor: Colors.grey[850]),
    body: Center(child: Text("Chats"),),
    );
  }
}