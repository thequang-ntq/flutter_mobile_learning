import 'package:flutter/material.dart';

class MyTextTheme {
  static final TextTheme lightTextTheme = Typography.material2021().black
      .copyWith(
        titleLarge: Typography.material2021().black.titleLarge?.copyWith(
          fontWeight: FontWeight.bold,
        ),
        bodyMedium: Typography.material2021().black.bodyMedium?.copyWith(
          fontSize: 15,
        ),
        headlineLarge: Typography.material2021().black.headlineLarge?.copyWith(
          fontWeight: FontWeight.w900,
        ),
        labelLarge: Typography.material2021().black.labelLarge?.copyWith(
          fontWeight: FontWeight.bold,
        ),
      );

  static final TextTheme darkTextTheme = Typography.material2021().white
      .copyWith(
        titleLarge: Typography.material2021().white.titleLarge?.copyWith(
          fontWeight: FontWeight.bold,
        ),
        bodyMedium: Typography.material2021().white.bodyMedium?.copyWith(
          fontSize: 15,
        ),
        headlineLarge: Typography.material2021().white.headlineLarge?.copyWith(
          fontWeight: FontWeight.w900,
        ),
        labelLarge: Typography.material2021().white.labelLarge?.copyWith(
          fontWeight: FontWeight.bold,
        ),
      );
}
