import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:task_management/repository/task_repository.dart';
import 'package:task_management/services/database_service.dart';
import 'package:task_management/controllers/home_screen_controller.dart';
import 'package:task_management/models/task_list.dart';

final databaseServiceProvider = Provider<DatabaseService>((ref) => DatabaseService.instance);

final taskRepositoryProvider = Provider<TaskRepository>((ref) => TaskRepository(db: ref.watch(databaseServiceProvider)));

final homeScreenControllerProvider = StateNotifierProvider<HomeScreenController, TaskList>((ref) {
  return HomeScreenController(TaskList.initial(), ref.watch(taskRepositoryProvider));
});
