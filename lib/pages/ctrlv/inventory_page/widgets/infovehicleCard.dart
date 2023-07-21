import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../providers/ctrlv/issue_reported_provider.dart';
import '../../../../theme/theme.dart';

class InfoVehicleCard extends StatefulWidget {
  const InfoVehicleCard({super.key});

  @override
  State<InfoVehicleCard> createState() => _InfoVehicleCardState();
}

class _InfoVehicleCardState extends State<InfoVehicleCard> {
  @override
  Widget build(BuildContext context) {
    IssueReportedProvider isssueReportedProvider =
        Provider.of<IssueReportedProvider>(context);
    return Container(
      padding: const EdgeInsets.all(10.0),
      width: 400,
      height: 400,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppTheme.of(context).primaryColor, width: 2),
      ),
      //ID, MAKE, LICENSEPLATES,YEAR, company
      child: Row(
        children: [
          Container(
              width: 400,
              height: 25,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      blurRadius: 4, color: Colors.grey, offset: Offset(5, 5))
                ],
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    isssueReportedProvider.actualVehicle!.licesensePlates,
                    style: TextStyle(
                        fontFamily:
                            AppTheme.of(context).encabezadoTablas.fontFamily,
                        fontSize: AppTheme.of(context).contenidoTablas.fontSize,
                        fontStyle:
                            AppTheme.of(context).encabezadoTablas.fontStyle,
                        fontWeight:
                            AppTheme.of(context).encabezadoTablas.fontWeight,
                        color: AppTheme.of(context).primaryText),
                  ),
                  Text(
                    isssueReportedProvider.actualVehicle!.make,
                    style: TextStyle(
                        fontFamily:
                            AppTheme.of(context).encabezadoTablas.fontFamily,
                        fontSize: AppTheme.of(context).contenidoTablas.fontSize,
                        fontStyle:
                            AppTheme.of(context).encabezadoTablas.fontStyle,
                        fontWeight:
                            AppTheme.of(context).encabezadoTablas.fontWeight,
                        color: AppTheme.of(context).primaryText),
                  ),
                  Text(
                    isssueReportedProvider.actualVehicle!.model,
                    style: TextStyle(
                        fontFamily:
                            AppTheme.of(context).encabezadoTablas.fontFamily,
                        fontSize: AppTheme.of(context).contenidoTablas.fontSize,
                        fontStyle:
                            AppTheme.of(context).encabezadoTablas.fontStyle,
                        fontWeight:
                            AppTheme.of(context).encabezadoTablas.fontWeight,
                        color: AppTheme.of(context).primaryText),
                  ),
                  Text(
                    isssueReportedProvider.actualVehicle!.year,
                    style: TextStyle(
                        fontFamily:
                            AppTheme.of(context).encabezadoTablas.fontFamily,
                        fontSize: AppTheme.of(context).contenidoTablas.fontSize,
                        fontStyle:
                            AppTheme.of(context).encabezadoTablas.fontStyle,
                        fontWeight:
                            AppTheme.of(context).encabezadoTablas.fontWeight,
                        color: AppTheme.of(context).primaryText),
                  ),
                ],
              )),
          Container(
            height: 200,
            width: 200,
            alignment: Alignment.center,
            margin: const EdgeInsets.only(left: 80),
            decoration: BoxDecoration(
                border: Border.all(
                  color: Color(
                      int.parse(isssueReportedProvider.actualVehicle!.color)),
                  width: 5.0,
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Color(
                        int.parse(isssueReportedProvider.actualVehicle!.color)),
                    spreadRadius: 3,
                    blurRadius: 3,
                    offset: const Offset(4, 4), // changes position of shadow
                  ),
                ],
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                        isssueReportedProvider.actualVehicle!.image!))),
          ),
        ],
      ),
    );
  }
}
