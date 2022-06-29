import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/models/subtask.dart';
import 'package:todo_app/models/todo.dart';
import 'package:todo_app/ui/widgets/sub_task_list.dart';
import 'package:todo_app/ui/widgets/task_list.dart';

class SubTaskScreen extends StatelessWidget {
  final Todo todo;
  static List<SubTask> todoSubTasks = [
    SubTask(
        title: 'SubTask',
        description: 'description',
        mandatory: true,
        status: false),
    SubTask(
        title: 'SubTask',
        description: 'description',
        mandatory: true,
        status: false)
  ];
  const SubTaskScreen({Key? key, required this.todo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(todo.title),
      ),
      body:
          Column(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
        Text("\nWeight: " + todo.weight.toStringAsPrecision(2) + "\n"),
        Text(
          'Your next milestone',
        ),
        Text(DateFormat('dd/MM/yyyy H:m').format(todo.deadline)),
        SubTaskList(todoSubTasks),
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // _showAddTaskPopUp();
        },
        tooltip: 'Add a task',
        child: const Icon(Icons.add),
      ),
    );
  }
}
