import 'package:flutter/material.dart';

import '../../../../../public/colors.dart';
import '../../../../../widgets/custom_card.dart';

class FTTHCard extends StatefulWidget {
  const FTTHCard({super.key});

  @override
  State<FTTHCard> createState() => _FTTHCardState();
}

class _FTTHCardState extends State<FTTHCard> {
  @override
  Widget build(BuildContext context) {
    return CustomCard(
      title: 'FTTH',
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      width: MediaQuery.of(context).size.width * 0.3,
      height: MediaQuery.of(context).size.height * 0.5,
      child: Container(
        padding: const EdgeInsets.all(10),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.38,
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
                  Text("FTTH Subs Target"),
                  Spacer(),
                  Text("349")
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
                    children: [Text("FTTH Subs To Date"), Spacer(), Text("0")]),
              ),
              Flexible(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.6,
                  height: MediaQuery.of(context).size.height * 0.10,
                  color: Colors.white,
                ),
              )
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
                  Text("Converted FTTH Subs Tg."),
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
                child: const Column(
                    children: [Text("Conv. FTTH Sub TD"), Spacer(), Text("0")]),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.6,
                height: MediaQuery.of(context).size.height * 0.10,
                color: Colors.white,
              )
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
                  Text("New FTTH Subs Target"),
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
                child: const Column(
                    children: [Text("New FTTH to Date"), Spacer(), Text("0")]),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.6,
                height: MediaQuery.of(context).size.height * 0.10,
                color: Colors.white,
              )
            ],
          ),
        ]),
      ),
    );
  }
}
