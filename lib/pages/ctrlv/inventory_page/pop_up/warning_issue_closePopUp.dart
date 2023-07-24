import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:rta_crm_cv/providers/ctrlv/issue_reported_provider.dart';

import '../../../../public/colors.dart';
import '../../../../theme/theme.dart';
import '../../../../widgets/custom_text_icon_button.dart';

class WarningIssueClosePopUp extends StatefulWidget {
  const WarningIssueClosePopUp({super.key});

  @override
  State<WarningIssueClosePopUp> createState() => _WarningIssueClosePopUpState();
}

class _WarningIssueClosePopUpState extends State<WarningIssueClosePopUp> {
  @override
  Widget build(BuildContext context) {
    IssueReportedProvider provider =
        Provider.of<IssueReportedProvider>(context);

    return AlertDialog(
      backgroundColor: Colors.transparent,
      content: Container(
        width: 300,
        height: 300,
        decoration: BoxDecoration(
            gradient: whiteGradient,
            boxShadow: const [
              BoxShadow(
                  blurRadius: 4, color: Colors.grey, offset: Offset(10, 10))
            ],
            borderRadius: BorderRadius.circular(10)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 10),
                    child: CustomTextIconButton(
                      width: 96,
                      isLoading: false,
                      icon: Icon(Icons.exit_to_app_outlined,
                          color: AppTheme.of(context).primaryBackground),
                      text: 'Exit',
                      color: AppTheme.of(context).primaryColor,
                      onTap: () async {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      " ¿Are you sure you want to Close the Issue?",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          " Issue Name: ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                            " ${provider.registroIssueComments!.nameIssue} "),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            CustomTextIconButton(
              width: 96,
              isLoading: false,
              icon: Icon(Icons.dangerous_outlined,
                  color: AppTheme.of(context).primaryBackground),
              text: 'Delete',
              color: AppTheme.of(context).secondaryColor,
              onTap: () async {
                provider.closeIssue();
                context.pop();
              },
            ),
          ],
        ),
      ),
    );
  }
}
