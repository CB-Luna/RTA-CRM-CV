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
      height: 120,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            width: 170,
            height: 100,
            padding: const EdgeInsets.all(10.0),
            margin: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                  color: AppTheme.of(context).primaryColor, width: 2),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Text("Company: ",
                        style: TextStyle(
                            fontFamily: AppTheme.of(context)
                                .encabezadoTablas
                                .fontFamily,
                            fontSize:
                                AppTheme.of(context).contenidoTablas.fontSize,
                            fontStyle:
                                AppTheme.of(context).encabezadoTablas.fontStyle,
                            color: AppTheme.of(context).primaryText)),
                    Text(
                      isssueReportedProvider.actualVehicle!.company.company,
                      style: TextStyle(
                        color: AppTheme.of(context).contenidoTablas.color,
                        fontFamily: 'Bicyclette-Thin',
                        fontWeight:
                            AppTheme.of(context).encabezadoTablas.fontWeight,
                        fontSize: AppTheme.of(context).contenidoTablas.fontSize,
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    Text("Status: ",
                        style: TextStyle(
                            fontFamily: AppTheme.of(context)
                                .encabezadoTablas
                                .fontFamily,
                            fontSize:
                                AppTheme.of(context).contenidoTablas.fontSize,
                            fontStyle:
                                AppTheme.of(context).encabezadoTablas.fontStyle,
                            color: AppTheme.of(context).primaryText)),
                    Text(
                      isssueReportedProvider.actualVehicle!.status.status,
                      style: TextStyle(
                        color: AppTheme.of(context).contenidoTablas.color,
                        fontFamily: 'Bicyclette-Thin',
                        fontWeight:
                            AppTheme.of(context).encabezadoTablas.fontWeight,
                        fontSize: AppTheme.of(context).contenidoTablas.fontSize,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          Container(
            width: 160,
            height: 100,
            clipBehavior: Clip.antiAlias,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: getUserImage(isssueReportedProvider.webImage),
          ),
          Container(
            width: 180,
            height: 120,
            padding: const EdgeInsets.all(10.0),
            margin: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
                border: Border.all(
                    color: AppTheme.of(context).primaryColor, width: 2),
                borderRadius: BorderRadius.circular(20)),
            alignment: Alignment.center,
            child: Column(
              children: [
                Row(
                  children: [
                    Text("Name: ",
                        style: TextStyle(
                            fontFamily: AppTheme.of(context)
                                .encabezadoTablas
                                .fontFamily,
                            fontSize:
                                AppTheme.of(context).contenidoTablas.fontSize,
                            fontStyle:
                                AppTheme.of(context).encabezadoTablas.fontStyle,
                            color: AppTheme.of(context).primaryText)),
                    Text(
                      "${isssueReportedProvider.actualIssueXUser!.name} \n ${isssueReportedProvider.actualIssueXUser!.lastName}",
                      style: TextStyle(
                        color: AppTheme.of(context).contenidoTablas.color,
                        fontFamily: 'Bicyclette-Thin',
                        fontWeight:
                            AppTheme.of(context).encabezadoTablas.fontWeight,
                        fontSize: AppTheme.of(context).contenidoTablas.fontSize,
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    Text("Id User: ",
                        style: TextStyle(
                            fontFamily: AppTheme.of(context)
                                .encabezadoTablas
                                .fontFamily,
                            fontSize:
                                AppTheme.of(context).contenidoTablas.fontSize,
                            fontStyle:
                                AppTheme.of(context).encabezadoTablas.fontStyle,
                            color: AppTheme.of(context).primaryText)),
                    Text(
                      "${isssueReportedProvider.actualIssueXUser!.sequentialId}",
                      style: TextStyle(
                        color: AppTheme.of(context).contenidoTablas.color,
                        fontFamily: 'Bicyclette-Thin',
                        fontWeight:
                            AppTheme.of(context).encabezadoTablas.fontWeight,
                        fontSize: AppTheme.of(context).contenidoTablas.fontSize,
                      ),
                    )
                  ],
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
