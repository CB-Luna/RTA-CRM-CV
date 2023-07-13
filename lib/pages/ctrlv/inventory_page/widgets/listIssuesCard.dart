import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../models/issues_open_close.dart';
import '../../../../providers/ctrlv/issue_reported_provider.dart';
import '../../../../theme/theme.dart';
import '../../../../widgets/custom_text_icon_button.dart';

class ListIssuesCard extends StatefulWidget {
  final List<IssueOpenclose> issuesComments;
  final int contador;
  const ListIssuesCard({super.key, required this.issuesComments, required this.contador});

  @override
  State<ListIssuesCard> createState() => _ListIssuesCardState();
}

class _ListIssuesCardState extends State<ListIssuesCard> {
  @override
  void initState() {
    super.initState();

    setState(() {
      context.read<IssueReportedProvider>();
      context.read<IssueReportedProvider>().clearListgetIssues();
      if (widget.contador == 1) {
        context.read<IssueReportedProvider>().cambiovistaMeasures = true;

        context.read<IssueReportedProvider>().getIssuesFluidCheck(context.read<IssueReportedProvider>().actualIssueXUser!);

        //print ("getIssuesFluidCheck");
      }
      if (widget.contador == 2) {
        context.read<IssueReportedProvider>().cambiovistaMeasures = true;

        context.read<IssueReportedProvider>().getIssuesCarBodywork(context.read<IssueReportedProvider>().actualIssueXUser!);
        //print ("getCarbodywork");
      }
      if (widget.contador == 3) {
        context.read<IssueReportedProvider>().cambiovistaMeasures = true;

        context.read<IssueReportedProvider>().getIssuesEquipment(context.read<IssueReportedProvider>().actualIssueXUser!);
        //print ("getequipment");
      }
      if (widget.contador == 4) {
        context.read<IssueReportedProvider>().cambiovistaMeasures = true;

        context.read<IssueReportedProvider>().getIssuesExtra(context.read<IssueReportedProvider>().actualIssueXUser!);
        // //print ("getextra");
      }
      if (widget.contador == 5) {
        context.read<IssueReportedProvider>().cambiovistaMeasures = true;

        context.read<IssueReportedProvider>().getIssuesBasics(context.read<IssueReportedProvider>().actualIssueXUser!);
        ////print  ("getBucketInspection");
      }
      if (widget.contador == 6) {
        context.read<IssueReportedProvider>().cambiovistaMeasures = true;

        context.read<IssueReportedProvider>().getIssuesLights(context.read<IssueReportedProvider>().actualIssueXUser!);
        //print ("getIssuesLights");
      }
      if (widget.contador == 7) {
        context.read<IssueReportedProvider>().cambiovistaMeasures = false;
        context.read<IssueReportedProvider>().getIssuesMeasure(context.read<IssueReportedProvider>().actualIssueXUser!);
        //print ("getIssuesMeasure");
      }
      if (widget.contador == 8) {
        context.read<IssueReportedProvider>().cambiovistaMeasures = true;

        context.read<IssueReportedProvider>().getIssueSecurity(context.read<IssueReportedProvider>().actualIssueXUser!);
        //print ("getIssueSecurity");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    IssueReportedProvider isssueReportedProvider = Provider.of<IssueReportedProvider>(context);
    return isssueReportedProvider.cambiovistaMeasures == true
        ? Container(
            //margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [BoxShadow(blurRadius: 4, color: Colors.grey, offset: Offset(10, 10))],
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
                            padding: const EdgeInsets.only(right: 40.0, left: 10),
                            child: Text(
                              "Name Issue",
                              style: TextStyle(
                                  color: AppTheme.of(context).contenidoTablas.color,
                                  fontFamily: 'Bicyclette-Thin',
                                  fontSize: AppTheme.of(context).contenidoTablas.fontSize,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 30.0),
                            child: Text(
                              "Issue Open",
                              style: TextStyle(
                                  color: AppTheme.of(context).contenidoTablas.color,
                                  fontFamily: 'Bicyclette-Thin',
                                  fontSize: AppTheme.of(context).contenidoTablas.fontSize,
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
                              padding: const EdgeInsets.only(left: 10.0, bottom: 8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    width: 150,
                                    padding: const EdgeInsets.only(left: 10.0),
                                    child: Column(
                                      children: [
                                        Text("${widget.issuesComments[index].idIssue}"),
                                        Text(
                                          "•${widget.issuesComments[index].nameIssue.capitalize.replaceAll("_", " ")}",
                                          style: TextStyle(
                                            color: Colors.orange,
                                            fontFamily: 'Bicyclette-Thin',
                                            fontSize: AppTheme.of(context).contenidoTablas.fontSize,
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
                                          DateFormat("MMM/dd/yyyy hh:mm:ss").format(widget.issuesComments[index].dateAddedOpen),
                                          style: TextStyle(
                                            color: AppTheme.of(context).contenidoTablas.color,
                                            fontFamily: 'Bicyclette-Thin',
                                            fontSize: AppTheme.of(context).contenidoTablas.fontSize,
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
                                      icon: Icon(Icons.remove_red_eye_outlined, color: AppTheme.of(context).primaryBackground),
                                      text: '',
                                      color: AppTheme.of(context).primaryColor,
                                      onTap: () {
                                        isssueReportedProvider.getIssuePhotosComments(widget.contador, widget.issuesComments[index]);
                                        isssueReportedProvider.setContador(widget.contador);
                                        isssueReportedProvider.setIssueViewActual(2);
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
              boxShadow: const [BoxShadow(blurRadius: 4, color: Colors.grey, offset: Offset(10, 10))],
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
                            padding: const EdgeInsets.only(right: 40.0, left: 10),
                            child: Text(
                              "Name Issue",
                              style: TextStyle(
                                  color: AppTheme.of(context).contenidoTablas.color,
                                  fontFamily: 'Bicyclette-Thin',
                                  fontSize: AppTheme.of(context).contenidoTablas.fontSize,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 30.0),
                            child: Text(
                              "Issue Open",
                              style: TextStyle(
                                  color: AppTheme.of(context).contenidoTablas.color,
                                  fontFamily: 'Bicyclette-Thin',
                                  fontSize: AppTheme.of(context).contenidoTablas.fontSize,
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
                              padding: const EdgeInsets.only(left: 10.0, bottom: 8.0),
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
                                            fontSize: AppTheme.of(context).contenidoTablas.fontSize,
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
                                          DateFormat("MMM/dd/yyyy hh:mm:ss").format(widget.issuesComments[index].dateAddedOpen),
                                          style: TextStyle(
                                            color: AppTheme.of(context).contenidoTablas.color,
                                            fontFamily: 'Bicyclette-Thin',
                                            fontSize: AppTheme.of(context).contenidoTablas.fontSize,
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
                                      icon: Icon(Icons.remove_red_eye_outlined, color: AppTheme.of(context).primaryBackground),
                                      text: '',
                                      color: AppTheme.of(context).primaryColor,
                                      onTap: () async {
                                        isssueReportedProvider.getIssuePhotosComments(widget.contador, widget.issuesComments[index]);
                                        isssueReportedProvider.setContador(widget.contador);
                                        isssueReportedProvider.setIssueViewActual(2);
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
