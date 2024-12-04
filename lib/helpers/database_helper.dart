import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/item.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  static Database? _database;

  DatabaseHelper._privateConstructor();

  // Initialize or get the database
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  // Create database and table
  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    return openDatabase(
      join(dbPath, 'items.db'),
      version: 1,
      onCreate: (db, version) {
        return db.execute('''
          CREATE TABLE items (
            id INTEGER PRIMARY KEY,
            name TEXT
          )
        ''');
      },
    );
  }

  // Insert items into the database
  Future<void> insertItems(List<Item> items) async {
    final db = await database;
    await db.delete('items'); // Clear old data
    for (var item in items) {
      await db.insert('items', item.toMap());
    }
  }

  // Retrieve items from the database
  Future<List<Item>> getItems() async {
    final db = await database;
    final maps = await db.query('items');
    return List.generate(maps.length, (i) => Item.fromMap(maps[i]));
  }
}
