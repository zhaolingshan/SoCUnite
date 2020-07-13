import 'package:SoCUniteTwo/screens/chat_screens/cs2040s_chat_screen.dart';
import 'package:flutter/material.dart';

class JoinStudyjio extends StatefulWidget {
  @override
  _JoinStudyjioState createState() => _JoinStudyjioState();
}

class _JoinStudyjioState extends State<JoinStudyjio> {
  bool _isJoined = false;

  void _toggleJoinButton() {
    setState(() {
      if (_isJoined) { // user already joined, now displays an option to leave
        _isJoined = false;
      } else { // adds user to chat room
        _isJoined= true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: RaisedButton(
        child: _isJoined
          ? Text(
            'Leave',
            style: TextStyle(color: Colors.grey[100]),
          )
          : Text(
            'JOIN',
          ),
        color: _isJoined
            ? Colors.grey[700]
            : Colors.tealAccent,
        onPressed: () {
          if (!_isJoined) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CS2040SChatScreen())
            );
          }
           _toggleJoinButton();
           
        },
      ),
    );
  }
}