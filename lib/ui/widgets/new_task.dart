import 'package:flutter/material.dart';

class NewTask extends StatefulWidget {
  final Function addTask;

  const NewTask(this.addTask, {Key? key}) : super(key: key);

  @override
  _NewTaskState createState() => _NewTaskState();
}

class _NewTaskState extends State<NewTask> {
  final nameController = TextEditingController();
  late bool status;
  String enteredName = "";
  double _value = 0;
  DateTime selectedDate = DateTime.now();
  DateTime fiftyDaysFromNow = DateTime.now().add(const Duration(days: 50));
  DateTime sevenDaysAgo = DateTime.now().subtract(const Duration(days: 7));

  String _checkName() {
    if (nameController.text == null ||
        nameController.text == " " ||
        nameController.text == '')
      enteredName = "A New Task";
    else
      enteredName = nameController.text;
    return enteredName;
  }

  void _submitTask() {
    _checkName();
    status = false;
    widget.addTask(enteredName, _value, selectedDate, status);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: EdgeInsets.zero,
      title: const Text('Add a task'),
      content: SizedBox(
        height: 265,
        width: 130,
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          TextField(
            controller: nameController,
            decoration: const InputDecoration(
                border: OutlineInputBorder(), hintText: "Name of the task"),
          ),
          const Divider(),

          Container(child: getWeightstatus()),
          // Text('Weight: ${_value!.toStringAsPrecision(2)}'),
          Slider(
            min: 0.0,
            max: 10.0,
            value: _value.toDouble(),
            onChanged: (value) {
              setState(() {
                _value = value;
              });
            },
          ),
          const Divider(),
          const Text('Deadline'),
          Builder(builder: (buildReturnedContext) {
            return IconButton(
                onPressed: () async {
                  final DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: sevenDaysAgo,
                      firstDate: DateTime(2022),
                      lastDate: fiftyDaysFromNow);
                  if (picked != null && picked != selectedDate) {
                    setState(() {
                      selectedDate = picked;
                    });
                  }
                },
                icon: const Icon(Icons.calendar_today));
          }),

          /* actions: <Widget>[ */
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: Colors.red,
                child: IconButton(
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
                child: IconButton(
                  onPressed: () {
                    _submitTask();
                    Navigator.of(context).pop(_value);
                  },
                  icon: const Icon(
                    Icons.add_task,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ]),
      ),
    );
  }

  Widget getWeightstatus() {
    if (_value > 1) {
      return Text('Weight: ${_value.toStringAsPrecision(2)}');
    } else {
      return Text('Weight: ${_value.toStringAsPrecision(1)}');
    }
  }

//Function addTx initialization
//State: NewTransaciton

//void submitData()
  //State: _NewTransactionState
  //enteredData = textControlers
  //if enteredData <= 0 => return;

  //override
  //return of the textfields and the button
  //with onSubmitted: (_) => submitData() & onPressed: submitData
}
