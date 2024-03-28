import 'package:flutter/material.dart';
import 'package:rta_crm_cv/pages/jsa/doc_creation/risks_hazards_widget.dart';
import 'package:rta_crm_cv/pages/jsa/doc_creation/widgets/custom_task_input.dart';
import 'package:rta_crm_cv/pages/jsa/doc_creation/widgets/team_members_list.dart';
import 'package:rta_crm_cv/widgets/custom_card.dart';

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
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          children: [
            const IconButtonCustom(
              icon: Icons.edit_document,
              selected: true,
              circle: true,
            ),
            IconButtonCustomDivisor(),
            const IconButtonCustom(
              icon: Icons.person,
              selected: false,
              circle: false,
            ),
            IconButtonCustomDivisor(),
            const IconButtonCustom(
              icon: Icons.auto_awesome_motion_rounded,
              selected: false,
              circle: false,
            ),
            IconButtonCustomDivisor(),
            const IconButtonCustom(
              icon: Icons.lock,
              selected: false,
              circle: false,
            ),
            IconButtonCustomDivisor(),
            const IconButtonCustom(
              icon: Icons.remove_red_eye,
              selected: false,
              circle: false,
            ),
          ],
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Colors.blue,
          margin: const EdgeInsets.symmetric(horizontal: 20),
          // alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomCard(
                title: "General Info",
                height: MediaQuery.of(context).size.height * 0.38,
                width: MediaQuery.of(context).size.width * 0.2,
                child: Column(
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
                    // TeamMemberList(),
                  ],
                ),
              ),
              CustomCard(
                  title: "Team Members",
                  height: MediaQuery.of(context).size.height * 0.6,
                  child: Container())
            ],
          ),
        )
        // Padding(
        //   padding: const EdgeInsets.only(bottom: 16.0),
        //   child: Container(
        //     width: double.infinity,
        //     height: MediaQuery.of(context).size.height * 0.8,
        //     margin: const EdgeInsets.all(10),
        //     decoration: BoxDecoration(
        //       borderRadius: BorderRadius.circular(6),
        //       gradient: LinearGradient(
        //         colors: [
        //           Color.fromARGB(255, 200, 219, 250), // Lighter blue

        //           Color.fromARGB(255, 249, 251, 255), // Light blue
        //         ],
        //         begin: Alignment.topCenter,
        //         end: Alignment.bottomCenter,
        //         stops: [0.0, 1.0],
        //         tileMode: TileMode.clamp,
        //       ),
        //     ),
        //     child: Padding(
        //       padding: const EdgeInsets.symmetric(horizontal: 10),
        //       child: Row(
        //         crossAxisAlignment: CrossAxisAlignment.start,
        //         mainAxisAlignment: MainAxisAlignment.spaceAround,
        //         children: [
        //           Column(
        //             crossAxisAlignment: CrossAxisAlignment.start,
        //             children: [
        //               const CustomDrop(
        //                 title: "OpCo Name",
        //               ),
        //               CustomtaskTextInput(
        //                 task: "Title Name",
        //                 controller: titleController,
        //               ),
        //               CustomtaskTextInput(
        //                 task: "Task Name",
        //                 controller: taskController,
        //               ),
        //               TeamMemberList(),
        //             ],
        //           ),
        //           // Container(
        //           //   color: Colors.transparent,
        //           //   padding: EdgeInsets.all(8.0),
        //           //   height: MediaQuery.of(context).size.height * 0.8,
        //           //   width: MediaQuery.of(context).size.width * 0.35,
        //           //   child: RisksHazardsScreen(),
        //           // ),
        //         ],
        //       ),
        //     ),
        //   ),
        // ),
      ],
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

class IconButtonCustom extends StatelessWidget {
  const IconButtonCustom(
      {super.key, this.icon, required this.selected, required this.circle});

  final IconData? icon;
  final bool selected;
  final bool circle;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.1,
          height: MediaQuery.of(context).size.height * 0.055,
          padding: const EdgeInsets.all(5),
          clipBehavior: Clip.antiAlias,
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              side: BorderSide(
                  width: 1,
                  color: circle ? const Color(0xFF335594) : Colors.transparent),
              borderRadius: BorderRadius.circular(100),
            ),
          ),
          child: Icon(
            icon,
            color: selected ? const Color(0xFF335594) : Colors.grey[500],
            size: 24,
          ),
        ),
      ],
    );
  }
}

class IconButtonCustomDivisor extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 24.02,
      decoration: const ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: 1,
            strokeAlign: BorderSide.strokeAlignCenter,
            color: Color(0xFFB7B7B7),
          ),
        ),
      ),
    );
  }
}
