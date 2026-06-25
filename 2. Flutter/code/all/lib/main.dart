import 'package:code_learning_flutter/stateful/my_stateful.dart';
// import 'package:code_learning_flutter/stateless/my_stateless.dart';
import 'package:flutter/material.dart';
// import 'package:code_learning_flutter/widget/my_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MyStateful(title: "Learning Stateful");
  }
}
