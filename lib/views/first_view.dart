import 'package:flutter/material.dart';

class FirstView extends StatelessWidget {
  final primaryColor = Colors.grey[900];
  
  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        width: _width,
        height: _height,
        color: primaryColor,
        child: SafeArea(
          child: Column(
            children: <Widget>[
              SizedBox(height: _height * 0.07),
              Text("Welcome",
              style: TextStyle(fontSize: 48, color: Colors.tealAccent,fontWeight: FontWeight.bold)),
              Text("to SoCUnite!",
              maxLines: 1,
              textAlign: TextAlign.center,
               style: TextStyle(fontSize: 48, color: Colors.white,
               fontWeight: FontWeight.bold)),
               SizedBox(height: _height * 0.2),
               RaisedButton(
                 onPressed: () {
                   Navigator.of(context).pushReplacementNamed('/signIn');
                 },
                 color: Colors.white,
                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                 child: Padding(
                  padding: const EdgeInsets.only(top: 20.0, bottom: 20.0, left: 100, right: 100),
                  child: Text("Login", style: TextStyle(color: Colors.black,
                              fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
              ),
              SizedBox(height: _height * 0.05),
              RaisedButton(
                 onPressed: () {
                   Navigator.of(context).pushReplacementNamed('/signUp');
                 },
                 color: Colors.blue[300],
                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                 child: Padding(
                  padding: const EdgeInsets.only(top: 20.0, bottom: 20.0, left: 90, right: 90),
                  child: Text("Sign Up", style: TextStyle(color: Colors.black,
                              fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
              ),
            ],
          )
        )
      )
      
    );
  }
}