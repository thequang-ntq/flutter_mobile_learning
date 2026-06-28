// import 'package:code_learning_flutter/cupertino/cupertino.dart';
// import 'package:code_learning_flutter/setstate/setstate.dart';
import 'package:code_learning_flutter/setstate/state_management/pages/login_page.dart';
import 'package:code_learning_flutter/theme/app_theme.dart';
import 'package:flutter/material.dart';
// import 'package:code_learning_flutter/material/material.dart';

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
      home: LoginPage(), // Change learning content here
    );
  }
}
