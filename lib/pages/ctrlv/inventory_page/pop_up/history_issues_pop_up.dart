import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rta_crm_cv/widgets/custom_card.dart';

import '../../../../providers/ctrlv/issue_reported_provider.dart';

class HistoryIssuePopUp extends StatefulWidget {
  const HistoryIssuePopUp({super.key});

  @override
  State<HistoryIssuePopUp> createState() => _HistoryIssuePopUpState();
}

class _HistoryIssuePopUpState extends State<HistoryIssuePopUp> {
  @override
  Widget build(BuildContext context) {
    IssueReportedProvider isssueReportedProvider =
        Provider.of<IssueReportedProvider>(context);
    return AlertDialog(
      backgroundColor: Colors.transparent,
      content: CustomCard(
          height: MediaQuery.of(context).size.height * 0.8,
          width: MediaQuery.of(context).size.width * 0.2,
          title: "History of Issue Closed",
          child: Container()),
    );
  }
}
