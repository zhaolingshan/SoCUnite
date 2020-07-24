import 'package:SoCUniteTwo/providers/studyjio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:SoCUniteTwo/widgets/chat/message_bubble.dart';
import 'package:SoCUniteTwo/widgets/provider_widget.dart';

class StudyjioChatScreen extends StatefulWidget {
  //final StudyjioChat studyjioChat;
  //final StudyjioChat chat;
  final Studyjio studyjio;
  //static String title;
  StudyjioChatScreen({Key key, @required this.studyjio}) : super(key: key);

  @override
  _StudyjioChatScreenState createState() => _StudyjioChatScreenState();
}

class _StudyjioChatScreenState extends State<StudyjioChatScreen> {

  final _controller = new TextEditingController();
  var _enteredMessage = '';

  void _sendMessage() async {
    FocusScope.of(context).unfocus();
    final user = await FirebaseAuth.instance.currentUser();
    final userData = await Firestore.instance.collection('users').document(user.uid).get();

    final uid = await Provider.of(context).auth.getCurrentUID();
    Map<String, dynamic> joinedUsers = {};

    var result = await Firestore.instance.collection('browse_jios')
    .where("title", isEqualTo: widget.studyjio.title)
    .getDocuments();
    result.documents.forEach((res) { 
        joinedUsers = res.data['joinedUsers']; // usernames
    });

    joinedUsers.forEach((username, value) async {
      if (value == true) { // all users in the studyjio
        await Firestore.instance.collection('users').getDocuments().then((querySnapshot) {
          querySnapshot.documents.forEach((user) async {
            if (user.data['username'] == username && user.documentID != uid) {
              Firestore.instance.collection('users').document(user.documentID)
              .collection('my_studyjios_chats').document(widget.studyjio.title)
              .collection(widget.studyjio.title)
              .add({
                'text': _enteredMessage,
                'createdAt': Timestamp.now(),
                'userId': uid,
                'username': userData['username'],
              });
            }
          });
        });
      }
    });

    Firestore.instance.collection('users').document(user.uid)
    .collection('my_studyjios_chats')
    .document(widget.studyjio.title)
    .collection(widget.studyjio.title)
    .add({
      'text': _enteredMessage,
      'createdAt': Timestamp.now(),
      'userId': user.uid,
      'username': userData['username'],
    });
    _controller.clear();
  }

  // _updateChat() async {
  //   final uid = await Provider.of(context).auth.getCurrentUID();
  //   Map<String, dynamic> joinedUsers = {};

  //   var result = await Firestore.instance.collection('browse_jios')
  //   .where("title", isEqualTo: widget.studyjio.title)
  //   .getDocuments();
  //   result.documents.forEach((res) { 
  //       joinedUsers = res.data['joinedUsers']; // usernames
  //   });
    
  //     joinedUsers.forEach((username, value) async {
  //       if (value == true) { // all users in the studyjio
  //         await Firestore.instance.collection('users').getDocuments().then((querySnapshot) {
  //           querySnapshot.documents.forEach((user) async {

  //             if (user.data['username'] == username && user.documentID != uid) { // for all joined users
                // Firestore.instance.collection('users').document(user.documentID)
                // .collection('my_studyjios_chats').document(widget.studyjio.title)
                // .collection(widget.studyjio.title).snapshots()
                // .listen((message) { // list of messages from other users
                //   message.documentChanges.forEach((msg) async { // for each message
                // var otherUsersMsgs = await Firestore.instance.collection('users').document(user.documentID)
                // .collection('my_studyjios_chats').document(widget.studyjio.title)
                // .collection(widget.studyjio.title).getDocuments();
                
                // var myMsgs = await Firestore.instance.collection('users').document(uid)
                // .collection('my_studyjios_chats').document(widget.studyjio.title)
                // .collection(widget.studyjio.title).getDocuments();

                // myMsgs.documents.forEach((mine) async { 
                //   otherUsersMsgs.documents.forEach((other) async { 
                //     // if (mine.data['createdAt'] != other.data['createdAt'] 
                //     // && mine.data['text'] != other.data['text'] 
                //     // && mine.data['userId'] != other.data['userId']) {
                //     if (mine.data != other.data) {

                //       await Firestore.instance.collection('users').document(uid)
                //       .collection('my_studyjios_chats').document(widget.studyjio.title)
                //       .collection(widget.studyjio.title).add(other.data);
                //       print('updated chat when someone sends a msg');
                //     }
                // });

                    //   if (doc.data['createdAt'] != msg.data['createdAt'] 
                    //   && doc.data['text'] != msg.data['text'] 
                    //   && doc.data['userId'] != msg.data['userId']) {

                    //     await Firestore.instance.collection('users').document(uid)
                    //     .collection('my_studyjios_chats').document(widget.studyjio.title)
                    //     .collection(widget.studyjio.title).add(doc.data);
                    //     print('updated chat when someone sends a msg');
                    //   }
                    // });
                    
                    //     if (doc.data['createdAt'] != msg.document.data['createdAt'] 
                    //     && doc.data['text'] != msg.document.data['text'] 
                    //     && doc.data['userId'] != msg.document.data['userId']) {
                          
                    //       if (msg.type == DocumentChangeType.added) {
                            
                    //     await Firestore.instance.collection('users').document(uid)
                    //     .collection('my_studyjios_chats').document(widget.studyjio.title)
                    //     .collection(widget.studyjio.title).add(msg.document.data);
                    //     print('updated chat when someone sends a msg');
                    //   }
                    // }                    
  //                 });
  //           }
  //           });          
  //         });                    
  //       }
  //     });
  // }

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
    //await _updateChat();
  }

  // @override
  // void didChangeDependencies() {
  //   //_updateChat();
  //   super.didChangeDependencies();
  // }

  @override
  Widget build(BuildContext context) {    
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        backgroundColor: Colors.grey[850],
        title: Text(widget.studyjio.title),
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
                .collection('my_studyjios_chats')
                .document(widget.studyjio.title)
                .collection(widget.studyjio.title)
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


