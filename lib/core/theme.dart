import 'package:flutter/material.dart';

final _inputDecorationTheme = InputDecorationTheme(
  filled: true,
  floatingLabelBehavior: FloatingLabelBehavior.always,
  border: OutlineInputBorder(
    borderSide: BorderSide.none,
    borderRadius: BorderRadius.circular(15),
  ),
  contentPadding: const EdgeInsets.symmetric(
    horizontal: 20,
    vertical: 15,
  ),
);

class AppTheme {
  static final dark = ThemeData(
    colorSchemeSeed: Colors.blue,
    brightness: Brightness.dark,
    useMaterial3: true,
    inputDecorationTheme: _inputDecorationTheme,
  );

  static final light = ThemeData(
    colorSchemeSeed: Colors.blue,
    brightness: Brightness.light,
    useMaterial3: true,
    inputDecorationTheme: _inputDecorationTheme,
  );
}
