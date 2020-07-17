import 'package:SoCUniteTwo/screens/studyjio_screens/studyjios_listview_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:SoCUniteTwo/providers/studyjio.dart';
import 'package:SoCUniteTwo/widgets/provider_widget.dart';

class JoinStudyjio extends StatefulWidget {
  final Studyjio studyjio;

  JoinStudyjio({Key key, @required this.studyjio}) : super(key: key);
  @override
  _JoinStudyjioState createState() => _JoinStudyjioState();
}

class _JoinStudyjioState extends State<JoinStudyjio> {
 static bool _isJoined = false;
  static bool _isMine = false;

  _toggleJoinButton() {
    setState(() {
      _isJoined = !_isJoined;
    });
  }

  void _showJoinDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Padding(
   padding: EdgeInsets.only(left: 50.0, right: 50.0, top: 20, bottom: 20),
   child:
        AlertDialog(
          backgroundColor: Colors.grey[850],
          title: new Text(
            "Confirmation",
            style: TextStyle(color: Colors.blue[300]),
            ),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget> [
              Text(
                "You have joined the study-jio successfully.",
                style: TextStyle(color: Colors.grey[100]),
              ),
              SizedBox(height: 10),
              Text(
                "You have been added into the chat room under 'Study Jios' in Chatrooms.",
                style: TextStyle(color: Colors.grey[100]),
              ),
              SizedBox(height: 10),
              Text(
                "Please refrain from leaving the study-jio 30 minutes before it starts or you will be issued with a warning.",
                style: TextStyle(color: Colors.grey[100]),
              ),
            ],
          ),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              color: Colors.blue[300],
              child: new Text(
                "Close",
                style: TextStyle(color: Colors.black),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
        );
      },
    );
  }

  void _showLeaveDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Padding(
   padding: EdgeInsets.only(left: 50.0, right: 50.0, top: 20, bottom: 20),
   child: AlertDialog(
            backgroundColor: Colors.grey[850],
            title: new Text(
              "Confirmation",
              style: TextStyle(color: Colors.blue[300]),
              ),
            content: Text(
              "Are you sure you want to leave the study-jio?",
              style: TextStyle(color: Colors.grey[100]),
            ), 
            actions: <Widget>[
              // buttons at the bottom of the dialog
              new FlatButton(
                color: Colors.blue[300],
                child: new Text(
                  "Yes",
                  style: TextStyle(color: Colors.black),
                ),
                onPressed: () async { // user wants to leave
                  await _toggleJoinButton();

                  final uid = await Provider.of(context).auth.getCurrentUID();
                  final DocumentSnapshot userSnapshot = await Firestore.instance.collection('users').document(uid).get();
                  String getUsername = userSnapshot.data['username'];
                
                  widget.studyjio.joinedUsers.update(
                    getUsername, (value) => _isJoined, 
                    ifAbsent: () => _isJoined,
                  );

                  await Firestore.instance.collection('browse_jios')
                  .document(widget.studyjio.documentId).setData({
                    'joinedUsers': widget.studyjio.joinedUsers,
                  }, merge: true).then((_) {
                    print("joined uploaded to firebase");
                  }); 

                  await Firestore.instance.collection('users').getDocuments().then((querySnapshot) {
                    querySnapshot.documents.forEach((result) {
                      Firestore.instance.collection('users').document(result.documentID)
                      .collection('joined_studyjios').getDocuments().then((querySnapshot) {
                        querySnapshot.documents.forEach((element) { 
                          if (element.documentID == widget.studyjio.documentId) {
                            Firestore.instance.collection('users').document(result.documentID) 
                            .collection('joined_studyjios').document(element.documentID)
                            .setData({
                              'joinedUsers': widget.studyjio.joinedUsers,
                            }, merge: true).then((_) {
                              print("joined uploaded to firebase");
                            });
                          }
                        });
                      });  
                    });
                  }); // uploading to joined collection

                  await Firestore.instance.collection('users').document(widget.studyjio.ownerId)
                    .collection('my_studyjios').document(widget.studyjio.documentId)
                    .updateData({
                      'joinedUsers': widget.studyjio.joinedUsers,
                    }); // updating owner's collection

                  await Firestore.instance.collection('users').document(uid)
                  .collection('joined_studyjios').document(widget.studyjio.documentId).delete();
                  print('DELETED'); // deleting from my joined collection

                  await Firestore.instance.collection('browse_jios').document(widget.studyjio.documentId)
                  .updateData({
                    'joinedUsers': widget.studyjio.joinedUsers,
                  }); // updating public collection

                  await Firestore.instance.collection('users').document(widget.studyjio.ownerId)
                  .collection('my_studyjios').document(widget.studyjio.documentId)
                  .updateData({
                    'joinedUsers': widget.studyjio.joinedUsers,
                  }); // updating owner's private collection

                  await Firestore.instance.collection('users').getDocuments().then((querySnapshot) {
                    querySnapshot.documents.forEach((result) {
                      Firestore.instance.collection('users').document(result.documentID)
                      .collection('joined_studyjios').getDocuments().then((querySnapshot) {
                        querySnapshot.documents.forEach((element) { 
                          if (element.documentID == widget.studyjio.documentId) {
                            Firestore.instance.collection('users').document(result.documentID) 
                            .collection('joined_studyjios').document(element.documentID)
                            .setData({
                              'joinedUsers': widget.studyjio.joinedUsers,
                              }, merge: true).then((_) {
                                print("joined uploaded to firebase");
                            });
                          }
                        });
                      });  // uploading to joined collection
                    });
                  });
                //}
                Navigator.of(context).pop(); // remove alert
                },
              ),
              new FlatButton(
                color: Colors.blue[300],
                child: new Text(
                  "No",
                  style: TextStyle(color: Colors.black),
                ),
                onPressed: () { // user does not want to leave
                  Navigator.of(context).pop();
                },
              ),
            ],
          )
        );
      },
    );
  }

  void _showDeleteDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Padding(
   padding: EdgeInsets.only(left: 50.0, right: 50.0, top: 20, bottom: 20),
   child: AlertDialog(
            backgroundColor: Colors.grey[850],
            title: new Text(
              "Confirmation",
              style: TextStyle(color: Colors.blue[300]),
              ),
            content: Text(
              "Are you sure you want to delete the study-jio you have created?",
              style: TextStyle(color: Colors.grey[100]),
            ),      
            actions: <Widget>[
              // buttons at the bottom of the dialog
              new FlatButton(
                color: Colors.blue[300],
                child: new Text(
                  "Yes",
                  style: TextStyle(color: Colors.black),
                ),
                onPressed: () async { // user wants to delete
                  await Firestore.instance.collection('browse_jios').document(widget.studyjio.documentId)
                  .delete();
                  await Firestore.instance.collection('users').document(widget.studyjio.ownerId)
                  .collection('my_studyjios').document(widget.studyjio.documentId).delete();
                  Navigator.of(context).pop();
                },
              ),
              new FlatButton(
                color: Colors.blue[300],
                child: new Text(
                  "No",
                  style: TextStyle(color: Colors.black),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
        ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();

    Firestore.instance.collection('browse_jios').document(widget.studyjio.documentId)
    .get().then((value) async {

      final uid = await Provider.of(context).auth.getCurrentUID();
      final DocumentSnapshot userSnapshot = await Firestore.instance.collection('users').document(uid).get();
      String getUsername = userSnapshot.data['username']; // key

      if (value.data['joinedUsers'] == null ||value.data['joinedUsers'][getUsername] == null) {
        widget.studyjio.joinedUsers.putIfAbsent(getUsername, () => false);
        Firestore.instance.collection('browse_jios').document(widget.studyjio.documentId)
        .setData({
          'joinedUsers': widget.studyjio.joinedUsers,
         }, merge: true).then((_) {
        print("joined");
        });
      } if (widget.studyjio.ownerId == uid) {
        setState(() {
          _isMine = true;
        }); 
        print('my own');
      } else { //if not mine and my username is in map
          setState(() {
           _isJoined = value.data['joinedUsers'][getUsername]; 
          });
       print('DONE');
      }  

    });
  }
  // Future<bool> _isFull() async {
  // final DocumentSnapshot studyjioSnapshot = 
  //   await Firestore.instance.collection('browse_jios').document(widget.studyjio.documentId).get();
  //   return studyjioSnapshot.data['capacity'] == studyjioSnapshot.data['joinedUsers'].values.where((e)=> e as bool).length;
  // }

  _switch() {
    if (_isMine) {
      return Row(
        children: <Widget>[
          IconButton(
            icon: Icon(
              Icons.edit,
              color: Colors.tealAccent,
              size: 30,
            ), 
            onPressed: () { // EDITING
              
            },
          ),
          IconButton(
            icon: Icon(
              Icons.delete_forever,
              color: Colors.tealAccent,
              size: 30,
            ), 
            onPressed: ()  {
              _showDeleteDialog();
            }
          ),
          ],
        );
    } else if (StudyjiosListviewScreen.isFull == true && !_isMine) {
      print(_isJoined); //showing null
      print(_isMine); //showing false
      if (_isJoined) {
        return Row(
          children: <Widget> [
            Container(
              child: Text(
                'FULL',
                style: TextStyle(color: Colors.grey[100]),
              ),
            ),
            SizedBox(width: 10,),
            RaisedButton(
              child: Text(
                'Leave',
                style: TextStyle(color: Colors.grey[100]),
              ),
              color: Colors.grey[700],
              onPressed: () {
                _showLeaveDialog();
              }
            ),
          ]
        );
      } else { // user has not joined
        return Container(
          child: Text(
            'FULL',
            style: TextStyle(color: Colors.grey[100]),
          ),
        );
      }
    } else { 
      return RaisedButton(
        child: _isJoined
          ? Text(
            'Leave',
            style: TextStyle(color: Colors.grey[100]),
          )
          : Text(
            'JOIN',
          ),
        color: _isJoined
            ? Colors.grey[700]
            : Colors.tealAccent,
        onPressed: () async {
          if (!_isJoined) {
          await _toggleJoinButton();

          final uid = await Provider.of(context).auth.getCurrentUID();
          final DocumentSnapshot userSnapshot = await Firestore.instance.collection('users').document(uid).get();
          String getUsername = userSnapshot.data['username'];
      
          widget.studyjio.joinedUsers.update(
              getUsername, (value) => _isJoined, 
              ifAbsent: () => _isJoined,
            );

          await Firestore.instance.collection('browse_jios')
          .document(widget.studyjio.documentId).setData({
            'joinedUsers': widget.studyjio.joinedUsers,
          }, merge: true).then((_) {
              print("joined uploaded to firebase");
          }); 

          await Firestore.instance.collection('users').getDocuments().then((querySnapshot) {
            querySnapshot.documents.forEach((result) {
              Firestore.instance.collection('users').document(result.documentID)
              .collection('joined_studyjios').getDocuments().then((querySnapshot) {
                querySnapshot.documents.forEach((element) { 
                  if (element.documentID == widget.studyjio.documentId) {
                    Firestore.instance.collection('users').document(result.documentID) 
                    .collection('joined_studyjios').document(element.documentID)
                    .setData({
                      'joinedUsers': widget.studyjio.joinedUsers,
                    }, merge: true).then((_) {
                      print("joined uploaded to firebase");
                    });
                  }
                });
              });  
            });
          }); // uploading to joined collection

          await Firestore.instance.collection('users').document(widget.studyjio.ownerId)
            .collection('my_studyjios').document(widget.studyjio.documentId)
            .updateData({
              'joinedUsers': widget.studyjio.joinedUsers,
            }); // updating owner's collection

          await Firestore.instance.collection('users').document(uid)
          .collection('joined_studyjios').document(widget.studyjio.documentId)
          .setData({
            'title': widget.studyjio.title,
            'description': widget.studyjio.description,
            'date': widget.studyjio.date,
            'startTime': widget.studyjio.startTime,
            'endTime': widget.studyjio.endTime,
            'modules': widget.studyjio.modules,
            'documentId': widget.studyjio.documentId,
            'capacity': widget.studyjio.capacity,
            'ownerId': widget.studyjio.ownerId,
            'joinedUsers': widget.studyjio.joinedUsers,
            'currentCount': widget.studyjio.currentCount,
            'location': widget.studyjio.location,
            'username': widget.studyjio.username,
          });
          _showJoinDialog();

          } else { // users leaves
            _showLeaveDialog();
          }   
        },
      );
    }
  }
  @override
  Widget build(BuildContext context) {
        return Container(
          child: _switch(),
        );
  }
}