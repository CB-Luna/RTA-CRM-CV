import 'package:flutter/material.dart';

import '../../../../public/colors.dart';

class LicenseHistory extends StatelessWidget {
  const LicenseHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.transparent,
      content: Container(
        width: 900,
        height: 550,
        decoration: BoxDecoration(gradient: whiteGradient, borderRadius: BorderRadius.circular(20)),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(20.0),
              child: Text("License Plates History"),
            ),
            Container(
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Icon(
                    Icons.supervised_user_circle_rounded,
                    color: Colors.grey,
                    size: 80,
                  ),
                  Text("Employee Name"),
                  Text("License Plate"),
                  Text("Jun-19-2023  -- Jun-20-2023"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
