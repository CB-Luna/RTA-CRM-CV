import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:rta_crm_cv/pages/ctrlv/inventory_page/pop_up/comments_photos_pop_up.dart';
import 'package:rta_crm_cv/providers/ctrlv/inventory_provider.dart';
import 'package:rta_crm_cv/widgets/custom_card.dart';

import '../../../../theme/theme.dart';
import '../../../../widgets/captura/custom_text_field.dart';
import '../../../../widgets/custom_text_icon_button.dart';
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

    return provider.issuesView == 0
        ? SizedBox(
            height: 500,
            width: 1400,
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
                  width: 1400,
                  height: 307,
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
                // Container(
                //   alignment: Alignment.centerRight,
                //   padding: const EdgeInsets.all(8.0),
                //   child: Padding(
                //     padding: const EdgeInsets.only(left: 10),
                //     child: CustomTextIconButton(
                //       width: 82,
                //       isLoading: false,
                //       icon: Icon(Icons.exit_to_app_outlined,
                //           color: AppTheme.of(context).primaryBackground),
                //       text: 'Exit',
                //       color: AppTheme.of(context).primaryColor,
                //       onTap: () async {
                //         context.pop();
                //       },
                //     ),
                //   ),
                // ),
              ],
            ),
          )
        : provider.issuesView == 1
            ? const ReportedIssues()
            // : provider.issuesView == 2
            //     ? const CommentsPhotosPopUp()
            : Container(
                height: 500,
              );
  }
}
