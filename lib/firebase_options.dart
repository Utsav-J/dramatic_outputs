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
//  await Firebase.initializeApp(
//    options: DefaultFirebaseOptions.currentPlatform,
//  );
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
    apiKey: 'AIzaSyBbbUxnYB2nSRBEPU7u8SxuKQYqGAkAYP0',
    appId: '1:1061320534593:web:dede32ceb554611e2a34c0',
    messagingSenderId: '1061320534593',
    projectId: 'dramatic-outputs',
    authDomain: 'dramatic-outputs.firebaseapp.com',
    storageBucket: 'dramatic-outputs.firebasestorage.app',
    measurementId: 'G-RGNF8NKJ89',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDOf85yn6YWE_Zb5ikaEDcpA7aC-H0zi5Q',
    appId: '1:1061320534593:android:cd9036a500c835a42a34c0',
    messagingSenderId: '1061320534593',
    projectId: 'dramatic-outputs',
    storageBucket: 'dramatic-outputs.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD7sY6MhXATVxqBBw8pXnhw5UoIv9LhIII',
    appId: '1:1061320534593:ios:cab1f460f81fb5b62a34c0',
    messagingSenderId: '1061320534593',
    projectId: 'dramatic-outputs',
    storageBucket: 'dramatic-outputs.firebasestorage.app',
    iosBundleId: 'com.example.dramaticOutputs',
  );
}
