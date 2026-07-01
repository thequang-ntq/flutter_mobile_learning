import 'package:flutter/material.dart';

class MyColorScheme {
  static final ColorScheme lightColorScheme =
      ColorScheme.fromSeed(
        seedColor: Colors.yellow,
        brightness: Brightness.light,
      ).copyWith(
        onPrimary: Colors.black,
        tertiary: Colors.blue,
        surface: Colors.white,
      );

  static final ColorScheme darkColorScheme =
      ColorScheme.fromSeed(
        seedColor: Colors.yellow,
        brightness: Brightness.dark,
      ).copyWith(
        onPrimary: Colors.black,
        tertiary: Colors.blue,
        surface: Colors.black,
      );
}
