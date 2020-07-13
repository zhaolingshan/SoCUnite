import 'package:SoCUniteTwo/widgets/provider_widget.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:SoCUniteTwo/screens/forum_screens/experiences/experience.dart';


//can add validation
//new post for collaborations

class NewExperience extends StatefulWidget {
  final Experience post;
  
  NewExperience({Key key, @required this.post}) : super(key: key);

  @override
  _NewExperienceState createState() => _NewExperienceState();
}

class _NewExperienceState extends State<NewExperience> {
  final db = Firestore.instance;
  String profilePicture;
  String username;


  @override
  Widget build(BuildContext context) {
    TextEditingController _contentController = new TextEditingController();
    TextEditingController _titleController = new TextEditingController();
    TextEditingController _companyController = new TextEditingController();
    TextEditingController _timeController = new TextEditingController(); //for time period
    TextEditingController _roleController = new TextEditingController();
    
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: Text("Create a post"),
        backgroundColor: Colors.grey[850],
      ),
      body: 
      SingleChildScrollView(
        child:
        Center(child: 
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
            Text("1)",style: TextStyle(color: Colors.grey[100])),
            SizedBox(width: 10,),
            Expanded(
            child: Text("Title should be kept concised and specific",style: TextStyle(color: Colors.grey[100]),)
          ,),
          SizedBox(height: 30),
          ],),
          Row(children: <Widget>[
            SizedBox(width: 20,),
            Text("2)",style: TextStyle(color: Colors.grey[100])),
            SizedBox(width: 10,),
            Expanded(
            child: Text("Details can mention about internship requirements and what can one expect from the role, as well as a description of how your internship experience was with this company.  ",style: TextStyle(color: Colors.grey[100]),)
          ,),
          SizedBox(height: 30),
          ],),SizedBox(height: 10),
          Row(children: <Widget>[
            SizedBox(width: 20,),
            Text("3)",style: TextStyle(color: Colors.grey[100])),
            SizedBox(width: 10,),
            Expanded(
            child: Text("Please refrain from using foul or uncivilised words",style: TextStyle(color: Colors.grey[100]),)
          ,),
          SizedBox(height: 30),
          ],),
          Row(children: <Widget>[
            SizedBox(width: 20,),
            Expanded(
            child: Text("Violation of these guidelines may lead to your post being deleted and you may be temporarily banned from making posts after a repeated number of violations."
            ,style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[100]),)
          ,),
          ],),
          SizedBox(height: 10),
          Divider(thickness: 1, color: Colors.tealAccent),
          SizedBox(height: 20),
          //select type of post
          Row(children: <Widget>[
            SizedBox(width: 20,),
            Text("Title", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold,  color: Colors.grey[100])),
          ],),
          
          Padding(
            padding: EdgeInsets.all(15),
            child: TextFormField(
              validator: (value) {
                if(value.isEmpty) {
                  return "Title cannot be empty";
                } else {
                  return null;
                }
              },
              decoration: InputDecoration(
                filled: true,
        fillColor: Colors.grey[100],
        hintText: 'Title',
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          borderSide: BorderSide(color: Colors.grey),
        ),
            ),
              autofocus: true,
              controller: _titleController,),
          ),
          Row(children: <Widget>[
            SizedBox(width: 20,),
            Text("Company", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.grey[100])),
          ],),
          Padding(
            padding: EdgeInsets.all(15),
            child: TextFormField(
              validator: (value) {
                if(value.isEmpty) {
                  return "Title cannot be empty";
                } else {
                  return null;
                }
              },
              decoration: InputDecoration(
                filled: true,
        fillColor: Colors.grey[100],
        hintText: 'Company name',
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          borderSide: BorderSide(color: Colors.grey),
        ),
            ),
              autofocus: true,
              controller: _companyController,),
          ),
          Row(children: <Widget>[
            SizedBox(width: 20,),
            Text("Role", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.grey[100])),
          ],),
          Padding(
            padding: EdgeInsets.all(15),
            child: TextFormField(
              minLines: 3,
              maxLines: 10,
              validator: (value) {
                if(value.isEmpty) {
                  return "Title cannot be empty";
                } else {
                  return null;
                }
              },
              decoration: InputDecoration(
                filled: true,
        fillColor: Colors.grey[100],
        hintText: 'Your job at the company',
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          borderSide: BorderSide(color: Colors.grey),
        ),
            ),
              autofocus: true,
              controller: _roleController,),
          ),
          Row(children: <Widget>[
            SizedBox(width: 20,),
            Text("Time period of internship", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold,  color: Colors.grey[100])),
          ],),
          Padding(
            padding: EdgeInsets.all(15),
            child: TextFormField(
              minLines: 3,
              maxLines: 10,
              validator: (value) {
                if(value.isEmpty) {
                  return "Title cannot be empty";
                } else {
                  return null;
                }
              },
              decoration: InputDecoration(
                filled: true,
        fillColor: Colors.grey[100],
        hintText: 'Time period',
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          borderSide: BorderSide(color: Colors.grey),
        ),
            ),
              autofocus: true,
              controller: _timeController,),
          ),
          Row(children: <Widget>[
            SizedBox(width: 20,),
            Text("Details", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold,  color: Colors.grey[100])),
          ],),
          Container(
            child: Padding(
              padding: EdgeInsets.all(15),
              child: TextFormField(
              validator: (value) {
                if(value.isEmpty) {
                  return "Content cannot be empty";
                } else {
                  return null;
                }
              },
              controller: _contentController,
              minLines: 10,
              maxLines: 15,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
        hintText: 'Details',
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

              widget.post.title = _titleController.text;
              widget.post.content = _contentController.text;
              widget.post.timestamp = DateFormat('dd/MM/yyyy').format(DateTime.now()).toString();
              widget.post.profilePicture = profilePicture;
              widget.post.username = username;
              widget.post.company = _companyController.text;
              widget.post.role = _roleController.text;
              widget.post.timePeriod = _timeController.text;
            
              final uid = await Provider.of(context).auth.getCurrentUID();
              widget.post.ownerid = uid;
              widget.post.saved = {uid: false};
              widget.post.upvotes =  {uid: false};
              
              final DocumentReference documentReference = 
              await db.collection("public").document("internship_experiences").
              collection("Experiences").add({ //add post into a collection
                'title': widget.post.title,
                'content': widget.post.content,
                'timestamp': widget.post.timestamp,
                'username': widget.post.username,
                'profilePicture' : widget.post.profilePicture,
                'documentid': '',
                'timePeriod': widget.post.timePeriod,
                'role': widget.post.role,
                'company': widget.post.company,
                'ownerid':  widget.post.ownerid,
                'saved': widget.post.saved,
                'upvotes': widget.post.upvotes,
              });

              final String documentid = documentReference.documentID;
               widget.post.documentid = documentid;

              await db.collection("public").document("internship_experiences").
              collection("Experiences").document(documentid).updateData({
                'documentid': documentid,
              });

              await db.collection('users').document(uid).
              collection('private_experiences').document(documentid).setData({
               'title': widget.post.title,
                'content': widget.post.content,
                'timestamp': widget.post.timestamp,
                'username': widget.post.username,
                'profilePicture' : widget.post.profilePicture,
                'documentid': documentid,
                'timePeriod': widget.post.timePeriod,
                'role': widget.post.role,
                'company': widget.post.company,
                'ownerid':  widget.post.ownerid,
                'saved': widget.post.saved,
                'upvotes': widget.post.upvotes,         
              });
              
              Navigator.pop(context);
              

            },
            color: Colors.blue[300],
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
              child: Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
              child: Text("Post", style: TextStyle(color: Colors.white,
                  fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  ),
                  ),
          
        ],
      ),),
        )
    );
  }
}

