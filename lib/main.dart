import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await openDatabase(
    join(await getDatabasesPath(), 'health_tracker.db'),
    onCreate: (Database db, int version) {
      db.execute(
          'CREATE TABLE IF NOT EXISTS water_track(timeInfo TEXT, glassesCount INTEGER)');
    },
    version: 1,
  );
  runApp(const MyApp());
}
