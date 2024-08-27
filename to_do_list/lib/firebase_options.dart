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
    apiKey: 'AIzaSyD-Dst9AILVByy-F3WPZve3NsVHF0zBCpw',
    appId: '1:436600709792:web:eb793c7855bc2d33575fc5',
    messagingSenderId: '436600709792',
    projectId: 'todoapp-3b930',
    authDomain: 'todoapp-3b930.firebaseapp.com',
    storageBucket: 'todoapp-3b930.appspot.com',
    measurementId: 'G-J63VLMQZ56',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAjBWuMiFC25nlEWHGppzQtQhBB9NF6XNw',
    appId: '1:436600709792:android:c26aba7df47e3eef575fc5',
    messagingSenderId: '436600709792',
    projectId: 'todoapp-3b930',
    storageBucket: 'todoapp-3b930.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCBrpMCvObKEkD3Jb5eJkp7Hr02QmxMj7w',
    appId: '1:436600709792:ios:de7d75977c865e75575fc5',
    messagingSenderId: '436600709792',
    projectId: 'todoapp-3b930',
    storageBucket: 'todoapp-3b930.appspot.com',
    iosBundleId: 'com.example.toDoList',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCBrpMCvObKEkD3Jb5eJkp7Hr02QmxMj7w',
    appId: '1:436600709792:ios:de7d75977c865e75575fc5',
    messagingSenderId: '436600709792',
    projectId: 'todoapp-3b930',
    storageBucket: 'todoapp-3b930.appspot.com',
    iosBundleId: 'com.example.toDoList',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyD-Dst9AILVByy-F3WPZve3NsVHF0zBCpw',
    appId: '1:436600709792:web:e4ee772bcfd503a2575fc5',
    messagingSenderId: '436600709792',
    projectId: 'todoapp-3b930',
    authDomain: 'todoapp-3b930.firebaseapp.com',
    storageBucket: 'todoapp-3b930.appspot.com',
    measurementId: 'G-HQTB7XP407',
  );
}
