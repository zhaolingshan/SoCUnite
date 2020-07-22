import 'package:SoCUniteTwo/screens/comments_report/report_collabcomment.dart';
import 'package:SoCUniteTwo/screens/forum_screens/collaborations/collaboration.dart';
import 'package:SoCUniteTwo/screens/forum_screens/details/report_collaborations.dart';
import 'package:SoCUniteTwo/screens/forum_screens/upvote_collaborations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:SoCUniteTwo/widgets/provider_widget.dart';
import 'package:SoCUniteTwo/screens/forum_screens/details/comments.dart';
import 'package:SoCUniteTwo/screens/forum_screens/collaborations/collaboration_comments.dart';


class CollaborationDetails extends StatefulWidget {
  final Collaboration collaboration;
  CollaborationDetails({Key key, @required this.collaboration}) : super(key: key);

  @override
  _CollaborationDetailsState createState() => _CollaborationDetailsState();
}

class _CollaborationDetailsState extends State<CollaborationDetails> {
  
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
    if (isSaved) { 
      Firestore.instance.collection('users').document(uid).collection('saved_collaborations').
      document(widget.collaboration.documentid).setData({
       'title': widget.collaboration.title,
       'content': widget.collaboration.content,
       'timestamp': widget.collaboration.timestamp,
       'username': widget.collaboration.username,
       'profilePicture' : widget.collaboration.profilePicture,
       'documentid': widget.collaboration.documentid,
       'link': widget.collaboration.link,
       'name': widget.collaboration.name,
       'ownerid': widget.collaboration.ownerid,
       'experience': widget.collaboration.experience,
       'contact': widget.collaboration.contact,
       'upvotes': widget.collaboration.upvotes,
        'saved': widget.collaboration.saved,
        'reported': widget.collaboration.reported,
        'isResolved': isResolved,
      });
      print('added to saved_collaborations collection');
    } else {
      await Firestore.instance.collection('users').document(uid)
      .collection('saved_collaborations').document(widget.collaboration.documentid).delete();
      print('deleted from saved_collaborations');
    }

  }

  _upVoted() {
    setState(() {
      isUpvoted = !isUpvoted;
    });
  }

  @override
  void initState() {
    super.initState();
    Firestore.instance.collection('public').document('collaborations').collection('Collaborations')
    .document(widget.collaboration.documentid).get().then((value) async {
      final uid = await Provider.of(context).auth.getCurrentUID();

      if (value.data['saved'] == null
      ||value.data['upvotes'] == null || value.data['saved'][uid] == null || value.data['upvotes'][uid] == null) {

      widget.collaboration.saved.putIfAbsent(uid, () => false);
      widget.collaboration.upvotes.putIfAbsent(uid, () => false);

      Firestore.instance.collection('public').document('collaborations').collection('Collaborations')
      .document(widget.collaboration.documentid).setData({
        'saved': widget.collaboration.saved,
        'upvotes': widget.collaboration.upvotes,
      }, merge: true).then((_){
        print("success at null!");
        });
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
                "Do you want to mark your collaboration as closed?",
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
                widget.collaboration.isResolved = true; //set isResolved for this post
                await Firestore.instance.collection('public').document('collaborations')
                .collection('Collaborations').document(widget.collaboration.documentid).setData({
                  'isResolved': isResolved,
                  },merge : true).then((_){
                    print("marked public post as resolved!"); //for public
                });

                await Firestore.instance.collection('users').document(widget.collaboration.ownerid)
                .collection('private_collaborations').document(widget.collaboration.documentid).setData({
                  'isResolved': widget.collaboration.isResolved,
                  },merge : true).then((_){
                    print("marked private post as resolved!");
                });

                await Firestore.instance.collection('users').getDocuments().then((querySnapshot){
              querySnapshot.documents.forEach((result) { //result is each uid 
                Firestore.instance.collection('users').document(result.documentID)
                .collection('saved_collaborations').getDocuments().then((querySnapshot) {
                  querySnapshot.documents.forEach((element) { //each element is each saved forum
                    if(element.documentID == widget.collaboration.documentid) {
                      Firestore.instance.collection('users').document(result.documentID)
                      .collection('saved_collaborations').document(element.documentID).setData({
                        'isResolved': isResolved,
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
                "Do you want to mark your collaboration as available?",
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
                widget.collaboration.isResolved = false;
                await Firestore.instance.collection('public').document('collaborations')
                .collection('Collaborations').document(widget.collaboration.documentid).setData({
                  'isResolved': widget.collaboration.isResolved,
                  },merge : true).then((_){
                    print("marked public post as resolved!"); //for public
                });

                await Firestore.instance.collection('users').document(widget.collaboration.ownerid)
                .collection('private_collaborations').document(widget.collaboration.documentid).setData({
                  'isResolved': widget.collaboration.isResolved,
                  },merge : true).then((_){
                    print("marked private post as resolved!");
                });

                await Firestore.instance.collection('users').getDocuments().then((querySnapshot){
              querySnapshot.documents.forEach((result) { //result is each uid 
                Firestore.instance.collection('users').document(result.documentID)
                .collection('saved_collaborations').getDocuments().then((querySnapshot) {
                  querySnapshot.documents.forEach((element) { //each element is each saved forum
                    if(element.documentID == widget.collaboration.documentid) {
                      Firestore.instance.collection('users').document(result.documentID)
                      .collection('saved_collaborations').document(element.documentID).setData({
                        'isResolved': widget.collaboration.isResolved,
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
            if (snapshot.data == widget.collaboration.ownerid) { //if is mine
            print(isResolved);
              if(isResolved == false) {
                return RaisedButton(
                  color: Colors.grey[850],
                child: Text('Mark as closed?', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[100],
                      fontSize: 15, decoration: TextDecoration.underline,),),
                splashColor: Colors.tealAccent,
                onPressed: () {
                  _markAsResolved();
                }
              );
              } else { //if resolved is true
                return RaisedButton(
                  color: Colors.grey[850],
                child: Text('Mark as available?', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[100],
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
          ) ]
      ),
      body:  SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(children: <Widget>[
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
                future: Firestore.instance.collection('users').document(widget.collaboration.ownerid).get(),
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
                future: Firestore.instance.collection('users').document(widget.collaboration.ownerid).get(),
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
                      Spacer(),
                      IconButton(
                        icon: Icon(Icons.flag, color: Colors.red, size: 30,), 
                      onPressed: () { //report post
                        Navigator.push(context, 
              MaterialPageRoute(builder: (context) => ReportCollaborations(post: widget.collaboration)));
                      },),
                      Column(children: <Widget>[
                        Text('Report', style: TextStyle(color: Colors.grey[100]),),
                      Text('post', style: TextStyle(color: Colors.grey[100]))
                      ],),
                      SizedBox(width: 20,),
                    ]),),
                    
                    //SizedBox(height: 20,),
                    Padding( 
                    padding: EdgeInsets.only(top: 4, bottom: 8),
                    child:
                    Row(children: <Widget>[
                      SizedBox(width: 10,), 
                      Expanded(child:
                      Text(widget.collaboration.title,style: TextStyle(fontSize: 18,
                      fontWeight:FontWeight.bold, color: Colors.grey[100]))),
                    ],)),
                    Padding( 
                    padding: EdgeInsets.only(top: 4, bottom: 8),
                    child:
                    Row(children: <Widget>[
                      SizedBox(width: 10,), 
                      Text("My contact details ", style: TextStyle(fontSize: 17,
                      fontWeight:FontWeight.bold, decoration: TextDecoration.underline, color: Colors.grey[100])),
                    ],)),
                    Padding( 
                    padding: EdgeInsets.only(top: 4, bottom: 8),
                    child:
                    Row(children: <Widget>[
                      SizedBox(width: 10,), 
                      Text("Name:", style: TextStyle(fontSize: 17,  color: Colors.grey[100]),),
                      SizedBox(width: 10,), 
                      Text(widget.collaboration.name, style: TextStyle(fontSize: 17,color: Colors.grey[100]
                      )),
                    ],)),
                    Padding( 
                    padding: EdgeInsets.only(top: 4, bottom: 8),
                    child:
                    Row(children: <Widget>[
                      SizedBox(width: 10,), 
                      Expanded(child: 
                      Text(widget.collaboration.contact, style: TextStyle(fontSize: 18,  color: Colors.grey[100])),)
                    ],)),
                    Padding( 
                    padding: EdgeInsets.only(top: 4, bottom: 8),
                    child:
                    Row(children: <Widget>[
                      SizedBox(width: 10,), 
                      Text("Reference materials ", style: TextStyle(fontSize: 18, color: Colors.grey[100],
                      fontWeight:FontWeight.bold, decoration: TextDecoration.underline,)),
                    ],)),
                    Padding( 
                    padding: EdgeInsets.only(top: 4, bottom: 8),
                    child:
                    Row(children: <Widget>[
                      SizedBox(width: 10,), 
                      Expanded(child:
                      Text(widget.collaboration.link, style: TextStyle(fontSize: 18,  color: Colors.grey[100]))),
                    ],)),
                    Padding( 
                    padding: EdgeInsets.only(top: 4, bottom: 8),
                    child:
                    Row(children: <Widget>[
                      SizedBox(width: 10,), 
                      Text("Details ", style: TextStyle(fontSize: 18, color: Colors.grey[100],
                      fontWeight:FontWeight.bold)),
                    ],)),
                
                    Padding(
                    padding: EdgeInsets.only(top: 4, bottom: 8),
                    child:
                    Row(children: <Widget>[
                      SizedBox(width: 10,),
                      Expanded(child:
                      Text(widget.collaboration.content, style: TextStyle(fontSize: 17,  color: Colors.grey[100]),
                      ),),
                    ],)),
                    
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
              MaterialPageRoute(builder: (context) => CollaborationComment(
                comment: comment, post: widget.collaboration,)));
              },),
          Text('Comment', style: TextStyle(color: Colors.grey[100]),),
          SizedBox(width: 30),
          IconButton(
            icon: Icon( isSaved ? Icons.star :
              Icons.star_border, size: 30, color: 
              isSaved ? Colors.yellow[600] : Colors.tealAccent,),
              onPressed: () async {
                 await _saved(); 
                 final uid = await Provider.of(context).auth.getCurrentUID();
                 widget.collaboration.saved.update(uid, (v) => isSaved, ifAbsent: () => isSaved);
                 await Firestore.instance.collection('public').document('collaborations')
                 .collection('Collaborations').document(widget.collaboration.documentid).setData({
                   'saved': widget.collaboration.saved, //new field is a map
                 }, merge: true).then((_){
                  print("successfully saved to firebase!");
                });
              },),
          Text(isSaved ? 'Unsave' : 'Save', style: TextStyle(color: Colors.grey[100])), //upon saving, saves post to home page
          SizedBox(width: 40),
          //Upvote(),
          IconButton(
            onPressed: () async {
             final uid = await Provider.of(context).auth.getCurrentUID();
              await _upVoted(); 
              widget.collaboration.upvotes.update(uid, (value) => isUpvoted, ifAbsent: () => isUpvoted);
              await Firestore.instance.collection('public').document('collaborations')
                 .collection('Collaborations').document(widget.collaboration.documentid).setData({
                   'upvotes': widget.collaboration.upvotes, //new field is a map
                 }, merge: true).then((_){
                  print("upvote successfully saved to firebase!");
                });

              await Firestore.instance.collection('users').document(widget.collaboration.ownerid)
                 .collection('private_collaborations').document(widget.collaboration.documentid).setData({ //updating for private forums as well
                   'upvotes': widget.collaboration.upvotes, //new field is a map
                 }, merge: true).then((_){
                  print("upvote successfully saved for private collabs!");
                });  

            //updating for saved forums
             await Firestore.instance.collection('users').getDocuments().then((querySnapshot){
              querySnapshot.documents.forEach((result) { //result is each uid 
                Firestore.instance.collection('users').document(result.documentID)
                .collection('saved_collaborations').getDocuments().then((querySnapshot) {
                  querySnapshot.documents.forEach((element) { //each element is each saved forum
                    if(element.documentID == widget.collaboration.documentid) {
                      Firestore.instance.collection('users').document(result.documentID)
                      .collection('saved_collaborations').document(element.documentID).setData({
                        'upvotes': widget.collaboration.upvotes, //new field is a map
                 }, merge: true).then((_){
                  print("upvote saved collaborations!");
                });  
                    }
                  });
                });
               });
            });        
            },
            icon: Icon(isUpvoted ? Icons.thumb_down : Icons.thumb_up,
             size: 26,
             color: isUpvoted ? Colors.grey[100] : Colors.tealAccent,),),
          Text(isUpvoted ? 'Unvote' : 'Upvote', style: TextStyle(color: Colors.grey[100]),), 
        ],)),
        SizedBox(height: 20,),
        Row(mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
          Text('  Comments:', style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold,
          color: Colors.grey[100])),
        ],),
        SizedBox(height: 20,),
        StreamBuilder( //stream of comments
          stream: getUsersCollaborationCommentsSnapshot(context),
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

  Stream<QuerySnapshot> getUsersCollaborationCommentsSnapshot(BuildContext context) async* {
    //final uid = await Provider.of(context).auth.getCurrentUID();
    yield* Firestore.instance.collection('public')
    .document('collaborations').collection('Collaborations').document(widget.collaboration.documentid).
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
                      color: Colors.grey[400]),),
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
                                await Firestore.instance.collection('public').document('collaborations')
                                .collection('Collaborations').document(widget.collaboration.documentid).
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
                    Divider(color: Colors.grey),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.flag, color: Colors.red, size: 25,), 
                      onPressed: () { //report post
                        Navigator.push(context, 
              MaterialPageRoute(builder: (context) => ReportCollaborationComment(post: widget.collaboration, comment: commentPosted,)));
                      },),
                      Text("report comment", style: TextStyle(fontSize: 14,
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
          Upvotecollaborations(comment: commentPosted, post: widget.collaboration,),
          SizedBox(width: 20),
                    ],)
                    ],)
                ,)
      ),),
            );
  }


}