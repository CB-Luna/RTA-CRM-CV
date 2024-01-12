import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'job_complete_techni_pop_up.dart';

class IndicatorCardWidget extends StatefulWidget {
  const IndicatorCardWidget({this.card, super.key});
  final int? card;
  @override
  State<IndicatorCardWidget> createState() => _IndicatorCardWidgetState();
}

class _IndicatorCardWidgetState extends State<IndicatorCardWidget> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: InkWell(
          onTap: () async {
            switch (widget.card) {
              case 1:
                print("1");
                await showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return StatefulBuilder(builder: (context, setState) {
                        return const JobCompleteTechniPopUp();
                      });
                    });
                break;
              case 2:
                print("2");
                await showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return StatefulBuilder(builder: (context, setState) {
                        return const JobCompleteTechniPopUp();
                      });
                    });
                break;
              case 3:
                print("3");
                await showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return StatefulBuilder(builder: (context, setState) {
                        return const JobCompleteTechniPopUp();
                      });
                    });
                break;
              case 4:
                print("4");
                await showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return StatefulBuilder(builder: (context, setState) {
                        return const JobCompleteTechniPopUp();
                      });
                    });
                break;
            }
          },
          child: Container(
            margin: const EdgeInsets.all(10),
            width: MediaQuery.of(context).size.width * 0.22,
            height: MediaQuery.of(context).size.height * 0.2,
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                color: colorCard(widget.card ?? 0, context)),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                        padding:
                            const EdgeInsets.only(top: 30, left: 10, right: 10),
                        height: MediaQuery.of(context).size.height * 0.15,
                        width: MediaQuery.of(context).size.width * 0.15,
                        alignment: Alignment.centerLeft,
                        child: const Column(
                          children: [
                            Text(
                              "0",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                            Text(
                              "Total",
                              style: TextStyle(color: Colors.white),
                            )
                          ],
                        )),
                    icon(widget.card ?? 0, context),
                  ],
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.05,
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.only(
                      left: 15, top: 10, bottom: 10, right: 10),
                  alignment: Alignment.bottomLeft,
                  decoration: const BoxDecoration(
                      border: Border(top: BorderSide(color: Colors.black))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        text(widget.card ?? 0, context),
                        style: const TextStyle(color: Colors.white),
                      ),
                      const Icon(
                        Icons.arrow_forward_ios_outlined,
                        size: 10,
                        color: Colors.white,
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Color colorCard(int card, BuildContext context) {
  late Color color;

  switch (card) {
    case 1: //Sales Form
      color = Colors.green;
      break;
    case 2: //Sen. Exec. Validate
      color = Colors.yellow;
      break;
    case 3: //Finance Validate
      color = Colors.red;
      break;
    case 4: //Finance Validate
      color = Colors.blue;
      break;

    default:
      return Colors.black;
  }
  return color;
}

String text(int card, BuildContext context) {
  late String text;

  switch (card) {
    case 1:
      text = "Excellent Service";
      break;
    case 2:
      text = "Good Service";
      break;
    case 3:
      text = "Poor Service";
      break;
    case 4: //Finance Validate
      text = "Total Service";
      break;

    default:
      return "Total";
  }
  return text;
}

FaIcon icon(int card, BuildContext context) {
  late FaIcon icon;

  switch (card) {
    case 1:
      icon = const FaIcon(FontAwesomeIcons.grinStars,
          size: 48.0, color: Colors.white);
      break;
    case 2:
      icon = const FaIcon(
        FontAwesomeIcons.smile,
        size: 48.0,
        color: Colors.white,
      );
      break;
    case 3:
      icon = const FaIcon(
        FontAwesomeIcons.angry,
        size: 48.0,
        color: Colors.white,
      );
      break;
    case 4: //Finance Validate
      icon = const FaIcon(FontAwesomeIcons.smileWink,
          size: 48.0, color: Colors.white
          // color: Colors.grey[300],
          );
      break;

    default:
      return FaIcon(
        FontAwesomeIcons.smile,
        color: Colors.grey[300],
      );
  }
  return icon;
}
