import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ChipOptions extends ChangeNotifier {
  int _selectedCityIndex = 0;
  int _selectedPurposeIndex = 0;

  List<String> _cityOptions = ['Kathmandu', 'Bhaktapur', 'Lalitpur'];
  List<String> _purposeOptions = ['Sell', 'Rent'];

  int get selectedCityIndex => _selectedCityIndex;
  int get selectedPurposeIndex => _selectedPurposeIndex;

  List<String> get cityOptions => _cityOptions;
  List<String> get purposeOptions => _purposeOptions;

  void setSelectedCityIndex(int index) {
    _selectedCityIndex = index;
    notifyListeners();
  }

  void setSelectedPurposeIndex(int index) {
    _selectedPurposeIndex = index;
    notifyListeners();
  }
}
