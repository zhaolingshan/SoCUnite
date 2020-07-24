import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MessageBubble extends StatelessWidget {
  MessageBubble(
    this.message, 
    this.userName,
    this.userImage,
    this.userId,
    this.isMe,
    {this.key}
  );

  final String userId;
  final String userImage;
  final Key key;
  final String message;
  final String userName;
  final bool isMe; // am i the sender of the message

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Row(
        mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: isMe ? Colors.grey[300] : Theme.of(context).accentColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
                bottomLeft: !isMe ? Radius.circular(0) : Radius.circular(12),
                bottomRight: isMe ? Radius.circular(0) : Radius.circular(12),
              ),
            ),
            width: 140,
            padding: EdgeInsets.symmetric(
              vertical: 10, 
              horizontal: 16,
            ),
            margin: EdgeInsets.symmetric(
              vertical: 16,
              horizontal: 8,
            ),
            child: Column(
              crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: <Widget>[
                FutureBuilder( 
                future: Firestore.instance.collection('users').document(userId).get(),
                builder: (context, snapshot) {
                  if (snapshot.data != null) {
                    return Text(
                      snapshot.data['username'], 
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: isMe ? Colors.black : Colors.grey[100],
                      ),
                    );
                  } else {
                    return CircularProgressIndicator();
                  }           
                }, 
              ), 
                Text(
                  message, 
                  style: TextStyle(
                    color: isMe ? Colors.black : Theme.of(context).accentTextTheme.headline6.color,
                  ),
                  textAlign: isMe ? TextAlign.end : TextAlign.start,
                ),
              ],
            ),
          ),
        ],
      ),
      Positioned(
        top: 0,
        left: isMe ? null : 120,
        right: isMe? 120 : null,
        child: FutureBuilder( 
                future: Firestore.instance.collection('users').document(userId).get(),
                builder: (context, snapshot) {
                  if (snapshot.data != null) {
                    if (snapshot.data['profilepicURL'] != null) {
                      return CircleAvatar(
                        radius: 25,
                        backgroundImage: NetworkImage(snapshot.data['profilepicURL'])
                      );
                    } else {
                      return CircleAvatar(
                        radius: 25,
                        backgroundImage: NetworkImage('https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png')
                      );
                    }
                  } else {
                    return CircleAvatar(
                      radius: 25,
                      backgroundColor: Colors.grey,
                    );
                  }
                } 
              ),
      ),     
    ],
    overflow: Overflow.visible,
  );    
  }
}