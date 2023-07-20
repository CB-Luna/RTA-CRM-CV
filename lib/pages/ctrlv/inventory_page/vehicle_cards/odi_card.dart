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
    return Container(
      width: 304,
      height: 269,
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              width: 97,
              height: 28,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: ShapeDecoration(
                color: Color.fromARGB(255, 235, 154, 173),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Opacity(
                    opacity: 0.65,
                    child: Text(
                      '● VEHICLES',
                      style: TextStyle(
                        color: Color(0xFFD20030),
                        fontSize: 12,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.08,
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Text(
                    "Total: $totalVehicleODE",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Color(0xFFD20030),
                      fontSize: 16,
                      fontFamily: 'Plus Jakarta Sans',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
        const SizedBox(
          width: 235,
          child: Text(
            'ODE',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFFD20030),
              fontSize: 22,
              fontFamily: 'Plus Jakarta Sans',
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.15,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Assigned: $totalAssignedODE",
                style: TextStyle(
                  color: AppTheme.of(context).secondaryColor,
                  fontFamily: 'Bicyclette-Thin',
                  fontSize: AppTheme.of(context).encabezadoTablas.fontSize,
                ),
              ),
              Text(
                "Repair: $totalRepairODE",
                style: TextStyle(
                  color: AppTheme.of(context).secondaryColor,
                  fontFamily: 'Bicyclette-Thin',
                  fontSize: AppTheme.of(context).encabezadoTablas.fontSize,
                ),
              ),
              Text(
                "Available: $totalAvailableODE ",
                style: TextStyle(
                  color: AppTheme.of(context).secondaryColor,
                  fontFamily: 'Bicyclette-Thin',
                  fontSize: AppTheme.of(context).encabezadoTablas.fontSize,
                ),
              ),
            ],
          ),
        ),
        Spacer(),
        Stack(children: [
          Container(
            width: 304,
            height: 79,
            decoration: BoxDecoration(color: Color(0xFFD20030)),
          ),
          Positioned(
            top: -50,
            right: 60,
            child: Container(
              width: 173,
              height: 86,
              alignment: Alignment.center,
              decoration: ShapeDecoration(
                image: const DecorationImage(
                  image: NetworkImage(
                      "https://supa43.rtatel.com/storage/v1/object/public/assets/car_images/OdyCar.png?t=2023-07-18T15%3A59%3A46.541Z"),
                ),
                shape: RoundedRectangleBorder(
                  side: const BorderSide(width: 2.50, color: Colors.white),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ),
        ]),
      ]),
    );
  }
}
