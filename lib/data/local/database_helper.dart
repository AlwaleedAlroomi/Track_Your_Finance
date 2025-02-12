import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();

  factory DatabaseHelper() {
    return _instance;
  }

  DatabaseHelper._internal();

  static Database? _database;
  final categoriesTableName = "categories";
  final accountsTableName = 'accounts';
  final wishlistTableName = 'wishlist';

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDataBase();
    return _database!;
  }

  Future<Database> _initDataBase() async {
    final dbDirPath = await getDatabasesPath();
    final dbPath = join(dbDirPath, "financial_tracker.db");

    return await openDatabase(
      dbPath,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $categoriesTableName (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        color INTEGER NOT NULL,
        icon INTEGER NOT NULL
      )
    ''');
    await db.execute('''
      CREATE TABLE $accountsTableName (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        accountName VARCHAR(255) NOT NULL,
        balance REAL NOT NULL 
      )
    ''');
    await db.execute('''
      CREATE TABLE $wishlistTableName (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        goalAmount REAL NOT NULL,
        currentAmount REAL NOT NULL,
        imageURL VARCHAR(255) NOT NULL,
        dueDate TEXT NOT NULL,
        isCompleted INTEGER NOT NULL,
        imageURL TEXT
      )
    ''');
  }
}
