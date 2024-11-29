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
    apiKey: 'AIzaSyCv09hp5w3AFRvypdpTbSD84qfuDngW00M',
    appId: '1:190939424592:web:e1f123709ea2361af36e55',
    messagingSenderId: '190939424592',
    projectId: 'coffe-shop-ea8dc',
    authDomain: 'coffe-shop-ea8dc.firebaseapp.com',
    storageBucket: 'coffe-shop-ea8dc.firebasestorage.app',
    measurementId: 'G-NCR97GCHLH',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCwj32itRJ1Kw20N4qjvRvprPlNN9Yhccs',
    appId: '1:190939424592:android:b82896a218916d0ff36e55',
    messagingSenderId: '190939424592',
    projectId: 'coffe-shop-ea8dc',
    storageBucket: 'coffe-shop-ea8dc.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDG7_hwE4hL9gyCbVhMQjcu9QWSBZUJpKw',
    appId: '1:190939424592:ios:8c32c7518cec989ff36e55',
    messagingSenderId: '190939424592',
    projectId: 'coffe-shop-ea8dc',
    storageBucket: 'coffe-shop-ea8dc.firebasestorage.app',
    iosBundleId: 'com.example.coffeApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDG7_hwE4hL9gyCbVhMQjcu9QWSBZUJpKw',
    appId: '1:190939424592:ios:8c32c7518cec989ff36e55',
    messagingSenderId: '190939424592',
    projectId: 'coffe-shop-ea8dc',
    storageBucket: 'coffe-shop-ea8dc.firebasestorage.app',
    iosBundleId: 'com.example.coffeApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCv09hp5w3AFRvypdpTbSD84qfuDngW00M',
    appId: '1:190939424592:web:110020a75a923951f36e55',
    messagingSenderId: '190939424592',
    projectId: 'coffe-shop-ea8dc',
    authDomain: 'coffe-shop-ea8dc.firebaseapp.com',
    storageBucket: 'coffe-shop-ea8dc.firebasestorage.app',
    measurementId: 'G-8N5LHFCGE1',
  );
}
