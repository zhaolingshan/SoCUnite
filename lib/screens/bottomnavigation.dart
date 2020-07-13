import 'package:flutter/material.dart';
import 'package:SoCUniteTwo/screens/forums.dart';
import 'package:SoCUniteTwo/screens/settings.dart';
//import 'package:SoCUniteTwo/screens/study.dart';
//import 'package:SoCUniteTwo/screens/chats.dart'; 
import 'package:SoCUniteTwo/screens/home.dart';
import 'package:SoCUniteTwo/screens/studyjio_screens/studyjios_overview_screen.dart';
import 'package:SoCUniteTwo/screens/chat_screens/chat_overview_screen.dart';


class BottomNavigation extends StatefulWidget {
  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int currentindex = 0;

  void onTappedBar(int index) {
    setState(() {
      currentindex = index;
    }
    );
  }

  final List<Widget> tabs = [
    Home(),
    StudyjiosOverviewScreen(),
    Forums(),
    ChatOverviewScreen(),
    Settings()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Recently viewed"),
      //   backgroundColor: Colors.blue,
      // ),
      body: tabs[currentindex], //router
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 30,
        onTap: onTappedBar,
        currentIndex: currentindex,
        items: [BottomNavigationBarItem(
          icon: Icon(Icons.home, color: Colors.tealAccent,),
          title: Text("Home"),
          backgroundColor: Colors.grey[850], 
        ),
      BottomNavigationBarItem(
          icon: Icon(Icons.border_color, color: Colors.tealAccent,),
          title: Text("Study-jio"),
          backgroundColor: Colors.grey[850], 
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.chat, color: Colors.tealAccent,),
          title: Text("Forums"),
          backgroundColor: Colors.grey[850], 
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.mood, color: Colors.tealAccent,),
          title: Text("Chats"),
          backgroundColor: Colors.grey[850], 
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings, color: Colors.tealAccent,),
          title: Text("Settings"),
          backgroundColor: Colors.grey[850], 
        ),
        ],
      ),
    );
  }
}
