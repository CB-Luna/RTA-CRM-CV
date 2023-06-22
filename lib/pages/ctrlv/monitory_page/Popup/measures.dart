import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../models/monitory.dart';
import '../../../../providers/ctrlv/monitory_provider.dart';
import '../../../../public/colors.dart';
import '../../../../widgets/card_header.dart';

class MeasuresPopUp extends StatelessWidget {
  final Monitory row;
  const MeasuresPopUp({super.key, required this.row});

  @override
  Widget build(BuildContext context) {
    MonitoryProvider provider = Provider.of<MonitoryProvider>(context);
    return AlertDialog(
      backgroundColor: Colors.transparent,
      content: Container(
         width: 700,
        height: 650,
        decoration: BoxDecoration(gradient: whiteGradient, borderRadius: BorderRadius.circular(20)),
        child:  Column(
          children: [
            CardHeader(text: "Measures"),
             Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.only(left: 20),
                  alignment: Alignment.centerLeft,
                  child: ElevatedButton(
                      onPressed: () {
                        provider.updateViewPopup(0);
                      },
                      child: const Text(
                        "BACK",
                        style: TextStyle(fontSize: 20),
                      )),
                ),
              ],
            ),
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
                  Text(row.mileageR.toString(),
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                  ),
                  ),
                  Icon( Icons.check_circle_outline_outlined,
                  color: Color.fromARGB(200, 65, 155, 23),
                  size: 60,),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child:  Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  
                  Text("Gas/Diesel %",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                  ),
                  ),
                  Text(row.gasR.toString(),
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                  ),
                  ),
                  Icon( Icons.check_circle_outline_outlined,
                  color: Color.fromARGB(200, 65, 155, 23),
                  size: 60,),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}