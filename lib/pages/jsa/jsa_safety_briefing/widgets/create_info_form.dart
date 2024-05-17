// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rta_crm_cv/helpers/globals.dart';
import 'package:rta_crm_cv/pages/jsa/doc_creation/widgets/custom_task_input.dart';
import 'package:rta_crm_cv/theme/theme.dart';
import 'package:rta_crm_cv/widgets/custom_text_icon_button.dart';

import '../../../../providers/jsa/jsa_safety_briefing_provider.dart';
import 'team_members_safety.dart';

class CreateInfoForm extends StatefulWidget {
  const CreateInfoForm({super.key});

  @override
  State<CreateInfoForm> createState() => _CreateInfoFormState();
}

class _CreateInfoFormState extends State<CreateInfoForm> {
  // @override
  // void initState() {
  //   super.initState();

  //   WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
  //     final JsaSafetyProvider provider = Provider.of<JsaSafetyProvider>(
  //       context,
  //       listen: false,
  //     );
  //     await provider.clearAll();
  //     await provider.clientPDF();
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    JsaSafetyProvider provider = Provider.of<JsaSafetyProvider>(context);

    // final List<String> usersName =
    //     provider.users.map((user) => user.name).toList();

    Future<void> selectDate(BuildContext context) async {
      final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2040),
      );
      if (picked != null && picked != DateTime.now()) {
        setState(() {
          // String formattedDate = DateFormat('MM/dd/yyyy').format(picked);
          String formattedDate = DateFormat('MMM/dd/yyyy').format(picked);

          provider.dateController.text = formattedDate;
          // provider.dateController.text = picked
          //     .toString(); // Aquí puedes formatear la fecha según tus necesidades
        });
      }
    }

    Future<void> selectDateDue(BuildContext context) async {
      final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2040),
      );
      if (picked != null && picked != DateTime.now()) {
        setState(() {
          String formattedDate = DateFormat('MMM/dd/yyyy').format(picked);
          provider.datedueController.text = formattedDate;
          // provider.dateController.text = picked
          //     .toString(); // Aquí puedes formatear la fecha según tus necesidades
        });
      }
    }

    return Column(
      children: [
        CustomtaskTextInput(
          task: "Briefing Name",
          controller: provider.titleController,
        ),
        // CustomtaskTextInput(
        //   task: "Prepared By",
        //   controller: provider.userController,
        // ),
        Container(
          width: MediaQuery.of(context).size.width * .2,
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Prepared By",
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.normal,
                  color: Color(0xFF737373),
                ),
              ),
              const SizedBox(height: 3.0),
              Container(
                  height: MediaQuery.of(context).size.height * 0.05,
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    border:
                        Border.all(color: const Color(0xFF335594), width: 1.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12.0, horizontal: 10),
                    child: Text(
                      currentUser!.fullName,
                      style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.normal,
                        color: Color(0xFF335594),
                      ),
                    ),
                  )),
            ],
          ),
        ),
        InkWell(
            onTap: () async {
              // await provider.getListUsers(currentUser!.companies.first.company);
              await showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return StatefulBuilder(builder: (context, setState) {
                      return const TeamMembersSafety();
                    });
                  });
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Prepared For",
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.normal,
                    color: Color(0xFF737373),
                  ),
                ),
                const SizedBox(height: 8.0),
                Container(
                  width: MediaQuery.of(context).size.width * .2,
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    border:
                        Border.all(color: const Color(0xFF335594), width: 1.0),
                  ),
                  child: provider.teamMembers.isEmpty
                      ? const Text(
                          "Prepared For",
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.normal,
                            color: Color(0xFF335594),
                          ),
                        )
                      : Column(
                          children: List.generate(provider.teamMembers.length,
                              (index) {
                            return Row(
                              children: [
                                Text(
                                  provider.teamMembers[index].name!,
                                  style: const TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.normal,
                                    color: Color(0xFF335594),
                                  ),
                                ),
                                if (index < provider.teamMembers.length - 1)
                                  const Text(', '),
                              ],
                            );
                          }),
                        ),
                ),
              ],
            )),

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 8.0),
              child: Text(
                "Date",
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.normal,
                  color: Color(0xFF737373),
                ),
              ),
            ),
            const SizedBox(height: 8.0),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: TextFormField(
                controller: provider.dateController,
                readOnly: true,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a Date';
                  }
                  // Puedes agregar más validaciones aquí (por ejemplo, para verificar un formato de email válido).
                  return null; // Retorna null si la validación es exitosa.
                },
                decoration: InputDecoration(
                  labelText: 'Date',
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.calendar_today),
                    onPressed: () {
                      selectDate(context);
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 8.0),
              child: Text(
                "Due Date",
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.normal,
                  color: Color(0xFF737373),
                ),
              ),
            ),
            const SizedBox(height: 8.0),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: TextFormField(
                controller: provider.datedueController,
                readOnly: true,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a Date';
                  }
                  // Puedes agregar más validaciones aquí (por ejemplo, para verificar un formato de email válido).
                  return null; // Retorna null si la validación es exitosa.
                },
                decoration: InputDecoration(
                  labelText: 'Due Date',
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.event_busy_outlined),
                    onPressed: () {
                      selectDateDue(context);
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: CustomTextIconButton(
            // width: width * 120,
            width: 200,
            text: 'Refresh File',
            isLoading: false,
            icon: Icon(
              Icons.refresh,
              color: AppTheme.of(context).primaryBackground,
            ),
            color: AppTheme.of(context).primaryColor,
            onTap: () async {
              // await provider.crearPDF();
              await provider.clientPDF();
            },
          ),
        ),
        // InkWell(
        //   child: Container(
        //     color: Colors.red,
        //     height: 50,
        //     width: 50,
        //   ),
        // )
        // CustomtaskTextInput(
        //   task: "Date",
        //   controller: provider.dateController,
        // ),
      ],
    );
  }
}
