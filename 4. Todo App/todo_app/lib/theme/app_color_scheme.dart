import 'package:flutter/material.dart';

class AppColorScheme {
  static const seedColor = Color(0xFF4F46E5);

  static final ColorScheme lightColorScheme =
      ColorScheme.fromSeed(
        seedColor: seedColor,
        brightness: Brightness.light,
      ).copyWith(
        primary: seedColor,
        onPrimary: Color.fromARGB(255, 255, 255, 255),
        secondaryContainer: Color.fromARGB(255, 50, 174, 54),
        onSecondaryContainer: Color.fromARGB(255, 255, 255, 255),
        outlineVariant: Color.fromARGB(255, 214, 214, 214),
      );
  static final ColorScheme darkColorScheme =
      ColorScheme.fromSeed(
        seedColor: seedColor,
        brightness: Brightness.dark,
      ).copyWith(
        primary: seedColor,
        onPrimary: Color.fromARGB(255, 255, 255, 255),
        secondaryContainer: Color.fromARGB(255, 50, 174, 54),
        onSecondaryContainer: Color.fromARGB(255, 255, 255, 255),
        outline: Color.fromARGB(255, 255, 255, 255),
        outlineVariant: Color.fromARGB(255, 58, 58, 58),
      );
}
