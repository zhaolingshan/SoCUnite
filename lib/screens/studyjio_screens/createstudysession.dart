import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appTitle = "New Study-jio";
    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        appBar: AppBar(
          title: Text(appTitle),
        ),
        body: CreateStudySession(),
      ),
    );
  }
}

class CreateStudySession extends StatefulWidget {
  @override 
  _CreateStudySessionState createState() => _CreateStudySessionState();
}

class _CreateStudySessionState extends State<CreateStudySession> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            
            validator: (value) {
              if (value.isEmpty) {
                return 'Please come up with a title';
              }
              return null;
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 16.0),
            child: RaisedButton(
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  Scaffold.of(context)
                    .showSnackBar(SnackBar(content: Text("Creating your study session...")));                
                }
              },
              child: Text("Confirm", style: TextStyle(color: Colors.white,
                  fontWeight: FontWeight.bold, fontSize: 15,)
              ),
              color: Colors.red[900],
            ),
          ),
        ],
      ),
    ),
    );    
  }
}