import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:SoCUniteTwo/widgets/provider_widget.dart';
//import 'package:intl/intl.dart';
import 'package:SoCUniteTwo/screens/forum_screens/post_notes.dart';
import 'package:SoCUniteTwo/screens/forum_screens/details/notes_details.dart';

class MyPostsNotes extends StatefulWidget {
  @override
  _MyPostsNotesState createState() => _MyPostsNotesState();
}

class _MyPostsNotesState extends State<MyPostsNotes> {

  void _showDialog() { //to appear on owner's screen when report hits 5 
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Padding(
   padding: EdgeInsets.only(left: 50.0, right: 50.0, top: 20, bottom: 20),
   child:
        AlertDialog(
          backgroundColor: Colors.grey[850],
          title: new Text(
            "This post has been reported.",
            style: TextStyle(color: Colors.blue[300]),
            ),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget> [
              Text(
                "Your post has been reported by several users for not abiding by the guidelines and has been deleted from public view.",
                style: TextStyle(color: Colors.grey[100]),
              ),
              SizedBox(height:10,),
               Text(
                "Please take note of the guidelines before making a post.  ",
                style: TextStyle(color: Colors.grey[100]),
              )
            ],
          ),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              color: Colors.blue[300],
              child: new Text(
                "Close",
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
  DateTime timeStamp = DateTime.now();
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
        title: Text("My posts: Notes"),
      ),
      body: Container(
        child: StreamBuilder(
          stream: getUserPrivateNotesStreamSnapshot(context),
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
          => buildPrivateNotes(context, 
          snapshot.data.documents[index])
          );
          } 
        )
        ),
    );
  }

  Stream<QuerySnapshot> getUserPrivateNotesStreamSnapshot(BuildContext context) async* {
    final uid = await Provider.of(context).auth.getCurrentUID();
    yield* Firestore.instance.collection('users').document(uid).collection('private_notes').snapshots();
  }

  Widget buildPrivateNotes(BuildContext context, DocumentSnapshot note) {
    final post = PostNotes.fromSnapshot(note);
    return Container(
              child: Card(
                color: Colors.grey[850],
                shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(15.0),),
                child: InkWell(
                  onTap: () {
                    if(note['reported'].length >= 5) {
                      _showDialog();
                    } else {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) => NotesDetails(note: post
            )));
                    }
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
                      Text(note['timestamp'], style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,
                      color: Colors.grey[400]),),
                      Spacer(),
                      IconButton(
                      iconSize: 30,
                      color: Colors.lightGreenAccent,
                      icon: Icon(Icons.delete_forever),
                      onPressed: () async {
                        final uid = await Provider.of(context).auth.getCurrentUID();

                        await Firestore.instance.collection('users').document(uid)
                        .collection('private_notes').document(note.documentID).delete();

                        await Firestore.instance.collection('public').document('CS2030')
                        .collection('Notes').document(note.documentID).delete();

                        await Firestore.instance.collection('users').getDocuments().then((querySnapshot){
                        querySnapshot.documents.forEach((result) { //result is each uid 
                        Firestore.instance.collection('users').document(result.documentID)
                        .collection('saved_notes').getDocuments().then((querySnapshot) {
                        querySnapshot.documents.forEach((element) { //each element is each saved forum
                        if(element.documentID == note.documentID) {
                        Firestore.instance.collection('users').document(result.documentID)
                        .collection('saved_notes').document(element.documentID).delete();
                        }
                        });
                        });
                        });
                        });
                      },)  
                    ]),),
                    SizedBox(height: 10),
                    Row(children: <Widget>[
                      SizedBox(width: 10,),
                      FutureBuilder( 
                future: Firestore.instance.collection('users').document(note['ownerid']).get(),
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
                      // backgroundImage: note['profilePicture'] != null ?
                      // NetworkImage(note['profilePicture']) : 
                      // NetworkImage('https://genslerzudansdentistry.com/wp-content/uploads/2015/11/anonymous-user.png'),
                      // backgroundColor: Colors.grey,
                      // radius: 20,),
                      SizedBox(width: 10,),
                    //   Text(note['username'], style: TextStyle(fontWeight: FontWeight.bold,
                    //   fontSize: 16, decoration: TextDecoration.underline, color: Colors.grey[100]),
                    // )
                    FutureBuilder( 
                future: Firestore.instance.collection('users').document(note['ownerid']).get(),
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
                      Text(note['topic'], style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey[100]),
                      maxLines: 1, overflow: TextOverflow.ellipsis,)),
                      Spacer(),
                    ],),),
                    Padding( 
                    padding: EdgeInsets.only(top: 4, bottom: 8),
                    child:
                    Row(children: <Widget>[
                      SizedBox(width: 10,), 
                      Text('Link: ', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.grey[100])),
                      Expanded(child:
                      Text((note['link'] != null ? note['link'] : "None"), style: TextStyle(color: Colors.grey[100]), overflow: TextOverflow.ellipsis, maxLines: 1,)),
                    ],),),
                    (note['imageurl'] != null)  ?
                    Padding( 
                    padding: EdgeInsets.only(top: 4, bottom: 8),
                    child:
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                      SizedBox(width: 10,), 
                      ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8.0),
                      topRight: Radius.circular(8.0),
                      ),
                      child:  Image.network(note['imageurl']),
                      ),
                      //image of notes
                    ],),) : Container(height:0),
                    Padding( 
                    padding: EdgeInsets.only(top: 4, bottom: 8),
                    child:
                    Row(children: <Widget>[
                      SizedBox(width: 10,), 
                      Expanded(child:
                      Text(note['content'], style: TextStyle(fontSize: 15, color: Colors.grey[100]), overflow: TextOverflow.ellipsis,
                      maxLines: 2,),),
                      //image of notes
                    ],),),
                    SizedBox(height: 20),
                    Row(children: <Widget>[
                      // SizedBox(width: 10,),
                      // Icon(Icons.comment, size: 26, color: Colors.tealAccent), 
                      // SizedBox(width: 6,),Text('0', style: TextStyle(color: Colors.grey[100]),), //change to icons
                      Spacer(),
                      Icon(Icons.thumb_up, size: 26, color: Colors.tealAccent),
                      SizedBox(width: 6,),
                      Text(note['upvotes'].values.where((e)=> e as bool).length.toString(), style: TextStyle(color: Colors.grey[100])),
                    SizedBox(width: 10,),],)
                  ],
                ),
                )
              ),
    );          
  }

}