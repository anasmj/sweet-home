import 'package:flutter/material.dart';
import '../theme.dart';

ThemeData get lightTheme => ThemeData(
      primaryColor: Colors.blue.shade200,
      secondaryHeaderColor: Colors.blue.shade50,
      useMaterial3: true,
      primarySwatch: Colors.blue,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      inputDecorationTheme: textFieldBorder,
      elevatedButtonTheme: elevatedButtonTheme,
      cardTheme: cardTheme,
    );
