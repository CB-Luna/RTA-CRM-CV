import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rta_crm_cv/pages/jsa/doc_creation/widgets/custom_task_input.dart';
import 'package:rta_crm_cv/pages/jsa/doc_creation/widgets/team_members_list.dart';
import 'package:rta_crm_cv/theme/theme.dart';
import 'package:rta_crm_cv/widgets/custom_card.dart';

import '../../../providers/jsa/jsa_provider.dart';

TextEditingController titleController = TextEditingController();
TextEditingController taskController = TextEditingController();
TextEditingController companyController = TextEditingController();

class CustomDocCreationCard extends StatefulWidget {
  const CustomDocCreationCard({
    Key? key,
  }) : super(key: key);

  @override
  State<CustomDocCreationCard> createState() => _CustomDocCreationCardState();
}

class _CustomDocCreationCardState extends State<CustomDocCreationCard> {
  // @override
  // void initState() {
  //   super.initState();
  //   JsaProvider jsaProvider = Provider.of<JsaProvider>(context, listen: false);
  //   jsaProvider.createJsaGeneralInfo("", "", "");
  // }
  // @override
  // void initState() {
  //   super.initState();
  //   JsaProvider jsaProvider = Provider.of<JsaProvider>(context, listen: false);
  //   jsaProvider.createJsaGeneralInfo("", "", "");
  // }
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final JsaProvider jsaProvider =
          Provider.of<JsaProvider>(context, listen: false);

      jsaProvider.createJsaGeneralInfo("", "", "", []);
    });
  }

  @override
  Widget build(BuildContext context) {
    JsaProvider provider = Provider.of<JsaProvider>(context);

    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.87,
      // alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
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
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
              ),
              CustomCard(
                  title: "Team Members",
                  height: MediaQuery.of(context).size.height * 0.7,
                  width: MediaQuery.of(context).size.width * 0.2,
                  child: const TeamMemberList())
            ],
          ),
          InkWell(
            onTap: () {
              provider.setButtonViewTaped(1);
              provider.setIcons(1);
              provider.createJsaGeneralInfo(
                  companyController.text,
                  titleController.text,
                  taskController.text,
                  provider.jsaGeneralInfo!.teamMembers!);

              setState(() {});
            },
            child: Container(
              width: MediaQuery.of(context).size.width * 0.6,
              height: MediaQuery.of(context).size.height * 0.04,
              margin: const EdgeInsets.all(10),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: AppTheme.of(context).cryPrimary,
                  borderRadius: BorderRadius.circular(20)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Next", style: AppTheme.of(context).subtitle2),
                  const Icon(
                    Icons.arrow_right_outlined,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ),
          // ElevatedButton(
          //     style: ElevatedButton.styleFrom(
          //         backgroundColor: AppTheme.of(context).cryPrimary),
          //     onPressed: () {
          //       provider.setButtonViewTaped(1);
          //       provider.setIcons(1);
          //       setState(() {});
          //     },
          //     child: Text("Next"))
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
    JsaProvider provider = Provider.of<JsaProvider>(context);

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
                  print(companyController.text);
                  provider.getListUsers(companyController.text);
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
