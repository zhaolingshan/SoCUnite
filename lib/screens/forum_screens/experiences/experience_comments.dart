import 'package:SoCUniteTwo/screens/forum_screens/experiences/experience.dart';
import 'package:flutter/material.dart';
import 'package:SoCUniteTwo/screens/forum_screens/details/comments.dart';
import 'package:SoCUniteTwo/widgets/provider_widget.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ExperienceComment extends StatefulWidget {
  final Comments comment;
  final Experience post; //needs to have document id 
  ExperienceComment({Key key, @required this.comment, @required this.post}) : super(key: key);

  @override
  _ExperienceCommentState createState() => _ExperienceCommentState();
}

class _ExperienceCommentState extends State<ExperienceComment> {
  String profilePicture;
  String username;

  @override
  Widget build(BuildContext context) {
    TextEditingController _commentController = new TextEditingController();
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: Text("Post a comment"),
        backgroundColor: Colors.grey[850],),
      body:
        Container(
          height: MediaQuery.of(context).size.height * .60,
          child: Padding(
            padding: EdgeInsets.only(left: 15.0, top: 15.0),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text("Post your comment", style: TextStyle(color: Colors.grey[100]),),
                    Spacer(),
                  SizedBox(width: 20,)
                  ],
                ),
                SizedBox(height: 20,),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 15.0),
                        child: TextFormField(
                          style: TextStyle(color: Colors.grey[100]),
                          cursorColor: Colors.tealAccent,
                          controller: _commentController,
                          decoration: InputDecoration(
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.tealAccent,
                              ),),
                            enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey[800])),
                            helperStyle: TextStyle(color: Colors.grey[100]),
                            helperText: "Enter your comment...",
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    RaisedButton(
                      onPressed: () async { //upload comment to firebase
                      await Provider.of(context).auth.getCurrentUser().then((user) {
                      setState(() {
                      profilePicture = user.photoUrl;
                      username = user.displayName;
                      });
                      }).catchError((e) {
                      print(e);
                      });

                      final uid = await Provider.of(context).auth.getCurrentUID();

                      widget.comment.content = _commentController.text;
                      widget.comment.timestamp = DateFormat.yMd().add_jm()
                      .format(DateTime.now()).toString();
                      widget.comment.username = username;
                      widget.comment.profilePicture = profilePicture;
                      widget.comment.ownerid = uid;
                      widget.comment.upvotes = {uid: false};  
                      widget.comment.reported = {uid: false};    

                      final DocumentReference documentReference = 
                      await Firestore.instance.collection("public").document('internship_experiences')
                      .collection('Experiences').document(widget.post.documentid)
                      .collection('comments').add({
                        'content': widget.comment.content,
                        'timestamp': widget.comment.timestamp,
                        'username': widget.comment.username,
                        'profilePicture': widget.comment.profilePicture,
                        'upvotes': widget.comment.upvotes,
                        'ownerid': uid,
                        'documentid': '',
                        'reported': widget.post.reported,
                      }
                      );

                      final String documentid = documentReference.documentID;
                     widget.comment.documentid = documentid;

                     await Firestore.instance.collection('public').document('internship_experiences').collection('Experiences')
                     .document(widget.post.documentid).collection('comments').document(widget.comment.documentid).updateData({
                       'documentid': documentid,
                     });
                      
                      Navigator.of(context).pop();
                      
                      },
                      color: Colors.blue[300],
                      shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)),
                      child: Padding(
                        padding: EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
                      child: Text("Post", style: TextStyle(color: Colors.white,
                      fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),);
  }
}