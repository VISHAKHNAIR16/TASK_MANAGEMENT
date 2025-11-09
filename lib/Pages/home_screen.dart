import 'package:flutter/material.dart';
import 'package:task_management/models/task.dart';
import 'package:task_management/services/database_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final DatabaseService _databaseService = DatabaseService.instance;
  String? _task = null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _floatingButton(),
      body: _tasksList(),
    );
  }

  Widget _tasksList() {
    return FutureBuilder(
      future: _databaseService.getTask(),
      builder: (context, snapshot) {
        return ListView.builder(
          itemCount: snapshot.data?.length ?? 0,
          itemBuilder: (context, index) {
            Task task = snapshot.data![index];
            return ListTile(
              onLongPress: () {
                _databaseService.deleteTask(task.id);
                setState(() {});
              },
              title: Text(task.content),
              trailing: Checkbox(
                value: task.status == 1,
                onChanged: (value) {
                  _databaseService.updateTaskStatus(
                    task.id,
                    value == true ? 1 : 0,
                  );
                  setState(() {});
                },
              ),
            );
          },
        );
      },
    );
  }

  Widget _floatingButton() {
    return FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: () {
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: const Text("Add Task"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  onChanged: (value) {
                    setState(() {
                      _task = value;
                    });
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Add your task...",
                  ),
                ),
                MaterialButton(
                  onPressed: () async {
  if (_task == null || _task!.isEmpty) return;
  await _databaseService.addTask(_task!);
  setState(() {
    _task = null;
  });
  Navigator.pop(context);
},

                  child: Text("Done"),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
