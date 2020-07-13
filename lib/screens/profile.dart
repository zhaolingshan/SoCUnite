import 'package:SoCUniteTwo/pickers/user_image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:image_picker/image_picker.dart';
import 'package:SoCUniteTwo/widgets/provider_widget.dart';
//import 'package:SoCUniteTwo/screens/avatar.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String displayedUsername = 'old name';
  File _userImageFile;
  //String _downloadURL;
  
  void _pickedImage(File image) {
    _userImageFile = image;
  }

  // Future downloadImage() async { 
  //   String downloadAddress = await _reference.getDownloadURL();
  //   setState(() {
  //     _downloadURL = downloadAddress;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
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
      title: Text("User details",)
    ),
    body: Builder(builder: (context) {
      return
      Center(
        child:
      Column(
        children: <Widget>[
              SizedBox(height: 20),
              UserImagePicker(_pickedImage), //circle avatar
              RaisedButton(
                      onPressed: () async { 
                      //final StorageUploadTask task = _reference.putFile(_userImageFile);
                      final uid = await Provider.of(context).auth.getCurrentUID();

                      var timekey = new DateTime.now();
                      final StorageReference _reference = 
                      FirebaseStorage.instance.ref().child(timekey.toString() + ".jpg");

                      StorageTaskSnapshot snapshot = await _reference
                      .putFile(_userImageFile)
                      .onComplete;

                      if (snapshot.error == null) {
                        final String downloadURL = //set this as profile picture
                        await snapshot.ref.getDownloadURL();

                        var userUpdateInfo = UserUpdateInfo();
                        userUpdateInfo.photoUrl = downloadURL;
                        FirebaseUser currentUser = await FirebaseAuth.instance.currentUser();
                        await currentUser.updateProfile(userUpdateInfo);
                        await currentUser.reload();
                        

                        await Firestore.instance.collection('users').document(uid)
                        .setData({
                          "profilepicURL" : downloadURL,
                        },
                        merge : true).then((_){
                        print("success!");
                        });
                      }
                      
                      final snackBar = SnackBar(
                        content: Text('Your profile picture is saved!'),
                        duration: Duration(seconds: 3),
                      );
                      Scaffold.of(context).showSnackBar(snackBar);

                      },
                      color: Colors.tealAccent,
                      shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)),
                      child: Padding(
                        padding: EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
                      child: Text("Save profile picture", style: TextStyle(color: Colors.grey[900],
                      fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
          FutureBuilder(
              future: Provider.of(context).auth.getCurrentUser(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return displayUserInformation(context, snapshot);
                } else {
                  return CircularProgressIndicator();
                }
              },
          ),
          SizedBox(height: 40),
          RaisedButton(
            onPressed: () {
              _userEditBottomSheet(context); //update information
            },
            color: Colors.tealAccent,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
            child: Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
            child: Text("Edit data", style: TextStyle(color: Colors.grey[900],
            fontWeight: FontWeight.bold, fontSize: 15),
              ),
            ),
          ),
        ], 
      ),
      );})
  );
}

Widget displayUserInformation(context, snapshot) {
  final user = snapshot.data;
  displayedUsername = user.displayName; //set state for this
  return Column(
    children: <Widget>[
      Padding(padding: const EdgeInsets.all(8.0),
      child:
      Text("Email: ${user.email}", style: TextStyle(fontSize: 20, color: Colors.grey[100])),
      ),
      Padding(padding: const EdgeInsets.all(8.0),
      child:
      Text("Username: $displayedUsername", style: TextStyle(fontSize: 20, color: Colors.grey[100])),
      ),
    ],
  );
}
  
  void _userEditBottomSheet(BuildContext context) {
    TextEditingController _newUsernameController = new TextEditingController();
    showModalBottomSheet(
      backgroundColor: Colors.grey[900],
      context: context,
      builder: (BuildContext bc) {
        return Container(
          height: MediaQuery.of(context).size.height * .60,
          child: Padding(
            padding: EdgeInsets.only(left: 15.0, top: 15.0),
            child: 
            Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text("Update Profile", style: TextStyle(color: Colors.grey[100]),),
                    Spacer(),
                    IconButton(
                      icon: Icon(Icons.cancel, color: Colors.white),
                      color: Colors.blue[400],
                      iconSize: 25,
                      onPressed: () { 
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 15.0),
                        child: TextFormField(
                          cursorColor: Colors.tealAccent,
                          style: TextStyle(
                            color: Colors.grey[100]),
                          controller: _newUsernameController,
                          decoration: InputDecoration(
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.tealAccent,
                              ),),
                            enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                             helperStyle: TextStyle(fontSize: 12.0, color: Colors.grey[100]),
                            helperText: "New username",
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    RaisedButton(
                      onPressed: () async { //change username/displayname

                      FirebaseUser user = await Provider.of(context).auth.getCurrentUser();
                      UserUpdateInfo updateInfo = UserUpdateInfo();
                      updateInfo.displayName = _newUsernameController.text;
                      user.updateProfile(updateInfo);
                      print('USERNAME IS: ${user.displayName}');

                      setState(() {
                        displayedUsername = user.displayName;
                      });
                        // final uid = await Provider.of(context).auth.getCurrentUID();
                        // await Firestore.instance.collection('users').document(uid).updateData(
                        //   {
                        //     "username": _newUsernameController,
                        //  });
                        Navigator.pop(context);
                        },
                        // await Firestore.instance.collection('users').document(uid)
                        // .setData({
                        //   "username" : _newUsernameController,
                        // },
                        // merge: true).then((_) {
                        //   print("successfully changed username!");
                        // });

                      color: Colors.blue[400],
                      shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)),
                      child: Padding(
                        padding: EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
                      child: Text("Save", style: TextStyle(color: Colors.white,
                      fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }


}