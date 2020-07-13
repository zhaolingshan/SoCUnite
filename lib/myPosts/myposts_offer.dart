import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:SoCUniteTwo/widgets/provider_widget.dart';
//import 'package:intl/intl.dart';
import 'package:SoCUniteTwo/screens/forum_screens/internship_offers/offer_details.dart';
import 'package:SoCUniteTwo/screens/forum_screens/internship_offers/offer.dart';

class MyPostsOffers extends StatefulWidget {
  @override
  _MyPostsOffersState createState() => _MyPostsOffersState();
}

class _MyPostsOffersState extends State<MyPostsOffers> {
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
        title: Text("My posts: Internship Offers"),
      ),
      body: Container(
        child: StreamBuilder(
          stream: getUserPrivateOffersStreamSnapshot(context),
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
          => buildPrivateOffers(context, 
          snapshot.data.documents[index])
          );
          } 
        )
        ),
    );
  }

  Stream<QuerySnapshot> getUserPrivateOffersStreamSnapshot(BuildContext context) async* {
    final uid = await Provider.of(context).auth.getCurrentUID();
    yield* Firestore.instance.collection('users').document(uid).collection('private_offers').snapshots();
  }

  Widget buildPrivateOffers(BuildContext context, DocumentSnapshot post) {
    final offer = Offer.fromSnapshot(post);
    return Container(
      child: Card(
        color: Colors.grey[850],
        shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(18.0)),
        child: InkWell(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) => OfferDetails(offer: offer) //with this particular forum 
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
                      IconButton(
                      iconSize: 30,
                      color: Colors.lightGreenAccent,
                      icon: Icon(Icons.delete_forever),
                      onPressed: () async {

                        final uid = await Provider.of(context).auth.getCurrentUID();

                        await Firestore.instance.collection('users').document(uid)
                        .collection('private_offers').document(post.documentID).delete();

                        await Firestore.instance.collection('public').document('internship_offers')
                        .collection('Offers').document(post.documentID).delete();

                        // final snackBar = SnackBar(
                        // content: Text('Your password change is successful!'),
                        // duration: Duration(seconds: 3),);

                        // Scaffold.of(context).showSnackBar(snackBar);

                      },)  
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
                    )],),
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
                      Text("Contact details ", style: TextStyle(fontSize: 17,
                      fontWeight:FontWeight.bold, decoration: TextDecoration.underline,  color: Colors.grey[100])),
                    ],)),
                    Padding( 
                    padding: EdgeInsets.only(top: 4, bottom: 8),
                    child:
                    Row(children: <Widget>[
                      SizedBox(width: 10,), 
                      Text("Company:", style: TextStyle(fontSize: 17,  color: Colors.grey[100]),),
                      SizedBox(width: 5,), 
                      Text(post['company'], style: TextStyle(fontSize: 17, color: Colors.grey[100]
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
                      SizedBox(width: 6,),Text('0', style: TextStyle(color: Colors.grey[100]),), //change to icons
                      Spacer(),
                      Icon(Icons.thumb_up, size: 26, color: Colors.tealAccent),
                      SizedBox(width: 6,),
                      Text(post['upvotes'].values.where((e)=> e as bool).length.toString(), style: TextStyle(color: Colors.grey[100])),
                    SizedBox(width: 10,),],)
                ],)
      ),),)
            );
    }
}