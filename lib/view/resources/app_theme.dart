import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData appLightTheme() {
    return ThemeData(
      iconTheme: const IconThemeData(
        color: Colors.black,
      ),
      primaryColor: Colors.blue.shade100,
      secondaryHeaderColor: Colors.blue[50],
      appBarTheme: AppBarTheme(
        color: Colors.blue.shade400,
        titleTextStyle: TextStyle(
          color: Colors.grey.shade50,
          fontSize: 18,
        ),
        iconTheme: IconThemeData(
          color: Colors.grey.shade50,
        ),
      ),
      textTheme: TextTheme(
        bodyText2: TextStyle(
          color: Colors.grey.shade900,
          // color: Colors.grey.shade900,
        ),
        subtitle1: TextStyle(
          color: Colors.grey.shade900,
        ),
        headline5: TextStyle(
          color: Colors.grey.shade900,
        ),
        headline6: TextStyle(
          color: Colors.grey.shade900,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        fillColor: Colors.grey.shade300,
        prefixIconColor: Colors.grey.shade300,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black),
          borderRadius: BorderRadius.circular(10.0),
        ),
        hintStyle: TextStyle(
          color: Colors.grey.shade200,
        ),
      ),
    );
  }

  static ThemeData appDarkTheme() {
    return ThemeData(
      drawerTheme: DrawerThemeData(
          backgroundColor: Colors.grey.shade600.withOpacity(0.97)),
      iconTheme: const IconThemeData(
        color: Colors.white,
      ),

      colorScheme: const ColorScheme.light(),
      primaryColor: Colors.grey.shade800,
      secondaryHeaderColor: Colors.grey.shade700,
      appBarTheme: AppBarTheme(
        color: Colors.grey.shade800,
        titleTextStyle: TextStyle(color: Colors.grey.shade500, fontSize: 18),
        iconTheme: IconThemeData(
          color: Colors.grey.shade500,
        ),
      ),
      scaffoldBackgroundColor: Colors.grey.shade900,

      //text Theme
      textTheme: TextTheme(
        bodyText2: TextStyle(
          color: Colors.grey.shade300,
          // color: Colors.grey.shade900,
        ),
        subtitle1: TextStyle(
          color: Colors.grey.shade300,
        ),
        headline5: TextStyle(
          color: Colors.grey.shade300,
        ),
        headline6: TextStyle(
          color: Colors.grey.shade300,
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        fillColor: Colors.grey.shade300,
        prefixIconColor: Colors.grey.shade300,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(10.0),
        ),
        hintStyle: TextStyle(
          color: Colors.grey.shade200,
        ),
      ),
    );
  }
}
