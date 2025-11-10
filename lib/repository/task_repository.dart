import 'package:task_management/models/task.dart';
import 'package:task_management/services/database_service.dart';

class TaskRepository {
  final DatabaseService db;

  TaskRepository({required this.db});

  Future<List<Task>?> getTasks() => db.getTask();
  Future<void> addTask(String content, {DateTime? dueDate}) => db.addTask(content, dueDate: dueDate);
  Future<void> updateTaskStatus(int id, int status) => db.updateTaskStatus(id, status);
  Future<void> deleteTask(int id) => db.deleteTask(id);
}
