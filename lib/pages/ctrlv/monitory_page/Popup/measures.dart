import 'package:flutter/material.dart';

import '../../../../public/colors.dart';
import '../../../../widgets/card_header.dart';

class MeasuresPopUp extends StatelessWidget {
  const MeasuresPopUp({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.transparent,
      content: Container(
         width: 700,
        height: 650,
        decoration: BoxDecoration(gradient: whiteGradient, borderRadius: BorderRadius.circular(20)),
        child:  Column(
          children: [
            CardHeader(text: "Measures"),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Mileage",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                  ),
                  ),
                  Text("12345",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                  ),
                  ),
                  Icon( Icons.check_circle_outline_outlined,
                  color: Color.fromARGB(200, 65, 155, 23)),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Gas/Diesel %",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                  ),
                  ),
                  Text("60%",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                  ),
                  ),
                  Icon( Icons.error_outlined,
                  color: Color.fromARGB(200, 210, 0, 48)),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}