import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:permission_handler/permission_handler.dart';

class CurrentLocationProvider with ChangeNotifier {
  LatLng? _userLocation;

  LatLng? get userLocation => _userLocation;

  Future<void> updateUserLocation() async {
    try {
      if (await Permission.location.serviceStatus.isEnabled) {
        var status = await Permission.location.status;
        if (status.isGranted) {
          Position position = await Geolocator.getCurrentPosition(
              desiredAccuracy: LocationAccuracy.high);
          _userLocation = LatLng(position.latitude, position.longitude);
          notifyListeners();
        } else if (status.isDenied) {
          await Permission.location.request();
        }
      } else {
        print('Location services are not enabled');
      }
    } catch (error) {
      print('Error getting user location: $error');
    }
  }
}
