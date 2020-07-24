import 'package:SoCUniteTwo/screens/chat_screens/public_chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:SoCUniteTwo/providers/chat.dart';
import 'package:SoCUniteTwo/widgets/provider_widget.dart';

class AddChatroomScreen extends StatefulWidget {
  AddChatroomScreen({Key key}) : super(key: key);
  @override
  _AddChatroomScreenState createState() => _AddChatroomScreenState();
}

class _AddChatroomScreenState extends State<AddChatroomScreen> {
  Chat chat;
  PublicChatScreen chatScreen;
  final _form = GlobalKey<FormState>();
  final _descriptionFocusNode = FocusNode();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();

  bool validate() {
    final form = _form.currentState;
    form.save();
    if(form.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        backgroundColor: Colors.grey[850],
        title: Text('Create A Chatroom'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _form,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                TextFormField(
                  style: TextStyle(color: Colors.grey[100]),
                  cursorColor: Colors.tealAccent,
                  controller: _titleController,
                  decoration: InputDecoration(
                    labelText: 'Group Name',
                    labelStyle: TextStyle(color: Colors.grey[100]),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.tealAccent,
                        ),
                      ),
                  ),
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_descriptionFocusNode);
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter a group name.';
                    }
                    return null; // return null when input is correct
                  },
                ),
                TextFormField(
                  style: TextStyle(color: Colors.grey[100]),
                  cursorColor: Colors.tealAccent,
                  controller: _descriptionController,
                  decoration: InputDecoration(
                    labelText: 'Description',
                    labelStyle: TextStyle(color: Colors.grey[100]),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.tealAccent,
                        ),
                      ),
                    hintText: 'What is this group chat for?',
                    hintStyle: TextStyle(color: Colors.grey[100]),
                  ),
                  textInputAction: TextInputAction.done,
                  maxLines: 3,
                  keyboardType: TextInputType.multiline,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter a description.';
                    }
                    return null; // return null when input is correct
                  },
                ),
                Padding(
                  child: Text(
                    '* disclaimer: all group chats created are public to all users.',
                    style: TextStyle(color: Colors.grey[100],),
                  ),
                  padding: const EdgeInsets.all(16.0),
                ),
                RaisedButton(
                  color: Colors.blue[300],
                  child: Text(
                    'Confirm',
                  ),
                  onPressed: () async {

                    chat = Chat(null, null, null, null);
                    if (validate()) {
                      final uid = await Provider.of(context).auth.getCurrentUID();
                      chat.title = _titleController.text;
                      chat.description = _descriptionController.text;

                      final DocumentReference documentReference = 
                          await Firestore.instance.collection('public_chats')
                          .add({
                            'title': chat.title,
                            'description': chat.description,
                            'documentId': '',
                            'ownerId': uid,
                          });
                        
                      final String documentId = documentReference.documentID;
                          chat.documentId = documentId;

                      await Firestore.instance.collection('public_chats')
                        .document(documentId)
                        .updateData({
                          'documentId': documentId,
                        }); 
                      
                      Navigator.pop(context);
                    }
                  }
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}