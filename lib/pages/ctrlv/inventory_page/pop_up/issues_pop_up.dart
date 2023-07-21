import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rta_crm_cv/public/colors.dart';

import '../../../../providers/ctrlv/issue_reported_provider.dart';
import '../../../../theme/theme.dart';
import '../../../../widgets/captura/custom_text_field.dart';
import '../widgets/employeeIssuesCard.dart';
import '../widgets/infovehicleCard.dart';
import 'comments_photos_pop_up.dart';
import 'reported_issues_pop_up.dart';

class IssuesPopUp extends StatefulWidget {
  const IssuesPopUp({super.key});

  @override
  State<IssuesPopUp> createState() => _IssuesPopUpState();
}

class _IssuesPopUpState extends State<IssuesPopUp> {
  @override
  Widget build(BuildContext context) {
    IssueReportedProvider isssueReportedProvider =
        Provider.of<IssueReportedProvider>(context);

    final int cadena = isssueReportedProvider.issuesxUser.length;
    print("valor issuesView: ${isssueReportedProvider.issuesView}");
    return isssueReportedProvider.issuesView == 0
        ? Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(
                      top: 10.0, left: 10.0, right: 50.0, bottom: 10.0),
                  height: MediaQuery.of(context).size.height - 600,
                  width: MediaQuery.of(context).size.width * 0.5,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: whiteGradient),
                  child: const InfoVehicleCard(),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        width: 300,
                        height: 31,
                        padding: const EdgeInsets.only(left: 10.0),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: AppTheme.of(context).primaryBackground,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 0.1,
                                blurRadius: 3,
                                offset: const Offset(
                                    0, 0), // changes position of shadow
                              ),
                            ]),
                        child:
                            const Text("List of the Employees of the Vehicle")),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10, right: 20.0),
                      child: CustomTextField(
                        width: 200,
                        enabled: true,
                        controller: isssueReportedProvider.searchController,
                        icon: Icons.search,
                        label: 'Search',
                        keyboardType: TextInputType.text,
                      ),
                    ),
                  ],
                ),
                SingleChildScrollView(
                  child: Container(
                    height: MediaQuery.of(context).size.height - 403,
                    width: MediaQuery.of(context).size.width * 0.5,
                    margin: const EdgeInsets.only(
                        top: 10.0, left: 10.0, right: 50.0, bottom: 10.0),
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: AppTheme.of(context).primaryColor, width: 2),
                        borderRadius: BorderRadius.circular(20),
                        gradient: whiteGradient),
                    child: Column(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 290,
                          child: ListView.builder(
                              padding: const EdgeInsets.all(8),
                              itemCount: cadena,
                              itemBuilder: (BuildContext context, int index) {
                                isssueReportedProvider.selectIssuesXUser(index);
                                return const Padding(
                                  padding: EdgeInsets.only(bottom: 20.0),
                                  child: EmployeeIssuesCard(),
                                );
                              }),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        : isssueReportedProvider.issuesView == 1
            ? const ReportedIssues()
            : isssueReportedProvider.issuesView == 2
                ? const CommentsPhotosPopUp()
                : Container(
                    height: 1200,
                  );
  }
}
