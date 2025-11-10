import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_management/controllers/home_screen_controller.dart';
import 'package:task_management/controllers/providers.dart';
import 'package:task_management/models/task_list.dart';
import 'package:task_management/widgets/task_list_title.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final taskList = ref.watch(homeScreenControllerProvider);
    final controller = ref.read(homeScreenControllerProvider.notifier);

    return Scaffold(
      appBar: _customAppBar(context),
      floatingActionButton: _floatingButton(context, controller),
      body: _tasksList(taskList, controller),
    );
  }

  Widget _floatingButton(
    BuildContext context,
    HomeScreenController controller,
  ) {
    return FloatingActionButton(
      onPressed: () {
        _showAddTaskDialog(context, controller);
      },
      child: Icon(Icons.add),
    );
  }

  PreferredSizeWidget _customAppBar(BuildContext context) {
    final double height = MediaQuery.of(context).size.height * 0.14;

    return PreferredSize(
      preferredSize: Size.fromHeight(height),
      child: SafeArea(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(30),
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Row (Hello + Notification)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "Hello, Mo",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "Welcome Back",
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.notifications_none_outlined,
                      size: 28,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showAddTaskDialog(
    BuildContext context,
    HomeScreenController controller,
  ) {
    String? inputTask;

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Add Task'),
        content: TextField(
          onChanged: (value) {
            inputTask = value;
          },
          decoration: InputDecoration(hintText: 'Task description'),
        ),
        actions: [
          TextButton(
            onPressed: () async {
              if (inputTask != null && inputTask!.isNotEmpty) {
                await controller.addTask(inputTask!);
                Navigator.pop(context);
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  Widget _tasksList(TaskList taskList, HomeScreenController controller) {
    final tasks = taskList.data ?? [];

    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                final task = tasks[index];
                return TaskListTitle(task: task, controller: controller);
              },
            ),
          ),
        ],
      ),
    );
  }

  // Widget _taskListTile(Task task, HomeScreenController controller) {
  //   return ListTile(
  //     title: Text(task.content),
  //     trailing: Checkbox(
  //       value: task.status == 1,
  //       onChanged: (bool? value) {
  //         controller.updateTaskStatus(task.id, value == true ? 1 : 0);
  //       },
  //     ),
  //     onLongPress: () {
  //       controller.deleteTask(task.id);
  //     },
  //   );
  // }
}
