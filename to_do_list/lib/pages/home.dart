import 'package:flutter/material.dart';
import 'package:to_do_list/models/task.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Task> _tasks = [];
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  void _addTask() {
    final taskTitle = _titleController.text;
    final taskDescription = _descriptionController.text;
    if (taskTitle.isNotEmpty && taskDescription.isNotEmpty) {
      setState(() {
        _tasks.add(Task(title: taskTitle, description: taskDescription));
        _titleController.clear();
        _descriptionController.clear();
      });
    }
  }

  Future<void> _formPopup(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Enter Task Details"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _titleController,
                decoration: InputDecoration(
                  hintText: "What would you like to do?",
                ),
              ),
              SizedBox(height: 8.0),
              TextField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  hintText: "Please describe the task.",
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                _addTask();
                Navigator.of(context).pop(); // Only pop here
              },
              child: Text("Submit"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancel"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: Column(
        children: [
          Expanded(child: _taskList()),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _formPopup(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _taskList() {
    return ListView(
      children: _tasks.map((task) => TaskWidget(task: task)).toList(),
    );
  }

  AppBar MyAppBar() {
    return AppBar(
      title: Text(
        "To Do List App",
        style: TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      leading: GestureDetector(
        onTap: () {},
        child: Container(
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            Icons.menu,
            color: Colors.white,
            size: 24,
          ),
        ),
      ),
    );
  }
}

class TaskWidget extends StatelessWidget {
  final Task task;

  const TaskWidget({required this.task, super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(task.title),
      subtitle: Text(task.description),
      leading: Icon(
        task.isComplete ? Icons.check_box : Icons.check_box_outline_blank,
        color: task.isComplete ? Colors.green : Colors.grey,
      ),
      onTap: () {},
    );
  }
}
