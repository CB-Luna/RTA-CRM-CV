import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rta_crm_cv/pages/dashboards_rtatel/migrations/widgets/bolivar_widgets/linear_percent_widget.dart';
import 'package:rta_crm_cv/pages/dashboards_rtatel/migrations/widgets/bolivar_widgets/percent_widget.dart';
import '../../../../../providers/dashboard_rta/bolivar_peninsula_provider.dart';
import '../../../../../widgets/custom_card.dart';
import 'information_container.dart';

class HomesandLots extends StatefulWidget {
  const HomesandLots({super.key});

  @override
  State<HomesandLots> createState() => _HomesandLotsState();
}

class _HomesandLotsState extends State<HomesandLots> {
  @override
  Widget build(BuildContext context) {
    BolivarPeninsulaProvider provider =
        Provider.of<BolivarPeninsulaProvider>(context);
    return provider.homeandLots == null
        ? const CircularProgressIndicator()
        : CustomCard(
            title: 'Homes and Lots',
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            width: MediaQuery.of(context).size.width * 0.3,
            height: MediaQuery.of(context).size.height * 1.0,
            child: Container(
              padding: const EdgeInsets.all(5),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 1.015,
              child: Column(children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.2,
                  padding: const EdgeInsets.all(2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InformationContainer(
                        text: "Homes Passed Target",
                        valor: provider.homeandLots!.homesPassedTarget ?? 0,
                      ),
                      InformationContainer(
                        text: "HP To Date",
                        valor: provider.homeandLots!.hpToDate ?? 0,
                      ),
                      Flexible(
                        child: LinearPercentIndicatorWidget(
                            percentValue: provider.homeandLots!.hpPercent ?? 0),
                      ),
                      PercentWidget(
                          percentValue: provider.homeandLots!.hpPercent ?? 0)
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InformationContainer(
                        text: "Lots Passed Target",
                        valor: provider.homeandLots!.lotsPassedTarget ?? 0,
                      ),
                      InformationContainer(
                        text: "LP To Date",
                        valor: provider.homeandLots!.lpToDate ?? 0,
                      ),
                      Flexible(
                          child: LinearPercentIndicatorWidget(
                              percentValue:
                                  provider.homeandLots!.lpPercent ?? 0)),
                      PercentWidget(
                          percentValue: provider.homeandLots!.lpPercent ?? 0)
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InformationContainer(
                        text: "Fiber Route Miles Target",
                        valor: provider.homeandLots!.fiberRouteMilesTarget ?? 0,
                      ),
                      InformationContainer(
                        text: "FT To Date",
                        valor: provider.homeandLots!.frToDate ?? 0,
                      ),
                      Flexible(
                          child: LinearPercentIndicatorWidget(
                              percentValue:
                                  provider.homeandLots!.frPercent ?? 0)),
                      PercentWidget(
                          percentValue: provider.homeandLots!.frPercent ?? 0)
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InformationContainer(
                        text: "Connected to Home",
                        valor: provider.homeandLots!.connectedToHome ?? 0,
                      ),
                      InformationContainer(
                        text: "CH To Date",
                        valor: provider.homeandLots!.chToDate ?? 0,
                      ),
                      Flexible(
                          child: LinearPercentIndicatorWidget(
                              percentValue:
                                  provider.homeandLots!.chPercent ?? 0.0)),
                      PercentWidget(
                          percentValue: provider.homeandLots!.chPercent ?? 0)
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InformationContainer(
                        text: "Conduit Route Miles",
                        valor: provider.homeandLots!.conduitRouteMiles ?? 0,
                      ),
                      InformationContainer(
                        text: "CR To Date",
                        valor: provider.homeandLots!.crToDate ?? 0,
                      ),
                      Flexible(
                          child: LinearPercentIndicatorWidget(
                              percentValue:
                                  provider.homeandLots!.crPercent ?? 0)),
                      PercentWidget(
                          percentValue: provider.homeandLots!.crPercent ?? 0)
                    ],
                  ),
                ),
              ]),
            ),
          );
  }
}
