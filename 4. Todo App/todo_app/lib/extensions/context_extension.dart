import 'package:flutter/material.dart';

extension ContextExt on BuildContext {
  TextTheme get text => Theme.of(this).textTheme;
  ColorScheme get colors => Theme.of(this).colorScheme;
  double get width => MediaQuery.of(this).size.width;
  double get height => MediaQuery.of(this).size.height;
  ScaffoldMessengerState get messenger => ScaffoldMessenger.of(this);
}
