import 'package:flutter/material.dart';
import 'package:SoCUniteTwo/widgets/provider_widget.dart';
import 'package:SoCUniteTwo/screens/forum_screens/post_notes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:SoCUniteTwo/screens/forum_screens/details/notes_details.dart';


class SavedNotes extends StatefulWidget {
  @override
  _SavedNotesState createState() => _SavedNotesState();
}

class _SavedNotesState extends State<SavedNotes> {
  String profilePicture;
  String username;
  var timeStamp = new DateTime.now();

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
        title: Text("Saved Notes"),
      ),
      backgroundColor: Colors.grey[900],
      body: Container(
        child: StreamBuilder(
          stream: getUsersNotesPostsSnapshot(context),
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
          => buildNotes(context, snapshot.data.documents[index]),
          itemCount: snapshot.data.documents.length,
        );
          }
        ),
      ) ,
     
    );
  }

  Stream<QuerySnapshot> getUsersNotesPostsSnapshot(BuildContext context) async* {
    final uid = await Provider.of(context).auth.getCurrentUID();
    yield* Firestore.instance.collection('users')
    .document(uid).collection('saved_notes').snapshots();
  }


  Widget buildNotes(BuildContext context, DocumentSnapshot note) {
    final post = PostNotes.fromSnapshot(note);
    return Container(
              child: Card(
                color: Colors.grey[850],
                shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(18.0)),
                child: InkWell(
                  onTap: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) => NotesDetails(note: post
            )));
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
                    ]),),
                    SizedBox(height: 10),
                    Row(children: <Widget>[
                      SizedBox(width: 10,),
                      CircleAvatar(
                      backgroundImage: note['profilePicture'] != null ?
                      NetworkImage(note['profilePicture']) : 
                      NetworkImage('https://genslerzudansdentistry.com/wp-content/uploads/2015/11/anonymous-user.png'),
                      backgroundColor: Colors.grey,
                      radius: 20,),
                      SizedBox(width: 10,),
                      Text(note['username'], style: TextStyle(fontWeight: FontWeight.bold,
                      fontSize: 16, decoration: TextDecoration.underline, color: Colors.grey[100]),
          //             FutureBuilder( 
          //     future: Provider.of(context).auth.getCurrentUser(),
          //     builder: (context, snapshot) {
          //       if (snapshot.connectionState == ConnectionState.done) {
          //         return Text("${snapshot.data.displayName}", style: TextStyle(fontWeight: FontWeight.bold,
          //          fontSize: 16, decoration: TextDecoration.underline,),
          //          );
          //       } else {
          //         return CircularProgressIndicator();
          //       }
          //     }, 
          // ),
                    )],),
                    SizedBox(height: 10),
                    Padding( 
                    padding: EdgeInsets.only(top: 4, bottom: 8),
                    child:
                    Row(children: <Widget>[
                      SizedBox(width: 10,), 
                      Expanded(child: 
                      Text(note['topic'], style: TextStyle(fontSize: 18,
                      fontWeight:FontWeight.bold, color: Colors.grey[100]))),
                      Spacer(),
                    ],),),
                    Padding( 
                    padding: EdgeInsets.only(top: 4, bottom: 8),
                    child:
                    Row(children: <Widget>[
                      SizedBox(width: 10,), 
                      Text('Link: ', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.grey[100])),
                      Expanded(child:
                      Text((note['link'] != null ? note['link'] : "none"
                      ), style: TextStyle(fontSize: 15, color: Colors.grey[100]), overflow: TextOverflow.ellipsis, maxLines: 1,)),
                    ],),),
                    note['imageurl'] != null ?
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
                    ],),) : Container(height: 0,),
                    Padding( 
                    padding: EdgeInsets.only(top: 4, bottom: 8),
                    child:
                    Row(children: <Widget>[
                      SizedBox(width: 10,), 
                      Expanded(child:
                      Text(note['content'], style: TextStyle(fontSize: 16, color: Colors.grey[100]), overflow: TextOverflow.ellipsis,
                      maxLines: 2,),),
                      //image of notes
                    ],),),
                    SizedBox(height: 20),
                    Row(children: <Widget>[
                      SizedBox(width: 10,),
                      Icon(Icons.comment, size: 26, color: Colors.tealAccent), 
                       SizedBox(width: 6,),
                      Text('0', style: TextStyle(color: Colors.grey[100]),), //change to icons
                      Spacer(),
                      Icon(Icons.thumb_up, size: 26, color: Colors.tealAccent),
                       SizedBox(width: 6,),
                      Text(note['upvotes'].values.where((e)=> e as bool).length.toString(),style: TextStyle(color: Colors.grey[100]),),
                     SizedBox(width: 10,),],)
                  ],
                ),
                )
              ),
    );          
  }
}