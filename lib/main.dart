import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'screens/home_page.dart';
import 'screens/add_task_page.dart';
import 'screens/task_detail_page.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To-Do App',
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/add': (context) => AddTaskPage(),
        '/details': (context) => TaskDetailPage(),
      },
    );
  }
}
