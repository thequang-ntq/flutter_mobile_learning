import 'dart:math';

import 'package:flutter/services.dart';

final _random = Random();

Color randomColor() {
  return Color.fromARGB(
    255,
    _random.nextInt(256),
    _random.nextInt(256),
    _random.nextInt(256),
  );
}
