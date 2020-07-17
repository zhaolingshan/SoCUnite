import 'package:SoCUniteTwo/screens/forum_screens/collaborations/collaboration.dart';
import 'package:SoCUniteTwo/widgets/provider_widget.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';


//can add validation
//new post for collaborations

class NewCollaboration extends StatefulWidget {
  final Collaboration post;
  
  NewCollaboration({Key key, @required this.post}) : super(key: key);

  @override
  _NewCollaborationState createState() => _NewCollaborationState();
}

class _NewCollaborationState extends State<NewCollaboration> {
  final db = Firestore.instance;

  String profilePicture;
  String username;


  @override
  Widget build(BuildContext context) {
    TextEditingController _contentController = new TextEditingController();
    TextEditingController _titleController = new TextEditingController();
    TextEditingController _nameController = new TextEditingController();
    TextEditingController _linkController = new TextEditingController();
    TextEditingController _experienceController = new TextEditingController();
    TextEditingController _contactController = new TextEditingController();
    
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
            child: Text("Information about the project should be detailed enough to attract potential collaborators ",style: TextStyle(color: Colors.grey[100]),)
          ,),
          SizedBox(height: 30),
          ],),SizedBox(height: 10),
          Row(children: <Widget>[
            SizedBox(width: 20,),
            Text("3)",style: TextStyle(color: Colors.grey[100])),
            SizedBox(width: 10,),
            Expanded(
            child: Text("Do include information about yourself, including details about your past projects (if any) and what you seek in a potential collaborator (if any)",style: TextStyle(color: Colors.grey[100]),)
          ,),
          SizedBox(height: 30),
          ],),
          Row(children: <Widget>[
            SizedBox(width: 20,),
            Text("4)",style: TextStyle(color: Colors.grey[100])),
            SizedBox(width: 10,),
            Expanded(
            child: Text("Please refrain from using foul or uncivilised words",style: TextStyle(color: Colors.grey[100]),)
          ,),
          SizedBox(height: 30),
          ],),
          Row(children: <Widget>[
            SizedBox(width: 20,),
            Text("5)",style: TextStyle(color: Colors.grey[100])),
            SizedBox(width: 10,),
            Expanded(
            child: Text("If you are providing more than one contact detail, the formatting of your information should be as such:",style: TextStyle(color: Colors.grey[100]),)
          ,),
          ],),
          SizedBox(height: 10),
          Row(children: <Widget>[
            SizedBox(width: 20,),
            Text("Email: 1234@gmail.com",style: TextStyle(color: Colors.grey[100]),)
          ],),
          Row(children: <Widget>[
            SizedBox(width: 20,),
            Text("Mobile: 12345678",style: TextStyle(color: Colors.grey[100]),)
          ],),
          Row(children: <Widget>[
            SizedBox(width: 20,),
            Text("Telegram username: @example",style: TextStyle(color: Colors.grey[100]),)
          ],),
          SizedBox(height: 10),
          Row(children: <Widget>[
            SizedBox(width: 20,),
            Expanded(
            child: Text("Following these guidelines will increase your chances in finding suitable partners for your project. Violation of these guidelines may lead to your post being deleted and you may be temporarily banned from making posts after a repeated number of violations."
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
            Text("Your Name", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.grey[100])),
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
        hintText: 'Name',
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
              controller: _nameController,),
          ),
          Row(children: <Widget>[
            SizedBox(width: 20,),
            Text("Contact details", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.grey[100])),
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
        hintText: 'Email/phone/telegram username',
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
              controller: _contactController,),
          ),
          Row(children: <Widget>[
            SizedBox(width: 20,),
            Text("Reference materials", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold,  color: Colors.grey[100])),
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
        hintText: 'Link',
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
              controller: _linkController,),
          ),
           Row(children: <Widget>[
            SizedBox(width: 20,),
            Text("Personal experiences and skills", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold,  color: Colors.grey[100])),
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
              controller: _experienceController,
              minLines: 8,
              maxLines: 15,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
        hintText: 'Your experiences and skills',
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
              widget.post.link = _linkController.text;
              widget.post.name = _nameController.text;
              widget.post.contact = _contactController.text;
              widget.post.experience = _experienceController.text;
              
              final uid = await Provider.of(context).auth.getCurrentUID();
              widget.post.ownerid = uid;
              widget.post.saved = {uid: false};
              widget.post.upvotes =  {uid: false};
              widget.post.reported = {uid: false};
              
              final DocumentReference documentReference = 
              await db.collection("public").document("collaborations").
              collection("Collaborations").add({ //add post into a collection
                'title': widget.post.title,
                'content': widget.post.content,
                'timestamp': widget.post.timestamp,
                'username': widget.post.username,
                'profilePicture' : widget.post.profilePicture,
                'documentid': '',
                'link': widget.post.link,
                'name': widget.post.name,
                'experience': widget.post.experience,
                'contact': widget.post.contact,
                'ownerid': widget.post.ownerid,
                'saved': widget.post.saved,
                'upvotes': widget.post.upvotes,
                'reported': widget.post.reported,
              });

              final String documentid = documentReference.documentID;
               widget.post.documentid = documentid;

              await db.collection("public").document("collaborations").
              collection("Collaborations").document(documentid).updateData({
                'documentid': documentid,
              });

              await db.collection('users').document(uid).
              collection('private_collaborations').document(documentid).setData({
                'title': widget.post.title,
                'content': widget.post.content,
                'timestamp': widget.post.timestamp,
                'username': widget.post.username,
                'profilePicture' : widget.post.profilePicture,
                'documentid': documentid,
                'link': widget.post.link,
                'name': widget.post.name,
                'experience': widget.post.experience,
                'contact': widget.post.contact,
                'ownerid': widget.post.ownerid,
                'saved': widget.post.saved,
                'upvotes': widget.post.upvotes,
                'reported': widget.post.reported,
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

