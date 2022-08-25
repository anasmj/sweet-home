import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    colorScheme: const ColorScheme.light(),
    // colorScheme: ColorScheme.fromSwatch().copyWith(
    //   primary: Color(0xFF61defa),
    //   //secondary: Color(0xff95d7e6),
    // )

    // primaryColor: Colors.black,
    //textTheme: Theme.of(context).textTheme.apply(bodyColor: Colors.black),
    // appBarTheme: const AppBarTheme(
    //   color: Color.fromARGB(255, 161, 239, 253),
    // ),
  );
  static ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.grey[900],
    colorScheme: const ColorScheme.dark(),
  );
}
