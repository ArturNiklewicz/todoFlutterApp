import 'package:flutter/material.dart';

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
    return new AlertDialog(
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
