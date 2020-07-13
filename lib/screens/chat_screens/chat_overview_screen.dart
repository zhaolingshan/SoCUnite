import 'package:SoCUniteTwo/screens/chat_screens/modules_chats_screen.dart';
import 'package:SoCUniteTwo/screens/chat_screens/myjios_chats_screen.dart';
import 'package:SoCUniteTwo/screens/chat_screens/studyjios_chats_screen.dart';
import 'package:flutter/material.dart';

import 'package:SoCUniteTwo/screens/chat_screens/add_chatroom_screen.dart';

class ChatOverviewScreen extends StatefulWidget {
  @override
  _ChatOverviewScreenState createState() => _ChatOverviewScreenState();
}

class _ChatOverviewScreenState extends State<ChatOverviewScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          backgroundColor: Colors.grey[900],
          appBar: AppBar(
            backgroundColor: Colors.grey[850],
            title: const Text('Chatrooms'),
            centerTitle: true,
            bottom: TabBar(
              tabs: [
                Tab(icon: Icon(Icons.assignment, color: Colors.tealAccent,), text: 'MODULES'),
                Tab(icon: Icon(Icons.fastfood, color: Colors.tealAccent,), text: 'MY JIOS'),
                Tab(icon: Icon(Icons.people, color: Colors.tealAccent,), text: 'STUDY JIOS'),
              ],  
            ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.add,
              color: Colors.white,
            ), 
            onPressed: () {
              Navigator.push(
                context, 
                MaterialPageRoute(builder: (context) => AddChatroomScreen()), // creates an automatic back button
              );
            },
          ),
        ],
      ),
      body: 
          TabBarView(
            children: [
              ModulesChatsScreen(),
              MyjiosChatsScreen(),
              StudyjiosChatsScreen(),
            ],
          ),
      ),
    );
  }
}