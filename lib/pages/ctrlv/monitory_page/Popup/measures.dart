import 'package:flutter/material.dart';

import '../../../../public/colors.dart';
import '../../../../widgets/card_header.dart';

class MeasuresPopUp extends StatelessWidget {
  const MeasuresPopUp({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
         width: 1000,
        height: 650,
        decoration: BoxDecoration(gradient: whiteGradient, borderRadius: BorderRadius.circular(20)),
        child: Column(
          children: [
            const Padding(padding: EdgeInsets.only(bottom: 10), child: CardHeader(text: "Measures")),
          ],
        ),
      ),
    );
  }
}