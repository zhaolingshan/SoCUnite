import 'package:flutter/material.dart';
import 'package:SoCUniteTwo/screens/forum_screens/new2030_feedbacks.dart';
import 'package:SoCUniteTwo/screens/forum_screens/post_feedback.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:SoCUniteTwo/widgets/provider_widget.dart';
import 'package:SoCUniteTwo/screens/forum_screens/details/feedback_details.dart';


class CS2030feedback extends StatefulWidget {
  @override
  _CS2030feedbackState createState() => _CS2030feedbackState();
}

class _CS2030feedbackState extends State<CS2030feedback> {
  final DateTime timeStamp = DateTime.now();
  String profilePicture;
  String username;
  
  @override
  Widget build(BuildContext context) {

    Provider.of(context).auth.getCurrentUser().then((user) {
      setState(() {
        profilePicture = user.photoUrl;
        username = user.displayName;
      });
    }).catchError((e) {
        print(e);
    });

    final post = new PostFeedback(null,null,null,null,null,null,null,null,null,null,null,null,null,null);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[850],
        title: Text("CS2030 - Feedbacks"),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.add, color: Colors.tealAccent),
            onPressed: () {
              Navigator.push(context, 
              MaterialPageRoute(builder: (context) => New2030feedbacks(post: post)));
            },
          )
        ],
      ),
      backgroundColor: Colors.grey[900],
      body: Container(
        child: StreamBuilder(
          stream: getUserFeedbacksStreamSnapshot(context),
          builder: (context, snapshot) {
            if(!snapshot.hasData) return 
            Center(child: 
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
              CircularProgressIndicator()
            ],));  
            return new ListView.builder(
          itemCount: snapshot.data.documents.length,
          itemBuilder: (BuildContext context, int index) 
          => buildFeedbacks(context, 
          snapshot.data.documents[index])
          );
          } 
        )
        ),
    );
  }

  Stream<QuerySnapshot> getUserFeedbacksStreamSnapshot(BuildContext context) async* {
    //final uid = await Provider.of(context).auth.getCurrentUID();
    yield* Firestore.instance.collection('public').document('CS2030').collection('Feedbacks').snapshots();
  }
  

  Widget buildFeedbacks(BuildContext context, DocumentSnapshot feedback) {
    final post = PostFeedback.fromSnapshot(feedback);
    return Container(
              child: Card(
                color: Colors.grey[850],
                shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(18.0)),
                child: InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
              builder: (context) => FeedbackDetails(feedback: post) //stateful widget
            ));
                  },
                child: Column(
                  children: <Widget>[
                    Padding( 
                    padding: EdgeInsets.only(top: 4, bottom: 8),
                    child:
                    Row(children: <Widget>[
                      SizedBox(width: 10,),
                      Text('Uploaded on ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,
                      color: Colors.grey[400]),),
                      Text(feedback['timestamp'], style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,
                      color: Colors.grey[400]),),
                      Spacer(),
                    ],),),
                     SizedBox(height: 10),
                    Row(children: <Widget>[
                      SizedBox(width: 10,),
                      CircleAvatar(
                      backgroundImage: feedback['profilePicture'] != null ?
                      NetworkImage(feedback['profilePicture']) : 
                      NetworkImage('https://genslerzudansdentistry.com/wp-content/uploads/2015/11/anonymous-user.png'),
                      backgroundColor: Colors.grey,
                      radius: 20,),
                      SizedBox(width: 10,),
                      Text(feedback['username'], style: TextStyle(fontWeight: FontWeight.bold,
                      fontSize: 16, decoration: TextDecoration.underline, color: Colors.grey[100]),        
                    )],),
                    SizedBox(height: 10),
                    Padding( 
                    padding: EdgeInsets.only(top: 4, bottom: 8),
                    child:
                    Row(children: <Widget>[
                      SizedBox(width: 10,),
                      Text("Year taken: ", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey[100],)),
                      Text(feedback['yearTaken'], style: TextStyle(fontSize: 16, color: Colors.grey[100]),),
                      Spacer(),
                    ]),),
                    Padding( 
                    padding: EdgeInsets.only(top: 4, bottom: 8),
                    child:
                    Row(children: <Widget>[
                      SizedBox(width: 10,),
                      Text('Taken under: ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey[100])),
                     Text(feedback['professor'], style: TextStyle(fontSize: 16, color: Colors.grey[100]),),
                    ],),),
                    Padding( 
                    padding: EdgeInsets.only(top: 4, bottom: 8),
                    child:
                    Row(children: <Widget>[
                      SizedBox(width: 10,),
                      Text('Expected grade: ', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.grey[100],)),
                      Text(feedback['expectedGrade'], style: TextStyle(fontSize: 16, color: Colors.grey[100]),),
                    ],),),
                    Padding( 
                    padding: EdgeInsets.only(top: 4, bottom: 8),
                    child:
                    Row(children: <Widget>[
                      SizedBox(width: 10,),
                      Text('Actual grade: ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey[100]),),
                      Text(feedback['actualGrade'], style: TextStyle(fontSize: 16, color: Colors.grey[100]),),
                    ],),),
                    Padding( 
                    padding: EdgeInsets.only(top: 4, bottom: 8),
                    child:
                    Row(children: <Widget>[
                      SizedBox(width: 10,),
                      Text('Difficulty (/10): ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey[100]),),
                      Text(feedback['difficulty'], style: TextStyle(fontSize: 16, color: Colors.grey[100]),),
                    ],),),
                    Padding( 
                    padding: EdgeInsets.only(top: 4, bottom: 8),
                    child:
                    Row(children: <Widget>[
                      SizedBox(width: 10,),
                      Text('Early preparation tips: ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey[100]),),
                      Expanded(child:
                      Text(feedback['preparationTips'], style: TextStyle(fontSize: 16, color: Colors.grey[100]),
                      overflow: TextOverflow.ellipsis, maxLines: 1,),), 
                    ],),),
                    Padding( 
                    padding: EdgeInsets.only(top: 4, bottom: 8),
                    child:
                    Row(children: <Widget>[
                      SizedBox(width: 10,),
                      Text('Feedback: ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey[100]),),
                      Expanded(child:
                      Text(feedback['content'], style: TextStyle(fontSize: 16, color: Colors.grey[100]), overflow: TextOverflow.ellipsis,
                      maxLines: 1,)),
                    ],),),
                    SizedBox(height: 20),
                    Row(children: <Widget>[
                      SizedBox(width: 10,),
                      Icon(Icons.comment, size: 26, color: Colors.tealAccent), 
                      SizedBox(width: 6,),Text('0', style: TextStyle(color: Colors.grey[100]),), 
                      Spacer(),
                      Icon(Icons.thumb_up, size: 26, color: Colors.tealAccent),
                      SizedBox(width: 6,),
                      Text(feedback['upvotes'].values.where((e)=> e as bool).length.toString(), style: TextStyle(color: Colors.grey[100]),),
                      SizedBox(width: 10,)
                    ],)
                  ],
                ),
              ),
    ),);          
  }


}