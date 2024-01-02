import 'package:flutter/material.dart';

import '../../../../helpers/constants.dart';
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
                decoration: BoxDecoration(
                  color: AppTheme.of(context).smiPrimary,
                ),
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
                    color: const Color.fromRGBO(255, 138, 0, 0.5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                  child: Opacity(
                    opacity: 0.65,
                    child: Text(
                      '● VEHICLES',
                      style: TextStyle(
                        color: AppTheme.of(context).smiPrimary,
                        fontSize: 12,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    "Total: $totalVehicleSMI",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppTheme.of(context).smiPrimary,
                      fontSize: 16,
                      fontFamily: 'Plus Jakarta Sans',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                )
              ],
            ),
            // Body
            Column(
              children: [
                Text(
                  'SMI',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppTheme.of(context).smiPrimary,
                    fontSize: 22,
                    fontFamily: 'Plus Jakarta Sans',
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Text(
                  "Assigned: $totalAssignedSMI",
                  style: TextStyle(
                    color: AppTheme.of(context).smiPrimary,
                    fontFamily: 'Bicyclette-Thin',
                    fontSize: AppTheme.of(context).encabezadoTablas.fontSize,
                  ),
                ),
                Text(
                  "Repair: $totalRepairSMI",
                  style: TextStyle(
                    color: AppTheme.of(context).smiPrimary,
                    fontFamily: 'Bicyclette-Thin',
                    fontSize: AppTheme.of(context).encabezadoTablas.fontSize,
                  ),
                ),
                Text(
                  "Available: $totalAvailableSMI ",
                  style: TextStyle(
                    color: AppTheme.of(context).smiPrimary,
                    fontFamily: 'Bicyclette-Thin',
                    fontSize: AppTheme.of(context).encabezadoTablas.fontSize,
                  ),
                ),
              ],
            ),
            // Imagen
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
                          "$supabaseUrl/storage/v1/object/public/assets/car_images/LYP6475.jpeg"),
                      fit: BoxFit.cover,
                    ),
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(width: 2.50, color: Colors.white),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ],
            ),
          ]),
        ],
      ),
    );
  }
}
