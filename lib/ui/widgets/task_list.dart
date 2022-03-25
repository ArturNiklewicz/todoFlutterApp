import 'dart:core';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/models/todo.dart';
import 'package:todo_app/ui/screens/homepage.dart';
import 'package:todo_app/ui/screens/subtask_screen.dart';

class TaskList extends StatelessWidget {
  List<Todo>? tasks;
  TaskList(this.tasks, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: tasks == null
            ? Text(
                'You have not added any tasks yet 😔😪',
              )
            : ListView.builder(
                itemCount: tasks!.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    child: TaskCard(
                      taskName: tasks![index].title,
                      taskWeight: tasks![index].weight,
                      taskDeadline: tasks![index].deadline,
                      taskStatus: tasks![index].status,
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  SubTaskScreen(todo: tasks![index])));
                    },
                  );
                  // return TaskCard();
                },
                // In this example, each String is on its own l
              ));
  }
}

class TaskCard extends StatefulWidget {
  String taskName;
  double taskWeight;
  DateTime taskDeadline;
  bool taskStatus = false;

  TaskCard(
      {Key? key,
      required this.taskName,
      required this.taskWeight,
      required this.taskDeadline,
      required this.taskStatus})
      : super(key: key);

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      return Colors.green;
    }

    return GestureDetector(
      onTap: () {
        setState(() {
          // Go to SubTaskScreen
          /* context, '/subtask_screen' */
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Text('dupa')
                // SubTaskScreen(todo: _HomePageState.userTasks[1]),
                ),
          );
        });
      },
      child: SizedBox(
        height: screenHeight / 5,
        width: screenWidth,
        child: Card(
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            Checkbox(
                checkColor: Colors.white,
                fillColor: MaterialStateProperty.resolveWith(getColor),
                value: widget.taskStatus,
                onChanged: (bool? value) {
                  setState(() {
                    widget.taskStatus = value!;
                    /*  widget.taskStatus = value!; */
                  });
                }),
            Text('Weight: ' + widget.taskWeight.toStringAsPrecision(2)),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FittedBox(
                  child: Text(widget.taskName,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                ),
                Column(
                  children: [
                    Text(
                      'Your next milestone',
                    ),
                    Text(DateFormat('dd/MM/yyyy H:m')
                        .format(widget.taskDeadline)),
                  ],
                )
              ],
            )
          ]),
        ),
      ),
    );
  }
}
