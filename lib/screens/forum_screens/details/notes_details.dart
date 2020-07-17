import 'package:SoCUniteTwo/screens/forum_screens/details/comments.dart';
import 'package:SoCUniteTwo/screens/forum_screens/post_notes.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:SoCUniteTwo/screens/forum_screens/details/report_notes.dart';
import 'package:SoCUniteTwo/screens/forum_screens/details/note_comment.dart';
import 'package:SoCUniteTwo/screens/forum_screens/upvote_notes.dart';
import 'package:SoCUniteTwo/widgets/provider_widget.dart';



class NotesDetails extends StatefulWidget {

  final PostNotes note;
  NotesDetails({Key key, @required this.note}) : super(key: key);
  @override
  _NotesDetailsState createState() => _NotesDetailsState();
}

class _NotesDetailsState extends State<NotesDetails> {

  bool isSaved = false;
  bool isUpvoted = false;
 

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
    if (isSaved) { //if saved 
      Firestore.instance.collection('users').document(uid).collection('saved_notes').
      document(widget.note.documentid).setData({
        'topic': widget.note.topic,
        'link': widget.note.link,
        'content': widget.note.content,
        'timestamp': widget.note.timestamp,
        'imageurl': widget.note.imageurl,
        'username': widget.note.username,
        'profilePicture' : widget.note.profilePicture,
        'ownerid': widget.note.ownerid,
        'documentid': widget.note.documentid,
        'upvotes': widget.note.upvotes,
        'saved': widget.note.saved,
        'reported': widget.note.reported,
      });
      print('added to saved_notes collection');
    } else {
      await Firestore.instance.collection('users').document(uid)
      .collection('saved_notes').document(widget.note.documentid).delete();
      print('deleted from saved notes');
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
    Firestore.instance.collection('public').document('CS2030').collection('Notes')
    .document(widget.note.documentid).get().then((value) async {
      final uid = await Provider.of(context).auth.getCurrentUID();
     if (value.data['saved'] == null
      ||value.data['upvotes'] == null || value.data['saved'][uid] == null || value.data['upvotes'][uid] == null) {

      widget.note.saved.putIfAbsent(uid, () => false);
       widget.note.upvotes.putIfAbsent(uid, () => false);

      Firestore.instance.collection('public').document('CS2030').collection('Notes')
      .document(widget.note.documentid).setData({
        'saved': widget.note.saved,
        'upvotes': widget.note.upvotes,
      }, merge: true).then((_){
        print("success at null!");
        });

      // Firestore.instance.collection('public').document('CS2030').collection('Forums')
      // .document(widget.note.documentid).setData({
      //   'upvotes': widget.note.upvotes,
      // }, merge: true).then((_){
      //   print("success at null upvotes!");
      //   });
        
        //persist(isSaved); // set an initial value
      } else {
        setState(() {
           isSaved = value.data['saved'][uid]; //accessing value 
           isUpvoted = value.data['upvotes'][uid];
        });
       print('set state upon opening page');
      }
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
      body: 
      SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: 
      Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
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
                      widget.note.profilePicture == null ?
                      NetworkImage('https://genslerzudansdentistry.com/wp-content/uploads/2015/11/anonymous-user.png')
                      : NetworkImage(widget.note.profilePicture),
                      backgroundColor: Colors.grey,
                      radius: 30,),
                      SizedBox(width: 10,),
                      Text(widget.note.username, style: TextStyle(fontWeight: FontWeight.bold,
                      fontSize: 18, decoration: TextDecoration.underline, color: Colors.grey[100])),
                      Spacer(),
                      IconButton(
                        icon: Icon(Icons.flag, color: Colors.red, size: 30,), 
                      onPressed: () { //report post
                        Navigator.push(context, 
              MaterialPageRoute(builder: (context) => ReportNotes(post: widget.note,)));
                      },),
                      Column(children: <Widget>[
                        Text('Report', style: TextStyle(color: Colors.grey[100]),),
                      Text('post', style: TextStyle(color: Colors.grey[100]),)
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
                      Text(widget.note.topic, 
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.grey[100]),
                      ),),
                    ]),),
                    Padding( 
                    padding: EdgeInsets.only(top: 4, bottom: 8),
                    child:
                    Row(children: <Widget>[
                      SizedBox(width: 10,),
                       Text('Link: ', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey[100])),
                      Expanded(child: 
                      Text(widget.note.link, 
                      style: TextStyle(fontSize: 18, color: Colors.grey[100]),
                      ),),
                    ]),),
                    widget.note.imageurl != null ?
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
                      child:  Image.network(widget.note.imageurl,
                      height: 300,
                      width: 400,),
                      ),
                     
                      //image of notes
                    ],),) : Container(height: 0,),
              Padding( 
                    padding: EdgeInsets.only(top: 4, bottom: 8),
                    child:
                    Row(children: <Widget>[
                      SizedBox(width: 10,),
                      Expanded(child: 
                      Text(widget.note.content, style: TextStyle(fontSize: 18, color: Colors.grey[100]),
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
              MaterialPageRoute(builder: (context) => NoteComment(
                comment: comment, post: widget.note,)));
              },),
          Text('Comment', style: TextStyle(color: Colors.grey[100])),
          SizedBox(width: 40),
          IconButton(
            icon: Icon( isSaved ? Icons.star :
              Icons.star_border, size: 30, color: 
              isSaved ? Colors.yellow[600] : Colors.tealAccent,),
              onPressed: () async {
               final uid = await Provider.of(context).auth.getCurrentUID();
                await _saved(); 
                 widget.note.saved.update(uid, (v) => isSaved, ifAbsent: () => isSaved);
                 await Firestore.instance.collection('public').document('CS2030')
                 .collection('Notes').document(widget.note.documentid).setData({
                   'saved': widget.note.saved, //new field is a map
                 }, merge: true).then((_){
                  print("successfully saved to firebase!");
                });
              },),
          Text(isSaved ? 'Unsave' : 'Save', style: TextStyle(color: Colors.grey[100])), //upon saving, saves post to home page
          SizedBox(width: 40),
          IconButton(
            onPressed: () async {
              final uid = await Provider.of(context).auth.getCurrentUID();
              await _upVoted(); 
              widget.note.upvotes.update(uid, (value) => isUpvoted, ifAbsent: () => isUpvoted);
              await Firestore.instance.collection('public').document('CS2030')
                 .collection('Notes').document(widget.note.documentid).setData({
                   'upvotes': widget.note.upvotes, //new field is a map
                 }, merge: true).then((_){
                  print("upvote successfully saved to firebase!");
                });    

              await Firestore.instance.collection('users').document(widget.note.ownerid)
                 .collection('private_notes').document(widget.note.documentid).setData({ //updating for private forums as well
                   'upvotes': widget.note.upvotes, //new field is a map
                 }, merge: true).then((_){
                  print("upvote successfully saved for private notes!");
                });  

            //updating for saved forums
             await Firestore.instance.collection('users').getDocuments().then((querySnapshot){
              querySnapshot.documents.forEach((result) { //result is each uid 
                Firestore.instance.collection('users').document(result.documentID)
                .collection('saved_notes').getDocuments().then((querySnapshot) {
                  querySnapshot.documents.forEach((element) { //each element is each saved forum
                    if(element.documentID == widget.note.documentid) {
                      Firestore.instance.collection('users').document(result.documentID)
                      .collection('saved_notes').document(element.documentID).setData({
                        'upvotes': widget.note.upvotes, //new field is a map
                 }, merge: true).then((_){
                  print("upvote saved notes!");
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
          Text(isUpvoted ? 'Unvote' : 'Upvote', style: TextStyle(color: Colors.grey[100])), //change to a function to keep track of counts
        ],)),
        //SizedBox(height: 20,),
        // Row(mainAxisAlignment: MainAxisAlignment.start,
        //   children: <Widget>[
        //   Text('  Comments:', style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold,
        //   color: Colors.grey[100])), 
        // ],),
       //SizedBox(height: 20,),
       //stream of comments
        StreamBuilder(
          stream: getUsersNotesCommentsSnapshot(context),
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
      ])  
    )));
  }

  Stream<QuerySnapshot> getUsersNotesCommentsSnapshot(BuildContext context) async* {
    //final uid = await Provider.of(context).auth.getCurrentUID();
    yield* Firestore.instance.collection('public')
    .document('CS2030').collection('Notes').document(widget.note.documentid).
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
                    Divider(color: Colors.grey),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.flag, color: Colors.red, size: 25,), 
                      onPressed: () { //report post
              //           Navigator.push(context, 
              // MaterialPageRoute(builder: (context) => Report(post: widget.note)));
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
          Upvotenotes(comment: commentPosted, post: widget.note,),
          SizedBox(width: 20),
                    ],)
                    ],)
                ,)
      ),),
            );
  }


}