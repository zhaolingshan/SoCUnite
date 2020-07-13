//import 'package:SoCUniteTwo/screens/chat_screens/cs2040s_chat_screen.dart';
import 'package:flutter/material.dart';

class StudyjiosChatsScreen extends StatefulWidget {
  @override
  _StudyjiosChatsScreenState createState() => _StudyjiosChatsScreenState();
}

class _StudyjiosChatsScreenState extends State<StudyjiosChatsScreen> {
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
                'CS2040S Finals Revision',
                style: TextStyle(color: Colors.grey[100],fontWeight: FontWeight.bold,),
              ),
              /*subtitle: Text(
                "Let's meet on the 5th floor!",
                style: TextStyle(color: Colors.grey[100],),
                 // latest msg
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CS2040SChatScreen())
                );
                // go to detail page
              },
              trailing: Text(
                '2',
                style: TextStyle(color: Colors.blue[300],),
              ), */ // show number of unread msgs or double tick,
            ),
          )
        ],
      ),
    );
  }
}