import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:SoCUniteTwo/providers/studyjio.dart';
import 'package:SoCUniteTwo/widgets/provider_widget.dart';
//import 'package:SoCUniteTwo/widgets/studyjios/joinstudyjio.dart';
import 'package:SoCUniteTwo/screens/studyjio_screens/book_a_room_screen.dart';
import 'package:SoCUniteTwo/screens/studyjio_screens/choose_a_location_screen.dart';
import 'package:SoCUniteTwo/models/place.dart';

class StudyjioDetailScreen extends StatefulWidget {
  final Studyjio studyjio;

  StudyjioDetailScreen({Key key, @required this.studyjio}) : super(key: key);
  @override
  _StudyjioDetailScreenState createState() => _StudyjioDetailScreenState();
}

class _StudyjioDetailScreenState extends State<StudyjioDetailScreen> {
  final _form = GlobalKey<FormState>();
  String getLocation = '';
  GeoPoint getLocationOnMap = GeoPoint(null, null);
  String listOfUsersJoined = '';
  
  getUID() async {
    return await Provider.of(context).auth.getCurrentUID();
  }

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

  _navigateAndDisplaySelectionforLocation(BuildContext context) async {
    Place result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChooseALocationScreen(),
      )
    );
    String location = result.title;
    Scaffold.of(context)
              ..removeCurrentSnackBar()
              ..showSnackBar(SnackBar(content: Text("Your chosen location: $location")));
    setState(() {
      getLocation = location;
      getLocationOnMap = GeoPoint(result.location.latitude, result.location.longitude);
    });
  }
  
  _navigateAndDisplaySelectionforRoom(BuildContext context) async {
    Place result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BookARoomScreen(),
      )
    );
    String room = result.title;
    Scaffold.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text("Your chosen location: $room")));
    setState(() {
      getLocation = room;
      getLocationOnMap = GeoPoint(result.location.latitude, result.location.longitude);
    });
  }

  // void _editTitleModalBottomSheet(BuildContext context) {

  //   TextEditingController _newTitleController = new TextEditingController();

  //   showModalBottomSheet(
  //     backgroundColor: Colors.grey[900],
  //     context: context, 
  //     builder: (BuildContext buildContext) {
  //       return Container(
  //         height: MediaQuery.of(context).size.height * .60,
  //         child: Padding(
  //           padding: EdgeInsets.only(left: 15.0, top: 15.0),
  //           child: Form(
  //             key: _form,
  //             child: Column(
  //               children: <Widget> [
  //                 Row(
  //                   children: <Widget>[
  //                     Text(
  //                       "Edit Title", 
  //                       style: TextStyle(
  //                         color: Colors.grey[100],
  //                         fontWeight: FontWeight.bold,
  //                         fontSize: 18,
  //                       ),
  //                       ),
  //                     Spacer(),
  //                     IconButton(
  //                       icon: Icon(Icons.cancel, color: Colors.white),
  //                       color: Colors.blue[400],
  //                       iconSize: 25,
  //                       onPressed: () { 
  //                         Navigator.of(context).pop();
  //                       },
  //                     ),
  //                   ],
  //                 ),
  //                 TextFormField(
  //                   cursorColor: Colors.tealAccent,
  //                   style: TextStyle(
  //                   color: Colors.grey[100]),
  //                   controller: _newTitleController,
  //                   decoration: InputDecoration(
  //                     labelText: 'Title', 
  //                     labelStyle: TextStyle(color: Colors.grey[100]),
  //                     focusedBorder: UnderlineInputBorder(
  //                       borderSide: BorderSide(color: Colors.tealAccent,),
  //                     ),
  //                     enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
  //                   ),
  //                   validator: (value) {
  //                     if (value.isEmpty) {
  //                       return 'Please enter a title.';
  //                     }
  //                     return null; 
  //                   },
  //                 ),
  //                 SizedBox(height: 20,),
  //                 RaisedButton(
  //                   color: Colors.blue[400],
  //                   shape: RoundedRectangleBorder(
  //                     borderRadius: BorderRadius.circular(50)
  //                   ),
  //                   child: Padding(
  //                     padding: EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
  //                     child: Text(
  //                       "Save", 
  //                       style: TextStyle(
  //                         color: Colors.white,
  //                         fontWeight: FontWeight.bold, fontSize: 15
  //                       ),
  //                     ),
  //                   ),
  //                   onPressed: () async {
  //                     if (validate()) {
  //                       await Firestore.instance.collection('browse_jios')
  //                       .document(widget.studyjio.documentId)
  //                       .setData({
  //                         'title': _newTitleController.text,
  //                       }, merge: true).then((_) {
  //                      });

  //                       await Firestore.instance.collection('users').document(widget.studyjio.ownerId)
  //                       .collection('my_studyjios').document(widget.studyjio.documentId)
  //                       .setData({
  //                         'title': _newTitleController.text,
  //                       }, merge: true).then((_) {
  //                      });

  //                         await Firestore.instance.collection('users').getDocuments().then((querySnapshot) {
  //                   querySnapshot.documents.forEach((result) {
  //                     Firestore.instance.collection('users').document(result.documentID)
  //                     .collection('joined_studyjios').getDocuments().then((querySnapshot) {
  //                       querySnapshot.documents.forEach((element) { 
  //                         if (element.documentID == widget.studyjio.documentId) {
  //                           Firestore.instance.collection('users').document(result.documentID) 
  //                           .collection('joined_studyjios').document(element.documentID)
  //                           .setData({
  //                              'title': _newTitleController.text,
  //                           }, merge: true).then((_) {
  //                             print("joined uploaded to firebase");
  //                           });
  //                         }
  //                       });
  //                     });  
  //                   });
  //                 }); //updating joined collection


  //                       Navigator.pop(context);
  //                       String snackBarTitle = 'New title: ' + _newTitleController.text;
  //                       final snackBar = SnackBar(
  //                       content: Text(snackBarTitle, overflow: TextOverflow.ellipsis, maxLines: 2),
  //                       duration: Duration(seconds: 5),
  //                     );

  //                     Scaffold.of(context).showSnackBar(snackBar);
  //                     }
  //                   },
  //                 )
  //               ],
  //             ),
  //           ),
  //         ),
  //       );
  //     }
  //   );
  // }

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
                      if (value.length < 20) {
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

                        await Firestore.instance.collection('browse_jios')
                        .document(widget.studyjio.documentId)
                        .setData({
                          'description': _newDescriptionController.text,
                        }, merge: true).then((_) {
                       }); //updating browse collection

                        await Firestore.instance.collection('users').document(widget.studyjio.ownerId)
                    .collection('my_studyjios').document(widget.studyjio.documentId)
                    .setData({
                      'description': _newDescriptionController.text,
                    }, merge: true).then((_) {
                    }); //updating owners collection

                       await Firestore.instance.collection('users').getDocuments().then((querySnapshot) {
                    querySnapshot.documents.forEach((result) {
                      Firestore.instance.collection('users').document(result.documentID)
                      .collection('joined_studyjios').getDocuments().then((querySnapshot) {
                        querySnapshot.documents.forEach((element) { 
                          if (element.documentID == widget.studyjio.documentId) {
                            Firestore.instance.collection('users').document(result.documentID) 
                            .collection('joined_studyjios').document(element.documentID)
                            .setData({
                               'description': _newDescriptionController.text,
                            }, merge: true).then((_) {
                              //print("joined uploaded to firebase");
                            });
                          }
                        });
                      });  
                    });
                  }); //updating joined collection

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

  void _editDateModalBottomSheet(BuildContext context) {

    DateTime _date = DateTime.now();
    String _formattedate = new DateFormat.yMMMd().format(_date);

    TextEditingController _newDateController = new TextEditingController();
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
                        "Edit Date", 
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
                    controller: _newDateController,
                    decoration: InputDecoration(
                      labelText: 'Date', 
                      labelStyle: TextStyle(color: Colors.grey[100]),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.tealAccent,),
                      ),
                      enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please provide a date.';
                      }
                      return null; 
                    },
                    onTap: () async {
                      DateTime picked = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2020),
                        lastDate: DateTime(2021));
                      _newDateController.text = _formattedate.toString();
                        if(picked != null && picked != _date) {
                          setState(() {
                            _date = picked;
                          });
                        }
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
                        await Firestore.instance.collection('browse_jios')
                        .document(widget.studyjio.documentId)
                        .setData({
                          'date': _newDateController.text,
                        }, merge: true).then((_) {
                    }); //updating browse collection

                        await Firestore.instance.collection('users').document(widget.studyjio.ownerId)
                    .collection('my_studyjios').document(widget.studyjio.documentId)
                    .setData({
                      'date': _newDateController.text,
                    }, merge: true).then((_) {
                    }); //updating owners collection

                       await Firestore.instance.collection('users').getDocuments().then((querySnapshot) {
                    querySnapshot.documents.forEach((result) {
                      Firestore.instance.collection('users').document(result.documentID)
                      .collection('joined_studyjios').getDocuments().then((querySnapshot) {
                        querySnapshot.documents.forEach((element) { 
                          if (element.documentID == widget.studyjio.documentId) {
                            Firestore.instance.collection('users').document(result.documentID) 
                            .collection('joined_studyjios').document(element.documentID)
                            .setData({
                                'date': _newDateController.text,
                            }, merge: true).then((_) {
                              print("joined uploaded to firebase");
                            });
                          }
                        });
                      });  
                    });
                  }); //updating joined collection                       
                       
                        Navigator.pop(context);
                        String snackBarTitle = 'New Date: ' + _newDateController.text;
                        final snackBar = SnackBar(
                        content: Text(snackBarTitle, overflow: TextOverflow.ellipsis, maxLines: 2,),
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

  void _editStartTimeModalBottomSheet(BuildContext context) {

    TextEditingController _newStartTimeController = new TextEditingController();
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
                        "Edit Start Time", 
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
                    controller: _newStartTimeController,
                    decoration: InputDecoration(
                      labelText: 'Start Time', 
                      labelStyle: TextStyle(color: Colors.grey[100]),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.tealAccent,),
                      ),
                      enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please provide a start time.';
                      }
                      return null; 
                    },
                    onTap: () async {
                      TimeOfDay time = TimeOfDay.now();
                      FocusScope.of(context).requestFocus(new FocusNode());
                      TimeOfDay picked =
                        await showTimePicker(context: context, initialTime: time);
                      if (picked != null && picked != time) {
                        _newStartTimeController.text = picked.format(context);
                          setState(() {
                            time = picked;
                          });
                      }
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
                        await Firestore.instance.collection('browse_jios')
                        .document(widget.studyjio.documentId)
                        .setData({
                          'startTime': _newStartTimeController.text,
                        }, merge: true).then((_) {
                              print("joined uploaded to firebase");
                        }); 

                        await Firestore.instance.collection('users').document(widget.studyjio.ownerId)
                    .collection('my_studyjios').document(widget.studyjio.documentId)
                    .setData({
                       'startTime': _newStartTimeController.text,
                    }, merge: true).then((_) {
                              print("joined uploaded to firebase");
                            }); //updating owners collection

                       await Firestore.instance.collection('users').getDocuments().then((querySnapshot) {
                    querySnapshot.documents.forEach((result) {
                      Firestore.instance.collection('users').document(result.documentID)
                      .collection('joined_studyjios').getDocuments().then((querySnapshot) {
                        querySnapshot.documents.forEach((element) { 
                          if (element.documentID == widget.studyjio.documentId) {
                            Firestore.instance.collection('users').document(result.documentID) 
                            .collection('joined_studyjios').document(element.documentID)
                            .setData({
                               'startTime': _newStartTimeController.text,
                            }, merge: true).then((_) {
                              print("joined uploaded to firebase");
                            });
                          }
                        });
                      });  
                    });
                  }); //updating joined collection    

                        Navigator.pop(context);

                        String snackBarTitle = 'New Start Time: ' + _newStartTimeController.text;
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

  void _editEndTimeModalBottomSheet(BuildContext context) {

    TextEditingController _newEndTimeController = new TextEditingController();
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
                        "Edit End Time", 
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
                    controller: _newEndTimeController,
                    decoration: InputDecoration(
                      labelText: 'End Time', 
                      labelStyle: TextStyle(color: Colors.grey[100]),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.tealAccent,),
                      ),
                      enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please provide an end time.';
                      }
                      return null; 
                    },
                    onTap: () async {
                      TimeOfDay time = TimeOfDay.now();
                      FocusScope.of(context).requestFocus(new FocusNode());
                      TimeOfDay picked =
                        await showTimePicker(context: context, initialTime: time);
                      if (picked != null && picked != time) {
                        _newEndTimeController.text = picked.format(context);
                          setState(() {
                            time = picked;
                          });
                      }
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
                        await Firestore.instance.collection('browse_jios')
                        .document(widget.studyjio.documentId)
                        .setData({
                          'endTime': _newEndTimeController.text,
                        }, merge: true).then((_) {
                              print("joined uploaded to firebase");
                            });

                      await Firestore.instance.collection('users').document(widget.studyjio.ownerId)
                    .collection('my_studyjios').document(widget.studyjio.documentId)
                    .setData({
                       'endTime': _newEndTimeController.text,
                    }, merge: true).then((_) {
                              print("joined uploaded to firebase");
                    }); //updating owners collection

                       await Firestore.instance.collection('users').getDocuments().then((querySnapshot) {
                    querySnapshot.documents.forEach((result) {
                      Firestore.instance.collection('users').document(result.documentID)
                      .collection('joined_studyjios').getDocuments().then((querySnapshot) {
                        querySnapshot.documents.forEach((element) { 
                          if (element.documentID == widget.studyjio.documentId) {
                            Firestore.instance.collection('users').document(result.documentID) 
                            .collection('joined_studyjios').document(element.documentID)
                            .setData({
                              'endTime': _newEndTimeController.text,
                            }, merge: true).then((_) {
                              print("joined uploaded to firebase");
                            });
                          }
                        });
                      });  
                    });
                  }); //updating joined collection                          
                        Navigator.pop(context);

                        String snackBarTitle = 'New End Time: ' + _newEndTimeController.text;
                        final snackBar = SnackBar(
                        content: Text(snackBarTitle, overflow: TextOverflow.ellipsis, maxLines: 2,),
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

  void _editModulesModalBottomSheet(BuildContext context) {

    TextEditingController _newModulesController = new TextEditingController();
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
                        "Edit Module(s)", 
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
                    controller: _newModulesController,
                    decoration: InputDecoration(
                      labelText: 'Module(s)', 
                      labelStyle: TextStyle(color: Colors.grey[100]),
                      hintText: 'eg. CS2040S, CS2030,...',
                      hintStyle: TextStyle(color: Colors.grey[100]),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.tealAccent,),
                      ),
                      enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please key in module code(s).';
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
                        await Firestore.instance.collection('browse_jios')
                        .document(widget.studyjio.documentId)
                        .setData({
                          'modules': _newModulesController.text,
                        },merge: true).then((_) {
                              print("joined uploaded to firebase");
                            });

                        await Firestore.instance.collection('users').document(widget.studyjio.ownerId)
                    .collection('my_studyjios').document(widget.studyjio.documentId)
                    .setData({
                         'modules': _newModulesController.text,
                    },merge: true).then((_) {
                              print("joined uploaded to firebase");
                    });//updating owners collection

                       await Firestore.instance.collection('users').getDocuments().then((querySnapshot) {
                    querySnapshot.documents.forEach((result) {
                      Firestore.instance.collection('users').document(result.documentID)
                      .collection('joined_studyjios').getDocuments().then((querySnapshot) {
                        querySnapshot.documents.forEach((element) { 
                          if (element.documentID == widget.studyjio.documentId) {
                            Firestore.instance.collection('users').document(result.documentID) 
                            .collection('joined_studyjios').document(element.documentID)
                            .setData({
                                'modules': _newModulesController.text,
                            }, merge: true).then((_) {
                              print("joined uploaded to firebase");
                            });
                          }
                        });
                      });  
                    });
                  }); //updating joined collection                                                 
                        Navigator.pop(context);

                        String snackBarTitle = 'New Module(s): ' + _newModulesController.text;
                        final snackBar = SnackBar(
                        content: Text(snackBarTitle, overflow: TextOverflow.ellipsis, maxLines: 2,),
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

  void _editCapacityModalBottomSheet(BuildContext context) {

    TextEditingController _newCapacityController = new TextEditingController();
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
                        "Edit Capacity", 
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
                    controller: _newCapacityController,
                    decoration: InputDecoration(
                      labelText: 'Capacity', 
                      labelStyle: TextStyle(color: Colors.grey[100]),
                      hintText: 'Enter your desired quota from 2 to 10.',
                      hintStyle: TextStyle(color: Colors.grey[100]),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.tealAccent,),
                      ),
                      enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please key in a quota.';
                      } else if (int.parse(value) < 2) {
                        return 'Please key in a quota of at least 2';
                      } else if (int.parse(value) > 10) {
                        return 'Please key in a quota of no more than 10';
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
                        await Firestore.instance.collection('browse_jios')
                        .document(widget.studyjio.documentId)
                        .setData({
                          'capacity': int.parse(_newCapacityController.text),
                        }, merge: true).then((_) {
                              print("joined uploaded to firebase");
                            });

                      await Firestore.instance.collection('users').document(widget.studyjio.ownerId)
                    .collection('my_studyjios').document(widget.studyjio.documentId)
                    .setData({
                         'capacity': int.parse(_newCapacityController.text),
                    }, merge: true).then((_) {
                              print("joined uploaded to firebase");
                            }); //updating owners collection

                       await Firestore.instance.collection('users').getDocuments().then((querySnapshot) {
                    querySnapshot.documents.forEach((result) {
                      Firestore.instance.collection('users').document(result.documentID)
                      .collection('joined_studyjios').getDocuments().then((querySnapshot) {
                        querySnapshot.documents.forEach((element) { 
                          if (element.documentID == widget.studyjio.documentId) {
                            Firestore.instance.collection('users').document(result.documentID) 
                            .collection('joined_studyjios').document(element.documentID)
                            .setData({
                                'capacity': int.parse(_newCapacityController.text),
                            }, merge: true).then((_) {
                              print("joined uploaded to firebase");
                            });
                          }
                        });
                      });  
                    });
                  }); //updating joined collection                                             
                        Navigator.pop(context);
                        String snackBarTitle = 'New Capacity: ' + _newCapacityController.text;
                        final snackBar = SnackBar(
                        content: Text(snackBarTitle, overflow: TextOverflow.ellipsis, maxLines: 2,),
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

  void _editLocationModalBottomSheet(BuildContext context) {
    //bool _didUserChooseOnline = true;

    showModalBottomSheet(
      backgroundColor: Colors.grey[900],
      context: context, 
      builder: (BuildContext buildContext) {
        return Container(
          height: MediaQuery.of(context).size.height * .60,
          child: Padding(
            padding: EdgeInsets.only(left: 15.0, top: 15.0),
              child: Column(
                children: <Widget> [
                  Row(
                    children: <Widget>[
                      Text(
                        "Edit Location", 
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
                  SizedBox(height: 40,),
                  ButtonBar(
                  alignment: MainAxisAlignment.center,
                  children: <Widget>[
                    RaisedButton(
                      child: Text(
                        'Online',
                      ),
                      onPressed: () {
                        setState(() {
                         //_didUserChooseOnline = true; 
                         getLocation = 'Online';
                         getLocationOnMap = GeoPoint(40.7128, 74.0060);
                        });
                      },
                    ),
                    RaisedButton(
                      child: Text('Choose a Location'),
                      onPressed: () {
                        _navigateAndDisplaySelectionforLocation(context);
                        setState(() {
                          //_didUserChooseOnline = false;
                        }); 
                      },
                    ),
                    RaisedButton(
                      child: Text('Book a Room'),
                      onPressed: () {
                        _navigateAndDisplaySelectionforRoom(context);
                        setState(() {
                          //_didUserChooseOnline = false;
                        });
                      },
                    ),
                  ],
                ),
                  SizedBox(height: 30,),
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
                      await Firestore.instance.collection('browse_jios')
                      .document(widget.studyjio.documentId)
                      .setData({
                        'location': getLocation,
                        'locationOnMap': getLocationOnMap,
                      }, merge: true).then((_) {
                        print("set data in browse jios");
                      });

                    await Firestore.instance.collection('users').document(widget.studyjio.ownerId)
                    .collection('my_studyjios').document(widget.studyjio.documentId)
                    .setData({
                        'location': getLocation,
                        'locationOnMap': getLocationOnMap,
                    }, merge: true).then((_) {
                        print("set data in my jios");
                    });
                     //updating owners collection

                       await Firestore.instance.collection('users').getDocuments().then((querySnapshot) {
                    querySnapshot.documents.forEach((result) {
                      Firestore.instance.collection('users').document(result.documentID)
                      .collection('joined_studyjios').getDocuments().then((querySnapshot) {
                        querySnapshot.documents.forEach((element) { 
                          if (element.documentID == widget.studyjio.documentId) {
                            Firestore.instance.collection('users').document(result.documentID) 
                            .collection('joined_studyjios').document(element.documentID)
                            .setData({
                                'location': getLocation,
                                'locationOnMap': getLocationOnMap,
                            }, merge: true).then((_) {
                              print("joined uploaded to firebase");
                            });
                          }
                        });
                      });  
                    });
                  }); //updating joined collection                                
                      Navigator.pop(context);
                    },
                  )
                ],
              ),
            ),
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {

    //bool _didUserChooseOnline = true;
    widget.studyjio.joinedUsers.forEach((key, value) {
      if (value == true) {
        listOfUsersJoined += key + '\n';
      }             
    });
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        backgroundColor: Colors.grey[850],
        title: Text('Details'), 
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
            return SingleChildScrollView(
              child: Column(
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
                      Text(
                        widget.studyjio.username, 
                        style: TextStyle(
                          color: Colors.blue[300],
                          fontSize: 16,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      Spacer(),
                  ],
                  ),
                  SizedBox(height:10),
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
                      // FutureBuilder(
                      //   future: getUID(), //returns uid
                      //   builder: (context, AsyncSnapshot snapshot) {
                      //   if (snapshot.data == widget.studyjio.ownerId) {
                      //     return  IconButton(
                      //       color: Colors.tealAccent,
                      //       icon: Icon(Icons.edit),
                      //       onPressed: () {    
                      //         _editTitleModalBottomSheet(context);               
                      //       }
                      //     );
                      //   } else {
                      //     return Container();
                      //   }
                      // },
                      // )
                    ],
                  ),
                  SizedBox(height:10),
                  Container(
                    height: 80,
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: Center(
                      child: Text(
                        widget.studyjio.title, 
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
                        future: getUID(), //returns uid
                        builder: (context, AsyncSnapshot snapshot) {
                        if (snapshot.data == widget.studyjio.ownerId) {
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
                        widget.studyjio.description, 
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(width: 20),
                      Text(
                        'Module(s)', 
                        style: TextStyle(
                          color: Colors.grey[100],
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Spacer(),
                      FutureBuilder(
                        future: getUID(), //returns uid
                        builder: (context, AsyncSnapshot snapshot) {
                        if (snapshot.data == widget.studyjio.ownerId) {
                          return  IconButton(
                            color: Colors.tealAccent,
                            icon: Icon(Icons.edit),
                            onPressed: () {    
                              _editModulesModalBottomSheet(context);               
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
                    height: 60,
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: Center(
                      child: Text(
                        widget.studyjio.modules, 
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(width: 20),
                      Text(
                        'Date', 
                        style: TextStyle(
                          color: Colors.grey[100],
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Spacer(),
                      FutureBuilder(
                        future: getUID(), //returns uid
                        builder: (context, AsyncSnapshot snapshot) {
                        if (snapshot.data == widget.studyjio.ownerId) {
                          return  IconButton(
                            color: Colors.tealAccent,
                            icon: Icon(Icons.edit),
                            onPressed: () {    
                              _editDateModalBottomSheet(context);               
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
                    height: 30,
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: Center(
                      child: Text(
                        widget.studyjio.date, 
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(width: 20),
                      Text(
                        'Start Time', 
                        style: TextStyle(
                          color: Colors.grey[100],
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Spacer(),
                      FutureBuilder(
                        future: getUID(), //returns uid
                        builder: (context, AsyncSnapshot snapshot) {
                        if (snapshot.data == widget.studyjio.ownerId) {
                          return  IconButton(
                            color: Colors.tealAccent,
                            icon: Icon(Icons.edit),
                            onPressed: () {    
                              _editStartTimeModalBottomSheet(context);               
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
                    height: 30,
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: Center(
                      child: Text(
                        widget.studyjio.startTime, 
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(width: 20),
                      Text(
                        'End Time', 
                        style: TextStyle(
                          color: Colors.grey[100],
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Spacer(),
                      FutureBuilder(
                        future: getUID(), //returns uid
                        builder: (context, AsyncSnapshot snapshot) {
                        if (snapshot.data == widget.studyjio.ownerId) {
                          return  IconButton(
                            color: Colors.tealAccent,
                            icon: Icon(Icons.edit),
                            onPressed: () {    
                              _editEndTimeModalBottomSheet(context);               
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
                    height: 30,
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: Center(
                      child: Text(
                        widget.studyjio.endTime, 
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(width: 20),
                      Text(
                        'Capacity', 
                        style: TextStyle(
                          color: Colors.grey[100],
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Spacer(),
                      FutureBuilder(
                        future: getUID(), //returns uid
                        builder: (context, AsyncSnapshot snapshot) {
                        if (snapshot.data == widget.studyjio.ownerId) {
                          return  IconButton(
                            color: Colors.tealAccent,
                            icon: Icon(Icons.edit),
                            onPressed: () {    
                              _editCapacityModalBottomSheet(context);               
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
                    height: 30,
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: Center(
                      child: Text(
                        widget.studyjio.capacity.toString(), 
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(width: 20),
                      Text(
                        'Location', 
                        style: TextStyle(
                          color: Colors.grey[100],
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Spacer(),
                      FutureBuilder(
                        future: getUID(), //returns uid
                        builder: (context, AsyncSnapshot snapshot) {
                        if (snapshot.data == widget.studyjio.ownerId) {
                          return  IconButton(
                            color: Colors.tealAccent,
                            icon: Icon(Icons.edit),
                            onPressed: () {     
                             _editLocationModalBottomSheet(context);              
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
                    height: 30,
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: Center(
                      child: Text(
                        widget.studyjio.location, 
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(width: 20),
                      Text(
                        'Users Joined', 
                        style: TextStyle(
                          color: Colors.grey[100],
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height:10),
                  Container(
                    height: 120,
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: Center(
                      child: Text(
                      listOfUsersJoined,
                      style: TextStyle(color: Colors.grey[100]),
                      )
                    ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey[600],
                        ),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                  ),
                ],
              ),
            );
          }
        ), 
      ), 
    );
  } 
}