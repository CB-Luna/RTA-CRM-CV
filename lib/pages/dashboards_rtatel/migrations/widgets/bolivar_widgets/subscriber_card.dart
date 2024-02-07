import 'package:flutter/material.dart';

import '../../../../../public/colors.dart';
import '../../../../../widgets/custom_card.dart';

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
                color: Colors.white,
              )
            ],
          ),
        ]),
      ),
    );
  }
}
