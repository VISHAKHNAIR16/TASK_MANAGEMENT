import 'package:task_management/models/task.dart';

class TaskList {
  final List<Task>? data;

  TaskList({required this.data});

  factory TaskList.initial() => TaskList(data: []);

  TaskList copyWith({List<Task>? data}) =>
      TaskList(data: data ?? this.data);
}
