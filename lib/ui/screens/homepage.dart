import 'package:flutter/material.dart';
import 'package:todo_app/main.dart';
import 'package:todo_app/ui/widgets/taskCard.dart';

class HomePage extends StatefulWidget {
  static int taskNumber = 0;
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final String title = "#1 TODO App";
  DateTime selectedDate = DateTime.now();
  double _value = 1.0;

  void _incrementCounter() {
    setState(() {
      HomePage.taskNumber++;
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  void _showAddTaskPopUp() async {
    // <-- note the async keyword here

    // this will contain the result from Navigator.pop(context, result)
    final selectedWeight = await showDialog<double>(
      context: context,
      builder: (context) => AddTaskPopUp(initialWeight: _value),
    );

    // execution of this code continues when the dialog was closed (popped)

    // note that the result can also be null, so check it
    // (back button or pressed outside of the dialog)
    if (selectedWeight != null) {
      setState(() {
        _value = selectedWeight;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
          child: ListView.builder(
        itemCount: HomePage.taskNumber,
        itemBuilder: (context, index) {
          return TaskCard();
        },
        // In this example, each String is on its own l
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddTaskPopUp,
        tooltip: 'Add a task',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget _buildPopupDialog(BuildContext context) {
    return AlertDialog(
      title: const TextField(
        decoration: InputDecoration(
            border: OutlineInputBorder(), hintText: "Name of the task"),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Slider(
            min: 0.0,
            max: 10.0,
            value: _value,
            onChanged: (value) {
              setState(() {
                _value = value;
              });
            },
          ),
          Divider(),
          IconButton(
              onPressed: () => _selectDate(context),
              icon: Icon(Icons.calendar_today))
        ],
      ),
      actions: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: Colors.red,
              child: new IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(
                  Icons.close,
                  color: Colors.white,
                ),
              ),
            ),
            CircleAvatar(
              radius: 20,
              backgroundColor: Colors.green,
              child: new IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(
                  Icons.add_task,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}

class AddTaskPopUp extends StatefulWidget {
  /// initial selection for the slider
  double? initialWeight = 1;

  AddTaskPopUp({Key? key, this.initialWeight}) : super(key: key);

  @override
  _AddTaskPopUpState createState() => _AddTaskPopUpState();
}

class _AddTaskPopUpState extends State<AddTaskPopUp> {
  /// current selection of the slider
  double? _value = 0;

  @override
  void initState() {
    super.initState();
    _value = widget.initialWeight;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add a task'),
      content: Column(
        children: [
          Text('Weight: ${_value!.toStringAsPrecision(2)}'),
          Slider(
            min: 0.0,
            max: 10.0,
            value: _value!.toDouble(),
            onChanged: (value) {
              setState(() {
                _value = value;
              });
            },
          ),
        ],
      ),
      actions: <Widget>[
        FlatButton(
          onPressed: () {
            // Use the second argument of Navigator.pop(...) to pass
            // back a result to the page that opened the dialog
            Navigator.pop(context, _value);
          },
          child: Text('DONE'),
        )
      ],
    );
  }
}
