import 'package:flutter/material.dart';
import 'package:rta_crm_cv/pages/ctrlv/inventory_page/widgets/trapecio_gris.dart';

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
              child: Image.asset(
                "assets/images/Cry_Car.png",
                height: 300,
              ),
            ),
            const Text("SMI",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 32,
                )),
            const SizedBox(
              height: 10,
            ),
            Text(
              "Total: $totalVehicleSMI",
              style: const TextStyle(
                color: Colors.black,
                fontSize: 20,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "Vehicle Assigned: $totalAssignedSMI ",
              style: const TextStyle(
                color: Colors.black,
                fontSize: 20,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "Vehicles in Repair: $totalRepairSMI ",
              style: const TextStyle(
                color: Colors.black,
                fontSize: 20,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "Vehicles Available: $totalAvailableSMI ",
              style: const TextStyle(
                color: Colors.black,
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
