import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData appLightTheme() {
    return ThemeData(
      bottomSheetTheme: const BottomSheetThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
      ),
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
        bodyMedium: TextStyle(
          color: Colors.grey.shade900,
          // color: Colors.grey.shade900,
        ),
        titleMedium: TextStyle(
          color: Colors.grey.shade900,
        ),
        headlineSmall: TextStyle(
          color: Colors.grey.shade900,
        ),
        titleLarge: TextStyle(
          color: Colors.grey.shade900,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        labelStyle: const TextStyle(color: Colors.black, fontSize: 14),
        fillColor: Colors.grey.shade200,
        prefixIconColor: Colors.grey.shade700,
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
          color: Colors.grey.shade700,
        ),
      ),
    );
  }

  static ThemeData appDarkTheme() {
    return ThemeData(
      drawerTheme: DrawerThemeData(backgroundColor: Colors.grey.shade200),
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
        bodyMedium: TextStyle(
          color: Colors.grey.shade300,
          // color: Colors.grey.shade900,
        ),
        titleMedium: TextStyle(
          color: Colors.grey.shade300,
        ),
        headlineSmall: TextStyle(
          color: Colors.grey.shade300,
        ),
        titleLarge: TextStyle(
          color: Colors.grey.shade300,
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        fillColor: Colors.grey.shade800,
        // fillColor: Colors.grey.shade300,
        prefixIconColor: Colors.grey.shade300,
        labelStyle: const TextStyle(
          color: Colors.white,
        ),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.circular(10.0),
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
