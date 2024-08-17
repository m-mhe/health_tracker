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
  final TextEditingController _tecWight = TextEditingController();
  final TextEditingController _tecHeight = TextEditingController();
  final TextEditingController _tecAge = TextEditingController();

  double _bMR = 0;
  double _ageValue = 0;
  double _heightValue = 0;
  double _weightValue = 0;
  bool _male = true;
  bool _female = false;
  String _maleText = 'Male';
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
                            spreadRadius: 1,
                            blurRadius: 8,
                            offset: Offset(3, 3))
                      ]),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Lottie.asset('assets/animations/health_animation3.json',
                          height: 224,
                          width: 224,
                          frameRate: const FrameRate(60),
                          repeat: true),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Text(
                          'BMR: ${_bMR.toStringAsFixed(2)} Cal/Day',
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
                                spreadRadius: 6,
                                blurRadius: 8,
                                offset: Offset(1, 1))
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
                                spreadRadius: 6,
                                blurRadius: 8,
                                offset: Offset(1, 1))
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
                            spreadRadius: 1,
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
                            _tecAge.text = _ageValue.toString();
                            _result();
                          });
                        },
                      ),
                      SizedBox(
                        width: 100,
                        child: TextField(
                          controller: _tecAge,
                          onChanged: (v) {
                            List<String> value = v.split('');
                            if (value.last == '-') {
                              _tecAge.clear();
                            }
                            setState(() {
                              _ageValue = double.tryParse(v) ?? 0;
                              _result();
                            });
                          },
                          keyboardType: TextInputType.number,
                          cursorColor: const Color(0xff299FD5),
                          style: const TextStyle(
                              color: Color(0xff299FD5),
                              fontWeight: FontWeight.w500),
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            prefixStyle: const TextStyle(
                                color: Color(0xff299FD5),
                                fontWeight: FontWeight.w500),
                            prefixText: 'Year ',
                            labelStyle: const TextStyle(
                              color: Color(0xff299FD5),
                              fontWeight: FontWeight.w500,
                            ),
                            labelText: 'Age:',
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(7),
                              borderSide: const BorderSide(
                                width: 2,
                                color: Color(0xff299FD5),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(17),
                              borderSide: const BorderSide(
                                width: 2,
                                color: Color(0xff299FD5),
                              ),
                            ),
                          ),
                        ),
                      ),
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
                            spreadRadius: 1,
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
                            _tecHeight.text = _heightValue.toString();
                            _result();
                          });
                        },
                      ),
                      SizedBox(
                        width: 100,
                        child: TextField(
                          controller: _tecHeight,
                          onChanged: (v) {
                            List<String> value = v.split('');
                            if (value.last == '-') {
                              _tecHeight.clear();
                            }
                            setState(() {
                              _heightValue = double.tryParse(v) ?? 0;
                              _result();
                            });
                          },
                          keyboardType: TextInputType.number,
                          cursorColor: const Color(0xff299FD5),
                          style: const TextStyle(
                              color: Color(0xff299FD5),
                              fontWeight: FontWeight.w500),
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            prefixStyle: const TextStyle(
                                color: Color(0xff299FD5),
                                fontWeight: FontWeight.w500),
                            prefixText: 'Feet ',
                            labelStyle: const TextStyle(
                              color: Color(0xff299FD5),
                              fontWeight: FontWeight.w500,
                            ),
                            labelText: 'Height:',
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(7),
                              borderSide: const BorderSide(
                                width: 2,
                                color: Color(0xff299FD5),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(17),
                              borderSide: const BorderSide(
                                width: 2,
                                color: Color(0xff299FD5),
                              ),
                            ),
                          ),
                        ),
                      ),
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
                            spreadRadius: 1,
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
                            _tecWight.text = _weightValue.toString();
                            _result();
                          });
                        },
                      ),
                      SizedBox(
                        width: 100,
                        child: TextField(
                          controller: _tecWight,
                          onChanged: (v) {
                            List<String> value = v.split('');
                            if (value.last == '-') {
                              _tecWight.clear();
                            }
                            setState(() {
                              _weightValue = double.tryParse(v) ?? 0;
                              _result();
                            });
                          },
                          keyboardType: TextInputType.number,
                          cursorColor: const Color(0xff299FD5),
                          style: const TextStyle(
                              color: Color(0xff299FD5),
                              fontWeight: FontWeight.w500),
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            prefixStyle: const TextStyle(
                                color: Color(0xff299FD5),
                                fontWeight: FontWeight.w500),
                            prefixText: 'KG ',
                            labelStyle: const TextStyle(
                              color: Color(0xff299FD5),
                              fontWeight: FontWeight.w500,
                            ),
                            labelText: 'Weight:',
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(7),
                              borderSide: const BorderSide(
                                width: 2,
                                color: Color(0xff299FD5),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(17),
                              borderSide: const BorderSide(
                                width: 2,
                                color: Color(0xff299FD5),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        currentIndex: 2,
        onTap: (i) {
          switch (i) {
            case (0):
              {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const BmiScreen();
                    },
                  ),
                );
              }
            case (1):
              {
                Navigator.pop(context);
              }
            case (2):
              {
                null;
              }
          }
        },
        selectedItemColor: const Color(0xff299FD5),
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.health_and_safety_outlined), label: "BMI"),
          BottomNavigationBarItem(
              icon: Icon(Icons.water_drop_outlined), label: "WIT"),
          BottomNavigationBarItem(
              icon: Icon(Icons.heart_broken_outlined), label: "BMR")
        ],
      ),
    );
  }

  @override
  void dispose() {
    _tecHeight.dispose();
    _tecAge.dispose();
    _tecWight.dispose();
    super.dispose();
  }
}
