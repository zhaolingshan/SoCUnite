import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:SoCUniteTwo/widgets/chat/message_bubble.dart';
import 'package:SoCUniteTwo/providers/module.dart';
//import 'package:SoCUniteTwo/widgets/provider_widget.dart';

class ModuleChatScreen extends StatefulWidget {

  final Module module;
  ModuleChatScreen({Key key, @required this.module}) : super(key: key);

  @override
  _ModuleChatScreenState createState() => _ModuleChatScreenState();
}

class _ModuleChatScreenState extends State<ModuleChatScreen> {

  final _controller = new TextEditingController();
  var _enteredMessage = '';

  void _sendMessage() async {
    //final uid = await Provider.of(context).auth.getCurrentUID();
    FocusScope.of(context).unfocus();
    final user = await FirebaseAuth.instance.currentUser();
    final userData = await Firestore.instance.collection('users').document(user.uid).get();

    Firestore.instance.collection(widget.module.code)
    .add({
      'text': _enteredMessage,
      'createdAt': Timestamp.now(),
      'userId': user.uid,
      'username': userData['username'],
    }); // add to public collection

    await Firestore.instance.collection('users').getDocuments().then((querySnapshot) {
      querySnapshot.documents.forEach((otherUserUid) async {
          await Firestore.instance.collection('users').document(otherUserUid.documentID)
          .collection('my_modules_chats').getDocuments().then((querySnapshot) {
            querySnapshot.documents.forEach((mod) { 
              if (mod.documentID == widget.module.code) {
                Firestore.instance.collection('users').document(otherUserUid.documentID)
                .collection('my_modules_chats').document(widget.module.code)
                .collection(widget.module.code)
                .add({
                  'text': _enteredMessage,
                  'createdAt': Timestamp.now(),
                  'userId': user.uid,
                  'username': userData['username'],
                });
              }
            });
          });
      });
    });

    _controller.clear();
  }

  @override
  void initState() {
    final fbm = FirebaseMessaging();
    fbm.requestNotificationPermissions();
    fbm.configure(onMessage: (msg) {
      print(msg);
      return;
    }, onLaunch: (msg) {
      print(msg);
      return;
    }, onResume: (msg) {
      print(msg);
      return;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        backgroundColor: Colors.grey[850],
        title: Text(widget.module.code),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.more_horiz, color: Colors.tealAccent,),
            onPressed: () {
              // details: members, media
            },
          ),
        ],
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Expanded(
              child: FutureBuilder(
              future: FirebaseAuth.instance.currentUser(),
              builder: (ctx, futureSnapshot) {
                if (futureSnapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return StreamBuilder(
                stream: Firestore.instance
                .collection('users').document(futureSnapshot.data.uid)
                .collection('my_modules_chats')
                .document(widget.module.code)
                .collection(widget.module.code)
                .orderBy(
                  'createdAt', 
                  descending: true
                )
                .snapshots(),
                builder: (ctx, chatSnapshot) {
                  if (chatSnapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  final chatDocs = chatSnapshot.data.documents;
                  return ListView.builder(
                    reverse: true, // order of messages
                    itemCount: chatDocs.length,
                    itemBuilder: (ctx, index) => MessageBubble(
                      chatDocs[index]['text'],
                      chatDocs[index]['username'],
                      chatDocs[index]['profilepicURL'],
                      chatDocs[index]['userId'],
                      chatDocs[index]['userId'] == futureSnapshot.data.uid,
                      key: ValueKey(chatDocs[index].documentID),
                    ),
                  );
                }
              );
            },
          ),
        ),  
            Container(
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
            ),
         ],
        ),
      )
    );
  }
}


