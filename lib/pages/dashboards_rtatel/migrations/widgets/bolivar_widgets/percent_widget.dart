import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class PercentWidget extends StatefulWidget {
  const PercentWidget({required this.percentValue, super.key});
  final double percentValue;

  @override
  State<PercentWidget> createState() => _PercentWidgetState();
}

class _PercentWidgetState extends State<PercentWidget> {
  double percentvalueP = 0;

  @override
  Widget build(BuildContext context) {
    percentvalueP = widget.percentValue / 100;

    return Container(
        width: MediaQuery.of(context).size.width * 0.15,
        height: MediaQuery.of(context).size.height * 0.20,
        margin: const EdgeInsets.all(10),
        child: Center(
          child: CircularPercentIndicator(
            radius: MediaQuery.of(context).size.width *
                0.04, // Ajusta el radio al ancho del Container
            animation: true,
            lineWidth: 15.0,
            percent: percentvalueP,
            center: Text(
              " ${widget.percentValue}%  \nPERCENT",
              style: TextStyle(fontSize: 15),
            ),
            progressColor: const Color(0xff4DD0E1),
          ),
        ));
  }
}
