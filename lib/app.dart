import 'package:flutter/material.dart';
import 'package:health_tracker/screens/screen_navigator.dart';
import 'package:health_tracker/screens/water_tracker_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Health Tracker',
      themeMode: ThemeMode.light,
      darkTheme: _darkTheme(),
      theme: _lightTheme(),
      home: const ScreenNavigator(),
    );
  }

  ThemeData _darkTheme() {
    return ThemeData(
        appBarTheme: const AppBarTheme(
            centerTitle: true,
            backgroundColor: Color(0xff299FD5),
            foregroundColor: Colors.white),
        scaffoldBackgroundColor: Colors.blueGrey[900],
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: const Color(0xff299FD5),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(7),
          ),
        ));
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
