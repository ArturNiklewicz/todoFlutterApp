import 'package:flutter/material.dart';
import 'package:todo_app/models/todo.dart';
import 'package:todo_app/ui/widgets/new_task.dart';
import 'package:todo_app/ui/widgets/task_list.dart';

import '../../database/todos_database.dart';

class TodosScreen extends StatefulWidget {
  TodosScreen({Key? key}) : super(key: key);

  @override
  State<TodosScreen> createState() => _TodosScreenState();
}

class _TodosScreenState extends State<TodosScreen> {
  final String title = "#1 TODO App";
  late List<Todo> todos;
  bool isLoading = false;
  double _weight = 1.0;

  void initState() {
    super.initState();
    refreshTodos();
  }

  void dispose() {
    super.dispose();
    TodosDatabase.instance.close();
  }

  Future refreshTodos() async {
    setState(() => isLoading = true);
    this.todos = await TodosDatabase.instance.readAllTodos();
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: isLoading
          ? CircularProgressIndicator()
          : todos.isEmpty
              ? Text("No todos")
              : TaskList(todos),
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

  Future addTodo(
      String title, double weight, DateTime milestone, bool status) async {
    final newTodo = Todo(
        title: title,
        weight: weight,
        milestone: milestone.toString().isEmpty ? today : milestone,
        status: status);
    await TodosDatabase.instance.create(newTodo);
  }

  @override
  Widget build(BuildContext context) {
    return NewTask(addTodo);
  }
}
