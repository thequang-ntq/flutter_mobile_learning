import 'package:code_learning_flutter/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:code_learning_flutter/material/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      title: "Flutter Demo",
      home: MyMaterial(), // Change learning content here
    );
  }
}
