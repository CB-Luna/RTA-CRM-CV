import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../models/monitory.dart';
import '../../../../providers/ctrlv/monitory_provider.dart';
import '../../../../public/colors.dart';
import '../../../../widgets/card_header.dart';
import '../../../../widgets/custom_text_icon_button.dart';

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
        child: 
        Column(
          children: [
            const CardHeader(text: "Measures"),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 20),
                  alignment: Alignment.centerLeft,
                  child: CustomTextIconButton(
                      icon: Icon(Icons.arrow_back, color: Colors.white),
                      text: "",
                      isLoading: false,
                      onTap: () {
                        provider.updateViewPopup(0);
                      },
                    ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "Mileage",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    row.mileageR.toString(),
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                 
                  InkWell(
                    child: Icon(
                      Icons.remove_red_eye,
                      color: Color.fromARGB(200, 65, 155, 23),
                      size: 40,
                    ),
                    onTap: () {
                      provider.updateViewPopup(9);
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "Gas/Diesel %",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    row.gasR.toString(),
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  
                  InkWell(
                    child: Icon(
                      Icons.remove_red_eye,
                      color: Color.fromARGB(200, 65, 155, 23),
                      size: 40,
                    ),
                    onTap: () {
                      provider.updateViewPopup(9);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
