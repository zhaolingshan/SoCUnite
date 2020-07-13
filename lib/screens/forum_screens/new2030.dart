import 'package:SoCUniteTwo/widgets/provider_widget.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:SoCUniteTwo/screens/forum_screens/post.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
//import 'package:SoCUniteTwo/screens/forum_screens/CS2030_forum.dart';
import 'package:intl/intl.dart';
import 'dart:io';

//can add validation
//new post for FORUMS

class New2030 extends StatefulWidget {
  final Post post;

  
  New2030({Key key, @required this.post}) : super(key: key);

  @override
  _New2030State createState() => _New2030State();
}

class _New2030State extends State<New2030> {
  final db = Firestore.instance;
  File sampleImage; //selected image to upload
  String url; //url of image for each forum
  String profilePicture;
  String username;


  // void uploadStatusImage() async {
  //   final StorageReference postImageRef = FirebaseStorage.instance.ref()
  //   .child("Post Images");

  //   var timekey = new DateTime.now();
  //   final StorageUploadTask uploadTask = postImageRef.child(
  //     timekey.toString() + ".jpg").putFile(sampleImage);
    
  //   var imageurl = await(await uploadTask.onComplete).ref.getDownloadURL();
  //   url = imageurl.toString();

  //   // setState(() {
  //   //   url = imageurl.toString();
  //   // });

  //   print("Image url = " + url);
  // }


  Future getImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.getImage(source: ImageSource.gallery);
    final pickedImageFile = File(pickedImage.path);
    setState(() {
      sampleImage = pickedImageFile;
    });
  }

  // void initState() {
  //   super.initState();
  //   Provider.of(context).auth.getCurrentUser().then((user) {
  //     setState(() {
  //       profilePicture = user.photoURL;
  //     });
  //   }).catchError((e) {
  //       print(e);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    TextEditingController _contentController = new TextEditingController();
    TextEditingController _titleController = new TextEditingController();
    _titleController.text = widget.post.title;

    // Provider.of(context).auth.getCurrentUser().then((user) {
    //   setState(() {
    //     profilePicture = user.photoUrl;
    //     username = user.displayName;
    //   });
    // }).catchError((e) {
    //     print(e);
    // });
    
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
        mainAxisAlignment: MainAxisAlignment.center,
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
            Text("1)", style: TextStyle(color: Colors.grey[100])),
            SizedBox(width: 10,),
            Expanded(
            child: Text("Title should be kept concised and specific", style: TextStyle(color: Colors.grey[100]),)
          ,),
          SizedBox(height: 30),
          ],),
          Row(children: <Widget>[
            SizedBox(width: 20,),
            Text("2)", style: TextStyle(color: Colors.grey[100])),
            SizedBox(width: 10,),
            Expanded(
            child: Text("If applicable, do include Lab/Lecture/Tutorial/Problem set and question number. (eg. Lab 3 question 2a) ", style: TextStyle(color: Colors.grey[100]))
          ,),],),
          SizedBox(height: 10),
          Row(children: <Widget>[
            SizedBox(width: 20,),
            Text("3)", style: TextStyle(color: Colors.grey[100])),
            SizedBox(width: 10,),
            Expanded(
            child: Text("Ensure your question has not been asked before to prevent duplicate posts", style: TextStyle(color: Colors.grey[100]))
          ,),],),
          SizedBox(height: 10),
          Row(children: <Widget>[
            SizedBox(width: 20,),
            Text("4)", style: TextStyle(color: Colors.grey[100])),
            SizedBox(width: 10,),
            Expanded(
            child: Text("Content of post should not be vague. Include an image for illustration purposes if necessary", style: TextStyle(color: Colors.grey[100]))
          ,),
          SizedBox(height: 30),
          ],),
          Row(children: <Widget>[
            SizedBox(width: 20,),
            Text("5)" ,style: TextStyle(color: Colors.grey[100])),
            SizedBox(width: 10,),
            Expanded(
            child: Text("Please refrain from using foul or uncivilised words", style: TextStyle(color: Colors.grey[100]))
          ,),
          ],),
          SizedBox(height: 30),
          Row(children: <Widget>[
            SizedBox(width: 20,),
            Expanded(
            child: Text("Following these guidelines and making a good post will benefit everyone's learning. Violation of these guidelines may lead to your post being deleted and you may be temporarily banned from making posts after a repeated number of violations."
            ,style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[100]),)
          ,),
          ],),
          SizedBox(height: 10),
          Divider(thickness: 1, color: Colors.tealAccent),
          Row(children: <Widget>[
            SizedBox(width: 20,),
            Text("Title", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.grey[100])),
          ],),
          Padding(
            padding: EdgeInsets.all(15),
            child: TextFormField(
              cursorColor: Colors.tealAccent,
              validator: (value) {
                if(value.isEmpty) {
                  return "Title cannot be empty";
                } else {
                  return null;
                }
              },
              decoration: InputDecoration(
                filled: true,
        fillColor: Colors.grey[300],
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
          Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
          IconButton(icon: Icon(Icons.image, color: Colors.grey[100]),
          onPressed: () {
            getImage();
          },
          ), Text("Press to upload photo", style: TextStyle(color: Colors.grey[100]))]),
          sampleImage != null    
               ? Image.asset(    //display timetable
                   sampleImage.path,    
                   height: 250,
                   fit: BoxFit.contain,
                 )    
               : Container(height: 10),   
               Row(children: <Widget>[
            SizedBox(width: 20,),
            Text("Details", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.grey[100])),
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
                fillColor: Colors.grey[300],
        hintText: 'Type here',
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
            .child("Post Images");

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

              widget.post.title = _titleController.text;
              widget.post.content = _contentController.text;
              widget.post.timestamp = DateFormat('dd/MM/yyyy').format(DateTime.now()).toString();
              widget.post.imageurl = url; //shows null
              widget.post.profilePicture = profilePicture;
              widget.post.username = username;
              
             
              final uid = await Provider.of(context).auth.getCurrentUID();
              widget.post.saved = {uid: false};
              widget.post.upvotes =  {uid: false};
              
              widget.post.ownerid = uid;
              
              final DocumentReference documentReference = 
              await db.collection("public").document("CS2030").
              collection("Forums").add({
                'title': widget.post.title,
                'content': widget.post.content,
                'timestamp': widget.post.timestamp,
                'imageurl': widget.post.imageurl, //shows null
                'username': widget.post.username,
                'profilePicture' : widget.post.profilePicture,
                'documentid': '',
                'ownerid': widget.post.ownerid,
                'saved': widget.post.saved,
                'upvotes': widget.post.upvotes,
              });

              final String documentid = documentReference.documentID;
               widget.post.documentid = documentid;

              await db.collection("public").document("CS2030").
              collection("Forums").document(documentid).updateData({
                'documentid': documentid,
              });

              await db.collection('users').document(uid).
              collection('private_forums').document(documentid).setData({
                'title': widget.post.title,
                'content': widget.post.content,
                'timestamp': widget.post.timestamp,
                'imageurl': widget.post.imageurl,
                'username': widget.post.username,
                'profilePicture' : widget.post.profilePicture,
                'documentid' : documentid,
                'ownerid': widget.post.ownerid,
                'saved': widget.post.saved,
                'upvotes': widget.post.upvotes,
              });
              
              Navigator.pop(context);
              // Navigator.push(context, 
              // MaterialPageRoute(builder: (context) => CS2030forum()));

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

