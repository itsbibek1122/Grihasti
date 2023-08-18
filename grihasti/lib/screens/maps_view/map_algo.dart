import 'package:latlong2/latlong.dart';
import 'dart:math' as math;

double calculateDistance(LatLng point1, LatLng point2) {
  const int earthRadius = 6371000; // in meters

  final double lat1 = point1.latitude;
  final double lon1 = point1.longitude;
  final double lat2 = point2.latitude;
  final double lon2 = point2.longitude;

  final double dLat = (lat2 - lat1) * (3.141592653589793 / 180);
  final double dLon = (lon2 - lon1) * (3.141592653589793 / 180);

  final double a = math.sin(dLat / 2) * math.sin(dLat / 2) +
      math.cos(lat1 * (3.141592653589793 / 180)) *
          math.cos(lat2 * (3.141592653589793 / 180)) *
          math.sin(dLon / 2) *
          math.sin(dLon / 2);

  final double c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a));

  final double distance = earthRadius * c;
  return distance;
}
