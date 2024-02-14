import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:rta_crm_cv/theme/theme.dart';

import '../../../../../public/colors.dart';
import '../../../../../widgets/custom_card.dart';
import '../line_chart_painter.dart';

class SubscriberCardBolivar extends StatefulWidget {
  const SubscriberCardBolivar({super.key});

  @override
  State<SubscriberCardBolivar> createState() => _SubscriberCardBolivarState();
}

class _SubscriberCardBolivarState extends State<SubscriberCardBolivar> {
  @override
  Widget build(BuildContext context) {
    return CustomCard(
      title: 'Subscribers',
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      width: MediaQuery.of(context).size.width * 0.3,
      height: MediaQuery.of(context).size.height * 0.6,
      child: Container(
        padding: const EdgeInsets.all(10),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.48,
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.13,
                height: MediaQuery.of(context).size.height * 0.10,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    gradient: whiteGradient,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.blue)),
                child: const Column(children: [
                  Text("Wireless Subs Target"),
                  Spacer(),
                  Text("217")
                ]),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.13,
                height: MediaQuery.of(context).size.height * 0.10,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    gradient: whiteGradient,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.blue)),
                child: const Column(children: [
                  Text("Wireless Subs to Date"),
                  Spacer(),
                  Text("0")
                ]),
              ),
              Flexible(
                child: Container(
                    width: MediaQuery.of(context).size.width * 0.6,
                    height: MediaQuery.of(context).size.height * 0.10,
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.blue),
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      children: [
                        const Text("2024"),
                        Flexible(
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.54,
                            height: MediaQuery.of(context).size.height * 0.50,
                            padding: const EdgeInsets.all(2),
                            child: CustomPaint(
                                painter: LineChartPainter(
                                    leftText: "",
                                    text: "FS Target Met:",
                                    targetValue: 0.2)),
                          ),
                        ),
                      ],
                    )),
              ),
              Container(
                  width: MediaQuery.of(context).size.width * 0.13,
                  height: MediaQuery.of(context).size.height * 0.12,
                  margin: const EdgeInsets.all(10),
                  child: Center(
                    child: CircularPercentIndicator(
                      radius: MediaQuery.of(context).size.width *
                          0.028, // Ajusta el radio al ancho del Container
                      animation: true,
                      lineWidth: 5.0,
                      percent: 0.93,
                      center: Text(
                        "HP PERCENT %",
                        style: TextStyle(fontSize: 10),
                      ),
                      footer: Text(
                        "0.93",
                        style: new TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 17.0),
                      ),
                      progressColor: AppTheme.of(context).techSupPrimary,
                    ),
                  ))
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.13,
                height: MediaQuery.of(context).size.height * 0.10,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    gradient: whiteGradient,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.blue)),
                child: const Column(children: [
                  Text("Converted Sub Target"),
                  Spacer(),
                  Text("100")
                ]),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.13,
                height: MediaQuery.of(context).size.height * 0.10,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    gradient: whiteGradient,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.blue)),
                child: const Column(
                    children: [Text("Converted to Date"), Spacer(), Text("0")]),
              ),
              Container(
                  width: MediaQuery.of(context).size.width * 0.6,
                  height: MediaQuery.of(context).size.height * 0.10,
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.blue),
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    children: [
                      const Text("2024"),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.54,
                        height: MediaQuery.of(context).size.height * 0.50,
                        padding: const EdgeInsets.all(2),
                        child: CustomPaint(
                            painter: LineChartPainter(
                                leftText: "",
                                text: "WS Target Met:",
                                targetValue: 0.2)),
                      ),
                    ],
                  ))
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.13,
                height: MediaQuery.of(context).size.height * 0.10,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    gradient: whiteGradient,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.blue)),
                child: const Column(children: [
                  Text("Subs Growth Target"),
                  Spacer(),
                  Text("50")
                ]),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.13,
                height: MediaQuery.of(context).size.height * 0.10,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    gradient: whiteGradient,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.blue)),
                child: const Column(children: [
                  Text("Subs Growth To Date"),
                  Spacer(),
                  Text("0")
                ]),
              ),
              Container(
                  width: MediaQuery.of(context).size.width * 0.6,
                  height: MediaQuery.of(context).size.height * 0.10,
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.blue),
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    children: [
                      const Text("2024"),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.54,
                        height: MediaQuery.of(context).size.height * 0.50,
                        padding: const EdgeInsets.all(2),
                        child: CustomPaint(
                            painter: LineChartPainter(
                                leftText: "",
                                text: "CS Target Met:",
                                targetValue: 0.2)),
                      ),
                    ],
                  ))
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.13,
                height: MediaQuery.of(context).size.height * 0.10,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    gradient: whiteGradient,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.blue)),
                child: const Column(children: [
                  Text("Fiber Subs Target"),
                  Spacer(),
                  Text("132")
                ]),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.13,
                height: MediaQuery.of(context).size.height * 0.10,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    gradient: whiteGradient,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.blue)),
                child: const Column(children: [
                  Text("Fiber Subs To Date"),
                  Spacer(),
                  Text("0")
                ]),
              ),
              Container(
                  width: MediaQuery.of(context).size.width * 0.6,
                  height: MediaQuery.of(context).size.height * 0.10,
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.blue),
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    children: [
                      const Text("2024"),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.54,
                        height: MediaQuery.of(context).size.height * 0.50,
                        padding: const EdgeInsets.all(2),
                        child: CustomPaint(
                            painter: LineChartPainter(
                                leftText: "",
                                text: "SG Target Met:",
                                targetValue: 0.5)),
                      ),
                    ],
                  ))
            ],
          ),
        ]),
      ),
    );
  }
}
