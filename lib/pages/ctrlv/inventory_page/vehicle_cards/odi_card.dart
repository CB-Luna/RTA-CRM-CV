import 'package:flutter/material.dart';
import 'package:rta_crm_cv/pages/ctrlv/inventory_page/widgets/trapecio_rojo.dart';

import '../../../../theme/theme.dart';

class OdiCard extends StatelessWidget {
  final int totalVehicleODE;
  final int totalRepairODE;
  final int totalAssignedODE;
  final int totalAvailableODE;
  const OdiCard(
      {super.key,
      required this.totalVehicleODE,
      required this.totalRepairODE,
      required this.totalAssignedODE,
      required this.totalAvailableODE});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      width: 400,
      child: CustomPaint(
        size: Size(339, (400).toDouble()),
        painter: TrapecioRojo(),
        child: Column(
          children: [
            SizedBox(
              width: 260,
              height: 150,
              child: Image.asset(
                "assets/images/Cry_Car.png",
                height: 300,
              ),
            ),
            Text("ODE",
                style: TextStyle(
                    fontFamily:
                        AppTheme.of(context).encabezadoTablas.fontFamily,
                    fontSize: AppTheme.of(context).encabezadoSubTablas.fontSize,
                    fontStyle: AppTheme.of(context).encabezadoTablas.fontStyle,
                    fontWeight:
                        AppTheme.of(context).encabezadoTablas.fontWeight,
                    color: AppTheme.of(context).gris)),
            const SizedBox(
              height: 10,
            ),
            Text(
              "Total: $totalVehicleODE",
              style: TextStyle(
                color: AppTheme.of(context).gris,
                fontFamily: 'Bicyclette-Thin',
                fontSize: AppTheme.of(context).encabezadoTablas.fontSize,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "Vehicles Assigned: $totalAssignedODE ",
              style: TextStyle(
                color: AppTheme.of(context).gris,
                fontFamily: 'Bicyclette-Thin',
                fontSize: AppTheme.of(context).encabezadoTablas.fontSize,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              "Vehicles in Repair: $totalRepairODE ",
              style: TextStyle(
                color: AppTheme.of(context).gris,
                fontFamily: 'Bicyclette-Thin',
                fontSize: AppTheme.of(context).encabezadoTablas.fontSize,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              "Vehicles Available: $totalAvailableODE ",
              style: TextStyle(
                color: AppTheme.of(context).gris,
                fontFamily: 'Bicyclette-Thin',
                fontSize: AppTheme.of(context).encabezadoTablas.fontSize,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
          ],
        ),
      ),
    );
  }
}
