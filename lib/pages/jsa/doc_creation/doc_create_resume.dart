// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rta_crm_cv/widgets/custom_card.dart';

import '../../../providers/jsa/jsa_provider.dart';
import '../../../theme/theme.dart';

TextEditingController titleController = TextEditingController();
TextEditingController taskController = TextEditingController();
TextEditingController companyController = TextEditingController();

class CustomDocResume extends StatefulWidget {
  const CustomDocResume({
    Key? key,
  }) : super(key: key);

  @override
  State<CustomDocResume> createState() => _CustomDocResumeState();
}

class _CustomDocResumeState extends State<CustomDocResume> {
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
            CustomCard(
                title: "General Info",
                height: MediaQuery.of(context).size.height * 0.30,
                width: MediaQuery.of(context).size.width * 0.2,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.20,
                  width: MediaQuery.of(context).size.width * 0.2,
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Company: ", style: AppTheme.of(context).bodyText2),
                      Text(provider.jsaGeneralInfo?.company ?? "No Company",
                          style: TextStyle(
                            fontFamily: 'Gotham-Light',
                            color: AppTheme.of(context).cryPrimary,
                            fontWeight: FontWeight.w300,
                            fontSize: 18,
                          )),
                      Text("Title : ", style: AppTheme.of(context).bodyText2),
                      Text(provider.jsaGeneralInfo?.title ?? "No Name",
                          style: TextStyle(
                            fontFamily: 'Gotham-Light',
                            color: AppTheme.of(context).cryPrimary,
                            fontWeight: FontWeight.w300,
                            fontSize: 18,
                          )),
                      Text("Task: ", style: AppTheme.of(context).bodyText2),
                      Text(provider.jsaGeneralInfo?.taskName ?? "No Task",
                          style: TextStyle(
                            fontFamily: 'Gotham-Light',
                            color: AppTheme.of(context).cryPrimary,
                            fontWeight: FontWeight.w300,
                            fontSize: 18,
                          ))
                    ],
                  ),
                )),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 20),
            ),
            // Custom Card de los Usuarios
            CustomCard(
              title: "Team Members",
              height: MediaQuery.of(context).size.height * 0.20,
              width: MediaQuery.of(context).size.width * 0.2,
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.15,
                width: MediaQuery.of(context).size.width * 0.2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: List.generate(
                          provider.jsaGeneralInfo!.teamMembers!.length,
                          (index) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 15.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              // User Name Placeholder
                              Container(
                                alignment: Alignment.center,
                                width: MediaQuery.of(context).size.width * 0.04,
                                child: Text(
                                  provider.jsaGeneralInfo?.teamMembers![index]
                                          .name ??
                                      "No Employee",
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontFamily: "Outfit",
                                    color: Color(0xFF335594),
                                  ),
                                  // overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              // User Role Placeholder
                              Expanded(
                                child: Container(
                                  alignment: Alignment.center,
                                  width:
                                      MediaQuery.of(context).size.width * 0.04,
                                  child: Text(
                                    provider.jsaGeneralInfo?.teamMembers![index]
                                            .role ??
                                        "No Role",
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontFamily: "Outfit",
                                      color: Color(0xFF335594),
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                    ),
                    // TeamMemberList(),
                  ],
                ),
              ),
            ),
            // Custom Card Steps and Risks
            CustomCard(
              title: "Steps and Risks",
              height: MediaQuery.of(context).size.height * 0.20,
              width: MediaQuery.of(context).size.width * 0.2,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: provider.jsa.jsaStepsJson!.length,
                itemBuilder: (context, i) => Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // Menu Icon
                    Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width * 0.07,
                      child: Text(
                        provider.jsa.jsaStepsJson![i].title.toString(),
                        style: const TextStyle(
                          fontSize: 15.0,
                          color: Color(0xFF335594),
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Outfit',
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    // Text "Steps"
                    Container(
                      width: MediaQuery.of(context).size.width * 0.07,
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          Text(
                            provider.jsa.jsaStepsJson![i].risks.isEmpty
                                ? 'No Risk(s)'
                                //corregir para que haga display el numero correcto
                                : '${provider.jsa.jsaStepsJson![i].risks.length} Risk(s)',
                            style: TextStyle(
                              fontSize: 15.0,
                              color: Colors.grey[600],
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Outfit',
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Text(
                            provider.jsa.jsaStepsJson![i].controls.isEmpty
                                ? 'No Controls(s)'
                                //corregir para que haga display el numero correcto
                                : '${provider.jsa.jsaStepsJson![i].controls.length} Control(s)',
                            style: TextStyle(
                              fontSize: 15.0,
                              color: Colors.grey[600],
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Outfit',
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [
                    //     InkWell(
                    //       onTap: () => showRiskMatrixPopup(
                    //           context,
                    //           provider.jsa.jsaStepsJson![i].id.toString(),
                    //           provider),
                    //       child: Container(
                    //         decoration: BoxDecoration(
                    //           borderRadius: BorderRadius.circular(10.0),
                    //           border: Border.all(
                    //             color: jsaProvider
                    //                     .jsa.jsaStepsJson![i].riskColor ??
                    //                 Colors.transparent,
                    //             width: 1.0,
                    //           ),
                    //           color: jsaProvider
                    //                       .jsa.jsaStepsJson![i].riskColor ==
                    //                   Colors.transparent
                    //               ? Colors.transparent
                    //               : jsaProvider.jsa.jsaStepsJson![i].riskColor,
                    //         ),
                    //         child: Text(
                    //           jsaProvider
                    //                   .jsa.jsaStepsJson![i].riskLevel!.isEmpty
                    //               ? 'N/A'
                    //               : jsaProvider.jsa.jsaStepsJson![i].riskLevel
                    //                   .toString(),
                    //           style: const TextStyle(
                    //             fontSize: 15.0,
                    //             color: Color(0xFF335594),
                    //             fontWeight: FontWeight.w600,
                    //             fontFamily: 'Outfit',
                    //             overflow: TextOverflow.ellipsis,
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    //     IconButton(
                    //       icon: const Icon(
                    //         Icons.remove_red_eye,
                    //         color: Color(0xFF335594),
                    //       ),
                    //       onPressed: () {
                    //         showRiskPopup(
                    //             context,
                    //             jsaProvider.jsa.jsaStepsJson![i].title,
                    //             jsaProvider.jsa.jsaStepsJson![i].id.toString());
                    //       },
                    //     ),
                    //   ],
                    // ),

                    // Open/Close Button
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    provider.setButtonViewTaped(1);
                    provider.setIcons(1);
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
                  onTap: () async {
                    provider.setButtonViewTaped(3);
                    provider.setIcons(3);
                    // Aqui es donde se tiene que crear el documento pdf
                    final pdfController = await provider.clientPDF(provider);
                    // print("PDF CONTROLLER: $pdfController");

                    // setState(() {});
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
                // ElevatedButton(
                //     onPressed: () {
                //       provider.selectedTask = true;
                //       provider.circleListTask = true;

                //       print(provider.selectedTask);
                //       provider.setButtonViewTaped(1);
                //       provider.setIcons(1);
                //       setState(() {});
                //     },
                //     child: Text("Back")),
                // ElevatedButton(
                //     onPressed: () {
                //       provider.selectedTask = true;
                //       provider.circleListTask = true;

                //       print(provider.selectedTask);
                //       provider.setButtonViewTaped(3);
                //       provider.setIcons(3);
                //       setState(() {});
                //     },
                //     child: Text("Next"))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
