import 'package:flutter/material.dart';

class Forums extends StatefulWidget { //first page of forum (categories)
  @override
  _ForumsState createState() => _ForumsState();
}

class _ForumsState extends State<Forums> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: 
    new AppBar(title: Text("Forums"),
     backgroundColor: Colors.grey[850]),
    body:
    SingleChildScrollView(
      child: 
    Column(
      children: <Widget>[
        ListTile(
              onTap: () { 
                Navigator.of(context).pushNamed('/myposts');
              },
              title: Text("My posts",
               style: TextStyle(fontSize: 21, 
               color: Colors.grey[100]),),
              trailing: Icon(Icons.keyboard_arrow_right, color: Colors.grey[350],),
            ),
            Divider(
              color: Colors.grey[800],
              thickness: 1,),
        ListTile(
              onTap: () { //enter module forum
                Navigator.of(context).pushNamed('/modulescreen');
              },
              title: Text("Modules / Module feedback and planning",
               style: TextStyle(fontSize: 21, color: Colors.grey[100]),),
              trailing: Icon(Icons.keyboard_arrow_right, color: Colors.grey[350],),
            ),
            Divider(
              color: Colors.grey[800],
              thickness: 1,),
            //   ListTile(
            //   onTap: () { //enter module forum
            //   },
            //   title: Text("Module Feedback/Planning",
            //    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
            //   trailing: Icon(Icons.keyboard_arrow_right, color: Colors.black,),
            // ),
            // Divider(
            //   color: Colors.grey[400],
            //   thickness: 1,),
              ListTile(
              title: Text("Opportunities",
               style: TextStyle(fontSize: 21, color: Colors.grey[600]),),
              trailing: Icon(Icons.keyboard_arrow_down, color: Colors.grey[350],),
            ),
            Divider(
              color: Colors.grey[800],
              thickness: 1,),
              ListTile(
              onTap: () { //enter module forum
                 Navigator.of(context).pushNamed('/collaborations');
              },
              title: Text("Collaborations",
               style: TextStyle(fontSize: 21, color: Colors.grey[100]),),
              trailing: Icon(Icons.keyboard_arrow_right, color: Colors.grey[350],),
            ),
            Divider(
              color: Colors.grey[800],
              thickness: 1,),
              ListTile(
              onTap: () { //enter module forum
              Navigator.of(context).pushNamed('/offers');
              },
              title: Text("Internship offers",
               style: TextStyle(fontSize: 21, color: Colors.grey[100]),),
              trailing: Icon(Icons.keyboard_arrow_right, color: Colors.grey[350],),
            ),
            Divider(
              color: Colors.grey[800],
              thickness: 1,),
            ListTile(
              title: Text("SeniorSays",
               style: TextStyle(fontSize: 21, color: Colors.grey[600]),),
              trailing: Icon(Icons.keyboard_arrow_down, color: Colors.grey[350],),
            ),
            Divider(
              color: Colors.grey[800],
              thickness: 1,),
              ListTile(
              onTap: () { 
                Navigator.of(context).pushNamed('/experiences');
              },
              title: Text("Internship experiences and advices",
               style: TextStyle(fontSize: 21, color: Colors.grey[100]),),
              trailing: Icon(Icons.keyboard_arrow_right, color: Colors.grey[350],),
            ),
            Divider(
              color: Colors.grey[800],
              thickness: 1,),
              
      ],),)
    );
  }
}