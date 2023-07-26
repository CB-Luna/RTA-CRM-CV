import 'package:flutter/material.dart';

import '../../../../theme/theme.dart';

class OdiCard extends StatelessWidget {
  final int totalVehicle;
  final int totalRepair;
  final int totalAssigned;
  final int totalAvailable;
  const OdiCard(
      {super.key,
      required this.totalVehicle,
      required this.totalRepair,
      required this.totalAssigned,
      required this.totalAvailable});

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
                decoration: const BoxDecoration(color: Color(0xFFD20030)),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
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
                    color: const Color.fromARGB(255, 235, 154, 173),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                  child: const Opacity(
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
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    "Total: $totalVehicle",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Color(0xFFD20030),
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
                const Text(
                  'ODE',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFFD20030),
                    fontSize: 22,
                    fontFamily: 'Plus Jakarta Sans',
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Text(
                  "Assigned: $totalAssigned",
                  style: TextStyle(
                    color: AppTheme.of(context).secondaryColor,
                    fontFamily: 'Bicyclette-Thin',
                    fontSize: AppTheme.of(context).encabezadoTablas.fontSize,
                  ),
                ),
                Text(
                  "Repair: $totalRepair",
                  style: TextStyle(
                    color: AppTheme.of(context).secondaryColor,
                    fontFamily: 'Bicyclette-Thin',
                    fontSize: AppTheme.of(context).encabezadoTablas.fontSize,
                  ),
                ),
                Text(
                  "Available: $totalAvailable ",
                  style: TextStyle(
                    color: AppTheme.of(context).secondaryColor,
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
                          "https://supa43.rtatel.com/storage/v1/object/public/assets/Vehicles/2629483.jpg"),
                      fit: BoxFit.cover,
                    ),
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(width: 2.50, color: Colors.white),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ],
            )
          ]),
        ],
      ),
    );
  }
}
