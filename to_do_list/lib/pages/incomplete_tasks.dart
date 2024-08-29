import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:to_do_list/models/task.dart';
import 'package:to_do_list/pages/task_in_detail.dart';

class IncompleteTasksScreen extends StatelessWidget {
  final Query _dbRef = FirebaseDatabase.instance
      .ref()
      .child('tasks')
      .orderByChild('isComplete')
      .equalTo(false);

  IncompleteTasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Incomplete Tasks"),
      ),
      body: FirebaseAnimatedList(
        query: _dbRef,
        itemBuilder: (BuildContext context, DataSnapshot snapshot,
            Animation<double> animation, int index) {
          Map<String, dynamic> taskMap = Map<String, dynamic>.from(snapshot.value as Map);
          Task task = Task(
            title: taskMap['title'],
            description: taskMap['description'],
            isComplete: taskMap['isComplete'],
          );
          return ListTile(
            title: Text(task.title),
            subtitle: Text(task.description),
            trailing: Checkbox(
              value: task.isComplete,
              onChanged: (bool? value) {
                FirebaseDatabase.instance
                    .ref()
                    .child('tasks')
                    .child(snapshot.key!)
                    .update({'isComplete': value ?? false});
              },
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      DetailedTaskScreen(task: task, taskID: snapshot.key!),
                ),
              );
            },
          );
        },
      ),
    );
  }
}