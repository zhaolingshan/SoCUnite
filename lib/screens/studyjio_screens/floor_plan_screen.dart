import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class FloorPlanScreen extends StatefulWidget {
  @override
  _FloorPlanScreenState createState() => _FloorPlanScreenState();
}

class _FloorPlanScreenState extends State<FloorPlanScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: Text('Floor Plan'),
        centerTitle: true,
        backgroundColor: Colors.grey[850],
        ),
      body: Container(
        child: PhotoView(
          imageProvider: 
            NetworkImage(
              'https://www.comp.nus.edu.sg/images/resources/content/mapsvenues/COM1_L3.jpg',
          ) 
        ),
      ),
    );
  }
}