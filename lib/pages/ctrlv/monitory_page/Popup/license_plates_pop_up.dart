import 'package:flutter/material.dart';
import 'package:rta_crm_cv/widgets/card_header.dart';

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
              child: CardHeader(text: "License Plate History"),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 20),
                    alignment: Alignment.centerLeft,
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          "BACK",
                          style: TextStyle(fontSize: 20),
                        )),
                  ),
                ],
              ),
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
