import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rta_crm_cv/providers/ctrlv/inventory_provider.dart';

import '../../../../providers/ctrlv/issue_reported_provider.dart';
import '../../../../widgets/captura/custom_text_field.dart';
import '../widgets/employeeIssuesCard.dart';
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
    print("---------------------");
    print("Se reconstruyo IssuesPopUP");

    //InventoryProvider provider = Provider.of<InventoryProvider>(context);
    IssueReportedProvider isssueReportedProvider =
        Provider.of<IssueReportedProvider>(context);

    final int cadena = isssueReportedProvider.issuesxUser.length;
    print("valor issuesView: ${isssueReportedProvider.issuesView}");
    return isssueReportedProvider.issuesView == 0
        ? Container(
            width: 200,
            height: 200,
            child: Column(
              children: [
                // Padding(
                //   padding: const EdgeInsets.only(bottom: 20),
                //   child: CustomTextField(
                //     width: 400,
                //     enabled: true,
                //     controller: provider.searchController,
                //     icon: Icons.search,
                //     label: 'Search',
                //     keyboardType: TextInputType.text,
                //   ),
                // ),
                SizedBox(
                  width: 400,
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
