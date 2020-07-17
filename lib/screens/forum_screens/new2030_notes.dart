import 'package:SoCUniteTwo/widgets/provider_widget.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
//import 'package:auto_size_text/auto_size_text.dart';
import 'package:SoCUniteTwo/screens/forum_screens/post_notes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'dart:io';


//can add validation
//new post for NOTES

class New2030notes extends StatefulWidget {
  final PostNotes post;
  New2030notes({Key key, @required this.post}) : super(key: key);

  @override
  _New2030notesState createState() => _New2030notesState();
}

class _New2030notesState extends State<New2030notes> {
  final db = Firestore.instance;
  File sampleImage; //selected image to upload
  String url; //url of image for each forum
  String profilePicture;
  String username;

  // void uploadStatusImage() async {
  //   final StorageReference postImageRef = FirebaseStorage.instance.ref()
  //   .child("Notes Images");

  //   var timekey = new DateTime.now();
  //   final StorageUploadTask uploadTask = postImageRef.child(
  //     timekey.toString() + ".jpg").putFile(sampleImage);
    
  //   var imageurl = await(await uploadTask.onComplete).ref.getDownloadURL();
  //   url = imageurl.toString();
  //   print("Image url = " + url);
  //   //saveToDatabase(url);
  // }


  Future getImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.getImage(source: ImageSource.gallery);
    final pickedImageFile = File(pickedImage.path);
    setState(() {
      sampleImage = pickedImageFile;
    });
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController _linkController = new TextEditingController();
    TextEditingController _contentController = new TextEditingController();
    //_contentController = null; //had error, so changed to null first
    TextEditingController _topicController = new TextEditingController(); //topic
    _topicController.text = widget.post.topic;
    
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
            Text("Guidelines when making a post",style: TextStyle(fontSize: 16, 
            fontWeight: FontWeight.bold, decoration: TextDecoration.underline, color: Colors.tealAccent), ),
          ],),
           SizedBox(height: 10),
           Row(children: <Widget>[
            SizedBox(width: 20,),
            Text("1)" ,style: TextStyle(color: Colors.grey[100])),
            SizedBox(width: 10,),
            Expanded(
            child: Text("If you are uploading notes for many topics, it can be summarised into (eg. Notes for topics from first half of the sem)", style: TextStyle(color: Colors.grey[100]),)
          ,),
          SizedBox(height: 30),
          ],),
          SizedBox(height: 10),
          Row(children: <Widget>[
            SizedBox(width: 20,),
            Text("2)",  style: TextStyle(color: Colors.grey[100])),
            SizedBox(width: 10,),
            Expanded(
            child: Text("If you want to share an e-copy of your notes, do include a link to your resources", style: TextStyle(color: Colors.grey[100]),)
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
            ,style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[100]))
          ,),
          ],),
          SizedBox(height: 10),
          Divider(thickness: 1, color: Colors.tealAccent,),
          SizedBox(height: 20),
          Row(children: <Widget>[
            SizedBox(width: 20),
            Text("Topic/s", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.grey[100])),
          ],),
          Padding(
            padding: EdgeInsets.all(15),
            child: TextFormField(
              
              cursorColor: Colors.tealAccent,
              validator: (value) {
                if(value.isEmpty) {
                  return "Topic cannot be empty";
                } else {
                  return null;
                }
              },
              decoration: InputDecoration(
                
                filled: true,
        fillColor: Colors.grey[100],
        hintText: 'Topic/s',
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
              controller: _topicController,),
          ),
          Row(children: <Widget>[
          Text("    Link:    ", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.grey[100])),
          Flexible(child: 
          Container(width: 300,
          child:
          TextFormField(
            style: TextStyle(color: Colors.grey[100]),
            cursorColor: Colors.tealAccent,
            controller: _linkController,
           decoration: InputDecoration(
             focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.tealAccent,
                              ),),
                            enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey[800])),
             
             hintStyle: TextStyle(color: Colors.grey[600]),
             hintText: "Link"
           ),
          ),))]),
          SizedBox(height: 10,),
          Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
          IconButton(color: Colors.grey[100],
            icon: Icon(Icons.add_a_photo),
          onPressed: () {
            getImage();
          }, 
          ), Text("Press to upload photos of your notes", style: TextStyle(color: Colors.grey[100]),)]),
          sampleImage != null    
               ? Image.asset(    //display timetable
                   sampleImage.path,    
                   height: 250,
                   fit: BoxFit.contain,
                 )    
               : Container(height: 10),   
                Row(children: <Widget>[
            SizedBox(width: 20),
            Text("Description of your notes", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.grey[100])),
          ],),
          Container(
            child: Padding(
              padding: EdgeInsets.all(15),
              child: TextFormField(
                cursorColor: Colors.tealAccent,
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
                fillColor: Colors.grey[100],
        hintText: 'Description',
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

            //uploadStatusImage();

            if(sampleImage != null) {

            final StorageReference postImageRef = FirebaseStorage.instance.ref()
            .child("Notes Images");

            var timekey = new DateTime.now();
            final StorageUploadTask uploadTask = postImageRef.child(
            timekey.toString() + ".jpg").putFile(sampleImage);
    
            var imageurl = await(await uploadTask.onComplete).ref.getDownloadURL();

            setState(() {
              url = imageurl.toString();
            });
            
            print("Image url = " + url);

            } else {
              setState(() {
                url = null;
              });
            }


            await Provider.of(context).auth.getCurrentUser().then((user) {
              setState(() {
              profilePicture = user.photoUrl;
              username = user.displayName;
              });
              }).catchError((e) {
              print(e);
              });

              widget.post.topic = _topicController.text;
              widget.post.content = _contentController.text;
              widget.post.link = _linkController.text;
              widget.post.timestamp = DateFormat('dd/MM/yyyy').format(DateTime.now()).toString();
              widget.post.imageurl = url; //shows null
              widget.post.profilePicture = profilePicture;
              widget.post.username = username;

              final uid = await Provider.of(context).auth.getCurrentUID();
              widget.post.ownerid = uid;
              widget.post.saved = {uid: false};
              widget.post.upvotes =  {uid: false};
              widget.post.reported = {uid: false};

              final DocumentReference documentReference = 
              await db.collection("public").document('CS2030').
              collection("Notes").add({
                'topic': widget.post.topic,
                'content': widget.post.content,
                'link': widget.post.link,
                'timestamp': widget.post.timestamp,
                'imageurl': widget.post.imageurl,
                'profilePicture': widget.post.profilePicture,
                'username': widget.post.username,
                'documentid': '',
                'ownerid': widget.post.ownerid,
                'saved': widget.post.saved,
                'upvotes': widget.post.upvotes,
                'reported': widget.post.reported,
              }
              );

              final String documentid = documentReference.documentID;
               widget.post.documentid = documentid;

               await db.collection("public").document("CS2030").
              collection("Notes").document(documentid).updateData({
                'documentid': documentid,
              });

              await db.collection("users").document(uid).
              collection("private_notes").document(documentid).setData({
                'topic': widget.post.topic,
                'content': widget.post.content,
                'link': widget.post.link,
                'timestamp': widget.post.timestamp,
                'imageurl': widget.post.imageurl,
                'profilePicture': widget.post.profilePicture,
                'username': widget.post.username,
                'documentid': documentid,
                'ownerid': widget.post.ownerid,
                'saved': widget.post.saved,
                'upvotes': widget.post.upvotes,
                'reported': widget.post.reported,
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
      )
    );
  }
}

