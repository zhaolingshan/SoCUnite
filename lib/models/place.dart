import 'package:flutter/foundation.dart';

class PlaceLocation {
  double latitude;
  double longitude;
  String address;

  PlaceLocation({
    this.latitude,
    this.longitude,
    this.address,
  });
}

class Place {
  String id;
  String title;
  PlaceLocation location;

  Place({
    @required this.id,
    @required this.title,
    @required this.location,
  });
}