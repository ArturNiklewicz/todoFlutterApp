import 'package:flutter/material.dart';
import 'package:todo_app/models/subtask.dart';
import 'package:todo_app/models/todo.dart';

class SubTaskScreen extends StatelessWidget {
  // final Todo todo;
  // const SubTaskScreen({Key? key, required this.todo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hej' /* todo.title */),
      ),
      body: Text('Dupa'),
      /* Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('The subtasks of: '),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(todo.weight.toStringAsPrecision(2)),
          ),
        ],
      ), */
    );
  }
}
