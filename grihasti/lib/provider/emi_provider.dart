import 'dart:math';
import 'package:flutter/foundation.dart';

class EMICalculator with ChangeNotifier {
  double _principal = 0.0;
  double _interestRate = 0.0;
  double _tenure = 0.0;
  double _emi = 0.0;

  double get emi => _emi;

  setPrincipal(double principal) {
    _principal = principal;
    calculateEMI();
  }

  setInterestRate(double interestRate) {
    _interestRate = interestRate / 12 / 100;
    calculateEMI();
  }

  setTenure(double tenure) {
    _tenure = tenure;
    calculateEMI();
  }

  void calculateEMI() {
    if (_principal > 0 && _interestRate > 0 && _tenure > 0) {
      _emi = (_principal * _interestRate * (pow(1 + _interestRate, _tenure))) /
          (pow(1 + _interestRate, _tenure) - 1);
    } else {
      _emi = 0.0;
    }
    notifyListeners();
  }
}
