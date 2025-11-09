import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:task_management/models/task.dart';

class DatabaseService {
  static Database? _db;
  static final DatabaseService instance =
      DatabaseService._constructor(); // To make the connection or instance of the database only once

  final String _taskTableName = "tasks";
  final String _tasksIdColumnName = "Id";
  final String _tasksContentColumnName = "content";
  final String _tasksStatusColoumnName = "status";
  final String _tasksPriorityColoumnName = "priority";
  final String _tasksDueDateColumnName = 'duedate';

  DatabaseService._constructor();

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await getDatabase();
    return _db!;
  }

  Future<Database> getDatabase() async {
    final databaseDirPath = await getDatabasesPath();
    final databasePath = join(databaseDirPath, "Tasks_List.db");
    final database = await openDatabase(
      version: 1,
      databasePath,
      onCreate: (db, version) {
        db.execute(''' 
        CREATE TABLE $_taskTableName (
          $_tasksIdColumnName INTEGER PRIMARY KEY,
          $_tasksContentColumnName TEXT NOT NULL,
          $_tasksStatusColoumnName INTEGER NOT NULL,
          $_tasksPriorityColoumnName INTEGER,
          $_tasksDueDateColumnName INTEGER
        );
        ''');
      },
    );

    return database;
  }

  Future<void> addTask(String content,{DateTime? dueDate}) async {
    final db = await database;
    await db.insert(_taskTableName, {
      _tasksContentColumnName: content,
      _tasksStatusColoumnName: 0,
      _tasksPriorityColoumnName: 0,
      _tasksDueDateColumnName: dueDate?.millisecondsSinceEpoch,
    });
  }

  Future<List<Task>?> getTask() async {
    final db = await database;
    final data = await db.query(_taskTableName);
    List<Task> tasks = data
        .map(
          (e) => Task(
            id: e["Id"] as int,
            status: e["status"] as int,
            priority: e["priority"] as int,
            content: e["content"] as String,
            dueDate: e['dueDate'] != null
          ? DateTime.fromMillisecondsSinceEpoch(e['dueDate'] as int)
          : null,
          ),
        )
        .toList();
    print(tasks);
    return tasks;
  }

  void updateTaskStatus(int id, int status) async {
    final db = await database;

    await db.update(
      _taskTableName,
      {_tasksStatusColoumnName: status},
      where: "Id = ?",
      whereArgs: [id],
    );
  }

  void deleteTask(int id) async {
    final db = await database;
    await db.delete(_taskTableName,
    where: "Id = ?",
    whereArgs: [
      id,
    ]
    );

  }
}
