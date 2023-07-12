import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../models/issues_open_close.dart';
import '../../../../providers/ctrlv/inventory_provider.dart';
import '../../../../providers/ctrlv/issue_reported_provider.dart';
import '../../../../theme/theme.dart';
import '../../../../widgets/custom_text_icon_button.dart';

class ListIssuesCard extends StatefulWidget {
  final List<IssueOpenclose> issuesComments;
  final int contador;
  const ListIssuesCard(
      {super.key, required this.issuesComments, required this.contador});

  @override
  State<ListIssuesCard> createState() => _ListIssuesCardState();
}

class _ListIssuesCardState extends State<ListIssuesCard> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      IssueReportedProvider isssueReportedProvider =
          Provider.of<IssueReportedProvider>(
        context,
        listen: false,
      );
      isssueReportedProvider.clearListgetIssues();
      if (widget.contador == 1) {
        isssueReportedProvider.cambiovistaMeasures = true;

        isssueReportedProvider
            .getIssuesFluidCheck(isssueReportedProvider.actualIssueXUser!);

        print("getIssuesFluidCheck");
      }
      if (widget.contador == 2) {
        isssueReportedProvider.cambiovistaMeasures = true;

        isssueReportedProvider
            .getIssuesCarBodywork(isssueReportedProvider.actualIssueXUser!);
        print("getCarbodywork");
      }
      if (widget.contador == 3) {
        isssueReportedProvider.cambiovistaMeasures = true;

        isssueReportedProvider
            .getIssuesEquipment(isssueReportedProvider.actualIssueXUser!);
        print("getequipment");
      }
      if (widget.contador == 4) {
        isssueReportedProvider.cambiovistaMeasures = true;

        isssueReportedProvider
            .getIssuesExtra(isssueReportedProvider.actualIssueXUser!);
        print("getextra");
      }
      if (widget.contador == 5) {
        isssueReportedProvider.cambiovistaMeasures = true;

        isssueReportedProvider
            .getIssuesBasics(isssueReportedProvider.actualIssueXUser!);
        print("getBucketInspection");
      }
      if (widget.contador == 6) {
        isssueReportedProvider.cambiovistaMeasures = true;

        isssueReportedProvider
            .getIssuesLights(isssueReportedProvider.actualIssueXUser!);
        print("getIssuesLights");
      }
      if (widget.contador == 7) {
        isssueReportedProvider.cambiovistaMeasures = false;
        isssueReportedProvider
            .getIssuesMeasure(isssueReportedProvider.actualIssueXUser!);
        print("getIssuesMeasure");
      }
      if (widget.contador == 8) {
        isssueReportedProvider.cambiovistaMeasures = true;

        isssueReportedProvider
            .getIssueSecurity(isssueReportedProvider.actualIssueXUser!);
        print("getIssueSecurity");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    InventoryProvider provider = Provider.of<InventoryProvider>(context);
    IssueReportedProvider isssueReportedProvider =
        Provider.of<IssueReportedProvider>(context);
    return isssueReportedProvider.cambiovistaMeasures == true
        ? Container(
            //margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [
                BoxShadow(
                    blurRadius: 4, color: Colors.grey, offset: Offset(10, 10))
              ],
            ),
            height: 300,
            width: 600,
            child: Column(
              children: [
                Container(
                    alignment: Alignment.centerLeft,
                    // Este issue es el nombre
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(right: 40.0, left: 10),
                            child: Text(
                              "Name Issue",
                              style: TextStyle(
                                  color: AppTheme.of(context)
                                      .contenidoTablas
                                      .color,
                                  fontFamily: 'Bicyclette-Thin',
                                  fontSize: AppTheme.of(context)
                                      .contenidoTablas
                                      .fontSize,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 30.0),
                            child: Text(
                              "Issue Open",
                              style: TextStyle(
                                  color: AppTheme.of(context)
                                      .contenidoTablas
                                      .color,
                                  fontFamily: 'Bicyclette-Thin',
                                  fontSize: AppTheme.of(context)
                                      .contenidoTablas
                                      .fontSize,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ])
                      ],
                    )),
                SizedBox(
                  height: 236,
                  width: 850,
                  child: ListView(
                    children: [
                      SizedBox(
                        //color: Colors.orange,
                        height: 236,
                        width: 600,
                        child: ListView.builder(
                          itemCount: widget.issuesComments.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.only(
                                  left: 10.0, bottom: 8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    width: 150,
                                    padding: const EdgeInsets.only(left: 10.0),
                                    child: Column(
                                      children: [
                                        Text(
                                            "${widget.issuesComments[index].idIssue}"),
                                        Text(
                                          "•${widget.issuesComments[index].nameIssue.capitalize.replaceAll("_", " ")}",
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
                                          DateFormat("MMM/dd/yyyy hh:mm:ss")
                                              .format(widget
                                                  .issuesComments[index]
                                                  .dateAddedOpen),
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      width: 80,
                                      isLoading: false,
                                      icon: Icon(Icons.remove_red_eye_outlined,
                                          color: AppTheme.of(context)
                                              .primaryBackground),
                                      text: '',
                                      color: AppTheme.of(context).primaryColor,
                                      onTap: () {
                                        isssueReportedProvider
                                            .getIssuePhotosComments(
                                                widget.contador,
                                                widget.issuesComments[index]);
                                        isssueReportedProvider
                                            .setContador(widget.contador);
                                        isssueReportedProvider
                                            .setIssueViewActual(2);
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
                )
              ],
            ))
        : Container(
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [
                BoxShadow(
                    blurRadius: 4, color: Colors.grey, offset: Offset(10, 10))
              ],
            ),
            height: 300,
            width: 600,
            child: Column(
              children: [
                Container(
                    alignment: Alignment.centerLeft,
                    // Este issue es el nombre
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(right: 40.0, left: 10),
                            child: Text(
                              "Name Issue",
                              style: TextStyle(
                                  color: AppTheme.of(context)
                                      .contenidoTablas
                                      .color,
                                  fontFamily: 'Bicyclette-Thin',
                                  fontSize: AppTheme.of(context)
                                      .contenidoTablas
                                      .fontSize,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 30.0),
                            child: Text(
                              "Issue Open",
                              style: TextStyle(
                                  color: AppTheme.of(context)
                                      .contenidoTablas
                                      .color,
                                  fontFamily: 'Bicyclette-Thin',
                                  fontSize: AppTheme.of(context)
                                      .contenidoTablas
                                      .fontSize,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ])
                      ],
                    )),
                SizedBox(
                  height: 217,
                  width: 850,
                  child: ListView(
                    children: [
                      SizedBox(
                        //color: Colors.orange,
                        height: 217,
                        width: 600,
                        child: ListView.builder(
                          itemCount: widget.issuesComments.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.only(
                                  left: 10.0, bottom: 8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    width: 150,
                                    padding: const EdgeInsets.only(left: 10.0),
                                    child: Column(
                                      children: [
                                        Text(
                                          "•${"${widget.issuesComments[index].nameIssue.capitalize.replaceAll("_", " ")} = ${widget.issuesComments[index].percentage!}"}",
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
                                          DateFormat("MMM/dd/yyyy hh:mm:ss")
                                              .format(widget
                                                  .issuesComments[index]
                                                  .dateAddedOpen),
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      width: 80,
                                      isLoading: false,
                                      icon: Icon(Icons.remove_red_eye_outlined,
                                          color: AppTheme.of(context)
                                              .primaryBackground),
                                      text: '',
                                      color: AppTheme.of(context).primaryColor,
                                      onTap: () async {
                                        isssueReportedProvider
                                            .getIssuePhotosComments(
                                                widget.contador,
                                                widget.issuesComments[index]);
                                        isssueReportedProvider
                                            .setContador(widget.contador);
                                        isssueReportedProvider
                                            .setIssueViewActual(2);
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
                )
              ],
            ));
  }
}
