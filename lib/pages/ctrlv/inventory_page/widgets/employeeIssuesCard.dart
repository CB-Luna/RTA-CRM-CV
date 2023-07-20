import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rta_crm_cv/theme/theme.dart';

import '../../../../providers/ctrlv/issue_reported_provider.dart';
import '../../../../widgets/get_image_widget.dart';

class EmployeeIssuesCard extends StatefulWidget {
  const EmployeeIssuesCard({
    super.key,
  });

  @override
  State<EmployeeIssuesCard> createState() => _EmployeeIssuesCardState();
}

class _EmployeeIssuesCardState extends State<EmployeeIssuesCard> {
  @override
  Widget build(BuildContext context) {
    //InventoryProvider provider = Provider.of<InventoryProvider>(context);
    IssueReportedProvider isssueReportedProvider =
        Provider.of<IssueReportedProvider>(context);
    return Container(
      decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(blurRadius: 4, color: Colors.grey, offset: Offset(10, 10))
          ],
          borderRadius: BorderRadius.all(Radius.circular(20))),
      width: MediaQuery.of(context).size.width + 200,
      height: MediaQuery.of(context).size.height * 0.10,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            width: 150,
            height: 80,
            padding: const EdgeInsets.all(10.0),
            margin: const EdgeInsets.all(10.0),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                  color: AppTheme.of(context).primaryColor, width: 2),
            ),
            child: Text(
              isssueReportedProvider.actualVehicle!.company.company,
              style: TextStyle(
                color: AppTheme.of(context).contenidoTablas.color,
                fontFamily: 'Bicyclette-Thin',
                fontWeight: AppTheme.of(context).encabezadoTablas.fontWeight,
                fontSize: AppTheme.of(context).contenidoTablas.fontSize,
              ),
            ),
          ),
          Container(
            width: 120,
            height: 80,
            clipBehavior: Clip.antiAlias,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: getUserImage(isssueReportedProvider.webImage),
          ),
          Container(
            width: 190,
            height: MediaQuery.of(context).size.height * 0.20,
            padding: const EdgeInsets.all(5.0),
            margin: const EdgeInsets.all(5.0),
            decoration: BoxDecoration(
                border: Border.all(
                    color: AppTheme.of(context).primaryColor, width: 2),
                borderRadius: BorderRadius.circular(20)),
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "${isssueReportedProvider.actualIssueXUser!.userID}",
                  style: TextStyle(
                    color: AppTheme.of(context).contenidoTablas.color,
                    fontFamily: 'Bicyclette-Thin',
                    fontWeight:
                        AppTheme.of(context).encabezadoTablas.fontWeight,
                    fontSize: AppTheme.of(context).contenidoTablas.fontSize,
                  ),
                ),
                Text(
                  "${isssueReportedProvider.actualIssueXUser!.name} ${isssueReportedProvider.actualIssueXUser!.lastName}",
                  style: TextStyle(
                    color: AppTheme.of(context).contenidoTablas.color,
                    fontFamily: 'Bicyclette-Thin',
                    fontWeight:
                        AppTheme.of(context).encabezadoTablas.fontWeight,
                    fontSize: AppTheme.of(context).contenidoTablas.fontSize,
                  ),
                ),
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () {
                    isssueReportedProvider.setIssueViewActual(1);
                  },
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                  ),
                  child: Text(
                      "${isssueReportedProvider.actualIssueXUser!.issuesR + isssueReportedProvider.actualIssueXUser!.issuesD}")),
              Text(
                "Issues",
                style: TextStyle(
                  color: AppTheme.of(context).primaryColor,
                  fontFamily: 'Bicyclette-Thin',
                  fontWeight: AppTheme.of(context).encabezadoTablas.fontWeight,
                  fontSize: AppTheme.of(context).contenidoTablas.fontSize,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
