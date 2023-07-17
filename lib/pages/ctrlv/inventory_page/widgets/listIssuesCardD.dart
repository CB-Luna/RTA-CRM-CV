import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../models/issues_open_close.dart';
import '../../../../providers/ctrlv/issue_reported_provider.dart';
import '../../../../public/colors.dart';
import '../../../../theme/theme.dart';
import '../../../../widgets/custom_text_icon_button.dart';

class ListIssuesCardD extends StatefulWidget {
  final List<IssueOpenclose> issuesComments;
  final int contador;
  const ListIssuesCardD(
      {super.key, required this.issuesComments, required this.contador});

  @override
  State<ListIssuesCardD> createState() => _ListIssuesCardDState();
}

class _ListIssuesCardDState extends State<ListIssuesCardD> {
  @override
  Widget build(BuildContext context) {
    IssueReportedProvider isssueReportedProvider =
        Provider.of<IssueReportedProvider>(context);
    return isssueReportedProvider.cambiovistaMeasures == true
        ? Container(
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              gradient: whiteGradient,
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [
                BoxShadow(
                    blurRadius: 4, color: Colors.grey, offset: Offset(10, 10))
              ],
              border: Border.all(
                  color: AppTheme.of(context).primaryColor, width: 2),
            ),
            height: 500,
            width: 600,
            child: Column(
              children: [
                Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.all(10.0),
                    // Este issue es el nombre
                    child: Row(children: [
                      Container(
                        width: 150,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          gradient: whiteGradient,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(15),
                            bottomRight: Radius.circular(40),
                            bottomLeft: Radius.circular(15),
                          ),
                          border: Border.all(
                              color: AppTheme.of(context).primaryColor,
                              width: 2),
                        ),
                        child: Text(
                          "Name Issue",
                          style: TextStyle(
                              color: AppTheme.of(context).contenidoTablas.color,
                              fontFamily: 'Bicyclette-Thin',
                              fontSize:
                                  AppTheme.of(context).contenidoTablas.fontSize,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        width: 150,
                        margin: const EdgeInsets.only(left: 30),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          gradient: whiteGradient,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(15),
                            bottomRight: Radius.circular(40),
                            bottomLeft: Radius.circular(15),
                          ),
                          border: Border.all(
                              color: AppTheme.of(context).primaryColor,
                              width: 2),
                        ),
                        child: Text(
                          "Issue Open",
                          style: TextStyle(
                              color: AppTheme.of(context).contenidoTablas.color,
                              fontFamily: 'Bicyclette-Thin',
                              fontSize:
                                  AppTheme.of(context).contenidoTablas.fontSize,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        width: 150,
                        margin: const EdgeInsets.only(left: 30),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          gradient: whiteGradient,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(15),
                            bottomRight: Radius.circular(40),
                            bottomLeft: Radius.circular(15),
                          ),
                          border: Border.all(
                              color: AppTheme.of(context).primaryColor,
                              width: 2),
                        ),
                        child: Text(
                          "Issue Close",
                          style: TextStyle(
                              color: AppTheme.of(context).contenidoTablas.color,
                              fontFamily: 'Bicyclette-Thin',
                              fontSize:
                                  AppTheme.of(context).contenidoTablas.fontSize,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ])),
                SizedBox(
                  height: 379,
                  width: 850,
                  child: ListView(
                    children: [
                      SizedBox(
                        //color: Colors.orange,
                        height: 500,
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
                                    width: 125,
                                    padding: const EdgeInsets.only(left: 10.0),
                                    child: Column(
                                      children: [
                                        Text(
                                            "${widget.issuesComments[index].idIssue}"),
                                        Text(
                                          "•${widget.issuesComments[index].nameIssue.capitalize.replaceAll("_", " ")}",
                                          style: TextStyle(
                                            color: const Color(0XFF25A531),
                                            fontFamily: 'Bicyclette-Thin',
                                            fontSize: AppTheme.of(context)
                                                .contenidoTablas
                                                .fontSize,
                                          ),
                                          // style:
                                          //     const TextStyle(color: Colors.orange),
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
            ))
        : Container(
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              gradient: whiteGradient,
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [
                BoxShadow(
                    blurRadius: 4, color: Colors.grey, offset: Offset(10, 10))
              ],
              border: Border.all(
                  color: AppTheme.of(context).primaryColor, width: 2),
            ),
            height: 500,
            width: 600,
            child: Column(
              children: [
                Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.all(10.0),

                    // Este issue es el nombre
                    child: Row(
                      children: [
                        Row(children: [
                          Container(
                            width: 150,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              gradient: whiteGradient,
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(40),
                                topRight: Radius.circular(15),
                                bottomRight: Radius.circular(40),
                                bottomLeft: Radius.circular(15),
                              ),
                              border: Border.all(
                                  color: AppTheme.of(context).primaryColor,
                                  width: 2),
                            ),
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
                          Container(
                            width: 150,
                            margin: const EdgeInsets.only(left: 30),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              gradient: whiteGradient,
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(40),
                                topRight: Radius.circular(15),
                                bottomRight: Radius.circular(40),
                                bottomLeft: Radius.circular(15),
                              ),
                              border: Border.all(
                                  color: AppTheme.of(context).primaryColor,
                                  width: 2),
                            ),
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
                          Container(
                            width: 150,
                            margin: const EdgeInsets.only(left: 30),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              gradient: whiteGradient,
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(40),
                                topRight: Radius.circular(15),
                                bottomRight: Radius.circular(40),
                                bottomLeft: Radius.circular(15),
                              ),
                              border: Border.all(
                                  color: AppTheme.of(context).primaryColor,
                                  width: 2),
                            ),
                            child: Text(
                              "Issue Close",
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
                  height: 379,
                  width: 850,
                  child: ListView(
                    children: [
                      SizedBox(
                        //color: Colors.orange,
                        height: 500,
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
                                    width: 125,
                                    padding: const EdgeInsets.only(left: 10.0),
                                    child: Column(
                                      children: [
                                        Text(
                                          "•${"${widget.issuesComments[index].nameIssue.capitalize.replaceAll("_", " ")} = ${widget.issuesComments[index].percentage!}"}",
                                          style: TextStyle(
                                            color: const Color(0XFF25A531),
                                            fontFamily: 'Bicyclette-Thin',
                                            fontSize: AppTheme.of(context)
                                                .contenidoTablas
                                                .fontSize,
                                          ),
                                          // style:
                                          //     const TextStyle(color: Colors.orange),
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
