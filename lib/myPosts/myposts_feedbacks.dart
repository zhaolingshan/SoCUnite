import 'package:SoCUniteTwo/screens/forum_screens/post_feedback.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:SoCUniteTwo/widgets/provider_widget.dart';
import 'package:SoCUniteTwo/screens/forum_screens/details/feedback_details.dart';

class MyPostsFeedbacks extends StatefulWidget {
  @override
  _MyPostsFeedbacksState createState() => _MyPostsFeedbacksState();
}

class _MyPostsFeedbacksState extends State<MyPostsFeedbacks> {
  final DateTime timeStamp = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.of(context).pop();
              },
            );
          },
        ),
        backgroundColor: Colors.grey[850],
        title: Text("My posts: Feedbacks"),
      ),
      body: Container(
        child: StreamBuilder(
          stream: getUserPrivateFeedbacksStreamSnapshot(context),
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
          => buildPrivateFeedbacks(context, 
          snapshot.data.documents[index])
          );
          } 
        )
        ),
    );
  }

  Stream<QuerySnapshot> getUserPrivateFeedbacksStreamSnapshot(BuildContext context) async* {
    final uid = await Provider.of(context).auth.getCurrentUID();
    yield* Firestore.instance.collection('users').document(uid).collection('private_feedbacks').snapshots();
  }

  Widget buildPrivateFeedbacks(BuildContext context, DocumentSnapshot feedback) {
    final post = PostFeedback.fromSnapshot(feedback);
    return Container(
              child: Card(
                color: Colors.grey[850],
                shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(15.0),),
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
                      IconButton(
                      iconSize: 30,
                      color: Colors.lightGreenAccent,
                      icon: Icon(Icons.delete_forever),
                      onPressed: () async {
                        final uid = await Provider.of(context).auth.getCurrentUID();

                        await Firestore.instance.collection('users').document(uid)
                        .collection('private_feedbacks').document(feedback.documentID).delete();

                        await Firestore.instance.collection('public').document('CS2030')
                        .collection('Feedbacks').document(feedback.documentID).delete();
                      },)  
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
                      Text("Year taken: ", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.grey[100]),),
                      Text(feedback['yearTaken'], style: TextStyle(fontSize: 15, color: Colors.grey[100]),),
                      Spacer(),
                    ]),),
                    Padding( 
                    padding: EdgeInsets.only(top: 4, bottom: 8),
                    child:
                    Row(children: <Widget>[
                      SizedBox(width: 10,),
                      Text('Taken under: ', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.grey[100]),),
                     Text(feedback['professor'], style: TextStyle(fontSize: 15, color: Colors.grey[100]),),
                    ],),),
                    Padding( 
                    padding: EdgeInsets.only(top: 4, bottom: 8),
                    child:
                    Row(children: <Widget>[
                      SizedBox(width: 10,),
                      Text('Expected grade: ', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.grey[100]),),
                      Text(feedback['expectedGrade'], style: TextStyle(fontSize: 15, color: Colors.grey[100]),),
                    ],),),
                    Padding( 
                    padding: EdgeInsets.only(top: 4, bottom: 8),
                    child:
                    Row(children: <Widget>[
                      SizedBox(width: 10,),
                      Text('Actual grade: ', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.grey[100]),),
                      Text(feedback['actualGrade'], style: TextStyle(fontSize: 15, color: Colors.grey[100]),),
                    ],),),
                    Padding( 
                    padding: EdgeInsets.only(top: 4, bottom: 8),
                    child:
                    Row(children: <Widget>[
                      SizedBox(width: 10,),
                      Text('Difficulty (/10): ', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.grey[100]),),
                      Text(feedback['difficulty'], style: TextStyle(fontSize: 15, color: Colors.grey[100]),),
                    ],),),
                    Padding( 
                    padding: EdgeInsets.only(top: 4, bottom: 8),
                    child:
                    Row(children: <Widget>[
                      SizedBox(width: 10,),
                      Text('Early preparation tips: ', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold,color: Colors.grey[100] ),),
                      Expanded(child:
                      Text(feedback['preparationTips'], style: TextStyle(fontSize: 15, color: Colors.grey[100]),
                      overflow: TextOverflow.ellipsis, maxLines: 1,),), 
                    ],),),
                    Padding( 
                    padding: EdgeInsets.only(top: 4, bottom: 8),
                    child:
                    Row(children: <Widget>[
                      SizedBox(width: 10,),
                      Text('Feedback: ', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.grey[100]),),
                      Expanded(child:
                      Text(feedback['content'], style: TextStyle(fontSize: 15, color: Colors.grey[100]), overflow: TextOverflow.ellipsis,
                      maxLines: 1,)),
                    ],),),
                    SizedBox(height: 20),
                    Row(children: <Widget>[
                      SizedBox(width: 10,),
                      Icon(Icons.comment, size: 26, color: Colors.tealAccent),
                      SizedBox(height: 6,), Text('0' ,style: TextStyle(color: Colors.grey[100])), 
                      Spacer(),
                      Icon(Icons.thumb_up, size: 26, color: Colors.tealAccent),
                      SizedBox(height: 6,),
                      Text(feedback['upvotes'].values.where((e)=> e as bool).length.toString(),style: TextStyle(color: Colors.grey[100])), 
                    SizedBox(width: 10,),],)
                  ],
                ),
              ),
    ),);          
  }


}