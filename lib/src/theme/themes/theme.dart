import 'package:flutter/material.dart'
    show
        BorderRadius,
        BorderSide,
        CardTheme,
        Colors,
        ElevatedButton,
        ElevatedButtonThemeData,
        InputDecorationTheme,
        OutlineInputBorder,
        RoundedRectangleBorder;

final roundedButtonStyle = ElevatedButton.styleFrom(
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
);

final elevatedButtonTheme = ElevatedButtonThemeData(
  style: ElevatedButton.styleFrom(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15),
    ),
  ),
);

final textFieldBorder = InputDecorationTheme(
  filled: true,
  fillColor: Colors.white,
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(20),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: const BorderSide(color: Colors.deepPurpleAccent),
    borderRadius: BorderRadius.circular(15),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: const BorderSide(
      color: Colors.blue,
    ),
    borderRadius: BorderRadius.circular(15),
  ),
);

final cardTheme = CardTheme(
  color: Colors.white,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(10),
  ),
);
