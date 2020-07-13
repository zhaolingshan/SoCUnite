import 'package:flutter/material.dart';

class Study extends StatefulWidget {
  @override
  _StudyState createState() => _StudyState();
}

class _StudyState extends State<Study> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Study-Jio!"),
        backgroundColor: Colors.grey[850],
      ),
    body: Center(child: Text("Study-jio"),
    
    ),
    );
  }
}