import 'package:flutter/material.dart';

void main() => runApp(MainApp());

// MaterialApp
// Scaffold
// Appbar
// Text
// body: Column
// tasks

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To Do App',
      theme: ThemeData(primarySwatch: Colors.grey),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My To Do List'),
      ),
      body: ListView(
        children: [
          TaskList(),
        ],
      ),
    );
  }
}

class TaskList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Task(label: "Do grocery shopping"),
        Task(label: "Clean the house"),
        Task(label: "Practice the guitar"),
      ],
    );
  }
}

class Task extends StatelessWidget {
  final String label;

  const Task({Key? key, required this.label}) : super(key: key); // Updated constructor

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(onChanged: null, value: false),
        Text(label),
      ],
    );
  }
}
