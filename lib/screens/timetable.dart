import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as Path;
import 'dart:io';
import 'package:SoCUniteTwo/widgets/provider_widget.dart';

//save _uploadedFileURL to firebase under timetable image:
//display the image 
class Timetable extends StatefulWidget {
  @override
  _TimetableState createState() => _TimetableState();
}

class _TimetableState extends State<Timetable> {
  File _image;  
  String _uploadedFileURL; 

  //final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
    _asyncMethod();
  });
    // Provider.of(context).auth.getCurrentUser().then((user) {
    //   final uid = user.uid;
    // Firestore.instance.collection('users').document(uid).collection('settings')
    // .document('timetable').get().then((value) async {
    //   _uploadedFileURL = value['timetable'];
    // });
    // }); 
  }

  _asyncMethod() async {
    final uid = await Provider.of(context).auth.getCurrentUID();
    Firestore.instance.collection('users').document(uid).collection('settings')
    .document('timetable').get().then((value) async {
      setState(() {
         _uploadedFileURL = value['timetable'];
      });
    });
  }

  Future chooseFile() async { //select picture of timetable
    final picker = ImagePicker();
    final pickedImage = await picker.getImage(source: ImageSource.gallery);
    final pickedImageFile = File(pickedImage.path);
    setState(() {
      _image = pickedImageFile;
    });
  }

  Future uploadFile() async {  
   StorageReference storageReference = FirebaseStorage.instance    
       .ref()    
       .child('userstimetable/${Path.basename(_image.path)}}');    
   StorageUploadTask uploadTask = storageReference.putFile(_image);    
   await uploadTask.onComplete;    
   print('File Uploaded');    //change below
   storageReference.getDownloadURL().then((fileURL) {    
     setState(() {    
       _uploadedFileURL = fileURL;    
     });    
   });    
 }  
   


  @override
  Widget build(BuildContext context) {
    

    //need to retrieve timetable (url) from uid and then set _uploadedFileURL = timetable to display it 

    // Provider.of(context).auth.getCurrentUser().then((user) {
    //   setState(() {
    //     profilePicture = user.uid;
    //   });
    // }).catchError((e) {
    //     print(e);
    // }); 

    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        backgroundColor: Colors.grey[850],
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
      title: Text("Your Timetable",) //upload an image
    ),
    body: Builder(builder: (context) {
      return
    Center(    
       child: Column(    
         children: <Widget>[    
           SizedBox(height: 40,),
           Text('My selected timetable', style: TextStyle(color: Colors.grey[100]),),
           _image != null  ? 
               Image.asset(   
                   _image.path,    
                   height: 250,
                   fit: BoxFit.contain, //if image is not null, will display (temp)
                 )    
               : _uploadedFileURL != null ? //even when u upload file -> image is not null 
               Image.network(_uploadedFileURL) : //doesnt display timetable 
               Container(height: 200), 
           _image == null    
               ? RaisedButton(    
                   child: Text('Choose File', style: TextStyle(
                     color: Colors.white,
                     fontWeight: FontWeight.bold
                   ),),    
                   onPressed: chooseFile,    
                   color: Colors.blue[300],
                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),    
                 )    
               : Container(),    
           _image != null    
               ? 
               Column(children: <Widget>[
               RaisedButton(
                 color: Colors.cyan[300],    
                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)), 
                   child: Text('Clear Selection', style: TextStyle(
                     color: Colors.white,
                   ),),    
                   onPressed: () {
                     //_uploadedFileURL = null;
                   }, //need a clear selection 
                 ),
                 RaisedButton(
                 color: Colors.indigo,    
                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)), 
                   child: Text('Save', style: TextStyle(
                     color: Colors.white,
                   ),),    
                   onPressed: () async { //upload to firebase
                    //uploadFile(); //uploading to storage and retrieving url

                    final uid = await Provider.of(context).auth.getCurrentUID();

                    final StorageReference _reference = 
                      FirebaseStorage.instance.ref().child('userstimetable/${Path.basename(_image.path)}}');

                      StorageTaskSnapshot snapshot = await _reference
                      .putFile(_image)
                      .onComplete;

                      if (snapshot.error == null) {
                        await snapshot.ref.getDownloadURL()
                        .then(
                          (fileURL) {    
                          setState(() {    
                          _uploadedFileURL = fileURL;  
                          });
                          }
                        );    

              await Firestore.instance.collection('users').document(uid)
              .collection('settings').document('timetable')
                        .setData({
                          "timetable" : _uploadedFileURL,
                        },
                        merge : true).then((_){
                        print("timetable uploaded success!");
                        });

                     final snackBar = SnackBar(
            content: Text('Uploading of timetable is successful!'),
            duration: Duration(seconds: 3),
          );
                Scaffold.of(context).showSnackBar(snackBar);
                   }
}
                 )
                 
                 ,])    
               : Container(),    
           //Text('Uploaded Image', style: TextStyle(color: Colors.white,)),     
         ],    
       ),    
     );
    })    
   );  
  }
}