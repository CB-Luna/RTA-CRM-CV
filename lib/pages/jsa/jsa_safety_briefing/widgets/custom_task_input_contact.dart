// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

class CustomtaskTextInputContact extends StatefulWidget {
  final String task;
  final TextEditingController controller;
  const CustomtaskTextInputContact(
      {Key? key, required this.task, required this.controller})
      : super(key: key);

  @override
  _CustomtaskTextInputContactState createState() =>
      _CustomtaskTextInputContactState();
}

class _CustomtaskTextInputContactState
    extends State<CustomtaskTextInputContact> {
  final TextEditingController _taskController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    bool isEmail(String value) {
      // Expresión regular para validar un correo electrónico
      final RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
      return emailRegex.hasMatch(value);
    }

// Función para validar número de teléfono
    bool isPhoneNumber(String value) {
      // Expresión regular para validar un número de teléfono
      final RegExp phoneRegex = RegExp(
          r'^[0-9]{10}$'); // Aquí asumimos un formato específico de 10 dígitos
      return phoneRegex.hasMatch(value);
    }

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
                maxLines: 1,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a valid input'; // Mensaje para campo vacío
                  }

                  // Validar si es un correo electrónico
                  if (isEmail(value)) {
                    return null; // Es un correo válido
                  }

                  // Validar si es un número de teléfono
                  if (isPhoneNumber(value)) {
                    return null; // Es un número de teléfono válido
                  }

                  // Si no coincide con ningún formato válido
                  return 'Please enter a valid email or phone number';
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
