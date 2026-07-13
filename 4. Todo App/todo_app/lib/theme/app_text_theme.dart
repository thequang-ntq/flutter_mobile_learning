import 'package:flutter/material.dart';

class AppTextTheme {
  static final TextTheme lightTextTheme = Typography.material2021().black
      .copyWith(
        headlineLarge: TextStyle(fontWeight: FontWeight.bold),
        titleLarge: TextStyle(fontWeight: FontWeight.w800),
        bodyLarge: TextStyle(fontWeight: FontWeight.w600),
      );
  static final TextTheme darkTextTheme = Typography.material2021().white;
}
