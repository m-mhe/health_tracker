import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

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
      return 'Over weight';
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
                                    color: Colors.green),
                                GaugeRange(
                                    startValue: 18.5,
                                    endValue: 24.9,
                                    color: const Color(0xff299FD5)),
                                GaugeRange(
                                    startValue: 25,
                                    endValue: 29.9,
                                    color: Colors.yellow),
                                GaugeRange(
                                    startValue: 30,
                                    endValue: 34.9,
                                    color: Colors.orange),
                                GaugeRange(
                                    startValue: 35,
                                    endValue: 40,
                                    color: Colors.red)
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
                      color: const Color(0xff299FD5),
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
                          axisLabelStyle: const TextStyle(color: Colors.white),
                          ranges: [
                            LinearGaugeRange(
                              startValue: 0,
                              endValue: double.tryParse(_tecWight.text) ?? 0,
                              color: const Color(0xffFC4100),
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
                              color: Colors.white,
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 100,
                        child: TextField(
                          controller: _tecWight,
                          onChanged: (v) {
                            setState(() {});
                          },
                          keyboardType: TextInputType.number,
                          cursorColor: Colors.white,
                          style: const TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w500),
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            prefixStyle: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                            prefixText: 'KG ',
                            labelStyle: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                            labelText: 'Weight:',
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(7),
                              borderSide: const BorderSide(
                                width: 2,
                                color: Colors.white,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(17),
                              borderSide: const BorderSide(
                                width: 2,
                                color: Colors.white,
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
              padding: const EdgeInsets.only(top: 20),
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
                      color: const Color(0xff299FD5),
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
                          axisLabelStyle: const TextStyle(color: Colors.white),
                          ranges: [
                            LinearGaugeRange(
                              startValue: 0,
                              endValue: double.tryParse(_tecHeight.text) ?? 0,
                              color: const Color(0xffFC4100),
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
                              color: Colors.white,
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 100,
                        child: TextField(
                          controller: _tecHeight,
                          onChanged: (v) {
                            setState(() {});
                          },
                          keyboardType: TextInputType.number,
                          cursorColor: Colors.white,
                          style: const TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w500),
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            prefixStyle: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                            prefixText: 'Feet ',
                            labelStyle: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                            labelText: 'Height:',
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(7),
                              borderSide: const BorderSide(
                                width: 2,
                                color: Colors.white,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(17),
                              borderSide: const BorderSide(
                                width: 2,
                                color: Colors.white,
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () {
          Navigator.pop(context);
        },
        child: Lottie.asset('assets/animations/waterAnimation.json'),
      ),
    );
  }
}
