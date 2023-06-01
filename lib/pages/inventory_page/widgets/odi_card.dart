import 'package:flutter/material.dart';
import 'package:rta_crm_cv/pages/inventory_page/widgets/trapecio_rojo.dart';

class OdiCard extends StatelessWidget {
  final int totalVehicleODE;
  final int totalRepairODE;
  final int totalAssignedODE;
  final int totalAvailableODE;
  const OdiCard({super.key, required this.totalVehicleODE, required this.totalRepairODE, required this.totalAssignedODE, required this.totalAvailableODE});

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
                "assets/images/Odi_Car.png",
                height: 300,
              ),
            ),
            const Text("ODE",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                )),
            const SizedBox(
              height: 10,
            ),
            Text(
              "Total: $totalVehicleODE",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "Vehicle's Assigned: $totalAssignedODE ",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "Vehicles in Repair: $totalRepairODE ",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "Vehicles Available: $totalAvailableODE ",
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
