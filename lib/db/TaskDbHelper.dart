import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../model/task.dart';

class TaskDbHelper {
  static final TaskDbHelper _instance = TaskDbHelper._internal();
  factory TaskDbHelper() => _instance;

  Database? _database;

  TaskDbHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDb();
    return _database!;
  }

  Future<Database> _initDb() async {
    String path = join(await getDatabasesPath(), 'tasks.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  void _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE tasks(
        id TEXT PRIMARY KEY,
        title TEXT,
        description TEXT,
        dueDate TEXT,
        priority TEXT,
        status TEXT
      )
    ''');
  }

  Future<void> insertTask(Task task) async {
    final db = await database;
    await db.insert('tasks', task.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> updateTask(Task task) async {
    final db = await database;
    await db.update('tasks', task.toMap(), where: 'id = ?', whereArgs: [task.id]);
  }

  Future<void> deleteTask(String id) async {
    final db = await database;
    await db.delete('tasks', where: 'id = ?', whereArgs: [id]);
  }

  Future<List<Task>> getTasks() async {
    final db = await database;
    var result = await db.query('tasks');
    return result.map((e) => Task.fromMap(e['id'] as String, e)).toList(); // Cast to String
  }
}
