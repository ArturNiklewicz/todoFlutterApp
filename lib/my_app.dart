import 'package:flutter/material.dart';
import 'package:todo_app/ui/screens/todos_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/home',
      routes: {
        '/home': (context) => TodosScreen(),
      },
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
    );
  }
}
