import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rta_crm_cv/public/colors.dart';

import '../../../../providers/ctrlv/issue_reported_provider.dart';
import '../../../../public/colors.dart';
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
                Container(
                  color: Colors.yellow,
                  height: MediaQuery.of(context).size.height - 367,
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: CustomTextField(
                          width: 400,
                          enabled: true,
                          controller: isssueReportedProvider.searchController,
                          icon: Icons.search,
                          label: 'Search',
                          keyboardType: TextInputType.text,
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 307,
                        child: ListView.builder(
                            padding: const EdgeInsets.all(8),
                            itemCount: cadena,
                            itemBuilder: (BuildContext context, int index) {
                              isssueReportedProvider.selectIssuesXUser(index);
                              return const Padding(
                                padding: EdgeInsets.only(bottom: 5.0),
                                child: EmployeeIssuesCard(),
                              );
                            }),
                      ),
                    ],
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
