// ignore_for_file: file_names

import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rta_crm_cv/widgets/custom_card.dart';

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
  @override
  build(BuildContext context) {
    IssueReportedProvider issueReportedProvider = Provider.of<IssueReportedProvider>(context);
    return AlertDialog(
        backgroundColor: Colors.transparent,
        content: CustomCard(
          width: MediaQuery.of(context).size.width * 0.45,
          height: MediaQuery.of(context).size.height * 0.4,
          title: widget.text,
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.only(right: 40.0),
                    child: CustomTextIconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      text: "",
                      isLoading: false,
                      onTap: () {
                        context.pop();
                      },
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.1,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.1,
                      height: MediaQuery.of(context).size.height * 0.03,
                      decoration: BoxDecoration(
                        color: statusColor(issueReportedProvider.actualVehicle!.company.company, context),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          issueReportedProvider.actualVehicle!.licesensePlates,
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.45,
                height: MediaQuery.of(context).size.height * 0.2,
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
                            width: MediaQuery.of(context).size.width * 0.2,
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Column(
                              children: [
                                Text("${widget.issueComments[index].idIssue}"),
                                Text(
                                  "•${widget.issueComments[index].nameIssue.capitalize.replaceAll("_", " ")}",
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
                                  DateFormat("MMM/dd/yyyy hh:mm:ss").format(widget.issueComments[index].dateAddedOpen),
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
                                issueReportedProvider.selectIssueOpenClose(index, widget.issueComments);
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return StatefulBuilder(builder: (context, setState) {
                                        issueReportedProvider.setContador(widget.contador, notify: false);
                                        issueReportedProvider.getIssuePhotosComments(widget.contador, widget.issueComments[index], notify: true);
                                        return const CommentsPhotosPopUp();
                                      });
                                    });
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

Color statusColor(String status, BuildContext context) {
  late Color color;

  switch (status) {
    case "ODE": //Sales Form
      color = AppTheme.of(context).odePrimary;
      break;
    case "SMI": //Sen. Exec. Validate
      color = AppTheme.of(context).smiPrimary;
      break;
    case "CRY": //Finance Validate
      color = AppTheme.of(context).cryPrimary;
      break;

    default:
      return Colors.black;
  }
  return color;
}
