import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'shop.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    // user表
    await db.execute('''
      CREATE TABLE users(
        id INTEGER PRIMARY KEY,
        username TEXT,
        email TEXT,
        password TEXT
      )
    ''');
    // cart表
    await db.execute('''
      CREATE TABLE cart(
        id TEXT PRIMARY KEY, 
        productImage TEXT,
        productName TEXT,
        productPrice TEXT,
        quantity INTEGER
      )
    ''');
  }
}
