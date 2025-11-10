import 'package:logger/logger.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:task_management/models/task.dart';

class DatabaseService {
  static Database? _db;
  static final DatabaseService instance =
      DatabaseService._constructor(); // To make the connection or instance of the database only once

  final logger = Logger();

  final String _taskTableName = "tasks";
  final String _tasksIdColumnName = "Id";
  final String _tasksContentColumnName = "content";
  final String _tasksStatusColoumnName = "status";
  final String _tasksPriorityColoumnName = "priority";
  final String _tasksDueDateColumnName = 'duedate';

  DatabaseService._constructor();

  Future<T?> _handleError<T>(
    Future<T> Function() dbOperation,
    String errorMessage,
  ) async {
    try {
      return await dbOperation();
    } catch (e, stacktrace) {
      logger.e(errorMessage, error: e, stackTrace: stacktrace);
      return null;
    }
  }

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await getDatabase();
    return _db!;
  }

  Future<Database> getDatabase() async {
    final databaseDirPath = await getDatabasesPath();
    final databasePath = join(databaseDirPath, "Tasks_List.db");
    final database = await openDatabase(
      databasePath,
      version: 2, 
      onCreate: (db, version) async {
        await db.execute('''
      CREATE TABLE $_taskTableName (
        $_tasksIdColumnName INTEGER PRIMARY KEY,
        $_tasksContentColumnName TEXT NOT NULL,
        $_tasksStatusColoumnName INTEGER NOT NULL,
        $_tasksPriorityColoumnName INTEGER,
        $_tasksDueDateColumnName INTEGER
      );
    ''');
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 2) {
          await db.execute(
            'ALTER TABLE $_taskTableName ADD COLUMN $_tasksDueDateColumnName INTEGER;',
          );
        }
      },
    );
    return database;
  }

  Future<void> addTask(String content, {DateTime? dueDate}) async {
    await _handleError<void>(() async {
      final db = await database;
      await db.insert(_taskTableName, {
        _tasksContentColumnName: content,
        _tasksStatusColoumnName: 0,
        _tasksPriorityColoumnName: 0,
        _tasksDueDateColumnName: dueDate?.millisecondsSinceEpoch,
      });
    }, "Failed To Add Task");
  }

  Future<List<Task>?> getTask() async {
    return await _handleError<List<Task>>(() async {
      final db = await database;
      final data = await db.query(_taskTableName);
      return data
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
    }, "Error while getting tasks");
  }

  Future<void> updateTaskStatus(int id, int status) async {
    await _handleError<void>(() async {
      final db = await database;
      await db.update(
        _taskTableName,
        {_tasksStatusColoumnName: status},
        where: "Id = ?",
        whereArgs: [id],
      );
    }, "Error While Updating Status in tasks");
  }

  Future<void> deleteTask(int id) async {
    await _handleError<void>(() async {
      final db = await database;
      await db.delete(_taskTableName, where: "Id = ?", whereArgs: [id]);
    }, "Error While Deleting a task");
  }
}
