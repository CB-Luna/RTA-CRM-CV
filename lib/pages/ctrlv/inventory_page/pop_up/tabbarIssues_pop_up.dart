import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../providers/ctrlv/issue_reported_provider.dart';
import '../../../../public/colors.dart';
import '../../../../theme/theme.dart';

class TabbarIssuePopUp extends StatefulWidget {
  const TabbarIssuePopUp({super.key});

  @override
  State<TabbarIssuePopUp> createState() => _TabbarIssuePopUpState();
}

class _TabbarIssuePopUpState extends State<TabbarIssuePopUp> {
  @override
  Widget build(BuildContext context) {
    IssueReportedProvider issueReportedProvider =
        Provider.of<IssueReportedProvider>(context);

    return Container(
      padding: const EdgeInsets.all(10.0),
      width: MediaQuery.of(context).size.width * 0.6,
      height: MediaQuery.of(context).size.height * 0.1,
      child: DefaultTabController(
        length: issueReportedProvider.issuesxUser.length,
        initialIndex: 0,
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: whiteGradient,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(15),
                  bottomRight: Radius.circular(40),
                  bottomLeft: Radius.circular(15),
                ),
                border: Border.all(
                    color: AppTheme.of(context).primaryColor, width: 2),
              ),
              child: TabBar(
                onTap: (value) async {
                  issueReportedProvider.selectIssuesXUser(value);
                  if (value == 0) {
                    issueReportedProvider.clearListasdegetIssues();

                    await issueReportedProvider
                        .getIssuesAll(issueReportedProvider.actualVehicle!);

                    print(" Entro a getIssuesALL");
                  } else {
                    // issueReportedProvider.clearListasdegetIssues();

                    await issueReportedProvider
                        .getIssues(issueReportedProvider.actualIssueXUser!);
                  }
                },
                indicator: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(15),
                    bottomRight: Radius.circular(40),
                    bottomLeft: Radius.circular(15),
                  ),
                  color: issueReportedProvider.indexSelected[1]
                      ? Colors.greenAccent
                      : issueReportedProvider.indexSelected[0]
                          ? Colors.blue
                          : issueReportedProvider.indexSelected[2]
                              ? Colors.yellow
                              : Colors.black,
                ),
                splashBorderRadius: BorderRadius.circular(40),
                labelStyle: const TextStyle(
                  fontFamily: 'UniNeue',
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
                unselectedLabelColor: AppTheme.of(context).primaryColor,
                unselectedLabelStyle: const TextStyle(
                  fontFamily: 'UniNeue',
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                  fontSize: 15,
                ),
                tabs: List.generate(issueReportedProvider.issuesxUser.length,
                    (index) {
                  if (index == 0) {
                    return const Tab(
                      text: "All",
                    );
                  } else {
                    return Tab(
                      text: issueReportedProvider.issuesxUser[index].name,
                    );
                  }
                }),
              ),
            ),
            //
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.001,
              child: TabBarView(
                children: List.generate(
                    issueReportedProvider.issuesxUser.length,
                    (index) => const SizedBox.shrink()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
