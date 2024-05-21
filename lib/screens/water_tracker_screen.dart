import 'package:flutter/material.dart';
import 'package:health_tracker/screens/bmi_screen.dart';
import 'package:lottie/lottie.dart';
import 'package:health_tracker/other_classes/data_model.dart';
import 'package:intl/intl.dart';

class WaterTrackerScreen extends StatefulWidget {
  const WaterTrackerScreen({super.key});

  @override
  State<WaterTrackerScreen> createState() => _WaterTrackerScreenState();
}

class _WaterTrackerScreenState extends State<WaterTrackerScreen> {
  //UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _waterTrackerAppBar(),
      body: Column(
        children: [
          _tapHereButton(context),
          _glassNumberInputSection(),
          _eightGlassMilestoneChecker(),
          _historyAndTotalGlassIndicator(context),
          _horizontalLine(context),
          _waterConsumptionHistory()
        ],
      ),
      floatingActionButton: _buildBuildFabBmiScreenNavigator(),
    );
  }

  /*----------------------------------------------------------------------------------------------------------------------*/
  //Variables
  final TextEditingController _tEControllerNumberOfGlass =
      TextEditingController(text: '1');

  final List<WaterIntakeInfo> _waterIntakeInfoList = [];

  /*----------------------------------------------------------------------------------------------------------------------*/
  //Functionalities
  void _glassAdder() {
    final int totalGlass = int.tryParse(_tEControllerNumberOfGlass.text) ?? 1;
    final DateTime time = DateTime.now();
    WaterIntakeInfo waterIntakeInfo =
        WaterIntakeInfo(glassesCount: totalGlass, timeInfo: time);
    setState(
      () {
        _waterIntakeInfoList.insert(0, waterIntakeInfo);
        _healthWarning();
      },
    );
  }

  int _totalNumberOfGlass() {
    int total = 0;
    for (WaterIntakeInfo waterIntake in _waterIntakeInfoList) {
      total += waterIntake.glassesCount;
    }
    return total;
  }

  void _addGlasses() {
    _tEControllerNumberOfGlass.text =
        ((int.tryParse(_tEControllerNumberOfGlass.text) ?? 1) + 1).toString();
  }

  void _subGlasses() {
    if (int.parse(_tEControllerNumberOfGlass.text) > 1) {
      _tEControllerNumberOfGlass.text =
          ((int.tryParse(_tEControllerNumberOfGlass.text) ?? 1) - 1).toString();
    }
  }

  String _isItHigherThanEightGlass() {
    int total = 0;
    for (WaterIntakeInfo waterIntake in _waterIntakeInfoList) {
      total += waterIntake.glassesCount;
    }
    if (total >= 8) {
      return '8 glasses of water per day goal is completed!';
    } else {
      return '';
    }
  }

  String _waterConsumptionInLitter({required int serialNo}) {
    double glassToLitter = (_waterIntakeInfoList[serialNo].glassesCount / 4);
    return "${glassToLitter.toStringAsFixed(2)} Litter";
  }

  void _healthWarning() {
    if (_totalNumberOfGlass() > 16) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: const Color(0xff299FD5),
            title: const Row(
              children: [
                Icon(
                  Icons.warning_amber_rounded,
                  color: Colors.white,
                ),
                Text(
                  ' Health hazard!',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            content: const Text(
              'Drinking more than 16 glasses of water per day is very harmful for your health!\nIt could potentially lead to water intoxication or hyponatremia, particularly if it\'s consumed rapidly.',
              style: TextStyle(color: Colors.white, fontSize: 15),
            ),
            actions: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: const Color(0xff299FD5)),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  'Understood',
                ),
              )
            ],
          );
        },
      );
    }
  }

  /*----------------------------------------------------------------------------------------------------------------------*/
  //Widgets
  FloatingActionButton _buildBuildFabBmiScreenNavigator() {
    return FloatingActionButton(
      onPressed: () {
        Navigator.push(
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
    );
  }

  Expanded _waterConsumptionHistory() {
    return Expanded(
      child: ListView.builder(
        itemCount: _waterIntakeInfoList.length,
        itemBuilder: (context, i) {
          return ListTile(
            leading: _serialNumber(i),
            title: _dateAndTime(i),
            trailing: _waterConsumptionInLitterUnit(i),
          );
        },
      ),
    );
  }

  Text _waterConsumptionInLitterUnit(int i) {
    return Text(
      _waterConsumptionInLitter(serialNo: i),
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: Colors.blue[700],
      ),
    );
  }

  Text _dateAndTime(int i) {
    return Text(
      DateFormat.yMMMEd().add_jms().format(_waterIntakeInfoList[i].timeInfo),
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: Colors.blue[700],
      ),
    );
  }

  CircleAvatar _serialNumber(int i) {
    return CircleAvatar(
      backgroundColor: const Color(0xff299FD5),
      foregroundColor: Colors.white,
      child: Text(
        (i + 1).toString(),
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
      ),
    );
  }

  Padding _horizontalLine(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.sizeOf(context).width / 23),
      child: const Divider(
        height: 15,
      ),
    );
  }

  Padding _historyAndTotalGlassIndicator(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.sizeOf(context).width / 23),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'History',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.blue[700],
            ),
          ),
          Text(
            'Total: ${_totalNumberOfGlass()} Glass/ ${_totalNumberOfGlass() / 4} L',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.blue[700],
            ),
          ),
        ],
      ),
    );
  }

  Padding _eightGlassMilestoneChecker() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Text(
        _isItHigherThanEightGlass(),
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Colors.blue[700],
        ),
      ),
    );
  }

  Padding _glassNumberInputSection() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: _subGlasses,
            icon: const Icon(
              Icons.horizontal_rule,
              color: Color(0xff299FD5),
            ),
          ),
          SizedBox(
            width: 90,
            child: _noOfGlassTF(),
          ),
          IconButton(
            onPressed: _addGlasses,
            icon: const Icon(
              Icons.add,
              color: Color(0xff299FD5),
            ),
          ),
        ],
      ),
    );
  }

  TextField _noOfGlassTF() {
    return TextField(
      cursorColor: const Color(0xff299FD5),
      enabled: false,
      textAlign: TextAlign.center,
      style: const TextStyle(
        color: Color(0xff299FD5),
        fontWeight: FontWeight.w500,
      ),
      controller: _tEControllerNumberOfGlass,
      decoration: const InputDecoration(
        labelStyle: TextStyle(
          color: Color(0xff299FD5),
          fontWeight: FontWeight.w600,
        ),
        labelText: 'No. of GLASS',
        contentPadding: EdgeInsets.all(5),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xff299FD5),
            width: 2,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xff299FD5),
            width: 1,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xff299FD5),
            width: 2,
          ),
        ),
      ),
    );
  }

  GestureDetector _tapHereButton(BuildContext context) {
    return GestureDetector(
      onTap: _glassAdder,
      child: Center(
        child: Padding(
          padding: EdgeInsets.only(top: MediaQuery.sizeOf(context).height / 20),
          child: Stack(
            alignment: Alignment.center,
            children: [_waterAnimation(context), _tapHereText()],
          ),
        ),
      ),
    );
  }

  Column _tapHereText() {
    return const Column(
      children: [
        Icon(
          Icons.water_drop_outlined,
          color: Colors.black54,
          size: 28,
          shadows: [],
        ),
        Text(
          '_Tap Here_',
          style: TextStyle(
              fontSize: 16, color: Colors.black54, fontWeight: FontWeight.w500),
        )
      ],
    );
  }

  LottieBuilder _waterAnimation(BuildContext context) {
    return Lottie.asset(
      'assets/animations/waterAnimation.json',
      width: MediaQuery.sizeOf(context).width / 1.5,
      fit: BoxFit.cover,
      repeat: true,
      frameRate: const FrameRate(90),
    );
  }

  AppBar _waterTrackerAppBar() {
    return AppBar(
      leading: const Icon(Icons.water_drop_rounded),
      title: const Text(
        'Water Intake Tracker',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
      ),
    );
  }

  @override
  void deactivate() {
    super.deactivate();
  }

  @override
  void dispose() {
    _tEControllerNumberOfGlass.dispose();
    super.dispose();
  }
}
