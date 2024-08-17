import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'other_classes/data_model.dart';

class LocalDatabase {
  static Future<void> insertToDB(WaterIntakeInfo data) async {
    final databaseConnection = openDatabase(
      join(await getDatabasesPath(), 'health_tracker.db'),
      onCreate: (Database db, int version) {
        db.execute(
            'CREATE TABLE water_track(timeInfo TEXT, glassesCount INTEGER)');
      },
      version: 1,
    );
    final db = await databaseConnection;
    db.insert('water_track', data.toMap());
  }

  static Future<List<WaterIntakeInfo>> fetchFromDB() async {
    List<WaterIntakeInfo> waterIntakeInfoList = [];
    final databaseConnection = openDatabase(
      join(await getDatabasesPath(), 'health_tracker.db'),
      onCreate: (Database db, int version) {
        db.execute(
            'CREATE TABLE water_track(timeInfo TEXT, glassesCount INTEGER)');
      },
      version: 1,
    );
    final db = await databaseConnection;
    final List<Map> dataList = await db.query('water_track');
    for (final {
          'timeInfo': timeInfo as String,
          'glassesCount': glassesCount as int,
        } in dataList) {
      waterIntakeInfoList.insert(
          0,
          WaterIntakeInfo(
              glassesCount: glassesCount, timeInfo: DateTime.parse(timeInfo)));
    }
    return waterIntakeInfoList;
  }
}
