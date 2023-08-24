import 'package:flutter/foundation.dart';

class PropertyFavoriteProvider with ChangeNotifier {
  Map<String, bool> _propertySavedStatus = {};

  // Get the saved status for a specific property by its ID.
  bool getPropertySavedStatus(String propertyId) {
    return _propertySavedStatus[propertyId] ?? false;
  }

  // Toggle the saved status for a specific property by its ID.
  void togglePropertySaved(String propertyId) {
    if (_propertySavedStatus.containsKey(propertyId)) {
      _propertySavedStatus[propertyId] = !_propertySavedStatus[propertyId]!;
    } else {
      _propertySavedStatus[propertyId] = true;
    }
    notifyListeners();
  }
}
