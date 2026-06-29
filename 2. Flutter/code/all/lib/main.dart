import 'package:code_learning_flutter/app.dart';
import 'package:code_learning_flutter/setstate/state_management/models/cart_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => CartModel(),
      child: const MyApp(),
    ),
  );
}
