import 'package:flutter/material.dart';

class AppTextTheme {
  static final TextTheme lightTextTheme = Typography.material2021().black
      .copyWith(
        headlineLarge: TextStyle(fontWeight: FontWeight.bold),
        titleLarge: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        bodyLarge: TextStyle(fontSize: 21, fontWeight: FontWeight.w500),
      );
  static final TextTheme darkTextTheme = Typography.material2021().white;
}
