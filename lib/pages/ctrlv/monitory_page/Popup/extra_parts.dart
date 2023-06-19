import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../providers/ctrlv/monitory_provider.dart';
import '../../../../public/colors.dart';
import '../../../../widgets/card_header.dart';

class ExtraPopUp extends StatelessWidget {
  final String catalog;
  const ExtraPopUp({super.key, required this.catalog, });
  //pedir ID de control form para conectar con als demas

  @override
  Widget build(BuildContext context) {
    MonitoryProvider provider = Provider.of<MonitoryProvider>(context);
    return AlertDialog(
      backgroundColor: Colors.transparent,
      content: Container(
         width: 700,
        height: 650,
        decoration: BoxDecoration(gradient: whiteGradient, borderRadius: BorderRadius.circular(20)),
        child:   Column(
          children: [
            CardHeader(text: catalog),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Headlight",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                ),
                ),
                Text("Good",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(200, 65, 155, 23),
                ),
                ),
                Icon( Icons.check_circle_outline_outlined,
                color: Color.fromARGB(200, 65, 155, 23)),
              ],
            ),
            

          ],
        ),
      ),
    );
  }
}