import 'package:flutter/material.dart';
import 'package:todo_app_simple/features/auth/view/login_page.dart';
import 'package:todo_app_simple/features/todo/view/home_page.dart';

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
