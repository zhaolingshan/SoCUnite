import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:SoCUniteTwo/widgets/chat/message_bubble.dart';
import 'package:SoCUniteTwo/providers/chat.dart';
import 'package:SoCUniteTwo/screens/chat_screens/chat_detail_screen.dart';



class PublicChatScreen extends StatefulWidget {
  final Chat publicChat;

  PublicChatScreen({Key key, @required this.publicChat}) : super(key: key);
  @override
  _PublicChatScreenState createState() => _PublicChatScreenState();
}

class _PublicChatScreenState extends State<PublicChatScreen> {

  final _controller = new TextEditingController();
  var _enteredMessage = '';

  void _sendMessage() async {
    FocusScope.of(context).unfocus();
    final user = await FirebaseAuth.instance.currentUser();
    final userData = await Firestore.instance.collection('users').document(user.uid).get();
    Firestore.instance.collection('public_chats').
    document(widget.publicChat.documentId)
    .collection(widget.publicChat.title)
    .add({
      'text': _enteredMessage,
      'createdAt': Timestamp.now(),
      'userId': user.uid,
      'username': userData['username'],
      'userImage': userData['profilepicURL'],
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
        title: Text(widget.publicChat.title),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.more_horiz, color: Colors.tealAccent,),
            onPressed: () {
              Navigator.push(
                  context, 
                  MaterialPageRoute(
                    builder: (context) => ChatDetailScreen(chat: widget.publicChat,)
                  )
              ); 
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
                .collection('public_chats')
                .document(widget.publicChat.documentId)
                .collection(widget.publicChat.title)
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
                      chatDocs[index]['userImage'],
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


