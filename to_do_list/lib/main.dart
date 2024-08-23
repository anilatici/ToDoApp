import 'package:flutter/material.dart';
import 'package:to_do_list/pages/home.dart';

void main() => runApp(MainApp());

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'To Do App',
      home: HomePage(),
    );
  }
}