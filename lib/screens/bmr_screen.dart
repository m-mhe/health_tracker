import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

import 'bmi_screen.dart';

class BmrScreen extends StatefulWidget {
  const BmrScreen({super.key});

  @override
  State<BmrScreen> createState() => _BmrScreenState();
}

class _BmrScreenState extends State<BmrScreen> {
  double _bMR = 0;
  double _ageValue = 0;
  double _heightValue = 0;
  double _weightValue = 0;
  bool _male = false;
  bool _female = false;
  String _maleText = '';
  String _femaleText = '';

  void _result() {
    double height = _heightValue * 30.48;
    if (_male == true) {
      _bMR = (10 * _weightValue) + (6.25 * height) - (5 * _ageValue) + 5;
      _maleText = 'Male';
      _femaleText = '';
    } else if (_female == true) {
      _bMR = (10 * _weightValue) + (6.25 * height) - (5 * _ageValue) - 161;
      _femaleText = "Female";
      _maleText = '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.heart_broken),
        title: const Text(
          'BMR Tracker',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Container(
                  height: 270,
                  width: MediaQuery.sizeOf(context).width - 40,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(17),
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.grey,
                            spreadRadius: 4,
                            blurRadius: 8,
                            offset: Offset(3, 3))
                      ]),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Lottie.asset('assets/animations/health_animation3.json',
                          height: 224,
                          width: 224,
                          frameRate: const FrameRate(90),
                          repeat: true),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Text(
                          'BMR: ${_bMR.toStringAsFixed(2)} Kcal/Day',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                            color: Colors.blue[700],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: () {
                    _male = true;
                    _female = false;
                    setState(_result);
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Container(
                      height: 70,
                      width: (MediaQuery.sizeOf(context).width / 2) - 40,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(17),
                          boxShadow: const [
                            BoxShadow(
                                color: Color(0xffA0D2ED),
                                spreadRadius: 4,
                                blurRadius: 8,
                                offset: Offset(3, 3))
                          ]),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const Icon(
                            Icons.male,
                            size: 35,
                            color: Colors.blue,
                          ),
                          Text(
                            _maleText,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: Colors.blue,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    _male = false;
                    _female = true;
                    setState(_result);
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Container(
                      height: 70,
                      width: (MediaQuery.sizeOf(context).width / 2) - 40,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(17),
                          boxShadow: const [
                            BoxShadow(
                                color: Color(0xffFCB2EF),
                                spreadRadius: 4,
                                blurRadius: 8,
                                offset: Offset(3, 3))
                          ]),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const Icon(
                            Icons.female,
                            size: 35,
                            color: Colors.pink,
                          ),
                          Text(
                            _femaleText,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                              color: Colors.pink,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Container(
                  height: 170,
                  width: MediaQuery.sizeOf(context).width - 40,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(17),
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.grey,
                            spreadRadius: 4,
                            blurRadius: 8,
                            offset: Offset(3, 3))
                      ]),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SfSlider(
                        activeColor: const Color(0xff299FD5),
                        min: 0.0,
                        max: 100,
                        value: _ageValue,
                        interval: 20,
                        showTicks: true,
                        showLabels: true,
                        enableTooltip: true,
                        minorTicksPerInterval: 1,
                        onChanged: (dynamic value) {
                          setState(() {
                            _ageValue = value;
                            _result();
                          });
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 0),
                        child: Text(
                          'Age ${_ageValue.toStringAsFixed(2)} year',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                            color: Colors.blue[700],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Container(
                  height: 170,
                  width: MediaQuery.sizeOf(context).width - 40,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(17),
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.grey,
                            spreadRadius: 4,
                            blurRadius: 8,
                            offset: Offset(3, 3))
                      ]),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SfSlider(
                        activeColor: const Color(0xff299FD5),
                        min: 0.0,
                        max: 10.0,
                        value: _heightValue,
                        interval: 2,
                        showTicks: true,
                        showLabels: true,
                        enableTooltip: true,
                        minorTicksPerInterval: 1,
                        onChanged: (dynamic value) {
                          setState(() {
                            _heightValue = value;
                            _result();
                          });
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 0),
                        child: Text(
                          'Height ${_heightValue.toStringAsFixed(2)} feet',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                            color: Colors.blue[700],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 80),
                child: Container(
                  height: 170,
                  width: MediaQuery.sizeOf(context).width - 40,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(17),
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.grey,
                            spreadRadius: 4,
                            blurRadius: 8,
                            offset: Offset(3, 3))
                      ]),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SfSlider(
                        activeColor: const Color(0xff299FD5),
                        min: 0.0,
                        max: 200,
                        value: _weightValue,
                        interval: 40,
                        showTicks: true,
                        showLabels: true,
                        enableTooltip: true,
                        minorTicksPerInterval: 1,
                        onChanged: (dynamic value) {
                          setState(() {
                            _weightValue = value;
                            _result();
                          });
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 0),
                        child: Text(
                          'Weight ${_weightValue.toStringAsFixed(2)} KG',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                            color: Colors.blue[700],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            backgroundColor: Colors.white,
            onPressed: () {
              Navigator.pop(context);
            },
            child: Lottie.asset('assets/animations/waterAnimation.json'),
          ),
          const SizedBox(
            width: 20,
          ),
          FloatingActionButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const BmiScreen();
                  },
                ),
              );
            },
            child: const Text(
              'BMI',
            ),
          ),
        ],
      ),
    );
  }
}
