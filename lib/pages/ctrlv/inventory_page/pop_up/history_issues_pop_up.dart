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
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      IssueReportedProvider provider =
          Provider.of<IssueReportedProvider>(context, listen: false);

      await provider.getIssueBucketInspectionClosed(provider.actualIssueXUser!);
      await provider.getIssuesFluidCheckClosed(provider.actualIssueXUser!);
      await provider.getIssuesLightsClosed(provider.actualIssueXUser!);
      await provider.getIssuesCarBodyworkClosed(provider.actualIssueXUser!);
      await provider.getIssueSecurityClosed(provider.actualIssueXUser!);
      await provider.getIssuesExtraClosed(provider.actualIssueXUser!);
      await provider.getIssuesEquipmentClosed(provider.actualIssueXUser!);

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
                              Row(
                                children: [
                                  const Text(
                                    "Name Issue:  ",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    issueReportedProvider
                                        .listTotalClosedIssue[index].nameIssue,
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  const Text(
                                    "Date:  ",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    issueReportedProvider
                                                .listTotalClosedIssue[index]
                                                .dateAddedClose ==
                                            null
                                        ? " No date "
                                        : "${issueReportedProvider.listTotalClosedIssue[index].dateAddedClose}",
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  const Text(
                                    "Category:  ",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    " ${issueReportedProvider.listTotalClosedIssue[index].category}",
                                  )
                                ],
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
