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
        return macos;
      case TargetPlatform.windows:
        return windows;
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
    apiKey: 'AIzaSyBc529JprxC7zck2QJD6fmPt3OWSrmbLHc',
    appId: '1:91171440695:web:5c43263c1c7bfb808757b2',
    messagingSenderId: '91171440695',
    projectId: 'nava-app-81d4f',
    authDomain: 'nava-app-81d4f.firebaseapp.com',
    storageBucket: 'nava-app-81d4f.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA4YwZMFpXl9mLzXMUqvqmACQcwNLlV7dA',
    appId: '1:91171440695:android:1e7c4094b64fa3fc8757b2',
    messagingSenderId: '91171440695',
    projectId: 'nava-app-81d4f',
    storageBucket: 'nava-app-81d4f.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAzmJ_QOim9nNcPTdMYrmywT_ebKj0RqdQ',
    appId: '1:91171440695:ios:c2c60c1ac43703f48757b2',
    messagingSenderId: '91171440695',
    projectId: 'nava-app-81d4f',
    storageBucket: 'nava-app-81d4f.firebasestorage.app',
    iosBundleId: 'com.aa.nava',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAzmJ_QOim9nNcPTdMYrmywT_ebKj0RqdQ',
    appId: '1:91171440695:ios:c2c60c1ac43703f48757b2',
    messagingSenderId: '91171440695',
    projectId: 'nava-app-81d4f',
    storageBucket: 'nava-app-81d4f.firebasestorage.app',
    iosBundleId: 'com.aa.nava',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBc529JprxC7zck2QJD6fmPt3OWSrmbLHc',
    appId: '1:91171440695:web:be1a3ed04c91cdbd8757b2',
    messagingSenderId: '91171440695',
    projectId: 'nava-app-81d4f',
    authDomain: 'nava-app-81d4f.firebaseapp.com',
    storageBucket: 'nava-app-81d4f.firebasestorage.app',
  );
}
