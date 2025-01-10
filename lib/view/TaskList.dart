import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/TaskController.dart';
import '../model/task.dart';

class TaskListScreen extends StatelessWidget {
  final TaskController taskController = Get.put(TaskController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task Manager'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Get.toNamed('/taskAdd');
            },
          ),
        ],
      ),
      body: Obx(
            () {
          if (taskController.tasks.isEmpty) {
            return Center(child: CircularProgressIndicator());
          }

          return ListView.builder(
            itemCount: taskController.tasks.length,
            itemBuilder: (context, index) {
              Task task = taskController.tasks[index];
              return ListTile(
                title: Text(task.title),
                subtitle: Text('Due: ${task.dueDate.toString()}'),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    taskController.deleteTask(task.id);
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
