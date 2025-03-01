import 'package:flutter/material.dart';
import 'package:todo_app_simple/screen/login_page.dart';
import 'package:todo_app_simple/screen/todo_list_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: TodoListPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
