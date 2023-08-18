import 'package:flutter/material.dart';

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
    return Container(
        width: MediaQuery.of(context).size.width * 0.2,
        height: MediaQuery.of(context).size.height * 0.37,
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.2,
                  height: MediaQuery.of(context).size.height * 0.1,
                  decoration: const BoxDecoration(color: Color(0xFF2E5899)),
                ),
              ],
            ),
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.06,
                    height: MediaQuery.of(context).size.height * 0.04,
                    alignment: Alignment.center,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: ShapeDecoration(
                      color: const Color(0x260B63F8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                    child: const Opacity(
                      opacity: 0.65,
                      child: Text(
                        '● VEHICLES',
                        style: TextStyle(
                          color: Color(0xFF2E5899),
                          fontSize: 12,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        Text(
                          "Total: $totalVehicleCRY ",
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Color(0xFF2E5899),
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
              // Body
              Column(
                children: [
                  const Text(
                    'CRY',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF2E5899),
                      fontSize: 22,
                      fontFamily: 'Plus Jakarta Sans',
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Text(
                    "Assigned: $totalAssignedCRY",
                    style: TextStyle(
                      color: AppTheme.of(context).primaryColor,
                      fontFamily: 'Bicyclette-Thin',
                      fontSize: AppTheme.of(context).encabezadoTablas.fontSize,
                    ),
                  ),
                  Text(
                    "Repair: $totalRepairCRY",
                    style: TextStyle(
                      color: AppTheme.of(context).primaryColor,
                      fontFamily: 'Bicyclette-Thin',
                      fontSize: AppTheme.of(context).encabezadoTablas.fontSize,
                    ),
                  ),
                  Text(
                    "Available: $totalAvailableCRY ",
                    style: TextStyle(
                      color: AppTheme.of(context).primaryColor,
                      fontFamily: 'Bicyclette-Thin',
                      fontSize: AppTheme.of(context).encabezadoTablas.fontSize,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.12,
                    height: MediaQuery.of(context).size.height * 0.13,
                    alignment: Alignment.center,
                    decoration: ShapeDecoration(
                      image: const DecorationImage(
                        image: NetworkImage(
                            "https://supa43.rtatel.com/storage/v1/object/public/assets/car_images/JLZ7391(CRY).jpg"),
                        fit: BoxFit.cover,
                      ),
                      shape: RoundedRectangleBorder(
                        side:
                            const BorderSide(width: 2.50, color: Colors.white),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ],
              ),
              // Imagen
            ]),
          ],
        ));
  }
}
