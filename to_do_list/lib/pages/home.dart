import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:to_do_list/models/task.dart';
import 'package:to_do_list/pages/complete_tasks.dart';
import 'package:to_do_list/pages/incomplete_tasks.dart';
import 'package:reorderables/reorderables.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  final List<Task> _incompletedTasks = [];
  final List<Task> _completedTasks = [];
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  late final DatabaseReference _dbRef =
      FirebaseDatabase.instance.ref().child("tasks");

  void _addTask() {
    final taskTitle = _titleController.text;
    final taskDescription = _descriptionController.text;
    if (taskTitle.isNotEmpty && taskDescription.isNotEmpty) {
      setState(() {
        _dbRef.push().set({
          "title": taskTitle,
          "description": taskDescription,
          "isComplete": false,
        });
        _titleController.clear();
        _descriptionController.clear();
      });
    }
  }

// set the task as complete or incomplete
  void _completeTask(Task task) {
    setState(() {
      if (task.isComplete) {
        _completedTasks.remove(task);
        task.isComplete = false;
        _incompletedTasks.add(task);
      } else {
        _incompletedTasks.remove(task);
        task.isComplete = true;
        _completedTasks.add(task);
      }
    });
  }

  Future<void> _formPopup(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Enter Task Details"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(
                  hintText: "What would you like to do?",
                ),
              ),
              const SizedBox(height: 8.0),
              TextField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  hintText: "Please describe the task.",
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                _addTask();
                Navigator.of(context).pop();
              },
              child: const Text("Submit"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cancel"),
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
    body: IndexedStack(
      index: _selectedIndex,
      children: [
        _taskList(),
        CompletedTasksScreen(),
        IncompleteTasksScreen(),
      ],
    ),
    floatingActionButton: FloatingActionButton(
      onPressed: () {
        _formPopup(context);
      },
      child: const Icon(Icons.add),
    ),
    bottomNavigationBar: BottomNavigationBar(
      currentIndex: _selectedIndex,
      onTap: (int index) {
        setState(() {
          _selectedIndex = index;
        });
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.check),
          label: 'Completed',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.clear),
          label: 'Incomplete',
        ),
      ],
    ),
  );
}


  // Drawer test(BuildContext context) {
  //   return Drawer(
  //       child: ListView(padding: EdgeInsets.zero, children: [
  //     SizedBox(
  //       height: 125.0,
  //       child: DrawerHeader(
  //         decoration: ShapeDecoration(
  //             color: Colors.grey,
  //             shape: SmoothRectangleBorder(
  //                 borderRadius: SmoothBorderRadius(
  //               cornerRadius: 10,
  //               cornerSmoothing: 0.5,
  //             ))),
  //         child: const Text('To Do Menu'),
  //       ),
  //     ),
  //     ListTile(
  //       title: const Text('Home Page'),
  //       onTap: () {
  //         Navigator.push(
  //           context,
  //           MaterialPageRoute(builder: (context) => const HomePage()),
  //         );
  //       },
  //     ),
  //     ListTile(
  //       title: const Text('Incomplete Tasks'),
  //       onTap: () {
  //         Navigator.push(
  //           context,
  //           MaterialPageRoute(builder: (context) => IncompleteTasksScreen()),
  //         );
  //       },
  //     ),
  //     ListTile(
  //       title: const Text('Completed Tasks'),
  //       onTap: () {
  //         Navigator.push(
  //           context,
  //           MaterialPageRoute(builder: (context) => CompletedTasksScreen()),
  //         );
  //       },
  //     ),
  //   ]));
  // }

// display tasks by mapping through the list based on their completion status
  Widget _taskList() {
    return ListView(
      children: [
        if (_incompletedTasks.isNotEmpty) ...[
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Incomplete Tasks",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          ..._incompletedTasks.map((task) => TaskWidget(
                task: task,
                onComplete: _completeTask,
              )),
        ],
        if (_completedTasks.isNotEmpty) ...[
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Completed Tasks",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          ..._completedTasks.map((task) => TaskWidget(
                task: task,
                onComplete: _completeTask,
              )),
        ],
      ],
    );
  }

  AppBar MyAppBar() {
    return AppBar(
      title: const Text(
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
    );
  }
}

// widget to display the tasks
class TaskWidget extends StatelessWidget {
  final Task task;
  final Function(Task) onComplete;

  const TaskWidget({required this.task, required this.onComplete, super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(task.title),
      subtitle: Text(task.description),
      leading: Checkbox(
        value: task.isComplete,
        onChanged: (_) => onComplete(task),
      ),
      onTap: () => onComplete(task),
    );
  }
}
