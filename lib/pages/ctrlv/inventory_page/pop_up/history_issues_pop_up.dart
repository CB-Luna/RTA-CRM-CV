import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
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
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      IssueReportedProvider provider =
          Provider.of<IssueReportedProvider>(context, listen: false);

      if (provider.statePrueba == false) {
        await provider.getIssueBucketInspectionClosed(
            provider.actualIssueXUser!, provider.statePrueba = false); // Listo
        await provider.getIssuesFluidCheckClosed(
            provider.actualIssueXUser!, provider.statePrueba = false); // Listo
        await provider.getIssuesLightsClosed(
            provider.actualIssueXUser!, provider.statePrueba = false); // Listo
        await provider.getIssuesCarBodyworkClosed(
            provider.actualIssueXUser!, provider.statePrueba = false); // Listo
        await provider.getIssueSecurityClosed(
            provider.actualIssueXUser!, provider.statePrueba = false); // Listo
        await provider.getIssuesExtraClosed(
            provider.actualIssueXUser!, provider.statePrueba = false); // Listo
        await provider.getIssuesEquipmentClosed(
            provider.actualIssueXUser!, provider.statePrueba = false);
      } else {
        await provider.getIssueBucketInspectionClosed(
            provider.actualIssueXUser!, provider.statePrueba = true); // Listo
        await provider.getIssuesFluidCheckClosed(
            provider.actualIssueXUser!, provider.statePrueba = true); // Listo
        await provider.getIssuesLightsClosed(
            provider.actualIssueXUser!, provider.statePrueba = true);
        await provider.getIssuesCarBodyworkClosed(
            provider.actualIssueXUser!, provider.statePrueba = true); // Listo
        await provider.getIssueSecurityClosed(
            provider.actualIssueXUser!, provider.statePrueba = true); // Listo
        await provider.getIssuesExtraClosed(
            provider.actualIssueXUser!, provider.statePrueba = true); // Listo
        await provider.getIssuesEquipmentClosed(
            provider.actualIssueXUser!, provider.statePrueba = true);
      }

      //provider.getIssuesMeasuresClosed(provider.actualIssueXUer!);
    });
  }

  @override
  Widget build(BuildContext context) {
    IssueReportedProvider issueReportedProvider =
        Provider.of<IssueReportedProvider>(context);
    return AlertDialog(
      backgroundColor: Colors.transparent,
      content: CustomCard(
          height: MediaQuery.of(context).size.height * 0.8,
          width: MediaQuery.of(context).size.width * 0.4,
          title: "History of Issue Closed",
          child: Column(
            children: [
              Container(
                alignment: Alignment.topLeft,
                child: CustomTextIconButton(
                  width: 60,
                  isLoading: false,
                  icon: Icon(Icons.arrow_back_outlined,
                      color: AppTheme.of(context).primaryBackground),
                  text: '',
                  color: AppTheme.of(context).primaryColor,
                  onTap: () {
                    context.pop();
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 15),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.1,
                  height: MediaQuery.of(context).size.height * 0.03,
                  decoration: BoxDecoration(
                    color: statusColor(
                        issueReportedProvider.actualVehicle!.company.company,context),
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
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.8,
                width: MediaQuery.of(context).size.width * 0.4,
                child: ListView.builder(
                    itemCount:
                        issueReportedProvider.listTotalClosedIssue.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                          width: MediaQuery.of(context).size.width * 0.3,
                          height: MediaQuery.of(context).size.height * 0.1,
                          margin: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.1,
                                child: Wrap(
                                  children: [
                                    const Text(
                                      "Name Issue:  ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      issueReportedProvider
                                          .listTotalClosedIssue[index]
                                          .nameIssue,
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.08,
                                child: Wrap(
                                  children: [
                                    const Text(
                                      "Date:  ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(issueReportedProvider
                                                .listTotalClosedIssue[index]
                                                .dateAddedClose ==
                                            null
                                        ? " No date "
                                        : DateFormat("MM/dd/yyyy").format(
                                            issueReportedProvider
                                                .listTotalClosedIssue[index]
                                                .dateAddedClose!))
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.08,
                                child: Wrap(
                                  children: [
                                    const Text(
                                      "Category:  ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      " ${issueReportedProvider.listTotalClosedIssue[index].category}",
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ));
                    }),
              ),
            ],
          )),
    );
  }
}

Color statusColor(String status,BuildContext context) {
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
