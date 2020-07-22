import 'package:SoCUniteTwo/screens/forum_screens/collaborations/collaboration.dart';
import 'package:flutter/material.dart';
import 'package:SoCUniteTwo/screens/forum_screens/details/report_two.dart';
import 'package:SoCUniteTwo/widgets/provider_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:SoCUniteTwo/screens/forum_screens/details/comments.dart';

class ReportCollaborationComment extends StatefulWidget {
  final Collaboration post; //forum
  final Comments comment;

  ReportCollaborationComment({Key key, @required this.post, @required this.comment}) : super(key: key);
  @override
  _ReportCollaborationCommentState createState() => _ReportCollaborationCommentState();
}

class _ReportCollaborationCommentState extends State<ReportCollaborationComment> {

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(title: 
      Text("Report", textAlign: TextAlign.center,),
      backgroundColor: Colors.grey[900],
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
      body: Column(
        children: <Widget>[
          SizedBox(height: 10),
          Padding(
            padding: EdgeInsets.all(7),
          child:
          Text(
            "Why are you reporting this comment under 'Collaborations'?",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,
           color: Colors.white),
          textAlign: TextAlign.center,),),
          SizedBox(height: 10,),
          Text(
            "Please choose the following that applies.",
          style: TextStyle(fontSize: 15,
           color: Colors.grey[50]),
          textAlign: TextAlign.center,),
          SizedBox(height: 10),
           Divider(
              color: Colors.grey[800],
              thickness: 1,),
          ListTile(
              onTap: () async { //add into the map uid -> true 
              final uid = await Provider.of(context).auth.getCurrentUID();
                widget.post.reported.putIfAbsent(uid, () => true);
                await Firestore.instance.collection('public').document('collaborations').collection('Collaborations')
                .document(widget.post.documentid).collection('comments').document(widget.comment.documentid).setData({
                  'reported': widget.post.reported,
                },merge : true).then((_){
                print("success!");
                }); //for public 

                DocumentSnapshot doc = await Firestore.instance.collection('public').document('collaborations').
                collection('Collaborations').document(widget.post.documentid).collection('comments').document(widget.comment.documentid).get();
                //print(doc.data['reported']);
                if(doc.data['reported'].length >= 5) {
                    await Firestore.instance.collection('public').document('collaborations').collection('Collaborations')
                  .document(widget.post.documentid).collection('comments').document(widget.comment.documentid).delete(); //deleting for public
                print('DELETED');          
                }
               
                Navigator.push(context, MaterialPageRoute(
              builder: (context) => ReportTwo() 
            ));

              },
              title: Text("Bullying or harrassment",
               style: TextStyle(fontSize: 19,
               color: Colors.white),),
              trailing: Icon(Icons.keyboard_arrow_right, color: Colors.white,),
            ),
            Divider(
              color: Colors.grey[800],
              thickness: 1,),
              ListTile(
              subtitle: Text("That was obviously done on purpose.",
              style: TextStyle(fontSize: 14, color: Colors.grey),),
              onTap: () async { 
              final uid = await Provider.of(context).auth.getCurrentUID();
                widget.post.reported.putIfAbsent(uid, () => true);
                await Firestore.instance.collection('public').document('collaborations').collection('Collaborations')
                .document(widget.post.documentid).collection('comments').document(widget.comment.documentid).setData({
                  'reported': widget.post.reported,
                },merge : true).then((_){
                print("success!");
                }); //for public 

                DocumentSnapshot doc = await Firestore.instance.collection('public').document('collaborations').
                collection('Collaborations').document(widget.post.documentid).collection('comments').document(widget.comment.documentid).get();
                //print(doc.data['reported']);
                if(doc.data['reported'].length >= 5) {
                    await Firestore.instance.collection('public').document('collaborations').collection('Collaborations')
                  .document(widget.post.documentid).collection('comments').document(widget.comment.documentid).delete(); //deleting for public
                print('DELETED');          
                }
                Navigator.push(context, MaterialPageRoute(
              builder: (context) => ReportTwo() //stateful widget
            ));
              },
              title: Text("False information",
               style: TextStyle(fontSize: 19,
               color: Colors.white),),
              trailing: Icon(Icons.keyboard_arrow_right, color: Colors.white,),
            ),
            Divider(
              color: Colors.grey[800],
              thickness: 1,),
              ListTile(
              onTap: () async { 
               final uid = await Provider.of(context).auth.getCurrentUID();
                widget.post.reported.putIfAbsent(uid, () => true);
                await Firestore.instance.collection('public').document('collaborations').collection('Collaborations')
                .document(widget.post.documentid).collection('comments').document(widget.comment.documentid).setData({
                  'reported': widget.post.reported,
                },merge : true).then((_){
                print("success!");
                }); //for public 

                DocumentSnapshot doc = await Firestore.instance.collection('public').document('collaborations').
                collection('Collaborations').document(widget.post.documentid).collection('comments').document(widget.comment.documentid).get();
                //print(doc.data['reported']);
                if(doc.data['reported'].length >= 5) {
                    await Firestore.instance.collection('public').document('collaborations').collection('Collaborations')
                  .document(widget.post.documentid).collection('comments').document(widget.comment.documentid).delete(); //deleting for public
                print('DELETED');          
                }
                Navigator.push(context, MaterialPageRoute(
              builder: (context) => ReportTwo() //stateful widget
            ));
              },
              title: Text("Hate speech or symbols",
               style: TextStyle(fontSize: 19,
               color: Colors.white),),
              trailing: Icon(Icons.keyboard_arrow_right, color: Colors.white,),
            ),
            Divider(
              color: Colors.grey[800],
              thickness: 1,),
              ListTile(
              onTap: () async { 
             final uid = await Provider.of(context).auth.getCurrentUID();
                widget.post.reported.putIfAbsent(uid, () => true);
                await Firestore.instance.collection('public').document('collaborations').collection('Collaborations')
                .document(widget.post.documentid).collection('comments').document(widget.comment.documentid).setData({
                  'reported': widget.post.reported,
                },merge : true).then((_){
                print("success!");
                }); //for public 

                DocumentSnapshot doc = await Firestore.instance.collection('public').document('collaborations').
                collection('Collaborations').document(widget.post.documentid).collection('comments').document(widget.comment.documentid).get();
                //print(doc.data['reported']);
                if(doc.data['reported'].length >= 5) {
                    await Firestore.instance.collection('public').document('collaborations').collection('Collaborations')
                  .document(widget.post.documentid).collection('comments').document(widget.comment.documentid).delete(); //deleting for public
                print('DELETED');          
                }
                Navigator.push(context, MaterialPageRoute(
              builder: (context) => ReportTwo() //stateful widget
            ));
              },
              title: Text("Scam or fraud",
               style: TextStyle(fontSize: 19,
               color: Colors.white),),
              trailing: Icon(Icons.keyboard_arrow_right, color: Colors.white,),
            ),
            Divider(
              color: Colors.grey[800],
              thickness: 1,),
              ListTile(
              onTap: () async { 
                final uid = await Provider.of(context).auth.getCurrentUID();
                widget.post.reported.putIfAbsent(uid, () => true);
                await Firestore.instance.collection('public').document('collaborations').collection('Collaborations')
                .document(widget.post.documentid).collection('comments').document(widget.comment.documentid).setData({
                  'reported': widget.post.reported,
                },merge : true).then((_){
                print("success!");
                }); //for public 

                DocumentSnapshot doc = await Firestore.instance.collection('public').document('collaborations').
                collection('Collaborations').document(widget.post.documentid).collection('comments').document(widget.comment.documentid).get();
                //print(doc.data['reported']);
                if(doc.data['reported'].length >= 5) {
                    await Firestore.instance.collection('public').document('collaborations').collection('Collaborations')
                  .document(widget.post.documentid).collection('comments').document(widget.comment.documentid).delete(); //deleting for public
                print('DELETED');          
                }
                Navigator.push(context, MaterialPageRoute(
              builder: (context) => ReportTwo() //stateful widget
            ));
              },
              title: Text("Sale of goods",
               style: TextStyle(fontSize: 19,
               color: Colors.white),),
              trailing: Icon(Icons.keyboard_arrow_right, color: Colors.white,),
            ),
            Divider(
              color: Colors.grey[800],
              thickness: 1,),
              ListTile(
              onTap: () async { 
               final uid = await Provider.of(context).auth.getCurrentUID();
                widget.post.reported.putIfAbsent(uid, () => true);
                await Firestore.instance.collection('public').document('collaborations').collection('Collaborations')
                .document(widget.post.documentid).collection('comments').document(widget.comment.documentid).setData({
                  'reported': widget.post.reported,
                },merge : true).then((_){
                print("success!");
                }); //for public 

                DocumentSnapshot doc = await Firestore.instance.collection('public').document('collaborations').
                collection('Collaborations').document(widget.post.documentid).collection('comments').document(widget.comment.documentid).get();
                //print(doc.data['reported']);
                if(doc.data['reported'].length >= 5) {
                    await Firestore.instance.collection('public').document('collaborations').collection('Collaborations')
                  .document(widget.post.documentid).collection('comments').document(widget.comment.documentid).delete(); //deleting for public
                print('DELETED');          
                }
                Navigator.push(context, MaterialPageRoute(
              builder: (context) => ReportTwo() //stateful widget
            ));
              },
              title: Text("Suicide, self-injury or eating disorders",
               style: TextStyle(fontSize: 19,
               color: Colors.white),),
              trailing: Icon(Icons.keyboard_arrow_right, color: Colors.white,),
            ),
            Divider(
              color: Colors.grey[800],
              thickness: 1,),
      ],),

      
    );
  }
}