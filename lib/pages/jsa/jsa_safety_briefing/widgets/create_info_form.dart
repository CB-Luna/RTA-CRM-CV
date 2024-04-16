import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rta_crm_cv/pages/jsa/doc_creation/widgets/custom_task_input.dart';

import '../../../../providers/jsa/jsa_safety_briefing_provider.dart';

class CreateInfoForm extends StatefulWidget {
  const CreateInfoForm({super.key});

  @override
  State<CreateInfoForm> createState() => _CreateInfoFormState();
}

class _CreateInfoFormState extends State<CreateInfoForm> {
  @override
  Widget build(BuildContext context) {
    JsaSafetyProvider provider = Provider.of<JsaSafetyProvider>(context);

    Future<void> selectDate(BuildContext context) async {
      final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime.now(),
      );
      if (picked != null && picked != DateTime.now()) {
        setState(() {
          provider.dateController.text = picked
              .toString(); // Aquí puedes formatear la fecha según tus necesidades
        });
      }
    }

    return Column(
      children: [
        CustomtaskTextInput(
          task: "Briefing Name",
          controller: provider.titleController,
        ),
        CustomtaskTextInput(
          task: "Prepared By",
          controller: provider.UserController,
        ),
        CustomtaskTextInput(
          task: "Prepared For",
          controller: provider.titleController,
        ),
        TextFormField(
          controller: provider.dateController,
          readOnly: true,
          decoration: InputDecoration(
            labelText: 'Fecha',
            suffixIcon: IconButton(
              icon: const Icon(Icons.calendar_today),
              onPressed: () {
                selectDate(context);
              },
            ),
          ),
        )
        // CustomtaskTextInput(
        //   task: "Date",
        //   controller: provider.dateController,
        // ),
      ],
    );
  }
}
