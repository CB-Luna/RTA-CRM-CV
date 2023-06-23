import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:rta_crm_cv/pages/ctrlv/inventory_page/pop_up/comments_photos_pop_up.dart';
import 'package:rta_crm_cv/providers/ctrlv/inventory_provider.dart';
import 'package:rta_crm_cv/widgets/custom_card.dart';

import '../../../../widgets/captura/custom_text_field.dart';
import '../widgets/employeeIssuesCard.dart';
import 'reported_issues_pop_up.dart';

class IssuesPopUp extends StatefulWidget {
  const IssuesPopUp({super.key});

  @override
  State<IssuesPopUp> createState() => _IssuesPopUpState();
}

class _IssuesPopUpState extends State<IssuesPopUp> {
  @override
  Widget build(BuildContext context) {
    InventoryProvider provider = Provider.of<InventoryProvider>(context);
    final int cadena = provider.issuesxUser.length;

    return AlertDialog(
        shadowColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        content: provider.issuesView == 0
            ? CustomCard(
                width: 450,
                height: 650,
                title: "Issues Reported",
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: CustomTextField(
                        width: MediaQuery.of(context).size.width,
                        enabled: true,
                        controller: provider.searchController,
                        icon: Icons.search,
                        label: 'Search',
                        keyboardType: TextInputType.text,
                      ),
                    ),
                    SizedBox(
                      height: 450,
                      width: 450,
                      child: ListView.builder(
                          padding: const EdgeInsets.all(8),
                          itemCount: cadena,
                          itemBuilder: (BuildContext context, int index) {
                            provider.selectIssuesXUser(index);
                            return const Padding(
                              padding: EdgeInsets.only(bottom: 5.0),
                              child: EmployeeIssuesCard(),
                            );
                          }),
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                          onPressed: () {
                            context.pop();
                          },
                          child: const Text("Exit")),
                    ),
                  ],
                ),
              )
            : provider.issuesView == 1
                ? const ReportedIssues()
                : provider.issuesView == 2
                    ? const CommentsPhotosPopUp()
                    : Container());
  }
}
