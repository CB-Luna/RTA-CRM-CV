import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rta_crm_cv/widgets/custom_card.dart';

import '../../../../models/issues_comments.dart';
import '../../../../models/issues_open_close.dart';
import '../../../../providers/ctrlv/issue_reported_provider.dart';
import '../../../../theme/theme.dart';
import '../../../../widgets/custom_text_icon_button.dart';
import 'comments_photos_pop_up.dart';

class IssuesPopUpTotal extends StatefulWidget {
  final List<IssueOpenclose> issueComments;
  final int contador;
  final String text;
  const IssuesPopUpTotal({
    super.key,
    required this.contador,
    required this.text,
    required this.issueComments,
  });

  @override
  State<IssuesPopUpTotal> createState() => _IssuesPopUpTotalState();
}

class _IssuesPopUpTotalState extends State<IssuesPopUpTotal> {
  // @override
  // void initState() {
  //   super.initState();

  //   WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
  //     IssueReportedProvider provider =
  //         Provider.of<IssueReportedProvider>(context, listen: false);
  //     //TODO: no borrar todo, actualizar
  //     if (widget.contador == 1) {
  //       provider.cambiovistaMeasures = true;
  //       await provider.getIssuesFluidCheck(provider.actualIssueXUser!);
  //       print("getIssuesFluidCheck");
  //     }
  //     if (widget.contador == 2) {
  //       provider.cambiovistaMeasures = true;
  //       await provider.getIssuesLights(provider.actualIssueXUser!);
  //       print("${provider.lightsRR.length}");
  //       print("--------------");
  //       print("${provider.lightsDD.length}");

  //       print("getIssuesLights");
  //     }
  //     if (widget.contador == 3) {
  //       provider.cambiovistaMeasures = true;
  //       await provider.getIssuesCarBodywork(provider.actualIssueXUser!);
  //       print("getIssuesCarBodywork");
  //     }
  //     if (widget.contador == 4) {
  //       provider.cambiovistaMeasures = true;
  //       await provider.getIssueSecurity(provider.actualIssueXUser!);
  //       print("getIssueSecurity");
  //     }
  //     if (widget.contador == 5) {
  //       provider.cambiovistaMeasures = true;
  //       await provider.getIssuesExtra(provider.actualIssueXUser!);
  //       print("getIssuesExtra");
  //     }
  //     if (widget.contador == 6) {
  //       provider.cambiovistaMeasures = true;
  //       await provider.getIssuesEquipment(provider.actualIssueXUser!);
  //       print("getIssuesEquipment");
  //     }
  //     if (widget.contador == 7) {
  //       provider.cambiovistaMeasures = false;
  //       await provider.getIssuesBasics(provider.actualIssueXUser!);
  //       print("getBucketInspection");
  //     }
  //     if (widget.contador == 8) {
  //       provider.cambiovistaMeasures = true;
  //       await provider.getIssuesMeasure(provider.actualIssueXUser!);
  //       print("getIssuesMeasure");
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    IssueReportedProvider issueReportedProvider =
        Provider.of<IssueReportedProvider>(context);
    return AlertDialog(
        backgroundColor: Colors.transparent,
        content: CustomCard(
          width: MediaQuery.of(context).size.width * 0.45,
          height: MediaQuery.of(context).size.height * 0.4,
          title: widget.text,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 15),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.1,
                  height: MediaQuery.of(context).size.height * 0.03,
                  decoration: BoxDecoration(
                    color: statusColor(
                        issueReportedProvider.actualVehicle!.company.company),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      issueReportedProvider.actualVehicle!.licesensePlates,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.45,
                height: MediaQuery.of(context).size.height * 0.4,
                child: ListView.builder(
                  itemCount: widget.issueComments.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 10.0, bottom: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            width: 250,
                            color: Colors.green,
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Column(
                              children: [
                                Text("${widget.issueComments[index].idIssue}"),
                                Text(
                                  "•${widget.issueComments[index].nameIssue.capitalize.replaceAll("_", " ")}",
                                  style: TextStyle(
                                    color: Colors.orange,
                                    fontFamily: 'Bicyclette-Thin',
                                    fontSize: AppTheme.of(context)
                                        .contenidoTablas
                                        .fontSize,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 25,
                          ),
                          Container(
                            alignment: Alignment.center,
                            child: Row(
                              children: [
                                Text(
                                  DateFormat("MMM/dd/yyyy hh:mm:ss").format(
                                      widget
                                          .issueComments[index].dateAddedOpen),
                                  style: TextStyle(
                                    color: AppTheme.of(context)
                                        .contenidoTablas
                                        .color,
                                    fontFamily: 'Bicyclette-Thin',
                                    fontSize: AppTheme.of(context)
                                        .contenidoTablas
                                        .fontSize,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Spacer(),
                          Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: CustomTextIconButton(
                              mainAxisAlignment: MainAxisAlignment.center,
                              width: 80,
                              isLoading: false,
                              icon: Icon(Icons.remove_red_eye_outlined,
                                  color:
                                      AppTheme.of(context).primaryBackground),
                              text: '',
                              color: AppTheme.of(context).primaryColor,
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return StatefulBuilder(
                                          builder: (context, setState) {
                                        return CommentsPhotosPopUp();
                                      });
                                    });
                                // Notify false en las primeras 2
                                // issueReportedProvider.getIssuePhotosComments(
                                //     widget.contador, widget.[index],
                                //     notify: false);
                                // issueReportedProvider.setContador(widget.contador,
                                //     notify: false);
                                // isssueReportedProvider.setIssueViewActual(2);
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ));
  }
}

Color statusColor(String status) {
  late Color color;

  switch (status) {
    case "ODE": //Sales Form
      color = const Color(0XFFB2333A);
      break;
    case "SMI": //Sen. Exec. Validate
      color = const Color.fromRGBO(255, 138, 0, 1);
      break;
    case "CRY": //Finance Validate
      color = const Color(0XFF345694);
      break;

    default:
      return Colors.black;
  }
  return color;
}
