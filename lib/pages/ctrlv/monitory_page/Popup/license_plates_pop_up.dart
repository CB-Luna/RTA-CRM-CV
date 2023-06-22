import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rta_crm_cv/providers/ctrlv/monitory_provider.dart';
import 'package:rta_crm_cv/widgets/card_header.dart';

import '../../../../public/colors.dart';

class LicenseHistory extends StatelessWidget {
  const LicenseHistory({super.key});

  @override
  Widget build(BuildContext context) {
   MonitoryProvider provider = Provider.of<MonitoryProvider>(context);
    return AlertDialog(
      backgroundColor: Colors.transparent,
      content: Container(
        width: 900,
        height: 550,
        decoration: BoxDecoration(
            gradient: whiteGradient, borderRadius: BorderRadius.circular(20)),
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
                          "Back",
                          style: TextStyle(fontSize: 20),
                        )),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                gradient: blueRadial,
                borderRadius:
                    BorderRadius.all(Radius.circular(10.0)),
              ),
              child:  Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Icon(
                    Icons.supervised_user_circle_rounded,
                    color: Colors.white,
                    size: 80,
                  ),
                  Text("${provider.monitory.first.employee.name} ${provider.monitory.first.employee.lastName}",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),),
                  Text("${provider.monitory.first.licensePlates}",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),),
                  Text("${provider.monitory.first.dateAddedR} - ${provider.monitory.first.dateAddedD}",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
