// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'firebase_options.dart';
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
    apiKey: 'AIzaSyDhXktRuu7-pi_0Y6rNbk3gwyxh42A_ojs',
    appId: '1:313898648012:web:c94fe58ae75171a4715d69',
    messagingSenderId: '313898648012',
    projectId: 'casadomotica-9bd92',
    authDomain: 'casadomotica-9bd92.firebaseapp.com',
    storageBucket: 'casadomotica-9bd92.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDi8AzpuIAevSrqPweaRIgxyIPkudD022w',
    appId: '1:313898648012:android:112ece508fd94cac715d69',
    messagingSenderId: '313898648012',
    projectId: 'casadomotica-9bd92',
    storageBucket: 'casadomotica-9bd92.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAsFD64xLpoMIJsDDGjKRRAWBcfz9gYCx0',
    appId: '1:313898648012:ios:44108d005307fc0e715d69',
    messagingSenderId: '313898648012',
    projectId: 'casadomotica-9bd92',
    storageBucket: 'casadomotica-9bd92.firebasestorage.app',
    iosBundleId: 'com.example.casadomotica',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAsFD64xLpoMIJsDDGjKRRAWBcfz9gYCx0',
    appId: '1:313898648012:ios:44108d005307fc0e715d69',
    messagingSenderId: '313898648012',
    projectId: 'casadomotica-9bd92',
    storageBucket: 'casadomotica-9bd92.firebasestorage.app',
    iosBundleId: 'com.example.casadomotica',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDhXktRuu7-pi_0Y6rNbk3gwyxh42A_ojs',
    appId: '1:313898648012:web:53153ad781ec25f0715d69',
    messagingSenderId: '313898648012',
    projectId: 'casadomotica-9bd92',
    authDomain: 'casadomotica-9bd92.firebaseapp.com',
    storageBucket: 'casadomotica-9bd92.firebasestorage.app',
  );
}
