import 'package:flutter/material.dart';
import 'package:health_tracker/screens/screen_navigator.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Health Tracker',
      theme: _lightTheme(),
      home: const ScreenNavigator(),
    );
  }

  ThemeData _lightTheme() {
    return ThemeData(
        appBarTheme: const AppBarTheme(
            centerTitle: true,
            backgroundColor: Color(0xff299FD5),
            foregroundColor: Colors.white),
        scaffoldBackgroundColor: Colors.white,
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: const Color(0xff299FD5),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(7),
          ),
        ));
  }
}
