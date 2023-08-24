import 'package:flutter/foundation.dart';

class BookingProvider with ChangeNotifier {
  List<String> bookedPropertyIds = [];

  void addBooking(String propertyId) {
    bookedPropertyIds.add(propertyId);
    notifyListeners();
  }

  bool isPropertyBooked(String propertyId) {
    return bookedPropertyIds.contains(propertyId);
  }
}
