import 'package:flutter_riverpod/legacy.dart';
import 'package:task_management/models/task_list.dart';
import 'package:task_management/repository/task_repository.dart';

class HomeScreenController extends StateNotifier<TaskList> {
  final TaskRepository _repository;

  HomeScreenController(TaskList initialState, this._repository)
      : super(initialState) {
    _loadTasks();
  }

  Future<void> _loadTasks() async {
    final tasks = await _repository.getTasks();
    state = state.copyWith(data: tasks);
  }

  Future<void> addTask(String content, {DateTime? dueDate}) async {
    await _repository.addTask(content, dueDate: dueDate);
    await _loadTasks();
  }

  Future<void> updateTaskStatus(int id, int status) async {
    await _repository.updateTaskStatus(id, status);
    await _loadTasks();
  }

  Future<void> deleteTask(int id) async {
    await _repository.deleteTask(id);
    await _loadTasks();
  }
}
