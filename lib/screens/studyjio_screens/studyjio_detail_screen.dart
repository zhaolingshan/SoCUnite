import 'package:flutter/material.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:SoCUniteTwo/providers/studyjio.dart';

class StudyjioDetailScreen extends StatefulWidget {
  final Studyjio studyjio;

  StudyjioDetailScreen({Key key, @required this.studyjio}) : super(key: key);
  @override
  _StudyjioDetailScreenState createState() => _StudyjioDetailScreenState();
}

class _StudyjioDetailScreenState extends State<StudyjioDetailScreen> {
  @override
  Widget build(BuildContext context) {
    //String users = widget.studyjio.joinedUsers.keys.forEach((k) => Text('{$k},'));
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        backgroundColor: Colors.grey[850],
        title: Text('Details'), 
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.of(context).pop();
              },
            );
          },
        ) ,
      ),
      body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(width: 20),
                  Text(
                    'Created by ', 
                    style: TextStyle(
                      color: Colors.blue[300],
                      fontSize: 16,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  Text(
                    widget.studyjio.username, 
                    style: TextStyle(
                      color: Colors.blue[300],
                      fontSize: 16,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
              ],
              ),
              SizedBox(height:10),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(width: 20),
                  Text(
                    'Title', 
                    style: TextStyle(
                      color: Colors.grey[100],
                      decoration: TextDecoration.underline,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height:10),
              Container(
                height: 60,
                width: MediaQuery.of(context).size.width * 0.9,
                child: Center(
                  child: Text(
                    widget.studyjio.title, 
                    style: TextStyle(color: Colors.grey[100]),
                  ),
                ),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey[600],
                    ),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(width: 20),
                  Text(
                    'Description', 
                    style: TextStyle(
                      color: Colors.grey[100],
                      decoration: TextDecoration.underline,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height:10),
              Container(
                height: 90,
                width: MediaQuery.of(context).size.width * 0.9,
                child: Center(
                  child: Text(
                    widget.studyjio.description, 
                    style: TextStyle(color: Colors.grey[100]),
                  ),
                ),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey[600],
                    ),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(width: 20),
                  Text(
                    'Module(s)', 
                    style: TextStyle(
                      color: Colors.grey[100],
                      decoration: TextDecoration.underline,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height:10),
              Container(
                height: 50,
                width: MediaQuery.of(context).size.width * 0.9,
                child: Center(
                  child: Text(
                    widget.studyjio.modules, 
                    style: TextStyle(color: Colors.grey[100]),
                  ),
                ),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey[600],
                    ),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(width: 20),
                  Text(
                    'Date', 
                    style: TextStyle(
                      color: Colors.grey[100],
                      decoration: TextDecoration.underline,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height:10),
              Container(
                height: 30,
                width: MediaQuery.of(context).size.width * 0.9,
                child: Center(
                  child: Text(
                    widget.studyjio.date, 
                    style: TextStyle(color: Colors.grey[100]),
                  ),
                ),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey[600],
                    ),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(width: 20),
                  Text(
                    'Start Time', 
                    style: TextStyle(
                      color: Colors.grey[100],
                      decoration: TextDecoration.underline,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height:10),
              Container(
                height: 30,
                width: MediaQuery.of(context).size.width * 0.9,
                child: Center(
                  child: Text(
                    widget.studyjio.startTime, 
                    style: TextStyle(color: Colors.grey[100]),
                    ),
                ),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey[600],
                    ),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(width: 20),
                  Text(
                    'End Time', 
                    style: TextStyle(
                      color: Colors.grey[100],
                      decoration: TextDecoration.underline,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height:10),
              Container(
                height: 30,
                width: MediaQuery.of(context).size.width * 0.9,
                child: Center(
                  child: Text(
                    widget.studyjio.endTime, 
                    style: TextStyle(color: Colors.grey[100]),
                  ),
                ),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey[600],
                    ),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(width: 20),
                  Text(
                    'Capacity', 
                    style: TextStyle(
                      color: Colors.grey[100],
                      decoration: TextDecoration.underline,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height:10),
              Container(
                height: 20,
                width: MediaQuery.of(context).size.width * 0.9,
                child: Center(
                  child: Text(
                    widget.studyjio.capacity.toString(), 
                    style: TextStyle(color: Colors.grey[100]),
                  ),
                ),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey[600],
                    ),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(width: 20),
                  Text(
                    'Location', 
                    style: TextStyle(
                      color: Colors.grey[100],
                      decoration: TextDecoration.underline,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height:10),
              Container(
                height: 30,
                width: MediaQuery.of(context).size.width * 0.9,
                child: Center(
                  child: Text(
                    widget.studyjio.location, 
                    style: TextStyle(color: Colors.grey[100]),
                  ),
                ),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey[600],
                    ),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(width: 20),
                  Text(
                    'Users Joined', 
                    style: TextStyle(
                      color: Colors.grey[100],
                      decoration: TextDecoration.underline,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height:10),
              Container(
                height: 50,
                width: MediaQuery.of(context).size.width * 0.9,
                child: Center(
                  child: Text('hi'),
                  // child: widget.studyjio.joinedUsers.values.where((e)=> e as bool)
                  // .for(

                  //   (element) => FutureBuilder(
                  //   future:
                  //   { })
                  // child: FutureBuilder(
                  //   future: Firestore.instance.collection('users').document(widget.studyjio.ownerId).get(),
                  //   builder: (context, snapshot) {
                  //     return Text(
                  //       widget.studyjio.username,
                  //       style: TextStyle(color: Colors.grey[100]),
                  //     );
                  //   }
                    //widget.studyjio.joinedUsers.keys.forEach((k) => Text('{$k},')), 
                    //widget.studyjio.joinedUsers.keys.toString(),
                    //widget.studyjio.joinedUsers.values.where((e)=> e as bool).length
                  // ),
                ),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey[600],
                    ),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
              ),
            ],
          ),
        ),  
    );
  }
}