import 'package:flutter/material.dart';
import 'package:todo_app/models/todo.dart';
import 'package:todo_app/ui/widgets/new_task.dart';
import 'package:todo_app/ui/widgets/task_list.dart';

class TodosScreen extends StatefulWidget {
  const TodosScreen({Key? key}) : super(key: key);

  @override
  State<TodosScreen> createState() => _TodosScreenState();
}

class _TodosScreenState extends State<TodosScreen> {
  final String title = "#1 TODO App";
  double _weight = 1.0;
  static List<Todo> userTasks = [
    Todo(deadline: DateTime.now(), title: 'Dupa', weight: 1, status: false)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: TaskList(userTasks),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddTaskPopUp();
        },
        tooltip: 'Add a task',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void _showAddTaskPopUp() async {
    final selectedWeight = await showDialog<double>(
      context: context,
      builder: (context) => AddTaskPopUp(initialWeight: _weight),
    );

    if (selectedWeight != null) {
      setState(() {
        _weight = selectedWeight;
      });
    }
  }
}

class AddTaskPopUp extends StatefulWidget {
  double? initialWeight;

  AddTaskPopUp({Key? key, this.initialWeight}) : super(key: key);

  @override
  _AddTaskPopUpState createState() => _AddTaskPopUpState();
}

class _AddTaskPopUpState extends State<AddTaskPopUp> {
  DateTime today = DateTime.now();

  void addNewTask(String title, double weight, DateTime deadline, bool status) {
    final newTask = Todo(
        title: title,
        weight: weight,
        deadline: deadline.toString().isEmpty ? today : deadline,
        status: status);

    setState(() {
      _TodosScreenState.userTasks.add(newTask);
    });
    int i = 0;
    bool endOfLoop = i <= _TodosScreenState.userTasks.length;
    for (Todo todo in _TodosScreenState.userTasks) {
      if (endOfLoop == false) {
        print(_TodosScreenState.userTasks[i].toString());
        i++;
      } else {
        break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return NewTask(addNewTask);
  }
}
