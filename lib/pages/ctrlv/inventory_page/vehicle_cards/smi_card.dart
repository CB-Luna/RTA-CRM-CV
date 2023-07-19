import 'package:flutter/material.dart';
import 'package:rta_crm_cv/pages/ctrlv/inventory_page/widgets/trapecio_gris.dart';

import '../../../../theme/theme.dart';

class SmiCard extends StatelessWidget {
  final int totalVehicleSMI;
  final int totalRepairSMI;
  final int totalAssignedSMI;
  final int totalAvailableSMI;
  const SmiCard(
      {super.key,
      required this.totalVehicleSMI,
      required this.totalRepairSMI,
      required this.totalAssignedSMI,
      required this.totalAvailableSMI});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      width: 400,
      child: CustomPaint(
        size: Size(339, (400).toDouble()),
        painter: TrapecioGris(),
        child: Column(
          children: [
            SizedBox(
              width: 260,
              height: 150,
              child: Image.network(
                "https://supa43.rtatel.com/storage/v1/object/public/assets/car_images/SmiCar.png",
                height: 300,
              ),
            ),
            Text("SMI",
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
              "Total: $totalVehicleSMI",
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
              "Vehicles Assigned: $totalAssignedSMI ",
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
              "Vehicles in Repair: $totalRepairSMI ",
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
              "Vehicles Available: $totalAvailableSMI ",
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
