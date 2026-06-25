import 'package:flutter/material.dart';

class MyStateless extends StatelessWidget {
  const MyStateless({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("Learning stateless")),
        body: Center(
          child: ElevatedButton(
            onPressed: () {},
            child: Text("Learning stateless"),
          ),
        ),
      ),
    );
  }
}
