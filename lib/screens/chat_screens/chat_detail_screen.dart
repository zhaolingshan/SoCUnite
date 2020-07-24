import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:SoCUniteTwo/providers/chat.dart';
import 'package:SoCUniteTwo/widgets/provider_widget.dart';

class ChatDetailScreen extends StatefulWidget {
  final Chat chat;

  ChatDetailScreen({Key key, @required this.chat}) : super(key: key);
  @override
  _ChatDetailScreenState createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  final _form = GlobalKey<FormState>();

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

  void _editTitleModalBottomSheet(BuildContext context) {

    TextEditingController _newTitleController = new TextEditingController();

    showModalBottomSheet(
      backgroundColor: Colors.grey[900],
      context: context, 
      builder: (BuildContext buildContext) {
        return Container(
          height: MediaQuery.of(context).size.height * .60,
          child: Padding(
            padding: EdgeInsets.only(left: 15.0, top: 15.0),
            child: Form(
              key: _form,
              child: Column(
                children: <Widget> [
                  Row(
                    children: <Widget>[
                      Text(
                        "Edit Title", 
                        style: TextStyle(
                          color: Colors.grey[100],
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                        ),
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
                  TextFormField(
                    cursorColor: Colors.tealAccent,
                    style: TextStyle(
                    color: Colors.grey[100]),
                    controller: _newTitleController,
                    decoration: InputDecoration(
                      labelText: 'Title', 
                      labelStyle: TextStyle(color: Colors.grey[100]),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.tealAccent,),
                      ),
                      enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter a title.';
                      }
                      return null; 
                    },
                  ),
                  SizedBox(height: 20,),
                  RaisedButton(
                    color: Colors.blue[400],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
                      child: Text(
                        "Save", 
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold, fontSize: 15
                        ),
                      ),
                    ),
                    onPressed: () async {
                      if (validate()) {
                        await Firestore.instance.collection('public_chats')
                        .document(widget.chat.documentId)
                        .setData({
                          'title': _newTitleController.text,
                        }, merge: true).then((_) {
                       });

                        Navigator.pop(context);
                        String snackBarTitle = 'New title: ' + _newTitleController.text;
                        final snackBar = SnackBar(
                        content: Text(snackBarTitle, overflow: TextOverflow.ellipsis, maxLines: 2),
                        duration: Duration(seconds: 5),
                      );

                      Scaffold.of(context).showSnackBar(snackBar);
                      }
                    },
                  )
                ],
              ),
            ),
          ),
        );
      }
    );
  }

  void _editDescriptionModalBottomSheet(BuildContext context) {
    TextEditingController _newDescriptionController = new TextEditingController();
    showModalBottomSheet(
      backgroundColor: Colors.grey[900],
      context: context, 
      builder: (BuildContext buildContext) {
        return Container(
          height: MediaQuery.of(context).size.height * .60,
          child: Padding(
            padding: EdgeInsets.only(left: 15.0, top: 15.0),
            child: Form(
              key: _form,
              child: Column(
                children: <Widget> [
                  Row(
                    children: <Widget>[
                      Text(
                        "Edit Description", 
                        style: TextStyle(
                          color: Colors.grey[100],
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                        ),
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
                  TextFormField(
                    cursorColor: Colors.tealAccent,
                    style: TextStyle(
                    color: Colors.grey[100]),
                    controller: _newDescriptionController,
                    decoration: InputDecoration(
                      labelText: 'Description', 
                      labelStyle: TextStyle(color: Colors.grey[100]),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.tealAccent,),
                      ),
                      enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                    ),
                    maxLines: 3,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.multiline,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter a description.';
                      }
                      if (value.length < 10) {
                        return 'Please provide more details.'; // ensure description is elaborate enough
                      }
                        return null;
                    }, 
                  ),
                  SizedBox(height: 20,),
                  RaisedButton(
                    color: Colors.blue[400],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
                      child: Text(
                        "Save", 
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold, fontSize: 15
                        ),
                      ),
                    ),
                    onPressed: () async {
                      if (validate()) {

                        await Firestore.instance.collection('public_chats')
                        .document(widget.chat.documentId)
                        .setData({
                          'description': _newDescriptionController.text,
                        }, merge: true).then((_) {
                       }); 

                        Navigator.pop(context);
                        String snackBarTitle = 'New Description: ' + _newDescriptionController.text;
                        final snackBar = SnackBar(
                        content: Text(snackBarTitle, overflow: TextOverflow.ellipsis, maxLines: 2),
                        duration: Duration(seconds: 5),
                      );

                      Scaffold.of(context).showSnackBar(snackBar);
                      }
                    },
                  )
                ],
              ),
            ),
          ),
        );
      }
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        backgroundColor: Colors.grey[850],
        title: Text('Chat Details'), 
        centerTitle: true,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.of(context).pop();
              },
            );
          },
        ),
      ),
      body: Center(
        child: Builder(
          builder: (builderContext) {
            return Column(
              children: <Widget>[
                SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Spacer(),
                      Text(
                        'Created by ', 
                        style: TextStyle(
                          color: Colors.blue[300],
                          fontSize: 16,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                       FutureBuilder( 
                        future: Firestore.instance.collection('users').document(widget.chat.ownerId).get(),
                        builder: (context, snapshot) {
                          if (snapshot.data != null) {
                            return Text(snapshot.data['username'], style: TextStyle(
                              fontSize: 16, fontStyle: FontStyle.italic, color: Colors.blue[300]),
                            );
                          } else {
                            return CircularProgressIndicator();
                          }           
                        }, 
                      ),
                      //Text(
                      //   user.displayName, 
                      //   style: TextStyle(
                      //     color: Colors.blue[300],
                      //     fontSize: 16,
                      //     fontStyle: FontStyle.italic,
                      //   ),
                      // ),
                      Spacer(),
                    ],
                  ),
                  SizedBox(height:30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(width: 20),
                      Text(
                        'Title', 
                        style: TextStyle(
                          color: Colors.grey[100],
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Spacer(),
                      FutureBuilder(
                        future: Provider.of(context).auth.getCurrentUID(),
                        builder: (context, AsyncSnapshot snapshot) {
                        if (snapshot.data == widget.chat.ownerId) {
                          return  IconButton(
                            color: Colors.tealAccent,
                            icon: Icon(Icons.edit),
                            onPressed: () {    
                              _editTitleModalBottomSheet(context);               
                            }
                          );
                        } else {
                          return Container();
                        }
                      },
                      ),
                    ],
                  ),
                      SizedBox(height:10),
                      Container(
                        height: 80,
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: Center(
                          child: Text(
                            widget.chat.title, 
                            style: TextStyle(color: Colors.grey[100]),
                          ),
                        ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey[600],
                            ),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                      ),
                      SizedBox(height: 50),
                      Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(width: 20),
                      Text(
                        'Description', 
                        style: TextStyle(
                          color: Colors.grey[100],
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Spacer(),
                      FutureBuilder(
                        future: Provider.of(context).auth.getCurrentUID(),
                        builder: (context, AsyncSnapshot snapshot) {
                        if (snapshot.data == widget.chat.ownerId) {
                          return  IconButton(
                            color: Colors.tealAccent,
                            icon: Icon(Icons.edit),
                            onPressed: () {    
                              _editDescriptionModalBottomSheet(context);               
                            }
                          );
                        } else {
                          return Container();
                        }
                      },
                      )
                    ],
                  ),
                  SizedBox(height:10),
                  Container(
                    height: 120,
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: Center(
                      child: Text(
                        widget.chat.description, 
                        style: TextStyle(color: Colors.grey[100]),
                      ),
                    ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey[600],
                        ),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                  ),
                  SizedBox(height: 20),
              ],
            );
          }
        ),
      ),     
    );
  }
}