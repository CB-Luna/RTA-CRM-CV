import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rta_crm_cv/pages/jsa/doc_creation/risks_hazards_widget.dart';
import 'package:rta_crm_cv/pages/jsa/doc_creation/widgets/custom_task_input.dart';
import 'package:rta_crm_cv/pages/jsa/doc_creation/widgets/team_members_list.dart';
import 'package:rta_crm_cv/widgets/custom_card.dart';

import '../../../providers/jsa/jsa_provider.dart';
import '../../../theme/theme.dart';

TextEditingController titleController = TextEditingController();
TextEditingController taskController = TextEditingController();
TextEditingController companyController = TextEditingController();

class CustomDocCreationFinalDocument extends StatefulWidget {
  const CustomDocCreationFinalDocument({
    Key? key,
  }) : super(key: key);

  @override
  State<CustomDocCreationFinalDocument> createState() =>
      _CustomDocCreationFinalDocumentState();
}

class _CustomDocCreationFinalDocumentState
    extends State<CustomDocCreationFinalDocument> {
  // @override
  // void initState() {
  //   super.initState();

  //   WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
  //     final JsaProvider provider = Provider.of<JsaProvider>(
  //       context,
  //       listen: false,
  //     );
  //     await provider.updateState();
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    JsaProvider provider = Provider.of<JsaProvider>(context);

    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.87,
      // alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomCard(
                    title: "JSA PREVIEW",
                    height: MediaQuery.of(context).size.height * 0.79,
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: Container(
                      color: Colors.red,
                    )),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                ),
                CustomCard(
                    title: "JSA TEMPLATE PREVIEW ",
                    height: MediaQuery.of(context).size.height * 0.3,
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: Expanded(
                      child: Container(
                        color: Colors.green,
                        child: Row(
                          children: [
                            Container(
                              height: 100,
                              width: 100,
                              color: Colors.blue,
                            ),
                            Column(
                              children: [
                                Text("Title : ",
                                    style: AppTheme.of(context).bodyText2),
                                Text(
                                    provider.jsaGeneralInfo?.title ?? "No Name",
                                    style: TextStyle(
                                      fontFamily: 'Gotham-Light',
                                      color: AppTheme.of(context).cryPrimary,
                                      fontWeight: FontWeight.w300,
                                      fontSize: 18,
                                    )),
                                Text("Task: ",
                                    style: AppTheme.of(context).bodyText2),
                                Text(
                                    provider.jsaGeneralInfo?.taskName ??
                                        "No Task",
                                    style: TextStyle(
                                      fontFamily: 'Gotham-Light',
                                      color: AppTheme.of(context).cryPrimary,
                                      fontWeight: FontWeight.w300,
                                      fontSize: 18,
                                    ))
                              ],
                            )
                          ],
                        ),
                      ),
                    ))
              ],
            ),
            InkWell(
              onTap: () {
                provider.setButtonViewTaped(2);
                provider.setIcons(2);
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
                    const Icon(
                      Icons.arrow_left_outlined,
                      color: Colors.white,
                    ),
                    Text("Previous", style: AppTheme.of(context).subtitle2),
                  ],
                ),
              ),
            ),
            // Row(
            //   children: [
            //     ElevatedButton(
            //         onPressed: () {
            //           provider.selectedTask = true;
            //           provider.circleListTask = true;

            //           print(provider.selectedTask);
            //           provider.setButtonViewTaped(2);
            //           provider.setIcons(2);
            //           setState(() {});
            //         },
            //         child: Text("Back")),
            //     // ElevatedButton(
            //     //     onPressed: () {
            //     //       provider.selectedTask = true;
            //     //       provider.circleListTask = true;

            //     //       print(provider.selectedTask);
            //     //       provider.setButtonViewTaped(2);
            //     //       provider.setIcons(2);
            //     //       setState(() {});
            //     //     },
            //     //     child: Text("Next"))
            //   ],
            // ),
          ],
        ),
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
