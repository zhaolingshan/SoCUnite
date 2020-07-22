// this screen is for both editing and adding a studyjio session
import 'package:SoCUniteTwo/screens/studyjio_screens/book_a_room_screen.dart';
import 'package:SoCUniteTwo/screens/studyjio_screens/choose_a_location_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'dart:io';
import 'package:SoCUniteTwo/providers/studyjio.dart';
import 'package:SoCUniteTwo/widgets/provider_widget.dart';
import 'package:SoCUniteTwo/models/place.dart';

class AddStudyJioScreen extends StatefulWidget {
  static String showTitleforMap = '';
  static GeoPoint showLocationOnMap = GeoPoint(null, null);
  // final Studyjio studyjio; //= new Studyjio(null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null);

   //AddStudyJioScreen({Key key, @required this.studyjio}) : super(key: key);

  // Studyjio get sj { 
  //   if (sj == null) {
  //     studyjio = Studyjio(null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null); // Instantiate the object if its null.
  //   }
  //   return sj;
  // }


  @override
  _AddStudyJioScreenState createState() => _AddStudyJioScreenState();
}

class _AddStudyJioScreenState extends State<AddStudyJioScreen> {
  Studyjio studyjio;
  String username;
  bool _didUserChooseOnline = false;
  final _descriptionFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  DateTime _date = DateTime.now();
  String getLocation = '';
  GeoPoint getLocationOnMap = GeoPoint(null, null);
  TextEditingController _titleController = new TextEditingController();
  TextEditingController _descriptionController = new TextEditingController();
  TextEditingController _dateController = new TextEditingController();
  TextEditingController _startTimeController = new TextEditingController();
  TextEditingController _endTimeController = new TextEditingController();
  TextEditingController _modulesController = new TextEditingController();
  TextEditingController _capacityController = new TextEditingController();
  

  @override
  void dispose() {
    _descriptionFocusNode.dispose();
    super.dispose();
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

  @override
  Widget build(BuildContext context) {
    
    
    
    String _formattedate = new DateFormat.yMMMd().format(_date);
//  TextEditingController _titleController = new TextEditingController();
//  TextEditingController _descriptionController = new TextEditingController();
  // TextEditingController _dateController = new TextEditingController();
  // TextEditingController _startTimeController = new TextEditingController();
  // TextEditingController _endTimeController = new TextEditingController();
  // TextEditingController _modulesController = new TextEditingController();
  // TextEditingController _capacityController = new TextEditingController();
   
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        backgroundColor: Colors.grey[850],
        title: Text('Add Study Jio',),
        centerTitle: true,
      ),
      body: Builder(
        builder: (BuildContext context) {
        return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _form,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                TextFormField(
                  cursorColor: Colors.tealAccent,
                    controller: _titleController,
                    decoration: InputDecoration(
                      labelText: 'Title',
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
                      return 'Please enter a title.';
                    }
                    return null; 
                  },
                  style: TextStyle(color: Colors.grey[100]),
                ),
                TextFormField(
                  cursorColor: Colors.tealAccent,
                  controller: _descriptionController,
                  decoration: InputDecoration(
                    labelText: 'Description',
                    labelStyle: TextStyle(color: Colors.grey[100]),
                    focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.tealAccent,
                              ),
                      ),
                  ),
                  maxLines: 3,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.multiline,
                  focusNode: _descriptionFocusNode,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter a description.';
                    }
                    if (value.length < 20) {
                      return 'Please provide more details.'; // ensure description is elaborate enough
                    }
                      return null;
                  }, 
                  style: TextStyle(color: Colors.grey[100]),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15, bottom: 20),
                  child: TextFormField(
                    style: TextStyle(color: Colors.grey[100]),
                    cursorColor: Colors.tealAccent,
                    controller: _dateController,
                    decoration: InputDecoration(
                      labelText: 'Date',
                      labelStyle: TextStyle(color: Colors.grey[100]),
                      focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.tealAccent,
                              ),
                      ),
                    ),
                    onTap: () async {
                      FocusScope.of(context).requestFocus(new FocusNode());

                      DateTime picked = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2020),
                        lastDate: DateTime(2021));
                      _dateController.text = _formattedate.toString();
                      if(picked != null && picked != _date) {
                        setState(() {
                          _date = picked;
                        });
                      }
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please provide a date.';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15, bottom: 20),
                  child: TextFormField(
                    style: TextStyle(color: Colors.grey[100]),
                    cursorColor: Colors.tealAccent,
                    controller: _startTimeController, 
                    decoration: InputDecoration(
                      labelText: 'Start Time',
                      labelStyle: TextStyle(color: Colors.grey[100]),
                      focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.tealAccent,
                              ),
                      ),
                    ),
                    onTap: () async {
                      TimeOfDay time = TimeOfDay.now();
                      FocusScope.of(context).requestFocus(new FocusNode());
                      TimeOfDay picked =
                        await showTimePicker(context: context, initialTime: time);
                         if (picked != null && picked != time) {
                          _startTimeController.text = picked.format(context);
                          setState(() {
                            time = picked;
                          });
                        }
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please provide a start time.';
                        }
                        return null;
                      },
                  ),
                ),
                Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, bottom: 20),
                child: TextFormField(
                  style: TextStyle(color: Colors.grey[100]),
                  cursorColor: Colors.tealAccent,
                  controller: _endTimeController, 
                  decoration: InputDecoration(
                    labelText: 'End Time',
                    labelStyle: TextStyle(color: Colors.grey[100]),
                    focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.tealAccent,
                              ),
                    ),
                  ),
                  onTap: () async {
                    TimeOfDay time = TimeOfDay.now();
                    FocusScope.of(context).requestFocus(new FocusNode());

                    TimeOfDay picked =
                            await showTimePicker(context: context, initialTime: time);
                        if (picked != null && picked != time) {
                          _endTimeController.text = picked.format(context);
                          setState(() {
                            time = picked;
                          });
                        }
                  },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please provide an end time.';
                        }
                        return null;
                      },
                  ),
                ),
                TextFormField( 
                  style: TextStyle(color: Colors.grey[100]),
                  cursorColor: Colors.tealAccent,
                  controller: _modulesController,
                  decoration: InputDecoration(
                    labelText: 'Module(s)',
                    labelStyle: TextStyle(color: Colors.grey[100]),
                    hintText: 'eg. CS2040S, CS2030,...',
                    hintStyle: TextStyle(color: Colors.grey[100]),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.tealAccent,
                      ),
                    ),
                  ),
                  maxLines: 2,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please key in module code(s).';
                    }
                    return null; 
                  },
                ),
                TextFormField(
                  style: TextStyle(color: Colors.grey[100]),
                  cursorColor: Colors.tealAccent,
                  controller: _capacityController,
                  decoration: InputDecoration(
                    labelText: 'Capacity',
                    labelStyle: TextStyle(color: Colors.grey[100]),
                    hintText: 'Enter your desired quota from 2 to 10.',
                    hintStyle: TextStyle(color: Colors.grey[100]),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.tealAccent,
                      ),
                    ),
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
                ButtonBar(
                  alignment: MainAxisAlignment.center,
                  children: <Widget>[
                    RaisedButton(
                      child: Text(
                        'Online',
                      ),
                      onPressed: () {
                        setState(() {
                         _didUserChooseOnline = true; 
                         getLocation = 'Online';
                        });
                      },
                    ),
                    RaisedButton(
                      child: Text(
                        'Offline',
                      ),
                      onPressed: () {
                        setState(() {
                         _didUserChooseOnline = false; 
                        });
                      },
                    ),
                  ],
                ),
                _didUserChooseOnline
                  ? Container(height: 0,)
                  : ButtonBar(
                    alignment: MainAxisAlignment.center,
                    children: <Widget>[
                      RaisedButton(
                        child: Text('Choose a Location'),
                        onPressed: () {
                          _navigateAndDisplaySelectionforLocation(context);
                        },
                      ),
                      RaisedButton(
                        child: Text('Book a Room'),
                        onPressed: () {
                          _navigateAndDisplaySelectionforRoom(context);
                        },
                      ),
                    ],
                  ),
                 
                  SizedBox(height: 20, width: 50,),
                  RaisedButton(
                    color: Colors.blue[300],
                    child: Text("Confirm"),
                    onPressed: () async {
                      studyjio = Studyjio(null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null);
                      final uid = await Provider.of(context).auth.getCurrentUID(); 
                      final DocumentSnapshot snapshot = await Firestore.instance.collection('users').document(uid).get();
                      String getUsername = snapshot.data['username'];

                      AddStudyJioScreen.showTitleforMap = studyjio.title;
                      AddStudyJioScreen.showLocationOnMap = studyjio.locationOnMap;

                      if (validate()) {

                        await Provider.of(context).auth.getCurrentUser().then((user) {
                          setState(() {
                            username = user.displayName;
                          });
                        }).catchError((e) {
                          print(e);
                        });

                        studyjio.title = _titleController.text;
                        studyjio.description = _descriptionController.text;
                        studyjio.date = _dateController.text;
                        studyjio.startTime = _startTimeController.text;
                        studyjio.endTime = _endTimeController.text;
                        studyjio.modules = _modulesController.text;
                        studyjio.capacity = int.parse(_capacityController.text);
                        studyjio.ownerId = uid;
                        studyjio.joinedUsers = {getUsername: true};
                        studyjio.currentCount = 1;
                        studyjio.location = getLocation;
                        studyjio.locationOnMap = getLocationOnMap;
                        studyjio.username = username;

                        final DocumentReference documentReference = 
                          await Firestore.instance.collection('browse_jios').add({
                            'title': studyjio.title,
                            'description': studyjio.description,
                            'date': studyjio.date,
                            'startTime': studyjio.startTime,
                            'endTime': studyjio.endTime,
                            'modules': studyjio.modules,
                            'documentId': '',
                            'capacity': studyjio.capacity,
                            'ownerId': studyjio.ownerId,
                            'joinedUsers': studyjio.joinedUsers,
                            'currentCount':studyjio.currentCount,
                            'location':studyjio.location,
                            'username': studyjio.username,
                            'locationOnMap': studyjio.locationOnMap, 
                          });

                        final String documentId = documentReference.documentID;
                          studyjio.documentId = documentId;

                        await Firestore.instance.collection('browse_jios')
                          .document(documentId).updateData({
                            'documentId': documentId,
                          });

                        await Firestore.instance.collection('users').document(uid).
                        collection('my_studyjios').document(documentId).setData({
                          'title': studyjio.title,
                          'description':studyjio.description,
                          'date': studyjio.date,
                          'startTime': studyjio.startTime,
                          'endTime': studyjio.endTime,
                          'modules': studyjio.modules,
                          'documentId': documentId,
                          'capacity': studyjio.capacity,
                          'ownerId': studyjio.ownerId,
                          'joinedUsers': studyjio.joinedUsers,
                          'currentCount':studyjio.currentCount,
                          'location': studyjio.location,
                          'username': studyjio.username,
                          'locationOnMap': studyjio.locationOnMap, 
                        });
                        
                        Navigator.of(context).pop();
                        _showAlertDialog();
                      }
                    }
                ), 
              ],
            ),
            ),
          ),
        );
        }
      ),
    );   
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

  void _showAlertDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Padding(
   padding: EdgeInsets.only(left: 50.0, right: 50.0, top: 20, bottom: 20),
   child:
        AlertDialog(
          backgroundColor: Colors.grey[850],
          title: new Text(
            "Important",
            style: TextStyle(color: Colors.blue[300]),
            ),
          content: Text(
            'You are not allowed to delete the study-jio you have created within 30 minutes before your chosen start time.',
            style: TextStyle(color: Colors.grey[100]),
          ),
          actions: <Widget>[
            new FlatButton(
              color: Colors.blue[300],
              child: new Text(
                "Noted",
                style: TextStyle(color: Colors.black),
              ),
              onPressed: () async {               
                  Navigator.of(context).pop();
                  //Navigator.popUntil(context, ModalRoute.withName('/studyjios'));
              },
            ),
          ],
        ),
        );
      },
    );
  }

  /* @override
  void didChangeDependencies() {
    if (_isInit) {
      final studyjioId = ModalRoute.of(context).settings.arguments as String;
      if (studyjioId != null) {
        _editedStudyjio = Provider.of<Studyjio>(context, listen: false).findbyId(studyjioId);
        _initValues = {
          'title': _editedStudyjio.title,
          'description': _editedStudyjio.description,
          'isOffline': _editedStudyjio.isOffline.toString(),
          'modules': _editedStudyjio.modules.toString(),
          'date': _editedStudyjio.date.toString(),
          'startTime': _editedStudyjio.startTime,
          'endTime': _editedStudyjio.endTime,
          'capacity': _editedStudyjio.capacity.toString(),
          'bookRoom': _editedStudyjio.bookRoom.toString(),
        };
      } 
    }
    _isInit = false;
    super.didChangeDependencies();
  } */
}