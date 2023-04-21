import 'package:flutter/material.dart';
import 'package:sweet_home/src/modules/authentication/view/authentication.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: const AuthenticatePages(),
    );
  }
}
