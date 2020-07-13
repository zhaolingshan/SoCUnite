import 'package:flutter/material.dart';
//import 'package:SoCUniteTwo/screens/forum_screens/new2030.dart';
//import 'package:SoCUniteTwo/screens/forum_screens/post.dart';
import 'package:SoCUniteTwo/screens/forum_screens/CS2030_forum.dart';
import 'package:SoCUniteTwo/screens/forum_screens/CS2030_feedback.dart';
import 'package:SoCUniteTwo/screens/forum_screens/CS2030_notes.dart';


//Only bottom navigation bar for CS2030 module (forums, notes, feedback)
class CS2030 extends StatefulWidget {
  @override
  _CS2030State createState() => _CS2030State();
}

class _CS2030State extends State<CS2030> {
  int _selectedIndex = 0;

  void onTappedBar(int index) {
    setState(() {
      _selectedIndex = index;
    }
    );
  }

  final List<Widget> tabs = [ 
    CS2030forum(),
    CS2030notes(),
    CS2030feedback(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: tabs[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.grey[850],
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.chat, color: Colors.tealAccent,),
            title: Text("Forum", style: TextStyle(color: Colors.white,))
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.done_outline, color: Colors.tealAccent,),
            title: Text("Notes", style: TextStyle(color: Colors.white,))
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.create, color: Colors.tealAccent,),
            title: Text("Feedback", style: TextStyle(color: Colors.white,))
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue[300],
        onTap: _onItemTapped,
      ),
    );
  }
}