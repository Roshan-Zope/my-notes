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
    apiKey: 'AIzaSyAhRuR3eL1JdysC8btaYHn_yI2i1MTik68',
    appId: '1:26126537806:web:83cf065468458e0cc41f1f',
    messagingSenderId: '26126537806',
    projectId: 'mynotes-1298b',
    authDomain: 'mynotes-1298b.firebaseapp.com',
    storageBucket: 'mynotes-1298b.appspot.com',
    measurementId: 'G-KJV2XHM41N',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDFtow2vv80NvsJnZhwQWigw8rOUDpzj4E',
    appId: '1:26126537806:android:10b24fd1e2d269a3c41f1f',
    messagingSenderId: '26126537806',
    projectId: 'mynotes-1298b',
    storageBucket: 'mynotes-1298b.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBmi9PeqcTdvSWrvALiLye5hTPHyYEeJD0',
    appId: '1:26126537806:ios:2b6dbf65b114c112c41f1f',
    messagingSenderId: '26126537806',
    projectId: 'mynotes-1298b',
    storageBucket: 'mynotes-1298b.appspot.com',
    iosBundleId: 'com.example.mynotes',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBmi9PeqcTdvSWrvALiLye5hTPHyYEeJD0',
    appId: '1:26126537806:ios:2b6dbf65b114c112c41f1f',
    messagingSenderId: '26126537806',
    projectId: 'mynotes-1298b',
    storageBucket: 'mynotes-1298b.appspot.com',
    iosBundleId: 'com.example.mynotes',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAhRuR3eL1JdysC8btaYHn_yI2i1MTik68',
    appId: '1:26126537806:web:05640bc6c81eaa39c41f1f',
    messagingSenderId: '26126537806',
    projectId: 'mynotes-1298b',
    authDomain: 'mynotes-1298b.firebaseapp.com',
    storageBucket: 'mynotes-1298b.appspot.com',
    measurementId: 'G-DVLVZ9VNTH',
  );
}
