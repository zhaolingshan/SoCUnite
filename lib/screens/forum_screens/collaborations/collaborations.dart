import 'package:SoCUniteTwo/screens/forum_screens/collaborations/collaboration.dart';
import 'package:flutter/material.dart';
import 'package:SoCUniteTwo/widgets/provider_widget.dart';
import 'package:SoCUniteTwo/screens/forum_screens/collaborations/newcollaboration.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:SoCUniteTwo/screens/forum_screens/collaborations/collaboration_details.dart';

class Collaborations extends StatefulWidget {
  @override
  _CollaborationsState createState() => _CollaborationsState();
}

class _CollaborationsState extends State<Collaborations> {
  String profilePicture;
  String username;

  getUID() async { //returning instance of futuredynamic
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

    final post = new Collaboration(null,null,null,null,null,null,null,null,null,null,null,null,null,null,null);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[850],
        title: Text("Collaborations"),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.add, color: Colors.tealAccent),
            onPressed: () {
              print(profilePicture);
              Navigator.push(context, 
              MaterialPageRoute(builder: (context) => NewCollaboration(post: post)));
            },
          )
        ],
      ),
      backgroundColor: Colors.grey[900],
      body: Container(
        child: StreamBuilder(
          stream: getUsersCollaborationsPostsSnapshot(context),
          builder: (context, snapshot) {
            if(!snapshot.hasData) return Center(child: 
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
              CircularProgressIndicator()
            ],)); 
            return new ListView.builder(
          itemBuilder: (BuildContext context, int index) 
          => buildForum(context, snapshot.data.documents[index]),
          itemCount: snapshot.data.documents.length,
        );
          }
        ),
      ) ,
     
    );
  }

  Stream<QuerySnapshot> getUsersCollaborationsPostsSnapshot(BuildContext context) async* {
    //final uid = await Provider.of(context).auth.getCurrentUID();
    yield* Firestore.instance.collection('public')
    .document('collaborations').collection('Collaborations').snapshots();
  }


  Widget buildForum(BuildContext context, DocumentSnapshot post) {
    final collaboration = Collaboration.fromSnapshot(post);
    return Container(
      child: Card(
        color: Colors.grey[850],
        shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(18.0)),
        child: InkWell(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) => CollaborationDetails(collaboration: collaboration) //with this particular forum 
            ));
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
                      Text('Uploaded on ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,
                      color: Colors.grey[400]),),
                      Text(post['timestamp'], 
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,
                      color: Colors.grey[400]),),
                      SizedBox(width: 10,),
                      (post['isResolved'] ? Card(
                       color: Colors.redAccent[400],
                       elevation: 10,
                        margin: EdgeInsets.all(6.0),
                        child: Padding(
                          padding: EdgeInsets.only(top: 2, bottom: 2, left: 3, right: 3),
                          child: Text('CLOSED',
                           style: TextStyle(fontWeight: FontWeight.bold),))) : 
                     Card(
                       color: Colors.lightGreenAccent[400],
                       elevation: 10,
                        margin: EdgeInsets.all(6.0),
                        child: Padding(
                          padding: EdgeInsets.only(top: 2, bottom: 2, left: 3, right: 3),
                          child: Text('AVAILABLE',
                           style: TextStyle(fontWeight: FontWeight.bold),)))),
                      Spacer(),
                      FutureBuilder(
                        future: getUID(), //returns uid
                        builder: (context, AsyncSnapshot snapshot) {
                          if (snapshot.data == post['ownerid']) {
                            return  IconButton(
                              iconSize: 30,
                              color: Colors.blue[300],
                              icon: Icon(Icons.delete_forever),
                              onPressed: () async {
                                final uid = await Provider.of(context).auth.getCurrentUID();

                        await Firestore.instance.collection('users').document(uid)
                        .collection('private_collaborations').document(post.documentID).delete();

                        await Firestore.instance.collection('public').document('collaborations')
                        .collection('Collaborations').document(post.documentID).delete();

                        await Firestore.instance.collection('users').getDocuments().then((querySnapshot){
                        querySnapshot.documents.forEach((result) { //result is each uid 
                        Firestore.instance.collection('users').document(result.documentID)
                        .collection('saved_collaborations').getDocuments().then((querySnapshot) {
                        querySnapshot.documents.forEach((element) { //each element is each saved forum
                        if(element.documentID == post.documentID) {
                        Firestore.instance.collection('users').document(result.documentID)
                        .collection('saved_collaborations').document(element.documentID).delete();
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
                    ],),
                    ),
                    SizedBox(height: 10),
                    Row(children: <Widget>[
                      SizedBox(width: 10,),
                      FutureBuilder( 
                future: Firestore.instance.collection('users').document(post['ownerid']).get(),
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
                      // backgroundImage: post['profilePicture'] != null ?
                      // NetworkImage(post['profilePicture']) : 
                      // NetworkImage('https://genslerzudansdentistry.com/wp-content/uploads/2015/11/anonymous-user.png'),
                      // backgroundColor: Colors.grey,
                      // radius: 20,),
                      SizedBox(width: 10,),
                      FutureBuilder( 
                future: Firestore.instance.collection('users').document(post['ownerid']).get(),
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
                    //   Text(post['username'], style: TextStyle(fontWeight: FontWeight.bold,
                    //   fontSize: 16, decoration: TextDecoration.underline, color: Colors.grey[100]),
                    // )
                    ],),
                    SizedBox(height: 10),
                    Padding( 
                    padding: EdgeInsets.only(top: 4, bottom: 8),
                    child:
                    Row(children: <Widget>[
                      SizedBox(width: 10,), 
                      Expanded(child:
                      Text(post['title'], style: TextStyle(fontSize: 18,
                      fontWeight:FontWeight.bold,  color: Colors.grey[100]))),
                    ],)),
                    Padding( 
                    padding: EdgeInsets.only(top: 4, bottom: 8),
                    child:
                    Row(children: <Widget>[
                      SizedBox(width: 10,), 
                      Text("My contact details ", style: TextStyle(fontSize: 17,
                      fontWeight:FontWeight.bold, decoration: TextDecoration.underline,  color: Colors.grey[100])),
                    ],)),
                    Padding( 
                    padding: EdgeInsets.only(top: 4, bottom: 8),
                    child:
                    Row(children: <Widget>[
                      SizedBox(width: 10,), 
                      Text("Name:", style: TextStyle(fontSize: 17,  color: Colors.grey[100]),),
                      SizedBox(width: 10,), 
                      Text(post['name'], style: TextStyle(fontSize: 17, color: Colors.grey[100]
                      )),
                    ],)),
                    Padding( 
                    padding: EdgeInsets.only(top: 4, bottom: 8),
                    child:
                    Row(children: <Widget>[
                      SizedBox(width: 10,), 
                      Expanded(child: 
                      Text(post['contact'], style: TextStyle(fontSize: 18,  color: Colors.grey[100])),)
                    ],)),
                    Padding( 
                    padding: EdgeInsets.only(top: 4, bottom: 8),
                    child:
                    Row(children: <Widget>[
                      SizedBox(width: 10,), 
                      Text("Reference materials ", style: TextStyle(fontSize: 18,
                      fontWeight:FontWeight.bold, decoration: TextDecoration.underline,  color: Colors.grey[100])),
                    ],)),
                    Padding( 
                    padding: EdgeInsets.only(top: 4, bottom: 8),
                    child:
                    Row(children: <Widget>[
                      SizedBox(width: 10,), 
                      Expanded(child:
                      Text(post['link'], style: TextStyle(fontSize: 18,  color: Colors.grey[100]))),
                    ],)),
                    Padding( 
                    padding: EdgeInsets.only(top: 4, bottom: 8),
                    child:
                    Row(children: <Widget>[
                      SizedBox(width: 10,), 
                      Text("Details ", style: TextStyle(fontSize: 18,
                      fontWeight:FontWeight.bold,  color: Colors.grey[100])),
                    ],)),
                
                    Padding(
                    padding: EdgeInsets.only(top: 4, bottom: 8),
                    child:
                    Row(children: <Widget>[
                      SizedBox(width: 10,),
                      Expanded(child:
                      Text(post['content'], style: TextStyle(fontSize: 17,  color: Colors.grey[100]),
                      overflow: TextOverflow.ellipsis, maxLines: 1,),),
                    ],)),
                    SizedBox(height: 20),
                    Row(children: <Widget>[
                      SizedBox(width: 10,),
                      Icon(Icons.comment, size: 26,
                      color: Colors.tealAccent), 
                      SizedBox(width: 6,),
                      Text('0', style: TextStyle(color: Colors.grey[100]),), //change to icons
                      Spacer(),
                      Icon(Icons.thumb_up, size: 26, color: Colors.tealAccent),
                      SizedBox(width: 6,),
                      Text(post['upvotes'].values.where((e)=> e as bool).length.toString(), style: TextStyle(color: Colors.grey[100])),
                    SizedBox(width: 10,)],)
                ],)
      ),),)
            );
    }
}