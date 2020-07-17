import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:SoCUniteTwo/widgets/provider_widget.dart';
import 'package:SoCUniteTwo/screens/forum_screens/post.dart';
import 'package:SoCUniteTwo/screens/forum_screens/new2030.dart';
//qwwq'import 'package:search_app_bar/search_app_bar.dart';
import 'package:SoCUniteTwo/screens/forum_screens/details/forum_details.dart';

class CS2030forum extends StatefulWidget {
  @override
  _CS2030forumState createState() => _CS2030forumState();
}

class _CS2030forumState extends State<CS2030forum> {
  Future usernameData;
  String profilePicture;
  String username;
  var timeStamp = new DateTime.now();

  // void initState() {
  //   super.initState();
  //   // Provider.of(context).auth.getCurrentUser().then((user) {
  //   //   setState(() {
  //   //     profilePicture = user.photoURL;
  //   //   });
  //   // }).catchError((e) {
  //   //     print(e);
  //   // });
  // }

  
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

    final post = new Post(null,null,null,null,null,null,null,null,null,null,null); //to appear in CS2030 forum
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[850],
        title: Text("CS2030 - Forum"),
        actions: <Widget>[
          // IconButton(icon: Icon(Icons.search, color: Colors.blue[300]),
          //   onPressed: () {
          //   },
            
          // ),
          IconButton(icon: Icon(Icons.add, color: Colors.tealAccent),
            onPressed: () {
              Navigator.push(context, 
              MaterialPageRoute(builder: (context) => New2030(post: post)));
            },
          )
        ],
      ),
      // appBar: SearchAppBar(
      //   searcher: ,
      //   actions: <Widget>[
      //     IconButton(icon: Icon(Icons.add, color: Colors.tealAccent),
      //       onPressed: () {
      //         Navigator.push(context, 
      //         MaterialPageRoute(builder: (context) => New2030(post: post)));
      //       },
      //     )
      //   ],),
      backgroundColor: Colors.grey[900],
      body: Container(
        child: StreamBuilder(
          stream: getUsersForumPostsSnapshot(context),
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
          => buildForum(context, snapshot.data.documents[index]),
          itemCount: snapshot.data.documents.length,
        );
          }
        ),
      ) ,
     
    );
  }

  Stream<QuerySnapshot> getUsersForumPostsSnapshot(BuildContext context) async* {
    //final uid = await Provider.of(context).auth.getCurrentUID();
    yield* Firestore.instance.collection('public')
    .document('CS2030').collection('Forums').snapshots();
  }

  
  Widget buildForum(BuildContext context, DocumentSnapshot post) {
    final forum = Post.fromSnapshot(post);
    return Container(
      child: Builder(builder: (context) {
        return
      Card(
        color: Colors.grey[850],
        shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(18.0)),
        child: InkWell(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) => ForumDetails(forum: forum) //with this particular forum 
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
                      Spacer(),   
                    ],),
                    ),
                    SizedBox(height: 10),
                    Row(children: <Widget>[
                      SizedBox(width: 10,),
                      CircleAvatar(
                      backgroundImage: post['profilePicture'] != null ?
                      NetworkImage(post['profilePicture']) : 
                      NetworkImage('https://genslerzudansdentistry.com/wp-content/uploads/2015/11/anonymous-user.png'),
                      backgroundColor: Colors.grey,
                      radius: 20,),
                      SizedBox(width: 10,),                     
                      Text(post['username'], style: TextStyle(fontWeight: FontWeight.bold,
                      fontSize: 16, decoration: TextDecoration.underline, color: Colors.grey[100]),
                    ),
          //      FutureBuilder( 
          //     future: Firestore.instance.collection('users').document(post['ownerid']).get(),
          //     builder: (context, snapshot) {
          //       if (snapshot.connectionState == ConnectionState.done) {
          //         return Text(snapshot.data['username'], style: TextStyle(fontWeight: FontWeight.bold,
          //             fontSize: 16, decoration: TextDecoration.underline, color: Colors.grey[100]),
          //          );
          //       } else {
          //         return Text('not connected');
          //       }
                
          //     }, 
          // ),                 
                    ],),
                    SizedBox(height: 10),
                    Padding( 
                    padding: EdgeInsets.only(top: 4, bottom: 8),
                    child:
                    Row(children: <Widget>[
                      SizedBox(width: 10,), 
                      Expanded(child:
                      Text(post['title'], style: TextStyle(fontSize: 18,
                      fontWeight:FontWeight.bold, color: Colors.grey[100]))),
                    ],)),
                    //display image if there is
                    (post['imageurl'] != null)  ?
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
                      child:  Image.network(post['imageurl']),
                      ),
                      //image of notes
                    ],),) : Container(height:0),
                    Padding(
                    padding: EdgeInsets.only(top: 4, bottom: 8),
                    child:
                    Row(children: <Widget>[
                      SizedBox(width: 10,),
                      Expanded(child:
                      Text(post['content'], style: TextStyle(fontSize: 16, color: Colors.grey[100]),
                      overflow: TextOverflow.ellipsis, maxLines: 2,),),
                    ],)),
                    SizedBox(height: 20),
                    Row(children: <Widget>[
                      SizedBox(width: 10,),
                      // Icon(Icons.comment, size: 26,
                      // color: Colors.tealAccent),
                      //  SizedBox(width: 6,),
          //    FutureBuilder( 
          //     future: Firestore.instance.collection('public').document('CS2030')
          //     .collection('Forums').document(post['documentid']).collection('comments').get(),
          //     builder: (context, snapshot) {
          //       if (snapshot.connectionState == ConnectionState.done) {
          //         return Text(snapshot.data['username'], style: TextStyle(fontWeight: FontWeight.bold,
          //             fontSize: 16, decoration: TextDecoration.underline, color: Colors.grey[100]),
          //          );
          //       } else {
          //         return Text('not connected');
          //       }
                
          //     }, 
          // ),      
                      //Text('0', style: TextStyle(color: Colors.grey[100]),), //change to icons
                      Spacer(),
                      Icon(Icons.thumb_up, size: 26, color: Colors.tealAccent),
                      SizedBox(width: 6,),Text(post['upvotes'].values.where((e)=> e as bool).length.toString(), style: TextStyle(color: Colors.grey[100]),),
                    SizedBox(width: 10,)],)
                ],)
      ),));})
            );
    }
}