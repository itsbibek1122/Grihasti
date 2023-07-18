import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

class LocationProvider with ChangeNotifier {
  LatLng? _selectedLocation;

  LatLng? get selectedLocation => _selectedLocation;

  void handleMapTap(LatLng latLng) {
    _selectedLocation = latLng;

    notifyListeners();
  }
}
