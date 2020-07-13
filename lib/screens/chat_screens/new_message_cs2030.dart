import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class NewMessageCS2030 extends StatefulWidget {
  @override
  _NewMessageStateCS2030 createState() => _NewMessageStateCS2030();
}

class _NewMessageStateCS2030 extends State<NewMessageCS2030> {
  final _controller = new TextEditingController();
  var _enteredMessage = '';

  void _sendMessage() async {
    FocusScope.of(context).unfocus();
    final user = await FirebaseAuth.instance.currentUser();
    final userData = await Firestore.instance.collection('users').document(user.uid).get();
    Firestore.instance.collection('cs2030chat').add({
      'text': _enteredMessage,
      'createdAt': Timestamp.now(),
      'userId': user.uid,
      'username': userData['username'],
    });
    _controller.clear();
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8),
      padding: EdgeInsets.all(8),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
             style: TextStyle(color: Colors.grey[100]),
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Send a message...',
                labelStyle: TextStyle(color: Colors.grey[100]),
              ),
              onChanged: (value) {
                setState(() {
                  _enteredMessage = value;
                });
              },
            ),
          ),
          IconButton(
            color: Theme.of(context).primaryColor,
            icon: Icon(
              Icons.send,
            ),
            onPressed: _enteredMessage.trim().isEmpty 
              ? null
              : _sendMessage,
          ),
        ],
      ),
    );
  }
}