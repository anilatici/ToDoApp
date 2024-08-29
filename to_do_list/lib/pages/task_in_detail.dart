import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:to_do_list/models/task.dart';

class DetailedTaskScreen extends StatelessWidget {

  final Task task;
  final String taskID;

  const DetailedTaskScreen({super.key, required this.task, required this.taskID});


  
@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Task Details"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              task.title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              task.description,
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Text("Status: "),
                Text(
                  task.isComplete ? "Completed" : "Incomplete",
                  style: TextStyle(
                    color: task.isComplete ? Colors.green : Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    FirebaseDatabase.instance
                        .ref()
                        .child('tasks')
                        .child(taskID)
                        .update({'isComplete': !task.isComplete}).then((_) {
                      Navigator.pop(context);
                    });
                  },
                  child: Text(task.isComplete ? "Mark as Incomplete" : "Mark as Complete"),
                ),
                ElevatedButton(
                  onPressed: () {
                    FirebaseDatabase.instance
                        .ref()
                        .child('tasks')
                        .child(taskID)
                        .remove().then((_) {
                      Navigator.pop(context);
                    });
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  child: const Text("Delete Task"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}