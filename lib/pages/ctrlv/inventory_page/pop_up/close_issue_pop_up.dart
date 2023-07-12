import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rta_crm_cv/widgets/custom_card.dart';

import '../../../../providers/ctrlv/inventory_provider.dart';
import '../../../../providers/ctrlv/issue_reported_provider.dart';
import '../../../../services/api_error_handler.dart';
import '../../../../theme/theme.dart';
import '../../../../widgets/custom_text_fieldForm.dart';
import '../../../../widgets/custom_text_icon_button.dart';
import '../../../../widgets/success_toast.dart';

class CloseIssuePopUp extends StatefulWidget {
  const CloseIssuePopUp({super.key});

  @override
  State<CloseIssuePopUp> createState() => _CloseIssuePopUpState();
}

class _CloseIssuePopUpState extends State<CloseIssuePopUp> {
  FToast fToast = FToast();
  bool light0 = true;
  bool light1 = true;

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
    print(isssueReportedProvider.registroIssueComments!.nameIssue);
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
                    Row(
                      children: [
                        Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 0.1,
                                  blurRadius: 3,
                                  offset: const Offset(
                                      0, 0), // changes position of shadow
                                ),
                              ],
                            ),
                            width: 200,
                            height: 35,
                            alignment: Alignment.center,
                            child: Text(
                              "The issue is Closed: ",
                              style: TextStyle(
                                color: AppTheme.of(context).primaryColor,
                                fontFamily: 'Bicyclette-Thin',
                                fontSize: AppTheme.of(context)
                                    .contenidoTablas
                                    .fontSize,
                              ),
                            )),
                        // const SwitchExample(),

                        Switch(
                          thumbIcon: thumbIcon,
                          value: light1,
                          onChanged: (bool value) {
                            setState(() {
                              light1 = value;
                              if (light1 != false) {
                                print("Verdadero");
                              } else {
                                print("falso");
                              }
                            });
                          },
                        ),
                      ],
                    ),
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
                      if (light1 != false) {
                        bool res = await isssueReportedProvider.closeIssue();
                        if (!res) {
                          await ApiErrorHandler.callToast(
                              'Error al Cerrar el Issue');
                          return;
                        }
                        if (!mounted) return;
                        fToast.showToast(
                          child: const SuccessToast(
                            message: 'Issue Closed Succesfuly',
                          ),
                          gravity: ToastGravity.BOTTOM,
                          toastDuration: const Duration(seconds: 2),
                        );

                        if (context.canPop()) context.pop();
                        context.pop();
                      } else {
                        print("falso");
                      }
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

class SwitchExample extends StatefulWidget {
  const SwitchExample({super.key});

  @override
  State<SwitchExample> createState() => _SwitchExampleState();
}

class _SwitchExampleState extends State<SwitchExample> {
  bool light0 = true;
  bool light1 = true;

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
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Switch(
          thumbIcon: thumbIcon,
          value: light1,
          onChanged: (bool value) {
            setState(() {
              light1 = value;
              if (light1 != false) {
                print("Verdadero");
              } else {
                print("falso");
              }
            });
          },
        ),
      ],
    );
  }
}
