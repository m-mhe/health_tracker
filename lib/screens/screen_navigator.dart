import 'package:flutter/material.dart';
import 'package:health_tracker/screens/bmi_screen.dart';
import 'package:health_tracker/screens/bmr_screen.dart';
import 'package:health_tracker/screens/water_tracker_screen.dart';

class ScreenNavigator extends StatefulWidget {
  const ScreenNavigator({
    super.key,
  });

  @override
  State<ScreenNavigator> createState() => _ScreenNavigatorState();
}

class _ScreenNavigatorState extends State<ScreenNavigator> {
  final List<Widget> screens = [
    const BmiScreen(),
    const WaterTrackerScreen(),
    const BmrScreen()
  ];
  int index = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[index],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        currentIndex: index,
        onTap: (i) {
          setState(() {
            index = i;
          });
        },
        selectedItemColor: const Color(0xff299FD5),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.health_and_safety_outlined),
            label: "BMI",
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.water_drop_outlined), label: "WIT"),
          BottomNavigationBarItem(
              icon: Icon(Icons.heart_broken_outlined), label: "BMR")
        ],
      ),
    );
  }
}
