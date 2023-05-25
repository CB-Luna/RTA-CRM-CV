import 'package:flutter/material.dart';
import 'package:rta_crm_cv/pages/inventory_page/widgets/trapecio.dart';

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
      height: 400,
      width: 400,
      child: CustomPaint(
        size: Size(339, (480).toDouble()),
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
            const Text("CRY",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                )),
            const SizedBox(
              height: 10,
            ),
            Text(
              "Total: $totalVehicleCRY",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "Vehicle's Assigned: $totalAssignedCRY",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "Vehicles in Repair: $totalRepairCRY ",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "Vehicles Available: $totalAvailableCRY ",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
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
