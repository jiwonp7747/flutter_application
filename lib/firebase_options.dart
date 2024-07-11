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
    apiKey: 'AIzaSyCQlEmzAh1i1t_fH8W9AgBzVP4Awo_OKUE',
    appId: '1:98826649118:web:7ff11cdd8eec2075edb80f',
    messagingSenderId: '98826649118',
    projectId: 'django-social-auth-379908',
    authDomain: 'django-social-auth-379908.firebaseapp.com',
    storageBucket: 'django-social-auth-379908.appspot.com',
    measurementId: 'G-09Z7B4MRDL',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAKewzYT-ZQExVsNNyeaq2ChZ_ar-BkcAM',
    appId: '1:98826649118:android:b099900719ff74b4edb80f',
    messagingSenderId: '98826649118',
    projectId: 'django-social-auth-379908',
    storageBucket: 'django-social-auth-379908.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAd1ZjLN1m6mMgpdA2vOzjMEnDSXfenVas',
    appId: '1:98826649118:ios:a4c41338b17ab05cedb80f',
    messagingSenderId: '98826649118',
    projectId: 'django-social-auth-379908',
    storageBucket: 'django-social-auth-379908.appspot.com',
    iosClientId: '98826649118-5nlo7v322la66op8f26g1j2fgsr6a3te.apps.googleusercontent.com',
    iosBundleId: 'com.example.flutterApplication6',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAd1ZjLN1m6mMgpdA2vOzjMEnDSXfenVas',
    appId: '1:98826649118:ios:a4c41338b17ab05cedb80f',
    messagingSenderId: '98826649118',
    projectId: 'django-social-auth-379908',
    storageBucket: 'django-social-auth-379908.appspot.com',
    iosClientId: '98826649118-5nlo7v322la66op8f26g1j2fgsr6a3te.apps.googleusercontent.com',
    iosBundleId: 'com.example.flutterApplication6',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCQlEmzAh1i1t_fH8W9AgBzVP4Awo_OKUE',
    appId: '1:98826649118:web:5eb2c9fed370f97dedb80f',
    messagingSenderId: '98826649118',
    projectId: 'django-social-auth-379908',
    authDomain: 'django-social-auth-379908.firebaseapp.com',
    storageBucket: 'django-social-auth-379908.appspot.com',
    measurementId: 'G-4NRJCV2F1J',
  );
}