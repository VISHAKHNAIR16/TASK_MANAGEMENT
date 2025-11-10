import 'package:flutter/material.dart';
import 'package:task_management/controllers/home_screen_controller.dart';
import 'package:task_management/models/task.dart';

class TaskListTitle extends StatelessWidget {
  final Task task;
  final HomeScreenController controller;

  const TaskListTitle({
    super.key,
    required this.task,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final int num = task.type;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Small color dot (status or category indicator)
          Container(
            width: 8,
            height: 8,
            margin: const EdgeInsets.only(top: 6),
            decoration: const BoxDecoration(
              color: Colors.purple,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 12),

          // Task details (title + time)
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  task.content,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.calendar_today_outlined,
                        size: 16, color: Colors.black54),
                    const SizedBox(width: 6),
                    Text(
                      num.toString(), // Replace with task.timestamp if available
                      style: const TextStyle(
                        fontSize: 13,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
