import 'package:flutter/material.dart';

class MyCounter extends StatefulWidget {
  const MyCounter({super.key});

  @override
  State<MyCounter> createState() => _MyCounterState();
}

class _MyCounterState extends State<MyCounter> {
  int _counter = 0;

  void _increment() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context, title: "SetState Counter example"),
      body: _buildBody(context),
      floatingActionButton: _buildFloatingButton(),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context, {String? title}) {
    final text = Theme.of(context).textTheme;
    return AppBar(title: Text(title ?? "", style: text.headlineLarge));
  }

  Widget _buildBody(BuildContext context) {
    final text = Theme.of(context).textTheme;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text("Number of clicks:", style: text.displaySmall),
          const SizedBox(height: 5),
          Text("$_counter", style: text.displayLarge),
        ],
      ),
    );
  }

  Widget _buildFloatingButton() {
    return FloatingActionButton(
      onPressed: _increment,
      child: const Icon(Icons.add),
    );
  }
}
