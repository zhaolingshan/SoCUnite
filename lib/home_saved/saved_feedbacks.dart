import 'package:flutter/material.dart';
import 'package:SoCUniteTwo/widgets/provider_widget.dart';
import 'package:SoCUniteTwo/screens/forum_screens/post_feedback.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:SoCUniteTwo/screens/forum_screens/details/feedback_details.dart';


class SavedFeedbacks extends StatefulWidget {
  @override
  _SavedFeedbacksState createState() => _SavedFeedbacksState();
}

class _SavedFeedbacksState extends State<SavedFeedbacks> {
  String profilePicture;
  String username;
  var timeStamp = new DateTime.now();

  getUID() async {
    return await Provider.of(context).auth.getCurrentUID();
  }

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

    //final post = new Post(null,null,null,null,null,null,null,null,null); //to appear in CS2030 forum
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[850],
        title: Text("Saved Feedbacks"),
      ),
      backgroundColor: Colors.grey[900],
      body: Container(
        child: StreamBuilder(
          stream: getUsersFeedbacksPostsSnapshot(context),
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
          itemBuilder: (BuildContext context, int index) 
          => buildFeedbacks(context, snapshot.data.documents[index]),
          itemCount: snapshot.data.documents.length,
        );
          }
        ),
      ) ,
     
    );
  }

  Stream<QuerySnapshot> getUsersFeedbacksPostsSnapshot(BuildContext context) async* {
    final uid = await Provider.of(context).auth.getCurrentUID();
    yield* Firestore.instance.collection('users')
    .document(uid).collection('saved_feedbacks').snapshots();
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
                        FutureBuilder(
                        future: getUID(), //returns uid
                        builder: (context, AsyncSnapshot snapshot) {
                          if (snapshot.data == feedback['ownerid']) {
                            return  IconButton(
                              iconSize: 30,
                              color: Colors.purpleAccent,
                              icon: Icon(Icons.delete_forever),
                              onPressed: () async {
                                final uid = await Provider.of(context).auth.getCurrentUID();

                        await Firestore.instance.collection('users').document(uid)
                        .collection('private_feedbacks').document(feedback.documentID).delete();

                        await Firestore.instance.collection('public').document('CS2030')
                        .collection('Feedbacks').document(feedback.documentID).delete();

                        await Firestore.instance.collection('users').getDocuments().then((querySnapshot){
                        querySnapshot.documents.forEach((result) { //result is each uid 
                        Firestore.instance.collection('users').document(result.documentID)
                        .collection('saved_feedbacks').getDocuments().then((querySnapshot) {
                        querySnapshot.documents.forEach((element) { //each element is each saved forum
                        if(element.documentID == feedback.documentID) {
                        Firestore.instance.collection('users').document(result.documentID)
                        .collection('saved_feedbacks').document(element.documentID).delete();
                                  }
                                });
                                });
                                });
                                });
                              }
                            );
                          }
                          else {
                          return Container();
                         }
                        },
                      ) 

                    ],),),
                     SizedBox(height: 10),
                    Row(children: <Widget>[
                      SizedBox(width: 10,),
                      FutureBuilder( 
                future: Firestore.instance.collection('users').document(feedback['ownerid']).get(),
                builder: (context, snapshot) {
                  if(snapshot.data != null) {
                    if (snapshot.data['profilepicURL'] != null) {
                      return CircleAvatar(
                        radius: 20,
                        backgroundImage: NetworkImage(snapshot.data['profilepicURL'])
                      );
                    } else {
                      return CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.grey,
                        backgroundImage: NetworkImage('https://genslerzudansdentistry.com/wp-content/uploads/2015/11/anonymous-user.png'),
                      );
                    }           
                  } else {
                    return CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.grey,
                      );
                  } 
                }),    
                      // CircleAvatar(
                      // backgroundImage: feedback['profilePicture'] != null ?
                      // NetworkImage(feedback['profilePicture']) : 
                      // NetworkImage('https://genslerzudansdentistry.com/wp-content/uploads/2015/11/anonymous-user.png'),
                      // backgroundColor: Colors.grey,
                      // radius: 20,),
                      SizedBox(width: 10,),
                      FutureBuilder( 
                future: Firestore.instance.collection('users').document(feedback['ownerid']).get(),
                builder: (context, snapshot) {
                  if (snapshot.data != null) {
                    return Text(snapshot.data['username'], style: TextStyle(fontWeight: FontWeight.bold,
                      fontSize: 16, decoration: TextDecoration.underline, color: Colors.grey[100]),
                    );
                  } else {
                    return CircularProgressIndicator();
                  }           
                }, 
              ),              
                    //   Text(feedback['username'], style: TextStyle(fontWeight: FontWeight.bold,
                    //   fontSize: 16, decoration: TextDecoration.underline, color: Colors.grey[100]),        
                    // )
                    ],),
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
                      // SizedBox(width: 10,),
                      // Icon(Icons.comment, size: 26, color: Colors.tealAccent), 
                      // SizedBox(width: 6,),Text('0', style: TextStyle(color: Colors.grey[100]),), 
                      Spacer(),
                      Icon(Icons.thumb_up, size: 26, color: Colors.tealAccent),
                      SizedBox(width: 6,),
                      Text(feedback['upvotes'].values.where((e)=> e as bool).length.toString(), style: TextStyle(color: Colors.grey[100]),),
                    SizedBox(width: 10,),],)
                  ],
                ),
              ),
    ),);          
  }


}