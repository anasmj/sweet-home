import 'package:flutter/material.dart';
import 'modules/authentication/view/wrapper.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: Colors.lightBlue,
      ),
      home: const Wrapper(),
    );
  }
}
