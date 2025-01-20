// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyCC81uvMM5fGs2niVq077R8l9E7dlaSvSU',
    appId: '1:1698335350:web:39721f7276effbf98aed57',
    messagingSenderId: '1698335350',
    projectId: 'transport-app-d662f',
    authDomain: 'transport-app-d662f.firebaseapp.com',
    databaseURL: 'https://transport-app-d662f-default-rtdb.firebaseio.com',
    storageBucket: 'transport-app-d662f.appspot.com',
    measurementId: 'G-YPE4HP3KTZ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBpZjRD-F7GCWVY3D5I6OVvap5VVHgO4VM',
    appId: '1:1698335350:android:8d2c58625fd69ca08aed57',
    messagingSenderId: '1698335350',
    projectId: 'transport-app-d662f',
    databaseURL: 'https://transport-app-d662f-default-rtdb.firebaseio.com',
    storageBucket: 'transport-app-d662f.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDD7a4sYFGVEEc8cZkgahjm6XhvKO7d5OM',
    appId: '1:1698335350:ios:76209b1f710d416c8aed57',
    messagingSenderId: '1698335350',
    projectId: 'transport-app-d662f',
    databaseURL: 'https://transport-app-d662f-default-rtdb.firebaseio.com',
    storageBucket: 'transport-app-d662f.appspot.com',
    iosBundleId: 'com.app.hadawiApp',
  );
}
