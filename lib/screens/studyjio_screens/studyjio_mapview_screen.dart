import 'package:flutter/material.dart';
// import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:SoCUniteTwo/models/place.dart';

class StudyjiosMapviewScreen extends StatefulWidget {
  final PlaceLocation initialLocation;
  final bool isSelecting;

  StudyjiosMapviewScreen({
    this.initialLocation = const PlaceLocation(latitude: 37.422, longitude: -122.084),
    this.isSelecting = false
  });

  @override
  _StudyjiosMapviewScreenState createState() => _StudyjiosMapviewScreenState();
}

class _StudyjiosMapviewScreenState extends State<StudyjiosMapviewScreen> {

 @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(
            widget.initialLocation.latitude, 
            widget.initialLocation.longitude
          ),
          zoom: 16,
        ),
      ),
    );
  } 
}