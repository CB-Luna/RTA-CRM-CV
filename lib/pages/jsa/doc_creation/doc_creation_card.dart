import 'package:flutter/material.dart';
import 'package:rta_crm_cv/pages/jsa/doc_creation/risks_hazards_screen.dart';
import 'package:rta_crm_cv/pages/jsa/doc_creation/widgets/custom_task_input.dart';
import 'package:rta_crm_cv/pages/jsa/doc_creation/widgets/team_members_list.dart';

TextEditingController titleController = TextEditingController();
TextEditingController taskController = TextEditingController();
TextEditingController companyController = TextEditingController();

class CustomDocCreationCard extends StatefulWidget {
  final String title;

  const CustomDocCreationCard({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  State<CustomDocCreationCard> createState() => _CustomDocCreationCardState();
}

class _CustomDocCreationCardState extends State<CustomDocCreationCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.8,
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(255, 200, 219, 250), // Lighter blue

                    Color.fromARGB(255, 249, 251, 255), // Light blue
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0.0, 1.0],
                  tileMode: TileMode.clamp,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CustomDrop(
                          title: "OpCo Name",
                        ),
                        CustomtaskTextInput(
                          task: "Title Name",
                          controller: titleController,
                        ),
                        CustomtaskTextInput(
                          task: "Task Name",
                          controller: taskController,
                        ),
                        TeamMemberList(),
                      ],
                    ),
                    Container(
                      color: Colors.transparent,
                      padding: EdgeInsets.all(8.0),
                      height: MediaQuery.of(context).size.height * 0.8,
                      width: MediaQuery.of(context).size.width * 0.35,
                      child: RisksHazardsScreen(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomDrop extends StatefulWidget {
  final String title;
  const CustomDrop({Key? key, required this.title});

  @override
  _CustomDropState createState() => _CustomDropState();
}

class _CustomDropState extends State<CustomDrop> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
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
              child: DropdownButton(
                value: text,
                items: const [
                  DropdownMenuItem(
                    value: "CRY",
                    child: Text("CRY"),
                  ),
                  DropdownMenuItem(
                    value: "ODE",
                    child: Text("ODE"),
                  ),
                  DropdownMenuItem(
                    value: "SMI",
                    child: Text("SMI"),
                  ),
                ],
                onChanged: (value) {
                  text = value.toString();
                  companyController.text = text;
                  setState(() {});
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

String text = "CRY";
