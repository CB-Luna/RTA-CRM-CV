import 'package:flutter/material.dart';
import 'package:rta_crm_cv/pages/dashboards_rtatel/migrations/widgets/bolivar_widgets/linear_percent_widget.dart';
import 'package:rta_crm_cv/pages/dashboards_rtatel/migrations/widgets/bolivar_widgets/percent_widget.dart';

import '../../../../../widgets/custom_card.dart';
import 'information_container.dart';

class FixedWirelessCard extends StatefulWidget {
  const FixedWirelessCard({super.key});

  @override
  State<FixedWirelessCard> createState() => _FixedWirelessCardState();
}

class _FixedWirelessCardState extends State<FixedWirelessCard> {
  @override
  Widget build(BuildContext context) {
    return CustomCard(
      title: 'Fixed Wireless',
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      width: MediaQuery.of(context).size.width * 0.3,
      height: MediaQuery.of(context).size.height * 0.55,
      child: Container(
        padding: const EdgeInsets.all(5),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.42,
        child: Column(children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.2,
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InformationContainer(
                  text: "Subs to be Conv. to FTTH",
                  valor: 217,
                ),
                InformationContainer(
                  text: "TB Converted to Date",
                  valor: 0,
                ),
                Flexible(
                    child:
                        LinearPercentIndicatorWidget(percentValue: 93.95 ?? 0)),
                PercentWidget(percentValue: 93.95 ?? 0)
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.2,
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InformationContainer(
                  text: "New Fixed Wireless Target",
                  valor: 100,
                ),
                InformationContainer(
                  text: "New FW to Date",
                  valor: 0,
                ),
                Flexible(
                    child: LinearPercentIndicatorWidget(
                        percentValue: 89.005 ?? 0)),
                PercentWidget(percentValue: 89.05 ?? 0)
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
