import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';
import 'package:todo_app/router/app_router.dart';
import 'package:todo_app/theme/app_theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ToastificationWrapper(
      child: MaterialApp.router(
        routerConfig: AppRouter.appRouter,
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.system,
        title: "Todo App",
      ),
    );
  }
}
