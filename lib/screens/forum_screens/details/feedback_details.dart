import 'package:flutter/material.dart';
import 'package:SoCUniteTwo/screens/forum_screens/post_feedback.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:SoCUniteTwo/screens/forum_screens/details/report.dart';
import 'package:SoCUniteTwo/screens/forum_screens/details/comments.dart';
import 'package:SoCUniteTwo/screens/forum_screens/details/feedback_comment.dart';
import 'package:SoCUniteTwo/screens/forum_screens/upvote_feedbacks.dart';
import 'package:SoCUniteTwo/widgets/provider_widget.dart';


class FeedbackDetails extends StatefulWidget {
  final PostFeedback feedback;
  FeedbackDetails({Key key, @required this.feedback}) : super(key: key);
  @override
  _FeedbackDetailsState createState() => _FeedbackDetailsState();
}

class _FeedbackDetailsState extends State<FeedbackDetails> {

  bool isSaved = false;
  bool isUpvoted = false;
 

  _saved() async {
    final uid = await Provider.of(context).auth.getCurrentUID();
    setState(() {
      isSaved = !isSaved;
    });
    
    if (isSaved) { //if saved 
      Firestore.instance.collection('users').document(uid).collection('saved_feedbacks').
      document(widget.feedback.documentid).setData({
        'yearTaken': widget.feedback.yearTaken,
        'expectedGrade': widget.feedback.expectedGrade,
        'actualGrade': widget.feedback.actualGrade,
        'professor': widget.feedback.professor,
        'difficulty': widget.feedback.difficulty,
        'preparationTips': widget.feedback.preparationTips,
        'content': widget.feedback.content,
        'username': widget.feedback.username,
        'profilePicture' : widget.feedback.profilePicture,
        'timestamp': widget.feedback.timestamp,
        'documentid': widget.feedback.documentid,
        'ownerid': widget.feedback.ownerid,
        'upvotes': widget.feedback.upvotes,
        'saved': widget.feedback.saved,
      });
      print('added to saved_feedbacks collection');
    } else {
      await Firestore.instance.collection('users').document(uid)
      .collection('saved_feedbacks').document(widget.feedback.documentid).delete();
      print('deleted from saved feedbacks');
    }

  }

  @override
  void initState() {
    super.initState();
    Firestore.instance.collection('public').document('CS2030').collection('Feedbacks')
    .document(widget.feedback.documentid).get().then((value) async {

      final uid = await Provider.of(context).auth.getCurrentUID();

      if (value.data['saved'] == null
      ||value.data['upvotes'] == null || value.data['saved'][uid] == null || value.data['upvotes'][uid] == null) {

      widget.feedback.saved.putIfAbsent(uid, () => false);
      widget.feedback.upvotes.putIfAbsent(uid, () => false);

      Firestore.instance.collection('public').document('CS2030').collection('Feedbacks')
      .document(widget.feedback.documentid).setData({
        'saved': widget.feedback.saved,
        'upvotes': widget.feedback.upvotes,
      }, merge: true).then((_){
        print("success at null!");
        });

        
      } else {
        setState(() {
          isSaved = value.data['saved'][uid]; //accessing value 
          isUpvoted = value.data['upvotes'][uid];
        });
       print('set state upon opening page');
      }
    });
  }

  _upVoted() {
    setState(() {
      isUpvoted = !isUpvoted;
    });
  }


  @override
  Widget build(BuildContext context) {
    final comment = new Comments(null,null,null,null,null,null,null);
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        backgroundColor: Colors.grey[850],
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.of(context).pop();
              },
            );
          },
        ) ,
      ),
      body: Column(children: <Widget>[
        SizedBox(height:10),
        Card(
          color: Colors.grey[850],
          child: Column(
            children: <Widget>[
              Padding( 
                    padding: EdgeInsets.only(top: 4, bottom: 8),
                    child:
                    Row(children: <Widget>[
                      //profile pic username
                      SizedBox(width: 10,),
                      CircleAvatar(
                      backgroundImage: 
                      widget.feedback.profilePicture == null ?
                      NetworkImage('https://genslerzudansdentistry.com/wp-content/uploads/2015/11/anonymous-user.png')
                      : NetworkImage(widget.feedback.profilePicture),
                      backgroundColor: Colors.grey,
                      radius: 30,),
                      SizedBox(width: 10,),
                      Text(widget.feedback.username, style: TextStyle(fontWeight: FontWeight.bold,
                      fontSize: 18, decoration: TextDecoration.underline, color: Colors.grey[100])),
                      Spacer(),
                      IconButton(
                        icon: Icon(Icons.flag, color: Colors.red, size: 30,), 
                      onPressed: () { //report post
                        Navigator.push(context, 
              MaterialPageRoute(builder: (context) => Report()));
                      },),
                      Column(children: <Widget>[
                        Text('Report', style: TextStyle(color: Colors.grey[100]),),
                      Text('post',style: TextStyle(color: Colors.grey[100]),),
                      ],),
                      SizedBox(width: 20,),
                    ]),),
                    Padding( 
                    padding: EdgeInsets.only(top: 4, bottom: 8),
                    child:
                    Row(children: <Widget>[
                      SizedBox(width: 10,),
                      Text("Year taken: ", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.grey[100]),),
                      Text(widget.feedback.yearTaken, style: TextStyle(fontSize: 17, color: Colors.grey[100]),),
                      Spacer(),
                    ]),),
                    Padding( 
                    padding: EdgeInsets.only(top: 4, bottom: 8),
                    child:
                    Row(children: <Widget>[
                      SizedBox(width: 10,),
                      Text('Taken under: ', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.grey[100]),),
                     Text(widget.feedback.professor, style: TextStyle(fontSize: 17, color: Colors.grey[100],),)
                    ],),),
                    Padding( 
                    padding: EdgeInsets.only(top: 4, bottom: 8),
                    child:
                    Row(children: <Widget>[
                      SizedBox(width: 10,),
                      Text('Expected grade: ', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.grey[100]),),
                      Text(widget.feedback.expectedGrade, style: TextStyle(fontSize: 17, color: Colors.grey[100]),)
                    ],),),
                    Padding( 
                    padding: EdgeInsets.only(top: 4, bottom: 8),
                    child:
                    Row(children: <Widget>[
                      SizedBox(width: 10,),
                      Text('Actual grade: ', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.grey[100],)),
                      Text(widget.feedback.actualGrade, style: TextStyle(fontSize: 17, color: Colors.grey[100]),),
                    ],),),
                    Padding( 
                    padding: EdgeInsets.only(top: 4, bottom: 8),
                    child:
                    Row(children: <Widget>[
                      SizedBox(width: 10,),
                      Text('Difficulty (/10): ', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.grey[100]),),
                      Text(widget.feedback.difficulty, style: TextStyle(fontSize: 17, color: Colors.grey[100]),),
                    ],),),
                    Padding( 
                    padding: EdgeInsets.only(top: 4, bottom: 8),
                    child:
                    Row(children: <Widget>[
                      SizedBox(width: 10,),
                      Text('Early preparation tips: ', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.grey[100]),),
                      Expanded(child:
                      Text(widget.feedback.preparationTips, style: TextStyle(fontSize: 17, color: Colors.grey[100],),
                      overflow: TextOverflow.ellipsis, maxLines: 1,),), 
                    ],),),
                    Padding( 
                    padding: EdgeInsets.only(top: 4, bottom: 8),
                    child:
                    Row(children: <Widget>[
                      SizedBox(width: 10,),
                      Text('Feedback: ', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.grey[100]),),
                      Expanded(child:
                      Text(widget.feedback.content, style: TextStyle(fontSize: 17, color: Colors.grey[100]), overflow: TextOverflow.ellipsis,
                      maxLines: 1,)),
                    ],),),
                    SizedBox(height: 20),                                  
          ],),
        ),
        Card(
          color: Colors.grey[850],
          child: 
        Row(children: <Widget>[
          IconButton(
            icon: Icon(
              Icons.comment, size: 26, color: Colors.tealAccent,),
              onPressed: () {
                Navigator.push(context, 
              MaterialPageRoute(builder: (context) => FeedbackComment(
              comment: comment, post: widget.feedback,)));
              },),
          Text('Comment', style: TextStyle(color: Colors.grey[100]),),
          SizedBox(width: 40),
          IconButton(
            icon: Icon( isSaved ? Icons.star :
              Icons.star_border, size: 30, color: 
              isSaved ? Colors.yellow[600] : Colors.tealAccent,),
              onPressed: ()  async{
               final uid = await Provider.of(context).auth.getCurrentUID();
                await _saved(); 
                widget.feedback.saved.update(uid, (v) => isSaved, ifAbsent: () => isSaved);
                await Firestore.instance.collection('public').document('CS2030')
                .collection('Feedbacks').document(widget.feedback.documentid).setData({
                  'saved': widget.feedback.saved, //new field is a map
                }, merge: true).then((_){
                  print("successfully saved to firebase!");
                });
              },),
          Text(isSaved ? 'Unsave' : 'Save' , style: TextStyle(color: Colors.grey[100]),), //upon saving, saves post to home page
          SizedBox(width: 40),
          IconButton(
            onPressed: () async {
             final uid = await Provider.of(context).auth.getCurrentUID();
              await _upVoted(); 
              widget.feedback.upvotes.update(uid, (value) => isUpvoted, ifAbsent: () => isUpvoted);
              await Firestore.instance.collection('public').document('CS2030')
                 .collection('Feedbacks').document(widget.feedback.documentid).setData({
                   'upvotes': widget.feedback.upvotes, //new field is a map
                 }, merge: true).then((_){
                  print("upvote successfully saved to firebase!");
                });  

              await Firestore.instance.collection('users').document(widget.feedback.ownerid)
                 .collection('private_feedbacks').document(widget.feedback.documentid).setData({ //updating for private forums as well
                   'upvotes': widget.feedback.upvotes, //new field is a map
                 }, merge: true).then((_){
                  print("upvote successfully saved for private feedbacks!");
                });

             await Firestore.instance.collection('users').getDocuments().then((querySnapshot){
              querySnapshot.documents.forEach((result) { //result is each uid 
                Firestore.instance.collection('users').document(result.documentID)
                .collection('saved_feedbacks').getDocuments().then((querySnapshot) {
                  querySnapshot.documents.forEach((element) { //each element is each saved forum
                    if(element.documentID == widget.feedback.documentid) {
                      Firestore.instance.collection('users').document(result.documentID)
                      .collection('saved_feedbacks').document(element.documentID).setData({
                        'upvotes': widget.feedback.upvotes, //new field is a map
                 }, merge: true).then((_){
                  print("upvote saved forums!");
                });  
                    }
                  });
                });
               });
            });  

            //updating for saved forums   
            },
            icon: Icon(isUpvoted ? Icons.thumb_down : Icons.thumb_up,
             size: 26,
             color: isUpvoted ? Colors.grey[100] : Colors.tealAccent,),),
          Text(isUpvoted ? 'Unvote' : 'Upvote', style: TextStyle(color: Colors.grey[100]),), //change to a function to keep track of counts
        ],)),
        SizedBox(height: 20,),
        Row(mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
          Text('  Comments:', style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold,
          color: Colors.grey[100])),
        ],),
        SizedBox(height: 20,),
        StreamBuilder(
          stream: getUsersFeedbackCommentsSnapshot(context),
          builder: (context, snapshot) {
            if(!snapshot.hasData) return Text('There are no comments yet');
            return new 
             Expanded(child:
        SizedBox(
          height: 100,
          child:
            ListView.builder(
          itemBuilder: (BuildContext context, int index) 
          => buildComments(context, snapshot.data.documents[index]),
          itemCount: snapshot.data.documents.length,
        ),),);
          }
        )
        
      ],)
    );
  }

  void deleteData(DocumentSnapshot doc) async {
    await Firestore.instance.collection('Forums').document(doc.documentID).delete();
  }

  Stream<QuerySnapshot> getUsersFeedbackCommentsSnapshot(BuildContext context) async* {
    //final uid = await Provider.of(context).auth.getCurrentUID();
    yield* Firestore.instance.collection('public')
    .document('CS2030').collection('Feedbacks').document(widget.feedback.documentid).
    collection('comments').snapshots();
  }

  Widget buildComments(BuildContext context, DocumentSnapshot comment) { //comments card
  final commentPosted = Comments.fromSnapshot(comment);
    return Container(
      child: Card(
        color: Colors.grey[850],
        shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(18.0)),
        child: InkWell(
          onTap: () {
          },
      child: Padding(
        padding: EdgeInsets.only(top: 4, bottom: 4),
                child: Column(
                  children: <Widget>[
                    Padding(
                    padding: EdgeInsets.only(top: 4, bottom: 8),
                    child:
                    Row(children: <Widget>[
                      SizedBox(width: 10,),
                      Text('Commented on ', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold,
                      color: Colors.grey[400]),),
                      Text(comment['timestamp'], 
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold,
                      color: Colors.grey[400]),),
                      Spacer(),   
                    ],),
                    ),
                    SizedBox(height: 10),
                    Row(children: <Widget>[
                      SizedBox(width: 10,),
                      CircleAvatar(
                      backgroundImage: comment['profilePicture'] != null ?
                      NetworkImage(comment['profilePicture']) : 
                      NetworkImage('https://genslerzudansdentistry.com/wp-content/uploads/2015/11/anonymous-user.png'),
                      backgroundColor: Colors.grey,
                      radius: 20,),
                      SizedBox(width: 10,),
                      Text(comment['username'], style: TextStyle(fontWeight: FontWeight.bold,
                      fontSize: 16, decoration: TextDecoration.underline, color: Colors.grey[100]),
                    )],),
                    SizedBox(height: 10),
                    Padding( 
                    padding: EdgeInsets.only(top: 4, bottom: 8),
                    child:
                    Row(children: <Widget>[
                      SizedBox(width: 10,), 
                      Expanded(child:
                      Text(comment['content'], style: TextStyle(fontSize: 16, color: Colors.grey[100]
                      ))),
                    ],)),
                    Divider(color: Colors.tealAccent),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.flag, color: Colors.red, size: 25,), 
                      onPressed: () { //report post
                        Navigator.push(context, 
              MaterialPageRoute(builder: (context) => Report()));
                      },),
                      Text("Report comment", style: TextStyle(fontSize: 14,
                      decoration: TextDecoration.underline, color: Colors.grey[100]),),
                      Spacer(),
            //           IconButton(
            // onPressed: () {
            //   //_upVoted();
            // },
            // icon: Icon(isUpvoted ? Icons.thumb_down : Icons.thumb_up,
            //  size: 20,
            //  color: isUpvoted ? Colors.red[400] : Colors.blue[900],),),
          // Text("0"),
          Upvotefeedbacks(comment: commentPosted, post: widget.feedback),
          SizedBox(width: 20),
                    ],)
                    ],)
                ,)
      ),),
            );
  }


}