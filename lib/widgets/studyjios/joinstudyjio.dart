//import 'package:SoCUniteTwo/screens/studyjio_screens/studyjios_listview_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:SoCUniteTwo/providers/studyjio.dart';
import 'package:SoCUniteTwo/widgets/provider_widget.dart';
import 'package:intl/intl.dart';

class JoinStudyjio extends StatefulWidget {
  final Studyjio studyjio;
  static bool isCreatedByUser = false;

  JoinStudyjio({Key key, @required this.studyjio}) : super(key: key);
  @override
  _JoinStudyjioState createState() => _JoinStudyjioState();
}

class _JoinStudyjioState extends State<JoinStudyjio> {
  bool _isJoined = false;
  bool _isMine = false;

  _toggleJoinButton() {
    setState(() {
      _isJoined = !_isJoined;
    });
  }

  // _leaveChat() async {
  //   final uid = await Provider.of(context).auth.getCurrentUID(); 
  //   await Firestore.instance.collection('users').document(uid)
  //   .collection('my_studyjios_chats').document(widget.studyjio.title)
  //   .delete();
  // }

  void _showJoinDialog() { //does not control database codes 
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
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget> [
              Text(
                "You have joined the study-jio successfully.",
                style: TextStyle(color: Colors.grey[100]),
              ),
              SizedBox(height: 20),
              Text(
                "You have been added into the chat room under 'Study Jios' in Chatrooms.",
                style: TextStyle(color: Colors.grey[100]),
              ),
              SizedBox(height: 20),
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
                  await _toggleJoinButton(); //changes isJoined to !isJoined

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
                  }); //updating browse

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
                  }); //updating joined 

                  await Firestore.instance.collection('users').document(widget.studyjio.ownerId)
                    .collection('my_studyjios').document(widget.studyjio.documentId)
                    .updateData({
                      'joinedUsers': widget.studyjio.joinedUsers,
                    }); // updating owner's collection

                  await Firestore.instance.collection('users').document(uid)
                  .collection('joined_studyjios').document(widget.studyjio.documentId).delete();
                  print('DELETED'); // deleting from my joined collection

                  //deleting studyjios chat
                await Firestore.instance.collection('users').document(uid)
                .collection('my_studyjios_chats').document(widget.studyjio.title)
                .delete();



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

  // void _showDeleteDialog() {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return Padding(
  //  padding: EdgeInsets.only(left: 50.0, right: 50.0, top: 20, bottom: 20),
  //  child: AlertDialog(
  //           backgroundColor: Colors.grey[850],
  //           title: new Text(
  //             "Confirmation",
  //             style: TextStyle(color: Colors.blue[300]),
  //             ),
  //           content: Text(
  //             "Are you sure you want to delete the study-jio you have created?",
  //             style: TextStyle(color: Colors.grey[100]),
  //           ),      
  //           actions: <Widget>[
  //             // buttons at the bottom of the dialog
  //             new FlatButton(
  //               color: Colors.blue[300],
  //               child: new Text(
  //                 "Yes",
  //                 style: TextStyle(color: Colors.black),
  //               ),
  //               onPressed: () async { // user wants to delete
  //                 final uid = await Provider.of(context).auth.getCurrentUID();

  //                 await Firestore.instance.collection('browse_jios').document(widget.studyjio.documentId)
  //                 .delete(); //deleting from browse collection

  //                 await Firestore.instance.collection('users').document(uid)
  //                 .collection('my_studyjios').document(widget.studyjio.documentId).delete(); //deleting from my collection

  //                 await Firestore.instance.collection('users').getDocuments().then((querySnapshot) {
  //                   querySnapshot.documents.forEach((result) {
  //                     Firestore.instance.collection('users').document(result.documentID)
  //                     .collection('joined_studyjios').getDocuments().then((querySnapshot) {
  //                       querySnapshot.documents.forEach((element) { 
  //                         if (element.documentID == widget.studyjio.documentId) {
  //                           Firestore.instance.collection('users').document(result.documentID) 
  //                           .collection('joined_studyjios').document(element.documentID)
  //                           .delete(); //deleting from joined collection
  //                         }
  //                       });
  //                     });  
  //                   });
  //                 }); //updating join

  //                // _leaveChat();

  //                await Firestore.instance.collection('users').document(uid)
  //                 .collection('my_studyjios_chats').document(widget.studyjio.title)
  //                 .delete();

  //                 Navigator.of(context).pop(); 
  //               },
  //             ),
  //             new FlatButton(
  //               color: Colors.blue[300],
  //               child: new Text(
  //                 "No",
  //                 style: TextStyle(color: Colors.black),
  //               ),
  //               onPressed: () {
  //                 Navigator.of(context).pop();
  //               },
  //             ),
  //           ],
  //       ),
  //       );
  //     },
  //   );
  // }

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
           print('mark this user as false join');
        });
      } 
      if (widget.studyjio.ownerId == uid) {
        setState(() {
          _isMine = true;
          JoinStudyjio.isCreatedByUser = _isMine;
        });
      } else { //if not mine and my username is in map
          setState(() {
           _isJoined = value.data['joinedUsers'][getUsername]; 
          });
      }  

    });
  } 

  _joinChat() async {
    final uid = await Provider.of(context).auth.getCurrentUID(); 

    await Firestore.instance.collection('users').document(uid)
    .collection('my_studyjios_chats').document(widget.studyjio.title)
    .setData({
      'title': widget.studyjio.title,
      'description':widget.studyjio.description,
    });

    await Firestore.instance.collection('users').document(widget.studyjio.ownerId)
    .collection('my_studyjios_chats').document(widget.studyjio.title)
    .collection(widget.studyjio.title).getDocuments().then((querySnapshot) {
      querySnapshot.documents.forEach((element) async { // element refers to each text
        await Firestore.instance.collection('users').document(uid)
        .collection('my_studyjios_chats').document(widget.studyjio.title)
        .collection(widget.studyjio.title).add({
          'text': element.data['text'],
          'createdAt': element.data['createdAt'],
          'userId': element.data['userId'],
          'username': element.data['username'],
        });
      });
    });
  }

  
  _switch() {
    var now = DateTime.now(); //DateTime
  
    var date = widget.studyjio.date; //parse this to datetime (Jul 21, 2020)
    DateFormat format = new DateFormat("MMM dd, yyyy");
    var useDate = format.parse(date); //2020-07-21 00:00:00.000

    var year = useDate.year; 
    var month = useDate.month; 
    var day = useDate.day;
   
    var startTime = DateFormat.jm().parse(widget.studyjio.startTime); 
    var endTime = DateFormat.jm().parse(widget.studyjio.startTime);
    startTime = startTime.toLocal();
    endTime = endTime.toLocal();
    startTime = new DateTime(year, month, day, startTime.hour,startTime.minute,startTime.millisecond,startTime.microsecond);
    endTime = new DateTime(year, month, day, startTime.hour,startTime.minute,startTime.millisecond,startTime.microsecond);
    var difference = startTime.difference(now).inMinutes;
    //as long as difference is negative => display ('OVER')
   
    if(_isMine) { //display bin icon 
      if(difference > 30) {
       return IconButton(
          icon: Icon(
            Icons.delete_forever,
            color: Colors.tealAccent,
            size: 30,
          ), 
          onPressed: () async {
            //_showDeleteDialog();

            final uid = await Provider.of(context).auth.getCurrentUID();

            await Firestore.instance.collection('browse_jios').document(widget.studyjio.documentId)
                  .delete().then((_) {
                    print('deleted studyjio from browse');
                  }); //deleting from browse collection

                  await Firestore.instance.collection('users').document(uid)
                  .collection('my_studyjios').document(widget.studyjio.documentId).delete()
                  .then((_) {
                    print('deleted from my_jios listview');
                  }); //deleting from my collection

                  await Firestore.instance.collection('users').document(uid)
                  .collection('my_studyjios_chats').document(widget.studyjio.title)
                  .delete().then((_) {
                    print('deleted studyjio chats');
                  });

                  await Firestore.instance.collection('users').getDocuments().then((querySnapshot) {
                    querySnapshot.documents.forEach((result) {
                      Firestore.instance.collection('users').document(result.documentID)
                      .collection('joined_studyjios').getDocuments().then((querySnapshot) {
                        querySnapshot.documents.forEach((element) { 
                          if (element.documentID == widget.studyjio.documentId) {
                            Firestore.instance.collection('users').document(result.documentID) 
                            .collection('joined_studyjios').document(element.documentID)
                            .delete(); //deleting from joined collection
                          }
                        });
                      });  
                    });
                  }); //updating join

                 // _leaveChat();
          }
        );
      } else if((difference > 0) && (difference <= 30)) {
        return Container();
      }
      else { //difference < 0
        return Container(
                child: Text(
                'ENDED',
                style: TextStyle(color: Colors.grey[100]),
                ),
              );
      }  
    } else { //is not mine
        if(_isJoined) { //IF JOIN AND NOT MINE: if full -> display full and leave / if not full -> display leave           
          return FutureBuilder(
                future: Firestore.instance.collection('browse_jios').document(widget.studyjio.documentId).get(),
                builder: (context, snapshot) {
                  if (snapshot.data != null) {
                    if(snapshot.data['capacity'] == snapshot.data['joinedUsers'].values.where((e)=> e as bool).length
                    && difference > 30) { //if full and still can leave
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
            ]);
              } else if(snapshot.data['capacity'] == snapshot.data['joinedUsers'].values.where((e)=> e as bool).length && 
              difference <= 30 && difference > 0) {
                    return Container(
                  child: Text(
                    'FULL',
                style: TextStyle(color: Colors.grey[100]),
                ),
          );
              } else if(snapshot.data['capacity'] != snapshot.data['joinedUsers'].values.where((e)=> e as bool).length &&
              difference > 30) {
                return RaisedButton(
                child: Text(
                  'Leave',
                  style: TextStyle(color: Colors.grey[100]),
                ),
                color: Colors.grey[700],
                onPressed: () {
                  _showLeaveDialog();
                }
              );
              } else if(snapshot.data['capacity'] != snapshot.data['joinedUsers'].values.where((e)=> e as bool).length && difference > 0
              && difference <= 30) {
                return Container();
              } else {
                return Container(
                child: Text(
                'ENDED',
                style: TextStyle(color: Colors.grey[100]),
                ),
              );
              }
        } else {
          return CircularProgressIndicator();
        }
      });
        } else { //not mine, not join 
          return FutureBuilder(
            future: Firestore.instance.collection('browse_jios').document(widget.studyjio.documentId).get(),
                builder: (context, snapshot) {
                  if(snapshot.data != null) {
                    if(snapshot.data['capacity'] == snapshot.data['joinedUsers'].values.where((e)=> e as bool).length &&
                    difference > 0) {
                       return Container(
              child: Text(
                'FULL',
            style: TextStyle(color: Colors.grey[100]),
            ),
          );
                    } else if(snapshot.data['capacity'] != snapshot.data['joinedUsers'].values.where((e)=> e as bool).length &&
                    difference > 0) {
                      return RaisedButton(
                        color: Colors.tealAccent,
                         child: Text(
                          'JOIN',
                          style: TextStyle(color: Colors.black),
                        ), onPressed: () async {
                          await _toggleJoinButton(); //from notJoined to not isjoin
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
                          });  //updating browse collection

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
            }); // updating to joined collection

            await Firestore.instance.collection('users').document(widget.studyjio.ownerId)
              .collection('my_studyjios').document(widget.studyjio.documentId)
              .setData({
                 'joinedUsers': widget.studyjio.joinedUsers,
                 'locationOnMap': widget.studyjio.locationOnMap,
                }, merge: true).then((_) {
                 print("joined uploaded to firebase");
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
              'locationOnMap': widget.studyjio.locationOnMap,
              'username': widget.studyjio.username,
            }); //uploading to my joined collection

            await _joinChat();
            _showJoinDialog(); //does not handle firebase code
                            
                        },
                      );
                    } else {
                      return Container(
                child: Text(
                'ENDED',
                style: TextStyle(color: Colors.grey[100]),
                ),
              );
                    }
                  } else {
                    return CircularProgressIndicator();
                  }
                }
          );
        }
    } 
  }
          
  @override
  Widget build(BuildContext context) {
        return Container(
          child: _switch(),
        );
  }
}
