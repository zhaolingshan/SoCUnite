import 'package:SoCUniteTwo/screens/chat_screens/cs2040s_chat_screen.dart';
import 'package:flutter/material.dart';

class ModulesChatsScreen extends StatefulWidget {
  @override
  _ModulesChatsScreenState createState() => _ModulesChatsScreenState();
}

class _ModulesChatsScreenState extends State<ModulesChatsScreen> {
  List<String> modules = [
    'CS2040S',
    'CS2030',
    'MA1101R',
    'IS1103',
    'GER1000',
  ];

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
                modules[0],
                style: TextStyle(color: Colors.grey[100],fontWeight: FontWeight.bold,),
              ),
              subtitle: Text(
                'hello',
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
              ), // show number of unread msgs or double tick,
            ),
          ),
          Card(
            color: Colors.grey[850],
            child: ListTile(
              title: Text(
                modules[1],
                style: TextStyle(color: Colors.grey[100],fontWeight: FontWeight.bold,),
              ),
              subtitle: Text(
                'Anyone wants to go for lecture together?',
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
                '1',
                style: TextStyle(color: Colors.blue[300],),
              ),
            ),
          ),
          Card(
            color: Colors.grey[850],
            child: ListTile(
              title: Text(
                modules[2],
                style: TextStyle(color: Colors.grey[100],fontWeight: FontWeight.bold,),
              ),
              subtitle: Text(
                'Who is in tutorial class 4!',
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

            ),
          ),
          Card(
            color: Colors.grey[850],
            child: ListTile(
              title: Text(
                modules[3],
                style: TextStyle(color: Colors.grey[100], fontWeight: FontWeight.bold,)
              ),
              subtitle: Text(
                'Looking for a group member!',
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
                '4',
                style: TextStyle(color: Colors.blue[300],),
              ),
            ),
          ),
          Card(
            color: Colors.grey[850],
            child: ListTile(
              title: Text(
                modules[4],
                style: TextStyle(color: Colors.grey[100], fontWeight: FontWeight.bold,)
              ),
              subtitle: Text(
                'Looking for someone to swap tutorial slots with me!',
                style: TextStyle(
                  color: Colors.grey[100],
                ),
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
                '1',
                style: TextStyle(color: Colors.blue[300],),
              ),
            ),
          ),
        ],
      ),
    );
  }
}