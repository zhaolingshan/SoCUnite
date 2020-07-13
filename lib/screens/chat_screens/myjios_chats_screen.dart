import 'package:SoCUniteTwo/screens/chat_screens/cs2040s_chat_screen.dart';
import 'package:flutter/material.dart';

class MyjiosChatsScreen extends StatefulWidget {
  @override
  _MyjiosChatsScreenState createState() => _MyjiosChatsScreenState();
}

class _MyjiosChatsScreenState extends State<MyjiosChatsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: ListView(
        children: <Widget>[
          Card(
            color: Colors.grey[850],
            child: ListTile(
              title: Text(
                "Lunch Jio!",
                style: TextStyle(color: Colors.grey[100],fontWeight: FontWeight.bold,),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CS2040SChatScreen())
                );
                // go to detail page
              },
            ),
          )
        ],
      ),
    );
  }
}