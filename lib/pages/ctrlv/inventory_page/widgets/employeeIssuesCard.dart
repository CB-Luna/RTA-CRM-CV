import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rta_crm_cv/providers/ctrlv/inventory_provider.dart';
import 'package:rta_crm_cv/theme/theme.dart';

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
    InventoryProvider provider = Provider.of<InventoryProvider>(context);
    return Container(
      decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(blurRadius: 4, color: Colors.grey, offset: Offset(10, 10))
          ],
          borderRadius: BorderRadius.all(Radius.circular(20))),
      width: MediaQuery.of(context).size.width,
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            width: 50,
            height: 50,
            clipBehavior: Clip.antiAlias,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: getUserImage(provider.webImage),
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0, top: 5.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                      "${provider.actualIssueXUser!.name} ${provider.actualIssueXUser!.lastName}",
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
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text("Company: ",
                      style: TextStyle(
                          fontFamily:
                              AppTheme.of(context).encabezadoTablas.fontFamily,
                          fontSize:
                              AppTheme.of(context).contenidoTablas.fontSize,
                          fontStyle:
                              AppTheme.of(context).encabezadoTablas.fontStyle,
                          color: AppTheme.of(context).primaryText)),
                  Text(
                    "${provider.actualIssueXUser!.company} ",
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
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () {
                    //provider.getIssues(provider.actualIssueXUser!);
                    provider.getIssuesBasics(provider.actualIssueXUser!);
                    provider.setIssueViewActual(1);
                    print(provider.issuesView);
                  },
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                  ),
                  child: Text(
                      "${provider.actualIssueXUser!.issuesR + provider.actualIssueXUser!.issuesD}")),
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
