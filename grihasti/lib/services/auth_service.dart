import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:grihasti/provider/user_provider.dart';
import 'package:grihasti/utils/showSnackBar.dart';
import 'package:provider/provider.dart';

class FirebaseAuthMethods {
  FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  FirebaseAuthMethods(this._auth);

  User get user => _auth.currentUser!;

  //EMAIL SIGN UP
  Future<void> signUpWithEmail({
    required String name,
    required String email,
    required String phoneNumber,
    required String password,
    required BuildContext context,
  }) async {
    // Once user is logged in and you have the user ID

    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      await sendEmailVerification(context);
      Navigator.pushNamed(context, '/signup');

      // Check if email already exists
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: email)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        throw FirebaseAuthException(
          code: 'email-already-exists',
          message: 'Phone or email already exists. Please use a different .',
        );
      }

      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'fullname': name.toString(),
        'phonenumber': phoneNumber.toString(),
        'email': email.toString(),
      });

      // Save user data to Firestore

      // await _firestore.collection('users').doc(userCredential.user!.uid).set({
      //   'email': email,
      //   // Add additional fields as needed
      // });

      // if (phoneSnapshot.docs.isNotEmpty) {
      //   throw FirebaseAuthException(
      //     code: 'phone-number-already-exists',
      //     message:
      //         'Phone number already exists. Please use a different phone number.',
      //   );
      // }
    } on FirebaseAuthException catch (e) {
      // if you want to display your own custom error message
      if (e.code == 'weak-password') {
        mySnackBar(context, 'The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        mySnackBar(context, 'The account already exists for that email.');
      }
      mySnackBar(context, e.message!);

      // Displaying the usual firebase error message
    }
  }

  // EMAIL VERIFICATION
  Future<void> sendEmailVerification(BuildContext context) async {
    try {
      _auth.currentUser!.sendEmailVerification();
      mySnackBar(context, 'Email verification sent!');
    } on FirebaseAuthException catch (e) {
      mySnackBar(context, e.message!.toString()); // Display error message
    }
  }

  // EMAIL LOGIN
  Future<void> loginWithEmail({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    if (_auth.currentUser != null) {
      String userId = _auth.currentUser!.uid;
      // Use the userId variable here.
      UserProvider userProvider =
          Provider.of<UserProvider>(context, listen: false);
      userProvider.setUserId(userId);
      print('The user id from auth service is :${userId}');
    } else {
      print('Login Error');
    }
    // Store the user ID in the provider

    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (!user.emailVerified) {
        await sendEmailVerification(context);
        mySnackBar(context, 'Verify email first');
      } else {
        Navigator.pushNamed(context, '/home');
      }
    } on FirebaseAuthException catch (e) {
      mySnackBar(context, e.message!); // Displaying the error message
    }
  }

  //FOR GOOGLE SIGN IN
  // Future<void> signInWithGoogle(BuildContext context) async {
  //   try {
  //     if (kIsWeb) {
  //       GoogleAuthProvider googleProvider = GoogleAuthProvider();

  //       googleProvider
  //           .addScope('https://www.googleapis.com/auth/contacts.readonly');

  //       await _auth.signInWithPopup(googleProvider);
  //     } else {
  //       final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  //       final GoogleSignInAuthentication? googleAuth =
  //           await googleUser?.authentication;

  //       if (googleAuth?.accessToken != null && googleAuth?.idToken != null) {
  //         // Create a new credential
  //         final credential = GoogleAuthProvider.credential(
  //           accessToken: googleAuth?.accessToken,
  //           idToken: googleAuth?.idToken,
  //         );
  //         UserCredential userCredential =
  //             await _auth.signInWithCredential(credential);

  //         // if you want to do specific task like storing information in firestore
  //         // only for new users using google sign in (since there are no two options
  //         // for google sign in and google sign up, only one as of now),
  //         // do the following:

  //         // if (userCredential.user != null) {
  //         //   if (userCredential.additionalUserInfo!.isNewUser) {}
  //         // }
  //       }
  //     }
  //   } on FirebaseAuthException catch (e) {
  //     showSnackBar(context, e.message!); // Displaying the error message
  //   }
  // }
}
