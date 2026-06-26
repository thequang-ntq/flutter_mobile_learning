import 'package:flutter/material.dart';

class MyColorScheme {
  static final ColorScheme lightColorScheme = ColorScheme.fromSeed(
    seedColor: const Color(0xFFC32708),
    brightness: Brightness.light,
  );

  static final ColorScheme darkColorScheme = ColorScheme.fromSeed(
    seedColor: const Color(0xFFC32708),
    brightness: Brightness.dark,
  );
}
