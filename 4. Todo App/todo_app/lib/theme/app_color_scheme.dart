import 'package:flutter/material.dart';

class AppColorScheme {
  static const seedColor = Color(0xFF4F46E5);

  static final ColorScheme lightColorScheme = ColorScheme.fromSeed(
    seedColor: seedColor,
    brightness: Brightness.light,
  );
  static final ColorScheme darkColorScheme = ColorScheme.fromSeed(
    seedColor: seedColor,
    brightness: Brightness.dark,
  );
}
