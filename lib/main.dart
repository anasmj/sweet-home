import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'firebase_options.dart';
import 'src/app.dart';

void main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    if (Firebase.apps.isEmpty) {
      await Firebase.initializeApp(
        // options: DefaultFirebaseOptions.currentPlatform,
        options: DefaultFirebaseOptions.android,
        //  const FirebaseOptions(
        //   apiKey:   'AIzaSyAYEiUKqHQ4aGxUAljsF8VrGCX9Ya2mEg4',
        //   appId: '1:121043908992:web:3a8e780ff48569f66fa965',
        //   messagingSenderId: '121043908992',
        //   projectId: 'sweet-home-18566',
        // ),
      );
    }
  } catch (e) {
    //
  }
  runApp(const ProviderScope(child: MyApp()));
}
