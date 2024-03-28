import 'package:flutter/material.dart';

class CustomTextInput extends StatefulWidget {
  final String title;
  final TextEditingController controller;
  const CustomTextInput(
      {super.key, required this.title, required this.controller});

  @override
  _CustomTextInputState createState() => _CustomTextInputState();
}

class _CustomTextInputState extends State<CustomTextInput> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: TextStyle(
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
              child: TextField(
                style: const TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.normal,
                  color: Color(0xFF335594),
                ),
                controller: widget.controller,
                decoration: InputDecoration(

                  hintText: widget.title,
                  border: InputBorder.none,
                ),
                onChanged: (value) {
                  // Perform search or filtering based on the entered value
                  // For example, update a list or perform a search operation
                  // based on the value in _searchController.text
                  print("Search Query: $value");
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
