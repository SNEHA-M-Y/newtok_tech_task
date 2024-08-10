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
    apiKey: 'AIzaSyD5t4p1P4Uouroe2tkq8jBq-SF2-AYIldo',
    appId: '1:490425675356:web:7ed611dd9676d859318099',
    messagingSenderId: '490425675356',
    projectId: 'newtok-tech-task',
    authDomain: 'newtok-tech-task.firebaseapp.com',
    storageBucket: 'newtok-tech-task.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDFEff3ARdH_LW0r2I8xid5oWrjtn42Alo',
    appId: '1:490425675356:android:9a5cca122201e478318099',
    messagingSenderId: '490425675356',
    projectId: 'newtok-tech-task',
    storageBucket: 'newtok-tech-task.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAJYoyHSVfLor6mSF-bY6BKr0tNgg-zpVw',
    appId: '1:490425675356:ios:8cd4e0ab6d806376318099',
    messagingSenderId: '490425675356',
    projectId: 'newtok-tech-task',
    storageBucket: 'newtok-tech-task.appspot.com',
    iosBundleId: 'com.example.newtokTechTask',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAJYoyHSVfLor6mSF-bY6BKr0tNgg-zpVw',
    appId: '1:490425675356:ios:8cd4e0ab6d806376318099',
    messagingSenderId: '490425675356',
    projectId: 'newtok-tech-task',
    storageBucket: 'newtok-tech-task.appspot.com',
    iosBundleId: 'com.example.newtokTechTask',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyD5t4p1P4Uouroe2tkq8jBq-SF2-AYIldo',
    appId: '1:490425675356:web:ea637d05e7939f6f318099',
    messagingSenderId: '490425675356',
    projectId: 'newtok-tech-task',
    authDomain: 'newtok-tech-task.firebaseapp.com',
    storageBucket: 'newtok-tech-task.appspot.com',
  );
}
