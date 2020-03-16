import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class DatabaseProvider {
  static const String TABLE_FOOD = "food";
  static const String COLUMN_ID = "id";
  static const String COLUMN_NAME = "name";
  static const String COLUMN_CALORIES = "calories";
  static const String COLUMN_VEGETARIAN = "isVegetarian";

  DatabaseProvider._();

  static final DatabaseProvider db = DatabaseProvider._();

  Database _database;

  Future<Database> get database async {
    print("Database Getter Called .");
    if (_database != null) {
      return _database;
    }
    _database = await createDatabase();
  }

  Future<Database> createDatabase() async {
    String dbPath = await getDatabasesPath();
    return await openDatabase(join(dbPath, 'foodDB.db'), version: 1,
        onCreate: (Database database, version) async {
      print("Database Created.");
      await database.execute(
        "CREATE TABLE $TABLE_FOOD "
        "$COLUMN_ID INTEGER PRIMARY KEY,"
        "$COLUMN_NAME TEXT,"
        "$COLUMN_CALORIES TEXT,"
        "$COLUMN_VEGETARIAN TEXT,"
        ")",
      );
    });
  }
}
