import 'package:flutter/material.dart';

class CustomtaskTextInput extends StatefulWidget {
  final String task;
  final TextEditingController controller;
  const CustomtaskTextInput({Key? key, required this.task, required this.controller}) : super(key: key);

  @override
  _CustomtaskTextInputState createState() => _CustomtaskTextInputState();
}

class _CustomtaskTextInputState extends State<CustomtaskTextInput> {
  final TextEditingController _taskController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * .2,
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.task,
            style: const TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.normal,
              color: Color(0xFF737373),
            ),
          ),
          const SizedBox(height: 8.0),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(color: const Color(0xFF335594), width: 1.0),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a valid task'; // Message to display when the field is empty
                  }
                  return null; // Return null if the input is valid
                },
                style: const TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.normal,
                  color: Color(0xFF335594),
                ),
                controller: widget.controller,
                decoration: InputDecoration(
                  hintText: widget.task,
                  border: InputBorder.none,
                ),
                onChanged: (value) {
                  // Perform search or filtering based on the entered value
                  // For example, update a list or perform a search operation
                  // based on the value in _taskController.text
                  // print("Task value: $value");
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Method to get the current value of the TextFormField
  String getValue() {
    return _taskController.text;
  }

  @override
  void dispose() {
    _taskController.dispose();
    super.dispose();
  }
}