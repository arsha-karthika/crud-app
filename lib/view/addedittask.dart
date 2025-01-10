import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/TaskController.dart';
import '../model/task.dart';

class AddEditTaskScreen extends StatelessWidget {
  final TaskController taskController = Get.put(TaskController());
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  bool isEditMode = false;
  Task? taskToEdit;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEditMode ? 'Edit Task' : 'Add Task'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
            DropdownButton<String>(
              value: 'High',
              onChanged: (value) {},
              items: [
                DropdownMenuItem(child: Text('High'), value: 'High'),
                DropdownMenuItem(child: Text('Medium'), value: 'Medium'),
                DropdownMenuItem(child: Text('Low'), value: 'Low'),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                final task = Task(
                  id: '',
                  title: titleController.text,
                  description: descriptionController.text,
                  dueDate: DateTime.now(),
                  priority: 'High',
                  status: 'Pending',
                );
                if (isEditMode) {
                  taskController.editTask(task);
                } else {
                  taskController.addTask(task);
                }
                Get.back();
              },
              child: Text(isEditMode ? 'Update Task' : 'Add Task'),
            ),
          ],
        ),
      ),
    );
  }
}
