import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rta_crm_cv/widgets/custom_card.dart';

import '../../../providers/jsa/jsa_provider.dart';
import '../../../theme/theme.dart';
import 'risks_hazards_widget.dart';
import 'widgets/CustomTextInput.dart';
import 'widgets/animated_containers/animated_control_container.dart';
import 'widgets/animated_containers/animated_risk_container.dart';
import 'widgets/animated_containers/animated_step_container.dart';

TextEditingController titleController = TextEditingController();
TextEditingController taskController = TextEditingController();
TextEditingController companyController = TextEditingController();

class CustomDocCreationTaskRiskControl extends StatefulWidget {
  const CustomDocCreationTaskRiskControl({
    Key? key,
  }) : super(key: key);

  @override
  State<CustomDocCreationTaskRiskControl> createState() =>
      _CustomDocCreationTaskRiskControlState();
}

class _CustomDocCreationTaskRiskControlState
    extends State<CustomDocCreationTaskRiskControl> {
  @override
  Widget build(BuildContext context) {
    JsaProvider provider = Provider.of<JsaProvider>(context);
    final formKey = GlobalKey<FormState>();

    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.87,
      // alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomCard(
                    title: "Steps",
                    height: MediaQuery.of(context).size.height * 0.7,
                    width: MediaQuery.of(context).size.width * 0.2,
                    child: Column(
                      children: [
                        Container(
                          // height: MediaQuery.of(context).size.height * 0.35,
                          height: MediaQuery.of(context).size.height * 0.3,
                          width: MediaQuery.of(context).size.width * 0.2,
                          padding: const EdgeInsets.all(5.0),
                          child: Form(
                            key: formKey,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              // mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                // const SizedBox(height: 8.0),
                                CustomTextInput(
                                    title: 'Step Name',
                                    controller: provider.stepNameController),
                                const SizedBox(height: 8.0),
                                CustomTextInput(
                                    title: 'Step Description',
                                    controller:
                                        provider.stepDescriptionController),
                                const SizedBox(height: 16.0),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.2,
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                      const Color(0xFF335594),
                                    )),
                                    onPressed: () {
                                      // Save your data or perform any action here
                                      if (formKey.currentState!.validate()) {
                                        if (editStep == false) {
                                          provider.addJsaSteps(
                                              provider.stepNameController.text,
                                              provider.stepDescriptionController
                                                  .text);
                                        } else {
                                          provider.jsa.jsaStepsJson!
                                              .forEach((element) {
                                            if (element.id == id) {
                                              element.title = provider
                                                  .stepNameController.text;
                                              element.description = provider
                                                  .stepDescriptionController
                                                  .text;
                                            }
                                          });
                                          provider.notifyEdit();
                                        }
                                        provider.stepNameController.clear();
                                        provider.stepDescriptionController
                                            .clear();
                                        setState(() {});
                                      }
                                    },
                                    child: const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text('Add Step',
                                            style: TextStyle(
                                              color: Colors.white,
                                            )),
                                        Icon(Icons.arrow_right_outlined)
                                      ],
                                    ),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    // ElevatedButton(
                                    //   style: ButtonStyle(
                                    //       backgroundColor: MaterialStateProperty.all<Color>(
                                    //     const Color(0xFF335594),
                                    //   )),
                                    //   onPressed: () {
                                    //     Navigator.of(context).pop();
                                    //   },
                                    //   child: const Text('Cancel',
                                    //       style: TextStyle(
                                    //         color: Colors.white,
                                    //       )),
                                    // ),
                                    SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.02),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        const AnimatedStepContainer(),
                      ],
                    )),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                ),
                CustomCard(
                    title: "Risk",
                    height: MediaQuery.of(context).size.height * 0.7,
                    width: MediaQuery.of(context).size.width * 0.2,
                    child: const AnimatedRiskContainer()),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                ),
                CustomCard(
                    title: "Control",
                    height: MediaQuery.of(context).size.height * 0.7,
                    width: MediaQuery.of(context).size.width * 0.2,
                    child: const AnimatedControlContainer())
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  provider.setButtonViewTaped(0);
                  provider.setIcons(0);
                  provider.searchUserController.clear();

                  setState(() {});
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.3,
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
              InkWell(
                onTap: () {
                  provider.setButtonViewTaped(2);
                  provider.setIcons(2);
                  setState(() {});
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.3,
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
            ],
          ),
        ],
      ),
    );
  }
}
