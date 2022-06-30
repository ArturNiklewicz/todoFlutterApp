import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:todo_app/models/subtask.dart';

class SubTaskList extends StatelessWidget {
  // Creating variables
  List<SubTask>? subTasks;
  // Initialization of variables
  SubTaskList(this.subTasks, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: subTasks == null
            // Display when 0 tasks
            ? Text(
                'You have not added any tasks yet 😔😪',
              )
            // Display the tasks
            : ListView.builder(
                shrinkWrap: true,
                itemCount: subTasks!.length,
                itemBuilder: (context, index) {
                  return SubTaskCard(
                    subTask: subTasks![index],
                  );
                  // return TaskCard();
                },
                // In this example, each String is on its own l
              ));
  }
}

class SubTaskCard extends HookWidget {
  // Creating variables
  SubTask subTask;
  // Variable initialization
  SubTaskCard({Key? key, required this.subTask}) : super(key: key);

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
    return SizedBox(
      height: screenHeight / 5, // Five tasks is the optimal number of tasks
      width: screenWidth,
      child: Card(
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          HookBuilder(builder: (_) {
            final toggle = useState(false);
            return Checkbox(
                checkColor: Colors.white,
                fillColor: MaterialStateProperty.resolveWith(getColor),
                value: subTask.status,
                onChanged: (bool? value) {
                  toggle.value = !toggle.value;
                  subTask.status = toggle.value;
                });
          }),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              FittedBox(
                child: Text(subTask.title,
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              ),
            ],
          )
        ]),
      ),
      // Navigaiton to the SubTaskScreen
    );
  }
}
