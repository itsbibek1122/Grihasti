import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class SignUpAuthProvider with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  User? _user;

  User? get user => _user;

  Future<void> signUpWithEmailAndPassword(
      String name, String email, String phone, String password) async {
    try {
      final UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      _user = result.user;

      // Save additional user data to Firestore
      await _firestore.collection('users').doc(_user!.uid).set({
        'name': name,
        'email': email,
        'phone': phone,
      });

      notifyListeners();
    } catch (error) {
      // Handle the authentication error
    }
  }

  // Rest of the code remains the same as the previous example
}
