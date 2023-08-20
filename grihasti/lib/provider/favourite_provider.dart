import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PropertyFavoriteProvider with ChangeNotifier {
  Map<String, bool> _propertySavedStatus = {};
  SharedPreferences? _prefs; // SharedPreferences instance

  PropertyFavoriteProvider() {
    _loadSavedStatus(); // Load saved status when the provider is created
  }

  // Initialize SharedPreferences
  Future<void> _initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // Load saved property status from SharedPreferences
  Future<void> _loadSavedStatus() async {
    await _initPrefs();
    final keys = _prefs?.getKeys()?.toList() ?? [];
    _propertySavedStatus = Map<String, bool>.from(
      keys.fold({}, (previous, key) {
        previous[key] = _prefs?.getBool(key) ?? false;
        return previous;
      }),
    );
    notifyListeners();
  }

  // Save the property status to SharedPreferences
  Future<void> _saveStatus() async {
    await _initPrefs();
    _propertySavedStatus.forEach((propertyId, isSaved) {
      _prefs?.setBool(propertyId, isSaved);
    });
  }

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
    _saveStatus(); // Save the updated status to SharedPreferences
  }
}
