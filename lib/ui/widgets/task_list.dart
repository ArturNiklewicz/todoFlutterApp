import 'dart:core';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/models/todo.dart';
import 'package:todo_app/ui/screens/subtask_screen.dart';

class TaskList extends StatelessWidget {
  // Creating variables
  List<Todo>? tasks;
  // Initialization of variables
  TaskList(this.tasks, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: tasks == null
            // Display when 0 tasks
            ? Text(
                'You have not added any tasks yet 😔😪',
              )
            // Display the tasks
            : ListView.builder(
                itemCount: tasks!.length,
                itemBuilder: (context, index) {
                  return TaskCard(
                    task: tasks![index],
                  );
                  // return TaskCard();
                },
                // In this example, each String is on its own l
              ));
  }
}

class TaskCard extends StatefulWidget {
  // Creating variables
  Todo task;
  // Variable initialization
  TaskCard({Key? key, required this.task}) : super(key: key);

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  @override
  Widget build(BuildContext context) {
    // Creating variables holding screen's size for the tasks' size
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    // Color switching for Checkboxes
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

    // Building the TaskCard
    return GestureDetector(
      child: SizedBox(
        height: screenHeight / 5, // Five tasks is the optimal number of tasks
        width: screenWidth,
        child: Card(
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            Checkbox(
                checkColor: Colors.white,
                fillColor: MaterialStateProperty.resolveWith(getColor),
                value: widget.task.status,
                onChanged: (bool? value) {
                  setState(() {
                    widget.task.status = value!;
                  });
                }),
            Text('Weight: ' + widget.task.weight.toStringAsPrecision(2)),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FittedBox(
                  child: Text(widget.task.title,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                ),
                Column(
                  children: [
                    Text(
                      'Your next milestone',
                    ),
                    Text(DateFormat('dd/MM/yyyy H:m')
                        .format(widget.task.deadline)),
                  ],
                )
              ],
            )
          ]),
        ),
      ),
      // Navigaiton to the SubTaskScreen
      onTap: () {
        // Go to SubTaskScreen
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => SubTaskScreen(todo: widget.task)),
        );
      },
    );
  }
}
