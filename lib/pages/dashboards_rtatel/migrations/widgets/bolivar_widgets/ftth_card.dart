import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rta_crm_cv/pages/dashboards_rtatel/migrations/widgets/bolivar_widgets/linear_percent_widget.dart';
import 'package:rta_crm_cv/pages/dashboards_rtatel/migrations/widgets/bolivar_widgets/percent_widget.dart';

import '../../../../../providers/dashboard_rta/bolivar_peninsula_provider.dart';
import '../../../../../widgets/custom_card.dart';
import 'information_container.dart';

class FTTHCard extends StatefulWidget {
  const FTTHCard({super.key});

  @override
  State<FTTHCard> createState() => _FTTHCardState();
}

class _FTTHCardState extends State<FTTHCard> {
  @override
  Widget build(BuildContext context) {
    BolivarPeninsulaProvider provider =
        Provider.of<BolivarPeninsulaProvider>(context);
    return provider.homeandLots == null
        ? const CircularProgressIndicator()
        : CustomCard(
            title: 'FTTH',
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            width: MediaQuery.of(context).size.width * 0.3,
            height: MediaQuery.of(context).size.height * 0.73,
            child: Container(
              padding: const EdgeInsets.all(10),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.61,
              child: SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.2,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InformationContainer(
                              text: "FTTH Subs Target",
                              valor: provider.ftth!.ftthSubsTarget ?? 0,
                            ),
                            InformationContainer(
                              text: "FTTH Subs To Date",
                              valor: provider.ftth!.ftthSubsToDate ?? 0,
                            ),
                            Flexible(
                                child: LinearPercentIndicatorWidget(
                                    percentValue:
                                        provider.ftth!.ftthSubsPercent ?? 0)),
                            PercentWidget(
                                percentValue:
                                    provider.ftth!.ftthSubsPercent ?? 0)
                          ],
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.2,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            InformationContainer(
                              text: "Converted FTTH Subs Tg.",
                              valor:
                                  provider.ftth!.convertedFtthSubsTarget ?? 0,
                            ),
                            InformationContainer(
                              text: "Conv. FTTH Subs TD",
                              valor: provider
                                      .ftth!.convertedFtthSubsTargetToDate ??
                                  0,
                            ),
                            Flexible(
                                child: LinearPercentIndicatorWidget(
                                    percentValue:
                                        provider.ftth!.convertedFtthPercent ??
                                            0)),
                            PercentWidget(
                                percentValue:
                                    provider.ftth!.convertedFtthPercent ?? 0)
                          ],
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.2,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            InformationContainer(
                              text: "New FTTH Subs Target",
                              valor: provider.ftth!.newFtthSubsTarget ?? 0,
                            ),
                            InformationContainer(
                              text: "New FTTH Subs To Date",
                              valor: provider.ftth!.ftthSubsToDate ?? 0,
                            ),
                            Flexible(
                                child: LinearPercentIndicatorWidget(
                                    percentValue:
                                        provider.ftth!.newFtthSubsPercent ??
                                            0)),
                            PercentWidget(
                                percentValue:
                                    provider.ftth!.newFtthSubsPercent ?? 0)
                          ],
                        ),
                      ),
                    ]),
              ),
            ),
          );
  }
}
