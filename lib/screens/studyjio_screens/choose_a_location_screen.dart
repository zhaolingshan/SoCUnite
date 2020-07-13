import 'package:SoCUniteTwo/providers/studyjio.dart';
import 'package:SoCUniteTwo/screens/studyjio_screens/add_studyjio_screen.dart';
import 'package:flutter/material.dart';

class ChooseALocationScreen extends StatefulWidget {
  Studyjio studyjio;

  @override
  _ChooseALocationScreenState createState() => _ChooseALocationScreenState();
}

class _ChooseALocationScreenState extends State<ChooseALocationScreen> {
  List<String> locations = [
    'Science Library',
    'Education Resource Center',
    'Yale-NUS Library',
    'Central Library',
    'COM2',
    'COM1',
  ];
  String _chosenLocation = 'No chosen location';

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
                  _chosenLocation = locations[0];
                });
              },
              title: Text(locations[0],
                  style: TextStyle(fontSize: 20, color: Colors.grey[100])),
            ),
          ),
          Card(
            color: Colors.grey[850],
            child: ListTile(
              onTap: () {
                setState(() {
                  _chosenLocation = locations[1];
                });
              },
              title: Text(locations[1],
                  style: TextStyle(fontSize: 20, color: Colors.grey[100])),
            ),
          ),
          Card(
            color: Colors.grey[850],
            child: ListTile(
              onTap: () {
                setState(() {
                  _chosenLocation = locations[2];
                });
              },
              title: Text(locations[2],
                  style: TextStyle(fontSize: 20, color: Colors.grey[100])),
            ),
          ),
          Card(
            color: Colors.grey[850],
            child: ListTile(
              onTap: () {
                setState(() {
                  _chosenLocation = locations[3];
                });
              },
              title: Text(locations[3],
                  style: TextStyle(fontSize: 20, color: Colors.grey[100])),
            ),
          ),
          Card(
            color: Colors.grey[850],
            child: ListTile(
              onTap: () {
                setState(() {
                  _chosenLocation = locations[4];
                });
              },
              title: Text(locations[4],
                  style: TextStyle(fontSize: 20, color: Colors.grey[100])),
            ),
          ),
          Card(
            color: Colors.grey[850],
            child: ListTile(
              onTap: () {
                setState(() {
                  _chosenLocation = locations[5];
                });
              },
              title: Text(locations[5],
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
                _chosenLocation,
                style: TextStyle(fontSize: 18, color: Colors.tealAccent)
              ),
            ]
          ),
          SizedBox(
            height: 40,
          ),
          RaisedButton(
            onPressed: () {
              Navigator.pop(context, _chosenLocation);
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
