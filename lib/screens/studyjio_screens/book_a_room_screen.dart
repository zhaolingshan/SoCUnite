import 'package:SoCUniteTwo/screens/studyjio_screens/floor_plan_screen.dart';
import 'package:flutter/material.dart';

class BookARoomScreen extends StatefulWidget {
  @override
  _BookARoomScreenState createState() => _BookARoomScreenState();
}

class _BookARoomScreenState extends State<BookARoomScreen> {
  List<String> roomNames = [
    'Tutorial Room 1 (TR1)',
    'Tutorial Room 3 (TR3)',
    'Seminar Room 1 (SR1)',
    'Seminar Room 7 (SR7)',
    'Discussion Room 1 (DR1)',
    'Discussion Room 2 (DR2)',
  ];
  List<String> unitNumbers = [
    'AS3 06-10',
    'AS6 02-08',
    'COM1 02-06',
    'COM1 02-07',
    'COM1 B-14B',
    'COM1 B-14A',
  ];
  String _chosenRoom = 'No chosen room';
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
                  _chosenRoom = roomNames[0];
                });
              },
              title: Text(roomNames[0],
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
                  _chosenRoom = roomNames[1];
                });
              },
              title: Text(roomNames[1],
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
                  _chosenRoom = roomNames[2];
                });
              },
              title: Text(roomNames[2],
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
                  _chosenRoom = roomNames[3];
                });
              },
              title: Text(roomNames[3],
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
                  _chosenRoom = roomNames[4];
                });
              },
              title: Text(roomNames[4],
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
                  _chosenRoom = roomNames[5];
                });
              },
              title: Text(roomNames[5],
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
                _chosenRoom,
                style: TextStyle(fontSize: 17, color: Colors.tealAccent)
              ),
            ]
          ),
          SizedBox(
            height: 18,
          ),
          RaisedButton(
              onPressed: () {
                Navigator.pop(context, _chosenRoom);
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