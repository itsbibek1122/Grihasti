import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  User? _user;
  Map<String, dynamic>? _userData;

  User? getCurrentUser() {
    return _auth.currentUser;
  }

  Future<Map<String, dynamic>?> fetchUserData() async {
    _user = _auth.currentUser;
    if (_user != null) {
      String uid = _user!.uid;
      try {
        DocumentSnapshot snapshot =
            await _firestore.collection('users').doc(uid).get();
        if (snapshot.exists) {
          _userData = snapshot.data() as Map<String, dynamic>;
          return _userData;
        } else {
          return null; // Return null if user data doesn't exist
        }
      } catch (error) {
        throw (error.toString());
      }
    }
    return null; // Return null if _user is null
  }

  Map<String, dynamic>? getUserData() {
    return _userData;
  }
}
