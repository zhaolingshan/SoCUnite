import 'package:SoCUniteTwo/screens/studyjio_screens/joinedjios_listview_screen.dart';
import 'package:SoCUniteTwo/screens/studyjio_screens/myjios_listview_screen.dart';
import 'package:flutter/material.dart';
//import 'package:provider/provider.dart';

import 'package:SoCUniteTwo/screens/studyjio_screens/add_studyjio_screen.dart';
import 'package:SoCUniteTwo/screens/studyjio_screens/studyjios_listview_screen.dart';
import 'package:SoCUniteTwo/screens/studyjio_screens/studyjio_mapview_screen.dart';
//import 'package:SoCUniteTwo/providers/studyjios.dart';
import 'package:SoCUniteTwo/providers/studyjio.dart';


enum FilterOptions {
  Mine,
  All,
  Joined,
}

class StudyjiosOverviewScreen extends StatefulWidget {
  @override
  _StudyjiosOverviewScreenState createState() => _StudyjiosOverviewScreenState();
} 

class _StudyjiosOverviewScreenState extends State<StudyjiosOverviewScreen> {
  Studyjio studyjio;
  bool showMine = false;
  bool showJoined = false;
  bool showBrowse = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 2, 
        child: Scaffold(
        backgroundColor: Colors.grey[900],
        appBar: AppBar(
          leading: Container(),
          backgroundColor: Colors.grey[850],
          centerTitle: true,
          title: showMine
            ? Text("My Study Jios")
            : showJoined 
              ? Text("Joined Study Jios")
              : Text("Browse Study Jios"),
          bottom: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.list, color: Colors.tealAccent), text: 'LIST VIEW'),
              Tab(icon: Icon(Icons.place, color: Colors.tealAccent), text: 'MAP VIEW'),
            ]
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
                  MaterialPageRoute(builder: (context) => AddStudyJioScreen()), // creates an automatic back button
                  );  
              },
            ),
            PopupMenuButton(
              onSelected: (FilterOptions selectedValue) {
                if (selectedValue == FilterOptions.Mine) {
                  setState(() {
                    showMine = true;
                    showJoined = false;
                    showBrowse = false;
                  });
                } else if (selectedValue == FilterOptions.All) {
                  setState(() {
                    showMine = false;
                    showJoined = false;
                    showBrowse = true;
                  });
                } else { 
                  setState(() {
                    showMine = false;
                    showJoined = true;
                    showBrowse = false;
                  });
                }
              },
              icon: Icon(
                Icons.more_vert,
                color: Colors.white,
              ),
              itemBuilder: (_) => [
                PopupMenuItem(child: Text('My Study-jios'), value: FilterOptions.Mine),
                PopupMenuItem(child: Text('Browse Study-jios'), value: FilterOptions.All),
                PopupMenuItem(child: Text('Joined Study-jios'), value: FilterOptions.Joined),
              ],
            )   
          ] 
        ),
        body: TabBarView(
            children: [
              showJoined 
                ? JoinedjiosListviewScreen()
                : showMine
                  ? MyjiosListviewScreen()
                  : StudyjiosListviewScreen(),
              StudyjiosMapviewScreen(), 
            ],
          ),
        ),
      ),
    );
  }
}
