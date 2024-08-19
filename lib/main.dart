import 'package:flutter/material.dart';
import 'package:health_tracker/other_classes/data_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //Open database
  final db = await openDatabase(
    join(await getDatabasesPath(), 'health_tracker.db'),
    onCreate: (Database db, int version) {
      db.execute(
          'CREATE TABLE IF NOT EXISTS water_track(timeInfo TEXT, glassesCount INTEGER)');
    },
    version: 1,
  );
  //fetch from database
  List<Map> dataList = await db.query('water_track');
  List<WaterIntakeInfo> waterIntakeInfoList = [];
  for (final {
        'timeInfo': timeInfo as String,
        'glassesCount': glassesCount as int,
      } in dataList) {
    waterIntakeInfoList.insert(
        0,
        WaterIntakeInfo(
            glassesCount: glassesCount, timeInfo: DateTime.parse(timeInfo)));
  }
  //check time and delete
  if (waterIntakeInfoList.isNotEmpty) {
    if (waterIntakeInfoList.last.timeInfo.day != DateTime.now().day ||
        waterIntakeInfoList.last.timeInfo.month != DateTime.now().month ||
        waterIntakeInfoList.last.timeInfo.year != DateTime.now().year) {
      await db.delete('water_track');
    }
  }
  runApp(const MyApp());
}
