import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/models/subtask.dart';
import 'package:todo_app/models/todo.dart';

class SubTaskScreen extends StatelessWidget {
  final Todo todo;
  const SubTaskScreen({Key? key, required this.todo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(todo.title),
      ),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text("\nWeight: " + todo.weight.toStringAsPrecision(2) + "\n"),
              Text(
                'Your next milestone',
              ),
              Text(DateFormat('dd/MM/yyyy H:m').format(todo.deadline))
            ]),
      ),
    );
  }
}
