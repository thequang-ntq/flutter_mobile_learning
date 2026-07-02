import 'package:flutter/material.dart';
import 'package:todo_app/theme/app_color_scheme.dart';
import 'package:todo_app/theme/app_text_theme.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    textTheme: AppTextTheme.lightTextTheme,
    colorScheme: AppColorScheme.lightColorScheme,
    brightness: Brightness.light,
  );

  static final ThemeData darkTheme = ThemeData(
    textTheme: AppTextTheme.darkTextTheme,
    colorScheme: AppColorScheme.darkColorScheme,
    brightness: Brightness.dark,
  );
}
