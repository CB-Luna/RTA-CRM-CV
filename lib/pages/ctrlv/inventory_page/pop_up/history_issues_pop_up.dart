import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:rta_crm_cv/widgets/custom_card.dart';

import '../../../../providers/ctrlv/issue_reported_provider.dart';
import '../../../../theme/theme.dart';
import '../../../../widgets/custom_text_icon_button.dart';

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
          height: MediaQuery.of(context).size.width * 0.5,
          width: MediaQuery.of(context).size.width * 0.5,
          title: "History of Issues Closed",
          child: Column(
            children: [
              CustomTextIconButton(
                width: 60,
                isLoading: false,
                icon: Icon(Icons.arrow_back_outlined,
                    color: AppTheme.of(context).primaryBackground),
                text: '',
                color: AppTheme.of(context).primaryColor,
                onTap: () async {
                  context.pop();
                },
              ),
              Text("Text")
            ],
          )),
    );
  }
}
