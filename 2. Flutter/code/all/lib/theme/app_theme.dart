import 'package:code_learning_flutter/theme/color_scheme.dart';
import 'package:code_learning_flutter/theme/text_theme.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    textTheme: MyTextTheme.lightTextTheme,
    colorScheme: MyColorScheme.lightColorScheme,
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    textTheme: MyTextTheme.darkTextTheme,
    colorScheme: MyColorScheme.darkColorScheme,
  );
}
