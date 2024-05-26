import 'package:flutter/material.dart';
import 'package:health_tracker/screens/water_tracker_screen.dart';
import 'package:lottie/lottie.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import 'bmr_screen.dart';

class BmiScreen extends StatefulWidget {
  const BmiScreen({super.key});

  @override
  State<BmiScreen> createState() => _BmiScreenState();
}

class _BmiScreenState extends State<BmiScreen> {
  final TextEditingController _tecWight = TextEditingController();
  final TextEditingController _tecHeight = TextEditingController();

  double _result() {
    double result = (double.tryParse(_tecWight.text) ?? 0) /
        (((double.tryParse(_tecHeight.text) ?? 0) * 0.3048) *
            ((double.tryParse(_tecHeight.text) ?? 0) * 0.3048));
    return result;
  }

  String _bmiStatus() {
    if (_result() < 18.5) {
      return ' Under weight';
    } else if (_result() <= 24.9) {
      return ' Normal';
    } else if (_result() <= 29.9) {
      return ' Over weight';
    } else if (_result() <= 34.9) {
      return ' Obese';
    } else if (_result() > 34.9) {
      return ' Extremely Obese';
    } else {
      return ' Enter valid numbers';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.health_and_safety_sharp),
        title: const Text(
          'BMI Tracker',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Center(
                child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(17)),
                    height: 270,
                    width: MediaQuery.sizeOf(context).width - 40,
                    child: SfRadialGauge(
                        title: GaugeTitle(
                            text: 'Result:${_bmiStatus()}',
                            textStyle: const TextStyle(
                                color: Color(0xff299FD5),
                                fontWeight: FontWeight.w500,
                                fontSize: 17)),
                        axes: <RadialAxis>[
                          RadialAxis(
                              minimum: 15,
                              maximum: 40,
                              ranges: <GaugeRange>[
                                GaugeRange(
                                    startValue: 15,
                                    endValue: 18.4,
                                    color: Colors.lightBlueAccent[100]),
                                GaugeRange(
                                    startValue: 18.5,
                                    endValue: 24.9,
                                    color: Colors.blue[300]),
                                GaugeRange(
                                    startValue: 25,
                                    endValue: 29.9,
                                    color: Colors.blue[500]),
                                GaugeRange(
                                    startValue: 30,
                                    endValue: 34.9,
                                    color: Colors.blue[700]),
                                GaugeRange(
                                    startValue: 35,
                                    endValue: 40,
                                    color: Colors.blue[900])
                              ],
                              pointers: <GaugePointer>[
                                NeedlePointer(
                                  value: _result(),
                                )
                              ],
                              annotations: <GaugeAnnotation>[
                                GaugeAnnotation(
                                    widget: Text(_result().toStringAsFixed(2),
                                        style: const TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                        )),
                                    angle: 90,
                                    positionFactor: 0.5)
                              ])
                        ])),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.grey,
                            spreadRadius: 1,
                            blurRadius: 8,
                            offset: Offset(3, 3))
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(17)),
                  height: 170,
                  width: MediaQuery.sizeOf(context).width - 40,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: MediaQuery.sizeOf(context).width - 60,
                        child: SfLinearGauge(
                          maximum: 200,
                          axisLabelStyle: const TextStyle(color: Colors.black),
                          ranges: [
                            LinearGaugeRange(
                              startValue: 0,
                              endValue: double.tryParse(_tecWight.text) ?? 0,
                              color: Colors.red,
                            ),
                          ],
                          markerPointers: [
                            LinearShapePointer(
                              value: double.tryParse(_tecWight.text) ?? 0,
                            ),
                          ],
                          barPointers: const [
                            LinearBarPointer(
                              value: 200,
                              color: Color(0xff299FD5),
                            )
                          ],
                        ),
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
                            setState(() {});
                          },
                          keyboardType: TextInputType.number,
                          cursorColor: Color(0xff299FD5),
                          style: const TextStyle(
                              color: Color(0xff299FD5), fontWeight: FontWeight.w500),
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
                      )
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 80),
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.grey,
                            spreadRadius: 1,
                            blurRadius: 8,
                            offset: Offset(3, 3))
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(17)),
                  height: 170,
                  width: MediaQuery.sizeOf(context).width - 40,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: MediaQuery.sizeOf(context).width - 60,
                        child: SfLinearGauge(
                          maximum: 10,
                          axisLabelStyle: const TextStyle(color: Colors.black),
                          ranges: [
                            LinearGaugeRange(
                              startValue: 0,
                              endValue: double.tryParse(_tecHeight.text) ?? 0,
                              color: Colors.red,
                            ),
                          ],
                          markerPointers: [
                            LinearShapePointer(
                              value: double.tryParse(_tecHeight.text) ?? 0,
                            ),
                          ],
                          barPointers: const [
                            LinearBarPointer(
                              value: 10,
                              color: Color(0xff299FD5),
                            )
                          ],
                        ),
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
                            setState(() {});
                          },
                          keyboardType: TextInputType.number,
                          cursorColor: Color(0xff299FD5),
                          style: const TextStyle(
                              color: Color(0xff299FD5), fontWeight: FontWeight.w500),
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
                      )
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
        currentIndex: 0,
        onTap: (i) {
          switch (i) {
            case (0):
              {
                null;
              }
            case (1):
              {
                Navigator.pop(context);
              }
            case (2):
              {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const BmrScreen();
                    },
                  ),
                );
              }
          }
        },
        selectedItemColor: Color(0xff299FD5),
        items: [
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
    _tecWight.dispose();
    super.dispose();
  }
}
