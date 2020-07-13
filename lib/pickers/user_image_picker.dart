import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:SoCUniteTwo/widgets/provider_widget.dart';

class UserImagePicker extends StatefulWidget {

  UserImagePicker(this.imagePickFn); //constructor
  final void Function(File pickedImage) imagePickFn;

  @override
  _UserImagePickerState createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File _pickedImage;
  String profilePicture;

  void _pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.getImage(source: ImageSource.gallery);
    final pickedImageFile = File(pickedImage.path);
    setState(() {
      _pickedImage = pickedImageFile;
    });
    widget.imagePickFn(pickedImageFile);
  }

  

  @override
  Widget build(BuildContext context) {

    Provider.of(context).auth.getCurrentUser().then((user) {
      setState(() {
        profilePicture = user.photoUrl; //photoUrl is already uploaded to firebase 
      });
    }).catchError((e) {
        print(e);
    });

    return Column(
      children: <Widget>[
        CircleAvatar( //profile picture
                radius: 110,
                backgroundColor: Colors.grey,
                backgroundImage:
                _pickedImage != null ? 
                FileImage(_pickedImage) :
                profilePicture != null ?
                NetworkImage(profilePicture) :
                null ,
                ),
              FlatButton.icon(
              textColor: Colors.grey[100],
              onPressed: () {
                _pickImage();
              }, 
              icon: Icon(Icons.image),
              label: Text('Press to choose an image', style: TextStyle(color: Colors.grey[100]),)),
      ],
    );
  }
}