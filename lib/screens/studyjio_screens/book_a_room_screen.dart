import 'package:flutter/material.dart';
import 'package:SoCUniteTwo/models/place.dart';
import 'package:SoCUniteTwo/screens/studyjio_screens/floor_plan_screen.dart';

class BookARoomScreen extends StatefulWidget {
  @override
  _BookARoomScreenState createState() => _BookARoomScreenState();
}

class _BookARoomScreenState extends State<BookARoomScreen> {
  List<Place> roomNames = [
    Place(
      id: DateTime.now().toString(),
      title: 'Tutorial Room 1 (TR1)',
      location: PlaceLocation(latitude: 1.2948066448369964, longitude:103.77154469490053),
    ),
    Place(
      id: DateTime.now().toString(),
      title: 'Tutorial Room 3 (TR3)',
      location: PlaceLocation(latitude: 1.295353329958129, longitude: 103.77331128855921),
    ),
    Place(
      id: DateTime.now().toString(),
      title: 'Seminar Room 1 (SR1)',
      location: PlaceLocation(latitude: 1.2950279706567276, longitude: 103.77393175616923),
    ),
    Place(
      id: DateTime.now().toString(),
      title: 'Seminar Room 3 (SR3)',
      location: PlaceLocation(latitude: 1.2947910941174683, longitude: 103.77400841456318),
    ),
    Place(
      id: DateTime.now().toString(),
      title: 'Seminar Room 5 (SR5)',
      location: PlaceLocation(latitude: 1.295399299579972, longitude: 103.77364859508984),
    ),
    Place(
      id: DateTime.now().toString(),
      title: 'Seminar Room 7 (SR7)',
      location: PlaceLocation(latitude: 1.2949426312679213, longitude: 103.7740489892307),
    ),
  ];
  List<String> unitNumbers = [
    'AS3 06-10',
    'AS6 02-08',
    'COM1 02-06',
    'COM1 02-07',
    'COM1 B-14B',
    'COM1 B-14A',
  ];
  String _chosenRoom = '';
  Place _chosenPlace = Place(id: null, title: 'No chosen room', location: PlaceLocation(latitude: null, longitude: null));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        backgroundColor: Colors.grey[850],
        title: Text("Choose A Room"),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.place, color: Colors.tealAccent),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FloorPlanScreen())
              );
            },
          )
        ],
      ),
      body: ListView(
        children: <Widget>[
          Card(
            color: Colors.grey[850],
            child: ListTile(
              onTap: () {
                setState(() {
                  _chosenPlace.title = roomNames[0].title;
                  _chosenPlace = roomNames[0];
                });
              },
              title: Text(roomNames[0].title,
                  style: TextStyle(fontSize: 20, color: Colors.grey[100])),
              subtitle: Text(unitNumbers[0],
                  style: TextStyle(fontSize: 18, color: Colors.grey[100])),
            ),
          ),
          Card(
            color: Colors.grey[850],
            child: ListTile(
              onTap: () {
                setState(() {
                  _chosenPlace = roomNames[1];
                  _chosenPlace.title = roomNames[1].title;
                });
              },
              title: Text(roomNames[1].title,
                  style: TextStyle(fontSize: 20, color: Colors.grey[100])),
              subtitle: Text(unitNumbers[1],
                  style: TextStyle(fontSize: 18, color: Colors.grey[100])),
            ),
          ),
          Card(
            color: Colors.grey[850],
            child: ListTile(
              onTap: () {
                setState(() {
                  _chosenPlace = roomNames[2];
                  _chosenPlace.title = roomNames[2].title;
                });
              },
              title: Text(roomNames[2].title,
                  style: TextStyle(fontSize: 20, color: Colors.grey[100])),
              subtitle: Text(unitNumbers[2],
                  style: TextStyle(fontSize: 18, color: Colors.grey[100])),
            ),
          ),
          Card(
            color: Colors.grey[850],
            child: ListTile(
              onTap: () {
                setState(() {
                  _chosenPlace = roomNames[3];
                  _chosenPlace.title = roomNames[3].title;
                });
              },
              title: Text(roomNames[3].title,
                  style: TextStyle(fontSize: 20, color: Colors.grey[100])),
              subtitle: Text(unitNumbers[3],
                  style: TextStyle(fontSize: 18, color: Colors.grey[100])),
            ),
          ),
          Card(
            color: Colors.grey[850],
            child: ListTile(
              onTap: () {
                setState(() {
                  _chosenPlace = roomNames[4];
                  _chosenPlace.title = roomNames[4].title;
                });
              },
              title: Text(roomNames[4].title,
                  style: TextStyle(fontSize: 20, color: Colors.grey[100])),
              subtitle: Text(unitNumbers[4],
                  style: TextStyle(fontSize: 18, color: Colors.grey[100])),
            ),
          ),
          Card(
            color: Colors.grey[850],
            child: ListTile(
              onTap: () {
                setState(() {
                  _chosenPlace = roomNames[5];
                  _chosenPlace.title = roomNames[5].title;
                });
              },
              title: Text(roomNames[5].title,
                  style: TextStyle(fontSize: 20, color: Colors.grey[100])),
              subtitle: Text(unitNumbers[5],
                  style: TextStyle(fontSize: 18, color: Colors.grey[200])),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Current Chosen Room:',
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
                style: TextStyle(fontSize: 17, color: Colors.tealAccent)
              ),
            ]
          ),
          SizedBox(
            height: 18,
          ),
          RaisedButton(
              onPressed: () {
                _chosenRoom = _chosenPlace.title;
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
}