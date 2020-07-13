import 'package:SoCUniteTwo/widgets/provider_widget.dart';
import 'package:flutter/material.dart';
//import 'package:auto_size_text/auto_size_text.dart';
import 'package:SoCUniteTwo/screens/forum_screens/post_feedback.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

//can add validation
//new post for FEEDBACKS

class New2030feedbacks extends StatefulWidget {
  final PostFeedback post;
  New2030feedbacks({Key key, @required this.post}) : super(key: key);

  @override
  _New2030feedbacksState createState() => _New2030feedbacksState();
}

class _New2030feedbacksState extends State<New2030feedbacks> {
  final db = Firestore.instance;
  String profilePicture;
  String username;

  @override
  Widget build(BuildContext context) {

    TextEditingController _yearController = new TextEditingController();
    TextEditingController _expectedController = new TextEditingController();
    TextEditingController _actualController = new TextEditingController();
    TextEditingController _professorController = new TextEditingController();
    TextEditingController _difficultyController = new TextEditingController();
    TextEditingController _prepController = new TextEditingController(); 
    TextEditingController _contentController = new TextEditingController();
    _yearController.text = widget.post.yearTaken;
    
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: Text("Create a post - CS2030"),
        backgroundColor: Colors.grey[850],
      ),
      body: 
      SingleChildScrollView(
        child:
      Column(
        children: <Widget>[
          SizedBox(height: 30),
          Row(children: <Widget>[
            SizedBox(width: 20,),
            Text("Guidelines when making a post", style: TextStyle(fontSize: 16, 
            fontWeight: FontWeight.bold, decoration: TextDecoration.underline, color: Colors.tealAccent), ),
          ],),
           SizedBox(height: 10),
           Row(children: <Widget>[
            SizedBox(width: 20,),
            Text("1)",  style: TextStyle(color: Colors.grey[100])),
            SizedBox(width: 10,),
            Expanded(
            child: Text("Examples of good formatting is shown in the hint text. (Eg AY19/20 Sem 2)",style: TextStyle(color: Colors.grey[100]),)
          ,),
          ],),
          SizedBox(height: 10),
          Row(children: <Widget>[
            SizedBox(width: 20,),
            Text("2)",  style: TextStyle(color: Colors.grey[100])),
            SizedBox(width: 10,),
            Expanded(
            child: Text("Do provide genuine feedback that are as detailed as possible ",style: TextStyle(color: Colors.grey[100]),)
          ,),],),
          SizedBox(height: 10),
          Row(children: <Widget>[
            SizedBox(width: 20,),
            Text("3)",  style: TextStyle(color: Colors.grey[100])),
            SizedBox(width: 10,),
            Expanded(
            child: Text("Please refrain from using foul or uncivilised words", style: TextStyle(color: Colors.grey[100]),)
          ,),
          SizedBox(height: 30),
          ],),
          Row(children: <Widget>[
            SizedBox(width: 20,),
            Expanded(
            child: Text("Following these guidelines and making a good post will benefit everyone's learning. Violation of these guidelines may lead to your post being deleted and you may be temporarily banned from making posts after a repeated number of violations."
            ,style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[100]),)
          ,),
          ],),
          SizedBox(height: 10),
          Divider(thickness: 1, color: Colors.tealAccent,),
          SizedBox(height: 20),
          Row(children: <Widget>[
          Text("    Taken in (year/sem):     ", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.grey[100])),
          Flexible(child: 
          Container(width: 150,
          child:
          TextFormField(
            style: TextStyle(color: Colors.grey[100]),
            controller: _yearController,
          decoration:
            InputDecoration(
              hintStyle: TextStyle(color: Colors.grey[600]),
              hintText: 'Eg AY19/20 Sem 2',) 
          ,),)),
          ]),
          SizedBox(height: 20),
          Row(children: <Widget>[
          Text("    Expected Grade:    ", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold,color: Colors.grey[100])),
          Flexible(child: 
          Container(width: 100,
          child:
          TextFormField(
            style: TextStyle(color: Colors.grey[100]),
            controller: _expectedController,
            decoration:
            InputDecoration(hintText: 'Enter', hintStyle: TextStyle(color: Colors.grey[600]),) 
          ,),))]),
            SizedBox(height: 20),
          Row(children: <Widget>[
          Text("    Actual Grade:    ", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold,color: Colors.grey[100])),
          Flexible(child: 
          Container(width: 100,
          child:
          TextFormField(
            style: TextStyle(color: Colors.grey[100]),
            controller: _actualController,
            decoration:
            InputDecoration(hintText: 'Enter', hintStyle: TextStyle(color: Colors.grey[600]),) 
          ,),))]),
          SizedBox(height: 20),
          Row(children: <Widget>[
          Text("    Taken under:    ", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold,color: Colors.grey[100])),
          Flexible(child: 
          Container(width: 220,
          child:
          TextFormField(
            style: TextStyle(color: Colors.grey[100]),
            controller: _professorController,
            decoration:
            InputDecoration(hintText: 'Eg Prof David', hintStyle: TextStyle(color: Colors.grey[600]),) 
          ,),))]),
          SizedBox(height: 20),
          Row(children: <Widget>[
          Text("    Difficulty (/10):    ", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold,color: Colors.grey[100])),
          Flexible(child: 
          Container(width: 100,
          child:
          TextFormField(
            style: TextStyle(color: Colors.grey[100]),
            controller: _difficultyController,
            decoration:
            InputDecoration(hintText: 'Enter', hintStyle: TextStyle(color: Colors.grey[600]),) 
          ,),))]),
          SizedBox(height: 30,),
          Row(children: <Widget>[
            SizedBox(width: 20,),
            Text('Early preparation tips', style: TextStyle(fontSize: 17,
          fontWeight: FontWeight.bold, color: Colors.grey[100])),
          ],),
          
            Container(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: TextFormField(
                style: TextStyle(color: Colors.black),
                cursorColor: Colors.tealAccent,
              validator: (value) {
                if(value.isEmpty) {
                  return "Content cannot be empty";
                } else {
                  return null;
                }
              },
              controller: _prepController,
              minLines: 12,
              maxLines: 100,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[100],
        hintText: 'Enter your preparation tips here',
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          borderSide: BorderSide(color: Colors.grey),
        ),
            )
              ),
          ),
          ),
          Row(children: <Widget>[
            SizedBox(width: 20,),
            Text('Feedback details', style: TextStyle(fontSize: 17,
          fontWeight: FontWeight.bold, color: Colors.grey[100]),),
          ],),
          Container(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: TextFormField(
                style: TextStyle(color: Colors.black),
                cursorColor: Colors.tealAccent,
              validator: (value) {
                if(value.isEmpty) {
                  return "Content cannot be empty";
                } else {
                  return null;
                }
              },
              controller: _contentController,
              minLines: 12,
              maxLines: 100,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
        hintText: 'Enter your feedback here',
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          borderSide: BorderSide(color: Colors.grey),
        ),
            )
              ),
          ),
          ),
          RaisedButton(
            onPressed: () async { //upload and save to firebase

            await Provider.of(context).auth.getCurrentUser().then((user) {
              setState(() {
              profilePicture = user.photoUrl;
              username = user.displayName;
              });
              }).catchError((e) {
              print(e);
              });

              widget.post.actualGrade = _actualController.text;
              widget.post.expectedGrade = _expectedController.text;
              widget.post.preparationTips = _prepController.text;
              widget.post.professor = _professorController.text;
              widget.post.yearTaken = _yearController.text;
              widget.post.difficulty = _difficultyController.text;
              widget.post.content = _contentController.text;
              widget.post.profilePicture = profilePicture;
              widget.post.username = username;
              widget.post.timestamp = DateFormat('dd/MM/yyyy').format(DateTime.now()).toString();

              final uid = await Provider.of(context).auth.getCurrentUID();

              widget.post.ownerid = uid;
             widget.post.saved = {uid: false};
              widget.post.upvotes =  {uid: false};

               final DocumentReference documentReference = 
              await db.collection("public").document('CS2030').
              collection("Feedbacks").add({
                'yearTaken': widget.post.yearTaken,
                'expectedGrade': widget.post.expectedGrade,
                'actualGrade': widget.post.actualGrade,
                'professor': widget.post.professor,
                'difficulty': widget.post.difficulty,
                'preparationTips': widget.post.preparationTips,
                'content': widget.post.content,
                'username': widget.post.username,
                'profilePicture' : widget.post.profilePicture,
                'timestamp': widget.post.timestamp,
                'documentid': '',
                'ownerid': widget.post.ownerid,
                'saved': widget.post.saved,
                'upvotes': widget.post.upvotes,
              }
              );

              final String documentid = documentReference.documentID;
               widget.post.documentid = documentid;

               await db.collection("public").document("CS2030").
              collection("Feedbacks").document(documentid).updateData({
                'documentid': documentid,
              });

              await db.collection("users").document(uid).
              collection("private_feedbacks").document(documentid).setData({
                'yearTaken': widget.post.yearTaken,
                'expectedGrade': widget.post.expectedGrade,
                'actualGrade': widget.post.actualGrade,
                'professor': widget.post.professor,
                'difficulty': widget.post.difficulty,
                'preparationTips': widget.post.preparationTips,
                'content': widget.post.content,
                'username': widget.post.username,
                'profilePicture' : widget.post.profilePicture,
                'timestamp': widget.post.timestamp,
                'documentid': documentid,
                'ownerid': widget.post.ownerid,
                'saved': widget.post.saved,
                'upvotes': widget.post.upvotes,
              }
              );
              Navigator.pop(context);
            },
            color: Colors.blue[300],
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
              child: Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
              child: Text("Post", style: TextStyle(color: Colors.grey[900],
                  fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  ),
                  ),
        ],
          ),
      ),
      );
  }
}


