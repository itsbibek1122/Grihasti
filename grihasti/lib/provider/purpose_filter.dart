import 'package:flutter/foundation.dart';

class PurposeFilterProvider with ChangeNotifier {
  String _selectedPurpose = '';

  String get selectedPurpose => _selectedPurpose;

  void updateSelectedPurpose(String purpose) {
    _selectedPurpose = purpose;
    notifyListeners();
  }
}
