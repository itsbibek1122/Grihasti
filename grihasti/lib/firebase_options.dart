// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDTwOyivLTKCtZxYIdzvOJGaG-BLqrYVqM',
    appId: '1:10767265273:web:c638a8936a15d3fc656128',
    messagingSenderId: '10767265273',
    projectId: 'grihasti-19f5f',
    authDomain: 'grihasti-19f5f.firebaseapp.com',
    storageBucket: 'grihasti-19f5f.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBJEwzimNpRl_AhlcCv7v8aO7ePvNxYLDs',
    appId: '1:10767265273:android:9562004bfd3dfa26656128',
    messagingSenderId: '10767265273',
    projectId: 'grihasti-19f5f',
    storageBucket: 'grihasti-19f5f.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDzsEnokXenYNa1Icz3_cPYozx9NyFElT0',
    appId: '1:10767265273:ios:682c8a3ec0f2b285656128',
    messagingSenderId: '10767265273',
    projectId: 'grihasti-19f5f',
    storageBucket: 'grihasti-19f5f.appspot.com',
    iosClientId: '10767265273-gbs04o646mjf64q20gultq5k8u01ekpd.apps.googleusercontent.com',
    iosBundleId: 'com.example.grihasti',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDzsEnokXenYNa1Icz3_cPYozx9NyFElT0',
    appId: '1:10767265273:ios:682c8a3ec0f2b285656128',
    messagingSenderId: '10767265273',
    projectId: 'grihasti-19f5f',
    storageBucket: 'grihasti-19f5f.appspot.com',
    iosClientId: '10767265273-gbs04o646mjf64q20gultq5k8u01ekpd.apps.googleusercontent.com',
    iosBundleId: 'com.example.grihasti',
  );
}
