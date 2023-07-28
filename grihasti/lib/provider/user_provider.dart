import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:grihasti/services/auth_service.dart';

class UserProvider with ChangeNotifier {
  String _userId = '';
  String get userId => _userId;

  void setUserId(String userId) {
    _userId = userId;
    notifyListeners();
  }
}
