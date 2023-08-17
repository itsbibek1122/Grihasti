import 'package:flutter/material.dart';

class DropdownProvider extends ChangeNotifier {
  String _selectedBedrooms = '0';
  String _selectedBathrooms = '0';
  String _selectedKitchen = '0';
  String _selectedCarParking = '0';
  String _selectedBikeParking = '0';

  String get selectedBedrooms => _selectedBedrooms;
  String get selectedBathrooms => _selectedBathrooms;
  String get selectedKitchen => _selectedKitchen;
  String get selectedCarParking => _selectedCarParking;
  String get selectedBikeParking => _selectedBikeParking;

  void setSelectedBedrooms(String? newValue) {
    _selectedBedrooms = newValue ?? '1'; // Set a default value if null
    notifyListeners();
  }

  void setSelectedBathrooms(String? newValue) {
    _selectedBathrooms = newValue ?? '1';
    notifyListeners();
  }

  void setSelectedKitchen(String? newValue) {
    _selectedKitchen = newValue ?? '1';
    notifyListeners();
  }

  void setSelectedCarParking(String? newValue) {
    _selectedCarParking = newValue ?? '1';
    notifyListeners();
  }

  void setSelectedBikeParking(String? newValue) {
    _selectedBikeParking = newValue ?? '1';
    notifyListeners();
  }
  //To clear

  void clearSelectedBedrooms() {
    _selectedBedrooms = '0'; // Set a default value
    notifyListeners();
  }

  void clearSelectedBathrooms() {
    _selectedBathrooms = '0';
    notifyListeners();
  }

  void clearSelectedKitchen() {
    _selectedKitchen = '0';
    notifyListeners();
  }

  void clearSelectedCarParking() {
    _selectedCarParking = '0';
    notifyListeners();
  }

  void clearSelectedBikeParking() {
    _selectedBikeParking = '0';
    notifyListeners();
  }
}
