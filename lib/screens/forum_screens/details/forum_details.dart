import 'package:SoCUniteTwo/screens/forum_screens/upvote_forums.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:SoCUniteTwo/screens/forum_screens/details/report.dart';
import 'package:flutter/material.dart';
import 'package:SoCUniteTwo/screens/comments_report/report_forumcomment.dart';
import 'package:SoCUniteTwo/widgets/provider_widget.dart';
import 'package:SoCUniteTwo/screens/forum_screens/post.dart'; 
import 'package:SoCUniteTwo/screens/forum_screens/details/comments.dart';
import 'package:SoCUniteTwo/screens/forum_screens/details/forum_comment.dart';


class ForumDetails extends StatefulWidget {
  final Post forum;
  ForumDetails({Key key, @required this.forum}) : super(key: key);

  @override
  _ForumDetailsState createState() => _ForumDetailsState();
}

class _ForumDetailsState extends State<ForumDetails> {
  bool isSaved = false;
  bool isUpvoted = false;
  bool isResolved = false;
 
  getUID() async { 
    return await Provider.of(context).auth.getCurrentUID();
  }
  
  _saved() async {
    final uid = await Provider.of(context).auth.getCurrentUID();
    setState(() {
      isSaved = !isSaved;
    });
    //print('saved');
    // await Firestore.instance.collection('public').document('CS2030').collection('Forums')
    // .document(widget.forum.documentid).setData({
    //   'isSaved': widget.forum.saved[uid],
    // });
    // print('uploaded to firebase');
    if (isSaved) { 
      Firestore.instance.collection('users').document(uid).collection('saved_forums').
      document(widget.forum.documentid).setData({
        'title': widget.forum.title,
        'content': widget.forum.content,
        'timestamp': widget.forum.timestamp,
        'imageurl': widget.forum.imageurl,
        'username': widget.forum.username,
        'profilePicture' : widget.forum.profilePicture,
        'ownerid': widget.forum.ownerid,
        'documentid': widget.forum.documentid,
        'upvotes': widget.forum.upvotes,
        'saved': widget.forum.saved,
        'reported': widget.forum.reported,
        'isResolved': isResolved,
      });
      print('added to saved_forums collection');
    } else {
      await Firestore.instance.collection('users').document(uid)
      .collection('saved_forums').document(widget.forum.documentid).delete();
      print('deleted from saved_forums');
    }

  }

  _upVoted() {
    setState(() {
      isUpvoted = !isUpvoted;
    });
  }

  void _markAsResolved() { 
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Padding(
   padding: EdgeInsets.only(left: 50.0, right: 50.0, top: 20, bottom: 10),
   child:
        AlertDialog(
          backgroundColor: Colors.grey[850],
          title: new Text(
            "Confirmation",
            style: TextStyle(color: Colors.tealAccent),
            ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget> [
              Text(
                "Do you want to mark your post as resolved?",
                style: TextStyle(color: Colors.grey[100]),
              ),
            ],
          ),
          actions: <Widget>[
            FlatButton(
              color: Colors.tealAccent,
              child: new Text(
                "Confirm",
                style: TextStyle(color: Colors.black),
              ),
              onPressed: () async { //change data 
                setState(() {
                  isResolved = true;
                });
                widget.forum.isResolved = true; //set isResolved for this post
                await Firestore.instance.collection('public').document('CS2030')
                .collection('Forums').document(widget.forum.documentid).setData({
                  'isResolved': widget.forum.isResolved,
                  },merge : true).then((_){
                    print("marked public post as resolved!"); //for public
                });

                await Firestore.instance.collection('users').document(widget.forum.ownerid)
                .collection('private_forums').document(widget.forum.documentid).setData({
                  'isResolved': widget.forum.isResolved,
                  },merge : true).then((_){
                    print("marked private post as resolved!");
                });

                await Firestore.instance.collection('users').getDocuments().then((querySnapshot){
              querySnapshot.documents.forEach((result) { //result is each uid 
                Firestore.instance.collection('users').document(result.documentID)
                .collection('saved_forums').getDocuments().then((querySnapshot) {
                  querySnapshot.documents.forEach((element) { //each element is each saved forum
                    if(element.documentID == widget.forum.documentid) {
                      Firestore.instance.collection('users').document(result.documentID)
                      .collection('saved_forums').document(element.documentID).setData({
                        'isResolved': widget.forum.isResolved,
                 }, merge: true).then((_){
                  print("marked saved forums as resolved!");
                });  
                    }
                  });
                });
               });
            });      
                Navigator.of(context).pop();
              },
            ),
            SizedBox(width: 40,),
            FlatButton(
              color: Colors.tealAccent,
              child: new Text(
                "Back",
                style: TextStyle(color: Colors.black),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
        );
      },
    );
  }

  void _markAsUnresolved() { 
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Padding(
   padding: EdgeInsets.only(left: 50.0, right: 50.0, top: 20, bottom: 10),
   child:
        AlertDialog(
          backgroundColor: Colors.grey[850],
          title: new Text(
            "Confirmation",
            style: TextStyle(color: Colors.tealAccent),
            ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget> [
              Text(
                "Do you want to mark post as unresolved?",
                style: TextStyle(color: Colors.grey[100]),
              ),
            ],
          ),
          actions: <Widget>[
            FlatButton(
              color: Colors.tealAccent,
              child: new Text(
                "Confirm",
                style: TextStyle(color: Colors.black),
              ),
              onPressed: () async { //change data 
                setState(() {
                  isResolved = false;
                });
                widget.forum.isResolved = false;
                await Firestore.instance.collection('public').document('CS2030')
                .collection('Forums').document(widget.forum.documentid).setData({
                  'isResolved': widget.forum.isResolved,
                  },merge : true).then((_){
                    print("marked post as unresolved!");
                });

                 await Firestore.instance.collection('users').document(widget.forum.ownerid)
                .collection('private_forums').document(widget.forum.documentid).setData({
                  'isResolved': widget.forum.isResolved,
                  },merge : true).then((_){
                    print("marked private post as resolved!");
                });

                await Firestore.instance.collection('users').getDocuments().then((querySnapshot){
              querySnapshot.documents.forEach((result) { //result is each uid 
                Firestore.instance.collection('users').document(result.documentID)
                .collection('saved_forums').getDocuments().then((querySnapshot) {
                  querySnapshot.documents.forEach((element) { //each element is each saved forum
                    if(element.documentID == widget.forum.documentid) {
                      Firestore.instance.collection('users').document(result.documentID)
                      .collection('saved_forums').document(element.documentID).setData({
                        'isResolved': widget.forum.isResolved,
                 }, merge: true).then((_){
                  print("marked saved forums as resolved!");
                });  
                    }
                  });
                });
               });
            });
                Navigator.of(context).pop();
              },
            ),
            SizedBox(width: 40,),
            FlatButton(
              color: Colors.tealAccent,
              child: new Text(
                "Back",
                style: TextStyle(color: Colors.black),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    Firestore.instance.collection('public').document('CS2030').collection('Forums')
    .document(widget.forum.documentid).get().then((value) async {
      final uid = await Provider.of(context).auth.getCurrentUID();
      
      if (value.data['saved'] == null
      ||value.data['upvotes'] == null || value.data['saved'][uid] == null || value.data['upvotes'][uid] == null) {

      widget.forum.saved.putIfAbsent(uid, () => false);
      widget.forum.upvotes.putIfAbsent(uid, () => false);

      Firestore.instance.collection('public').document('CS2030').collection('Forums')
      .document(widget.forum.documentid).setData({
        'saved': widget.forum.saved,
        'upvotes': widget.forum.upvotes,
      }, merge: true).then((_){
        print("success at null saved!");
        });

      // Firestore.instance.collection('public').document('CS2030').collection('Forums')
      // .document(widget.forum.documentid).setData({
      //   'upvotes': widget.forum.upvotes,
      // }, merge: true).then((_){
      //   print("success at null upvotes!");
      //   });
        
        //persist(isSaved); // set an initial value
      } else {
        setState(() {
           isSaved = value.data['saved'][uid]; //accessing value 
           isUpvoted = value.data['upvotes'][uid]; 
           isResolved = value.data['isResolved'];
        });
       print('set state upon opening page');
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    final comment = new Comments(null,null,null,null,null,null,null,null);
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
        ),
        actions: <Widget>[
           FutureBuilder(
            future: getUID(), //returns uid
            builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.data == widget.forum.ownerid) { //if is mine
              if(isResolved == false) {
                return RaisedButton(
                  color: Colors.grey[850],
                child: Text('Mark as resolved?', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[100],
                      fontSize: 15, decoration: TextDecoration.underline,),),
                splashColor: Colors.tealAccent,
                onPressed: () {
                  _markAsResolved();
                }
              );
              } else { //if resolved is true
                return RaisedButton(
                  color: Colors.grey[850],
                child: Text('Mark as unresolved?', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[100],
                      fontSize: 15, decoration: TextDecoration.underline,),),
                splashColor: Colors.tealAccent,
                onPressed: () {
                  _markAsUnresolved();
                }
              );
              }
            }

            else { //if not owner
            return Container();
            }
           },
          ) 
        ]
      ),
      body:  SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: 
      Column(children: <Widget>[
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
                      FutureBuilder( 
                future: Firestore.instance.collection('users').document(widget.forum.ownerid).get(),
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
                      SizedBox(width: 10,),
                      FutureBuilder( 
                future: Firestore.instance.collection('users').document(widget.forum.ownerid).get(),
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
                      // Text(widget.forum.username, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[100],
                      // fontSize: 18, decoration: TextDecoration.underline,)),
                      Spacer(),
                      IconButton(
                        icon: Icon(Icons.flag, color: Colors.red, size: 30,), 
                      onPressed: () { 
                        Navigator.push(context, 
              MaterialPageRoute(builder: (context) => Report(post: widget.forum,)));
                      },),
                      Column(children: <Widget>[
                        Text('Report', style: TextStyle(color: Colors.grey[100]),),
                      Text('post', style: TextStyle(color: Colors.grey[100]),)
                      ],),
                      SizedBox(width: 20,),
                    ]),),
                    Padding( 
                    padding: EdgeInsets.only(top: 4, bottom: 8),
                    child:
                    Row(children: <Widget>[
                      SizedBox(width: 10,),
                      Expanded(child: 
                      Text(widget.forum.title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                      ),),
                    ]),),
                    widget.forum.imageurl != null ?
                    Padding( 
                    padding: EdgeInsets.only(top: 4, bottom: 8),
                    child:
                    Column(
                      children: <Widget>[
                      SizedBox(width: 10,), 
                      ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8.0),
                      topRight: Radius.circular(8.0),
                      ),
                      child:  Image.network(widget.forum.imageurl,
                      height: 300,
                      width: 400,),
                      ),
                      //image
                    ],),) : Container(height: 0),
              Padding( 
                    padding: EdgeInsets.only(top: 4, bottom: 8),
                    child:
                    Row(children: <Widget>[
                      SizedBox(width: 10,),
                      Expanded(child: 
                      Text(widget.forum.content, style: TextStyle(fontSize: 18, color: Colors.grey[100]),
                      ),),
                    ]),),
                    SizedBox(height: 30),
                   
                    
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
              MaterialPageRoute(builder: (context) => ForumComment(
                comment: comment, post: widget.forum,)));
              },),
          Text('Comment', style: TextStyle(color: Colors.white)),
          SizedBox(width: 40),
          IconButton(
            icon: Icon( isSaved ? Icons.star :
              Icons.star_border, size: 30, color: 
              isSaved ? Colors.yellow[600] : Colors.tealAccent,),
              onPressed: () async {
                final uid = await Provider.of(context).auth.getCurrentUID();
                 await _saved(); 
                 //widget.forum.saved.putIfAbsent(uid, () => isSaved); //adding into map
                 widget.forum.saved.update(uid, (v) => isSaved, ifAbsent: () => isSaved);
                 await Firestore.instance.collection('public').document('CS2030')
                 .collection('Forums').document(widget.forum.documentid).setData({
                   'saved': widget.forum.saved, //new field is a map
                 }, merge: true).then((_){
                  print("saved post successfully saved to firebase!");
                });
                
              },),
          Text(isSaved ? 'Unsave' : 'Save', style: TextStyle(color: Colors.white)), //upon saving, saves post to home page
          SizedBox(width: 40),
          //Upvote(),
          IconButton(
            onPressed: () async {
              final uid = await Provider.of(context).auth.getCurrentUID();
              await _upVoted(); 
              widget.forum.upvotes.update(uid, (value) => isUpvoted, ifAbsent: () => isUpvoted);
              await Firestore.instance.collection('public').document('CS2030')
                 .collection('Forums').document(widget.forum.documentid).setData({
                   'upvotes': widget.forum.upvotes, //new field is a map
                 }, merge: true).then((_){
                  print("upvote successfully saved to firebase!");
                });        

            await Firestore.instance.collection('users').document(widget.forum.ownerid)
                 .collection('private_forums').document(widget.forum.documentid).setData({ //updating for private forums as well
                   'upvotes': widget.forum.upvotes, //new field is a map
                 }, merge: true).then((_){
                  print("upvote successfully saved for private forums!");
                });  

            //updating for saved forums 
            await Firestore.instance.collection('users').getDocuments().then((querySnapshot){
              querySnapshot.documents.forEach((result) { //result is each uid 
                Firestore.instance.collection('users').document(result.documentID)
                .collection('saved_forums').getDocuments().then((querySnapshot) {
                  querySnapshot.documents.forEach((element) { //each element is each saved forum
                    if(element.documentID == widget.forum.documentid) {
                      Firestore.instance.collection('users').document(result.documentID)
                      .collection('saved_forums').document(element.documentID).setData({
                        'upvotes': widget.forum.upvotes, //new field is a map
                 }, merge: true).then((_){
                  print("upvote saved forums!");
                });  
                    }
                  });
                });
               });
            });
            
            },
            icon: Icon(isUpvoted ? Icons.thumb_down : Icons.thumb_up,  
             size: 26,
             color: isUpvoted ? Colors.white : Colors.tealAccent,),),
          Text(isUpvoted ? 'Unvote' : 'Upvote', style: TextStyle(color: Colors.white)),
        ],)),
        //SizedBox(height: 20,),
        // Row(mainAxisAlignment: MainAxisAlignment.start,
        //   children: <Widget>[
        //   Text('  Comments:', style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold,
        //   color: Colors.grey[100])),
        // ],),
        SizedBox(height: 20,),
        StreamBuilder( //stream of comments
          stream: getUsersForumCommentsSnapshot(context),
          builder: (context, snapshot) {
            if(!snapshot.hasData) return CircularProgressIndicator();
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
      ]),))   
    );
  }

  // void deleteData(DocumentSnapshot doc) async {
  //   await Firestore.instance.collection('Forums').document(doc.documentID).delete();
  // }

  Stream<QuerySnapshot> getUsersForumCommentsSnapshot(BuildContext context) async* {
    //final uid = await Provider.of(context).auth.getCurrentUID();
    yield* Firestore.instance.collection('public')
    .document('CS2030').collection('Forums').document(widget.forum.documentid).
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
          onTap: () { //maybe to see users profile eg karma points etc
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
                      color: Colors.grey[600]),),
                      Spacer(),
                      FutureBuilder(
                        future: getUID(), //returns uid
                        builder: (context, AsyncSnapshot snapshot) {
                          if (snapshot.data == comment['ownerid']) {
                            return  IconButton(
                              iconSize: 30,
                              color: Colors.red,
                              icon: Icon(Icons.delete_forever),
                              onPressed: () async {
                                //final uid = await Provider.of(context).auth.getCurrentUID();
                                await Firestore.instance.collection('public').document('CS2030')
                                .collection('Forums').document(widget.forum.documentid).
                                collection('comments').document(comment.documentID).delete();
                              }
                            );
                          }
                          else {
                          return Container();
                         }
                        },
                      )   
                    ],),
                    ),
                    SizedBox(height: 10),
                    Row(children: <Widget>[
                      SizedBox(width: 10,),
                      FutureBuilder( 
                future: Firestore.instance.collection('users').document(comment['ownerid']).get(),
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
                      SizedBox(width: 10,),
                    //   Text(comment['username'], style: TextStyle(fontWeight: FontWeight.bold,
                    //   fontSize: 16, decoration: TextDecoration.underline, color: Colors.grey[100]),
                    // )
                    FutureBuilder( 
                future: Firestore.instance.collection('users').document(comment['ownerid']).get(),
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
                    ],),
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
                      onPressed: () { 
                        Navigator.push(context, 
              MaterialPageRoute(builder: (context) => ReportForumComment(post: widget.forum, comment: commentPosted,)));
                      },),
                      Text("Report comment", style: TextStyle(fontSize: 14,
                      decoration: TextDecoration.underline, color: Colors.grey[100]),),
                      Spacer(),
          Upvoteforums(comment: commentPosted, post: widget.forum,), //update 
          SizedBox(width: 20),
                    ],)
                    ],)
                ,)
      ),),
            );
  }


}