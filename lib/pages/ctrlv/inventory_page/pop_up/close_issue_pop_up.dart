import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rta_crm_cv/pages/ctrlv/inventory_page/pop_up/warning_issue_closePopUp.dart';
import 'package:rta_crm_cv/widgets/custom_card.dart';

import '../../../../providers/ctrlv/issue_reported_provider.dart';
import '../../../../theme/theme.dart';
import '../../../../widgets/custom_text_fieldForm.dart';
import '../../../../widgets/custom_text_icon_button.dart';

class CloseIssuePopUp extends StatefulWidget {
  const CloseIssuePopUp({super.key});

  @override
  State<CloseIssuePopUp> createState() => _CloseIssuePopUpState();
}

class _CloseIssuePopUpState extends State<CloseIssuePopUp> {
  FToast fToast = FToast();

  final MaterialStateProperty<Icon?> thumbIcon =
      MaterialStateProperty.resolveWith<Icon?>(
    (Set<MaterialState> states) {
      if (states.contains(MaterialState.selected)) {
        return const Icon(Icons.check);
      }
      return const Icon(Icons.close);
    },
  );
  @override
  Widget build(BuildContext context) {
    fToast.init(context);
    IssueReportedProvider isssueReportedProvider =
        Provider.of<IssueReportedProvider>(context);
    final formKey = GlobalKey<FormState>();
    DateTime date = DateTime.now();
    return AlertDialog(
      backgroundColor: Colors.transparent,
      content: CustomCard(
        title: 'Close Issue',
        height: 300,
        width: 380,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      child: CustomTextFieldForm(
                          label: 'Date of the finished Issue',
                          controller: isssueReportedProvider
                              .dateTimeClosedIssueController,
                          enabled: true,
                          onTapCheck: true,
                          width: 350,
                          keyboardType: TextInputType.name,
                          onTap: () async {
                            DateTime? newDate = await showDatePicker(
                                context: context,
                                initialDate: date,
                                firstDate: DateTime(1980),
                                lastDate: DateTime(2050));

                            if (newDate != null) {
                              isssueReportedProvider
                                      .dateTimeClosedIssueController.text =
                                  DateFormat("MM/dd/yyyy").format(newDate);
                            }
                          }),
                    ),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomTextIconButton(
                    isLoading: false,
                    icon: Icon(Icons.save_outlined,
                        color: AppTheme.of(context).primaryBackground),
                    text: 'Close Issue',
                    onTap: () async {
                      if (!formKey.currentState!.validate()) {
                        return;
                      }
                      await showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return StatefulBuilder(
                                builder: (context, setState) {
                              return const WarningIssueClosePopUp();
                            });
                          });
                    }),
                CustomTextIconButton(
                  isLoading: false,
                  icon: Icon(Icons.exit_to_app_outlined,
                      color: AppTheme.of(context).primaryBackground),
                  text: 'Exit',
                  onTap: () {
                    context.pop();
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
