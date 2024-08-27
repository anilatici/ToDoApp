import 'package:flutter/material.dart';
import 'package:to_do_list/models/task.dart';

class IncompleteTasksScreen extends StatelessWidget {
  final List<Task> tasks;

  const IncompleteTasksScreen({super.key, required this.tasks});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Incomplete Tasks"),
      ),
      body: incompletedTasksList(),
    );
  }

  Widget incompletedTasksList() {

    final incompleteTasks = tasks.where((task) => !task.isComplete).toList();

    return ListView.builder(
      itemCount: incompleteTasks.length,
      itemBuilder: (context, index) {
        final task = incompleteTasks[index];
        return ListTile(
          title: Text(task.title),
          subtitle: Text(task.description),
          trailing: Icon(
            Icons.check_box_outline_blank,
            color: Colors.grey,
          ),
        );
      },
    );
  }
}
