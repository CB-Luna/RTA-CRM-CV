import 'package:flutter/material.dart';
import 'package:rta_crm_cv/helpers/globals.dart';
import 'package:rta_crm_cv/pages/dashboards_rtatel/migrations/widgets/container_widget.dart';
import 'package:rta_crm_cv/pages/dashboards_rtatel/migrations/widgets/indicator_card_widget.dart';
import 'package:rta_crm_cv/theme/theme.dart';
import 'package:rta_crm_cv/widgets/side_menu/sidemenu.dart';

class JobCompleteTechniciansPage extends StatefulWidget {
  const JobCompleteTechniciansPage({super.key});

  @override
  State<JobCompleteTechniciansPage> createState() =>
      _JobCompleteTechniciansPageState();
}

class _JobCompleteTechniciansPageState
    extends State<JobCompleteTechniciansPage> {
  @override
  Widget build(BuildContext context) {
    return Material(
        child: SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Row(children: [
        const SideMenu(),
        SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width - 100,
          child: ListView(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.1,
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                alignment: Alignment.bottomLeft,
                child: Text(
                  "Dashboard ${currentUser!.name}",
                  style: AppTheme.of(context).title1,
                ),
              ),
              Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(10),
                height: MediaQuery.of(context).size.height * 0.07,
                width: MediaQuery.of(context).size.width,
                color: const Color(0xffE9ECEF),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Job Complete Service Experience Survey Results"),
                    Container(
                      width: 150,
                      height: 100,
                      color: Colors.white,
                    )
                  ],
                ),
              ),
              const Flexible(
                child: Row(
                  children: [
                    IndicatorCardWidget(
                      card: 1,
                    ),
                    IndicatorCardWidget(
                      card: 2,
                    ),
                    IndicatorCardWidget(
                      card: 3,
                    ),
                    IndicatorCardWidget(
                      card: 4,
                    ),
                  ],
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ContainerWidget(
                        text: "Technician Ranking",
                        icon: const Icon(Icons.graphic_eq_sharp),
                      ),
                      ContainerWidget(
                        text:
                            " List of surveys by technician that resulted in an incentive",
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ContainerWidget(
                        text: " Total Survey Results",
                      ),
                      ContainerWidget(
                        text: "  Total Survey Sent vs Completed",
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ContainerWidget(
                        text: " Survey Results Breakdown Trend",
                      ),
                      ContainerWidget(
                        text: " Total Survey Trend",
                      )
                    ],
                  ),
                ],
              )
            ],
          ),
        )
      ]),
    ));
  }
}
