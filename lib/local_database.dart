import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'other_classes/data_model.dart';

class LocalDatabase {
  static Future<void> insertToDB(WaterIntakeInfo data) async {
    final databaseConnection = await openDatabase(
      join(await getDatabasesPath(), 'health_tracker.db'),
    );
    await databaseConnection.insert('water_track', data.toMap());
  }

  static Future<List<WaterIntakeInfo>> fetchFromDB() async {
    List<WaterIntakeInfo> waterIntakeInfoList = [];
    final databaseConnection = await openDatabase(
      join(await getDatabasesPath(), 'health_tracker.db'),
    );
    final List<Map> dataList = await databaseConnection.query('water_track');
    for (final {
          'timeInfo': timeInfo as String,
          'glassesCount': glassesCount as int,
        } in dataList) {
      waterIntakeInfoList.insert(
          0,
          WaterIntakeInfo(
              glassesCount: glassesCount, timeInfo: DateTime.parse(timeInfo)));
    }
    await databaseConnection.close();
    return waterIntakeInfoList;
  }

  static Future<void> deleteAllFromDB() async {
    final databaseConnections = await openDatabase(
      join(await getDatabasesPath(), 'health_tracker.db'),
    );
    await databaseConnections.delete('water_track');
  }
}
