import 'package:flutter/material.dart';

class MyStateful extends StatefulWidget {
  const MyStateful({super.key, required this.title});
  final String title;

  @override
  State<MyStateful> createState() => _MyStatefulState();
}

class _MyStatefulState extends State<MyStateful> {
  int _counter = 0;
  int _resultCalc = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
      _resultCalc = _counter * _counter;
    });
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height * 0.02;
    // double w = MediaQuery.of(context).size.width * 0.02;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: Text(widget.title)),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Your score: "),
              SizedBox(height: h),
              Text("$_counter"),
              SizedBox(height: h),
              Text("$_resultCalc"),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _incrementCounter,
          tooltip: "Increment",
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
