import 'package:flutter/material.dart';
import 'package:rta_crm_cv/pages/ctrlv/inventory_page/widgets/trapecio.dart';

import '../../../../theme/theme.dart';

class CryCard extends StatelessWidget {
  final int totalVehicleCRY;
  final int totalRepairCRY;
  final int totalAssignedCRY;
  final int totalAvailableCRY;
  const CryCard({
    super.key,
    required this.totalVehicleCRY,
    required this.totalRepairCRY,
    required this.totalAssignedCRY,
    required this.totalAvailableCRY,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      width: 400,
      child: CustomPaint(
        size: Size(339, (490).toDouble()),
        painter: RPSCustomPainter(),
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
            Text("CRY",
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
              "Total: $totalVehicleCRY",
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
              "Vehicles Assigned: $totalAssignedCRY",
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
              "Vehicles in Repair: $totalRepairCRY ",
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
              "Vehicles Available: $totalAvailableCRY ",
              style: TextStyle(
                color: AppTheme.of(context).gris,
                fontFamily: 'Bicyclette-Thin',
                fontSize: AppTheme.of(context).encabezadoTablas.fontSize,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
