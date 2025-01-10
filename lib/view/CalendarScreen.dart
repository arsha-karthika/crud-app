import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

import '../controller/TaskController.dart';

class CalendarScreen extends StatelessWidget {
  final TaskController taskController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calendar View'),
      ),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2025, 1, 1),
            focusedDay: DateTime.now(),
            calendarFormat: CalendarFormat.month,
            eventLoader: (date) {
              return taskController.tasks
                  .where((task) => task.dueDate.year == date.year && task.dueDate.month == date.month && task.dueDate.day == date.day)
                  .toList();
            },
            onDaySelected: (selectedDay, focusedDay) {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('Add Task for ${selectedDay.toLocal()}'),
                  content: TextField(
                    decoration: InputDecoration(labelText: 'Task Title'),
                    onSubmitted: (value) {
                      // Add your task adding logic here
                      Navigator.pop(context);
                    },
                  ),
                ),
              );
            },
          ),
          Expanded(
            child: ListView.builder(
              itemCount: taskController.tasks.length,
              itemBuilder: (context, index) {
                var task = taskController.tasks[index];
                return ListTile(
                  title: Text(task.title),
                  subtitle: Text('Due: ${task.dueDate}'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
