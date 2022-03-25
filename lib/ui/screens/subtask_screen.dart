import 'package:flutter/material.dart';
import 'package:todo_app/models/subtask.dart';
import 'package:todo_app/models/todo.dart';

class SubTaskScreen extends StatelessWidget {
  const SubTaskScreen({Key? key, required this.todo}) : super(key: key);
  final Todo todo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Second Route'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('The subtasks of: '),
            // Text('The subtasks of: '),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(todo.title),
            ),
          ],
        ), /* SubTaskList(), */
      ),
    );
  }
}

class SubTaskList extends StatefulWidget {
  const SubTaskList({Key? key}) : super(key: key);

  @override
  _SubTaskListState createState() => _SubTaskListState();
}

class _SubTaskListState extends State<SubTaskList> {
  late List<SubTask> ListSubTask;
  bool _value = false;
  int? itemCount = 3;
  @override
  Widget build(BuildContext context) {
    return Text('TaskList');
    /* return ListView.builder(
        itemCount: itemCount,
        itemBuilder: (context, index) => CheckboxListTile(
              title: const Text('GeeksforGeeks'),
              subtitle: const Text('A computer science portal for geeks.'),
              secondary: const Icon(Icons.code),
              autofocus: false,
              activeColor: Colors.green,
              checkColor: Colors.white,
              selected: _value,
              value: _value,
              onChanged: (bool? value) {
                setState(() {
                  _value = value!;
                });
              },
            )); */
  }
}
