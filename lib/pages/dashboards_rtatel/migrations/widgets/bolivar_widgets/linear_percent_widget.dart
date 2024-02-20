import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:rta_crm_cv/public/colors.dart';

class LinearPercentIndicatorWidget extends StatefulWidget {
  const LinearPercentIndicatorWidget({required this.percentValue, super.key});
  final double percentValue;
  @override
  State<LinearPercentIndicatorWidget> createState() =>
      _LinearPercentIndicatorWidgetState();
}

class _LinearPercentIndicatorWidgetState
    extends State<LinearPercentIndicatorWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.5,
      height: MediaQuery.of(context).size.height * 0.13,
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
          gradient: whiteGradient,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.blue)),
      child: LinearPercentIndicator(
        width: MediaQuery.of(context).size.width * 0.3,
        leading: Text("${widget.percentValue}"),
        animation: true,
        lineHeight: 20.0,
        animationDuration: 2000,
        percent: widget.percentValue / 100,
        center: Text(
          "${widget.percentValue}%",
          style: TextStyle(color: Colors.white),
        ),
        linearStrokeCap: LinearStrokeCap.roundAll,
        progressColor: Color(0xff0072F0),
      ),
    );
  }
}
