import 'package:SoCUniteTwo/screens/forum_screens/experiences/experience.dart';
import 'package:flutter/material.dart';
import 'package:SoCUniteTwo/widgets/provider_widget.dart';
import 'package:SoCUniteTwo/screens/forum_screens/experiences/newexperience.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:SoCUniteTwo/screens/forum_screens/experiences/experience_details.dart';


class Experiences extends StatefulWidget {
  @override
  _ExperiencesState createState() => _ExperiencesState();
}

class _ExperiencesState extends State<Experiences> {
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

    final post = new Experience(null,null,null,null,null,null,null,null,null,null,null,null,null);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[850],
        title: Text("Internship experiences"),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.add, color: Colors.tealAccent),
            onPressed: () {
              print(profilePicture);
              Navigator.push(context, 
              MaterialPageRoute(builder: (context) => NewExperience(post: post)));
            },
          )
        ],
      ),
      backgroundColor: Colors.grey[900],
      body: Container(
        child: StreamBuilder(
          stream: getUsersExperiencesPostsSnapshot(context),
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
          => buildExperience(context, snapshot.data.documents[index]),
          itemCount: snapshot.data.documents.length,
        );
          }
        ),
      ) ,
     
    );
  }

  Stream<QuerySnapshot> getUsersExperiencesPostsSnapshot(BuildContext context) async* {
    //final uid = await Provider.of(context).auth.getCurrentUID();
    yield* Firestore.instance.collection('public')
    .document('internship_experiences').collection('Experiences').snapshots();
  }


  Widget buildExperience(BuildContext context, DocumentSnapshot post) {
    final experience = Experience.fromSnapshot(post);
    return Container(
      child: Card(
        color: Colors.grey[850],
        shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(18.0)),
        child: InkWell(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) => ExperienceDetails(experience: experience) //with this particular forum 
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
                        
                        //need to loop and delete from saved 

                        await Firestore.instance.collection('users').document(uid)
                        .collection('private_experiences').document(post.documentID).delete();

                        await Firestore.instance.collection('public').document('internship_experiences')
                        .collection('Experiences').document(post.documentID).delete();

                        await Firestore.instance.collection('users').getDocuments().then((querySnapshot){
                        querySnapshot.documents.forEach((result) { //result is each uid 
                        Firestore.instance.collection('users').document(result.documentID)
                        .collection('saved_experiences').getDocuments().then((querySnapshot) {
                        querySnapshot.documents.forEach((element) { //each element is each saved forum
                        if(element.documentID == post.documentID) {
                        Firestore.instance.collection('users').document(result.documentID)
                        .collection('saved_experiences').document(element.documentID).delete();
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
                      Text("Time period of internship: ", style: TextStyle(fontSize: 17,
                      fontWeight:FontWeight.bold,color: Colors.grey[100])),
                      SizedBox(width: 10,), 
                      Expanded(child:
                      Text(post['timePeriod'], style: TextStyle(fontSize: 17, color: Colors.grey[100]
                      ))),
                    ],)),
                    Padding( 
                    padding: EdgeInsets.only(top: 4, bottom: 8),
                    child:
                    Row(children: <Widget>[
                      SizedBox(width: 10,), 
                      Text("Company:", style: TextStyle(fontSize: 17,fontWeight:FontWeight.bold, color: Colors.grey[100]),),
                      SizedBox(width: 10,), 
                      Text(post['company'], style: TextStyle(fontSize: 17, color: Colors.grey[100]
                      )),
                    ],)),
                    Padding( 
                    padding: EdgeInsets.only(top: 4, bottom: 8),
                    child:
                    Row(children: <Widget>[
                      SizedBox(width: 10,), 
                      Text('Role:', style: TextStyle(fontSize: 17,fontWeight:FontWeight.bold, color: Colors.grey[100])),
                      SizedBox(width: 10,), 
                      Expanded(child: 
                      Text(post['role'], style: TextStyle(fontSize: 18,  color: Colors.grey[100])),)
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
                      SizedBox(width: 6),
                      Text('0', style: TextStyle(color: Colors.grey[100]),), //change to icons
                      Spacer(),
                      Icon(Icons.thumb_up, size: 26, color: Colors.tealAccent),
                      SizedBox(width: 6),
                      Text(post['upvotes'].values.where((e)=> e as bool).length.toString(), style: TextStyle(color: Colors.grey[100])),
                    SizedBox(width: 10,),],)
                ],)
      ),),)
            );
    }
}