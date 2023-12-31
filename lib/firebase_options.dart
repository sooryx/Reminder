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
    apiKey: 'AIzaSyDnU9VrVfXXWfzzEozencL_DiS4pd7p4eU',
    appId: '1:589757872659:web:b31981b61b60ddbdee1de6',
    messagingSenderId: '589757872659',
    projectId: 'reminder-de82b',
    authDomain: 'reminder-de82b.firebaseapp.com',
    databaseURL: 'https://reminder-de82b-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'reminder-de82b.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCcmTy4JdJBEeAuCuRrekOKOJG0oGAqGJQ',
    appId: '1:589757872659:android:f858a551d6b29738ee1de6',
    messagingSenderId: '589757872659',
    projectId: 'reminder-de82b',
    databaseURL: 'https://reminder-de82b-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'reminder-de82b.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyABLDXOVT-6OA-pYJfe5lzqPRw9cu2gaiI',
    appId: '1:589757872659:ios:271c0ba079ee9e75ee1de6',
    messagingSenderId: '589757872659',
    projectId: 'reminder-de82b',
    databaseURL: 'https://reminder-de82b-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'reminder-de82b.appspot.com',
    iosBundleId: 'com.example.sooryx.reminder',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyABLDXOVT-6OA-pYJfe5lzqPRw9cu2gaiI',
    appId: '1:589757872659:ios:559279104bd744ecee1de6',
    messagingSenderId: '589757872659',
    projectId: 'reminder-de82b',
    databaseURL: 'https://reminder-de82b-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'reminder-de82b.appspot.com',
    iosBundleId: 'com.example.sooryx.reminder.RunnerTests',
  );
}
