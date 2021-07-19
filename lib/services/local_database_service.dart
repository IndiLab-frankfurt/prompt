import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:async';

// database table and column names
final String tableWords = 'implementationIntentions';
final String columnId = '_id';
final String columnGoal = 'goal';
final String columnHindrance = 'hindrance';

const String TABLE_GOALS = "goals";
const String TABLE_SETTINGS = "settings";
const String TABLE_CACHE = "cache";
const String TABLE_INTERNALISATIONS = "internalisations";
const String TABLE_RECALL = "recall";
const int DB_VERSION = 5;

class LocalDatabaseService {
  LocalDatabaseService._();
  static final LocalDatabaseService db = LocalDatabaseService._();

  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) return _database;

    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "TestDB.db");
    return await openDatabase(path,
        version: DB_VERSION,
        onOpen: (db) {},
        onUpgrade: _onUpgrade,
        onCreate: _onCreate);
  }

  _onCreate(Database db, int version) async {
    await db.execute("CREATE TABLE $TABLE_SETTINGS(key STRING PRIMARY KEY, " +
        // "key STRING, " +
        "value STRING " +
        ")");
  }

//TODO: Write a better migration script
  _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion != newVersion) {
      await db.execute(
          "CREATE TABLE IF NOT EXISTS $TABLE_SETTINGS(key STRING PRIMARY KEY, " +
              // "key STRING, " +
              "value STRING " +
              ")");
    }
  }

  upsertSetting(String key, String value) async {
    final db = await database;
    await db!.insert(TABLE_SETTINGS, {"key": key, "value": value},
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Map<String, dynamic>>> getAllSettings() async {
    final db = await database;

    var existing = await db!.rawQuery("select * from $TABLE_SETTINGS");

    return existing;
  }

  dynamic getSettingsValue(String key) async {
    final db = await database;
    var existing;
    try {
      existing = await db!
          .rawQuery("SELECT value FROM $TABLE_SETTINGS where key = ?", [key]);

      // existing.forEach((row) {
      //   print(row);
      // });
      // existing = await db.query(TABLE_SETTINGS,
      //     columns: ["key", "value"], where: '"key" = ?', whereArgs: [key]);

      if (existing == null) return null;
      if (existing.length == 0) return null;
      return existing.first["value"];
    } on Exception catch (e) {
      print("Could not retrieve setting $key, error ${e.toString()}");
      return null;
    }
  }

  deleteSetting(String key) async {
    final db = await database;

    await db!.delete(TABLE_SETTINGS, where: "key = ?", whereArgs: [key]);
  }

  clearDatabase() async {
    final Database db = (await database)!;

    await db.delete(TABLE_GOALS);
  }

  clearUser() async {
    // final Database db = await database;

    // await db.delete(TABLE_GOALS, where: "id = ?", whereArgs: [goal.id]);
  }
}
