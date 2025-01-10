import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../controller/TaskController.dart';
import '../model/task.dart';
class TaskDetailPage extends StatelessWidget {
  final Task task;
  final taskController = Get.find<TaskController>();

  TaskDetailPage({required this.task});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Task Details')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(task.title, style: const TextStyle(fontSize: 24)),
            Text(task.description),
            Text('Due Date: ${task.dueDate}'),
            ElevatedButton(
              onPressed: () {
                Task updatedTask = Task(
                  id: task.id,
                  title: 'Updated ${task.title}',
                  description: 'Updated ${task.description}',
                  dueDate: task.dueDate.add(const Duration(days: 1)),
                  priority: task.priority,
                  status: 'In Progress',
                );
                taskController.updateTask( updatedTask,0);
              },
              child: const Text('Mark as Completed'),
            ),
          ],
        ),
      ),
    );
  }
}
