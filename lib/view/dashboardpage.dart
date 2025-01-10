import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/TaskController.dart';
import '../controller/Theme.dart'; // Create TaskController to manage tasks

class DashboardScreen extends StatelessWidget {
  final TaskController taskController = Get.put(TaskController());
  final ThemeController themeController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Dashboard')),
      body: Column(
        children: [
          Obx(() {
            return Text('Pending: ${taskController.pendingTasks.length}');
          }),
          Obx(() {
            return Text('In Progress: ${taskController.inProgressTasks.length}');
          }),
          Obx(() {
            return Text('Completed: ${taskController.completedTasks.length}');
          }),
          ElevatedButton(
            onPressed: () {
              Get.toNamed('/taskAdd'); // Navigate to task adding screen
            },
            child: Text('Add Task'),
          ),
        ],
      ),
    );
  }
}
