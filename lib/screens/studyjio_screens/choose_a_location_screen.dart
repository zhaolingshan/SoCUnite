//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:SoCUniteTwo/providers/studyjio.dart';
import 'package:SoCUniteTwo/models/place.dart';

class ChooseALocationScreen extends StatefulWidget {
  //Studyjio studyjio;

  @override
  _ChooseALocationScreenState createState() => _ChooseALocationScreenState();
}

class _ChooseALocationScreenState extends State<ChooseALocationScreen> {
  List<Place> locations = [
    Place(
      id: DateTime.now().toString(), // shld id be same as studyjio's document id?
      title: 'Science Library',
      location: PlaceLocation(latitude: 1.296800, longitude: 103.779190),
    ),
    Place(
      id: DateTime.now().toString(),
      title: 'Education Resource Center',
      location: PlaceLocation(latitude: 1.305840, longitude: 103.772610),
    ),
    Place(
      id: DateTime.now().toString(),
      title: 'Yale-NUS Library',
      location: PlaceLocation(latitude: 1.306800, longitude: 103.772480),
    ),
    Place(
      id: DateTime.now().toString(),
      title: 'Central Library',
      location: PlaceLocation(latitude: 1.296750, longitude: 103.773148),
    ),
    Place(
      id: DateTime.now().toString(), 
      title: 'COM2', 
      location: PlaceLocation(latitude: 1.294260, longitude: 103.774320),
    ),
    Place(
      id: DateTime.now().toString(), 
      title: 'COM1',
      location: PlaceLocation(latitude: 1.294260, longitude: 103.774320)) ,
  ];
  String _chosenLocation = '';
  Place _chosenPlace = Place(id: null, title: 'No chosen location', location: PlaceLocation(latitude: null, longitude: null));

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        backgroundColor: Colors.grey[850],
        title: Text("Choose A Location"),
        centerTitle: true,
      ),
      body: ListView(
        //for loop the list???
        children: <Widget>[
          Card(
            color: Colors.grey[850],
            child: ListTile(
              onTap: () {
                setState(() {
                  _chosenPlace = locations[0];
                  _chosenPlace.title = locations[0].title;
                });
              },
              title: Text(locations[0].title,
                  style: TextStyle(fontSize: 20, color: Colors.grey[100])),
            ),
          ),
          Card(
            color: Colors.grey[850],
            child: ListTile(
              onTap: () {
                setState(() {
                   _chosenPlace.title = locations[1].title;
                   _chosenPlace = locations[1];
                });
              },
              title: Text(locations[1].title,
                  style: TextStyle(fontSize: 20, color: Colors.grey[100])),
            ),
          ),
          Card(
            color: Colors.grey[850],
            child: ListTile(
              onTap: () {
                setState(() {
                   _chosenPlace.title = locations[2].title;
                   _chosenPlace = locations[2];
                });
              },
              title: Text(locations[2].title,
                  style: TextStyle(fontSize: 20, color: Colors.grey[100])),
            ),
          ),
          Card(
            color: Colors.grey[850],
            child: ListTile(
              onTap: () {
                setState(() {
                   _chosenPlace.title = locations[3].title;
                   _chosenPlace = locations[3];
                });
              },
              title: Text(locations[3].title,
                  style: TextStyle(fontSize: 20, color: Colors.grey[100])),
            ),
          ),
          Card(
            color: Colors.grey[850],
            child: ListTile(
              onTap: () {
                setState(() {
                   _chosenPlace.title = locations[4].title;
                   _chosenPlace = locations[4];
                });
              },
              title: Text(locations[4].title,
                  style: TextStyle(fontSize: 20, color: Colors.grey[100])),
            ),
          ),
          Card(
            color: Colors.grey[850],
            child: ListTile(
              onTap: () {
                setState(() {
                   _chosenPlace.title = locations[5].title;
                   _chosenPlace = locations[5];
                });
              },
              title: Text(locations[5].title,
                  style: TextStyle(fontSize: 20, color: Colors.grey[100])),
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Current Chosen Location:',
                style: TextStyle(
                  fontSize: 23, 
                  color: Colors.tealAccent,
                  fontWeight: FontWeight.bold,
                )
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                _chosenPlace.title,
                style: TextStyle(fontSize: 18, color: Colors.tealAccent)
              ),
            ]
          ),
          SizedBox(
            height: 40,
          ),
          RaisedButton(
            onPressed: () {
              _chosenLocation = _chosenPlace.title;
              Navigator.pop(context, _chosenPlace);
            },
              color: Colors.blue[300],
              child: Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
              child: Text("Confirm", style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  ),
                  ),
        ],
      ),
    );
  }
  
  String getChosenLocation(Studyjio studyjio) {
    return _chosenLocation;
  }
}
