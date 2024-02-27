import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rta_crm_cv/functions/sizes.dart';
import 'package:rta_crm_cv/helpers/globals.dart';
import 'package:rta_crm_cv/pages/dashboards_rtatel/migrations/monitoring_dashboards/widgets/action_log.dart';
import 'package:rta_crm_cv/pages/dashboards_rtatel/migrations/monitoring_dashboards/widgets/eas_txol.dart';
import 'package:rta_crm_cv/pages/dashboards_rtatel/migrations/monitoring_dashboards/widgets/ode_net3.dart';
import 'package:rta_crm_cv/pages/dashboards_rtatel/migrations/monitoring_dashboards/widgets/san_fusion.dart';
import 'package:rta_crm_cv/pages/dashboards_rtatel/migrations/monitoring_dashboards/widgets/smi_sct.dart';
import 'package:rta_crm_cv/pages/dashboards_rtatel/migrations/monitoring_dashboards/widgets/summary.dart';
import 'package:rta_crm_cv/pages/dashboards_rtatel/migrations/monitoring_dashboards/widgets/weekly_error_trends.dart';
import 'package:rta_crm_cv/pages/dashboards_rtatel/migrations/monitoring_dashboards/widgets/wholesale.dart';
import 'package:rta_crm_cv/widgets/side_menu/sidemenu.dart';

import '../../../../providers/dashboard_rta/monitoring_dashboard_provider.dart';
import '../../../../public/colors.dart';
import '../../../../theme/theme.dart';
import 'widgets/cry_sbb.dart';
import 'widgets/summary_opco.dart';
import 'widgets/top_bar_buttons.dart';

class MonitoringDashboardPageDesktop extends StatefulWidget {
  const MonitoringDashboardPageDesktop({super.key});

  @override
  State<MonitoringDashboardPageDesktop> createState() =>
      _MonitoringDashboardPageDesktopState();
}

class _MonitoringDashboardPageDesktopState
    extends State<MonitoringDashboardPageDesktop> {
  @override
  Widget build(BuildContext context) {
    MonitoringDashboardProvider provider =
        Provider.of<MonitoringDashboardProvider>(context);
    return Material(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(gradient: whiteGradient),
        child: Row(
          children: [
            const SideMenu(),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Image.network(
                              assets.logoColor,
                              key: ValueKey(Random().nextInt(100)),
                              height: getHeight(50, context),
                            ),
                          ),
                          Flexible(
                            child: Container(
                              //usando el width y el alignment lo pone en el centro, pero marca overflow
                              // padding: const EdgeInsets.only(left: 100),
                              // margin: const EdgeInsets.all(0),
                              // width: MediaQuery.of(context).size,
                              height: MediaQuery.of(context).size.height * 0.08,
                              alignment: Alignment.center,
                              color: AppTheme.of(context).primaryColor,
                              child: provider.viewPopup == 1
                                  ? const Text("After Hours Monitoring Report",
                                      style: TextStyle(
                                          fontFamily: 'Gotham-Regular',
                                          color: Colors.white,
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold))
                                  : const Text("Monitoring Reports Dashboards",
                                      style: TextStyle(
                                          fontFamily: 'Gotham-Regular',
                                          color: Colors.white,
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold)),
                            ),
                          )
                        ]),
                    const SizedBox(
                      height: 30,
                    ),
                    const TopBarButtons(),
                    provider.viewPopup == 1
                        ? Column(
                            children: [
                              const Summary(),
                              const WeeklyErrorTrends(),
                              const ActionLog(),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.75,
                                height:
                                    MediaQuery.of(context).size.height * 0.1,
                                decoration:
                                    BoxDecoration(color: Colors.grey[700]),
                                padding: const EdgeInsets.all(10),
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.05,
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                  ),
                                  child: const Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.download_outlined,
                                        color: Colors.blue,
                                        size: 28,
                                      ),
                                      SizedBox(width: 15),
                                      Text(
                                        "Download Report",
                                        style: TextStyle(
                                            color: Colors.blue,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 28),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          )
                        : const Column(
                            children: [
                              SummaryOpco(),
                              CRYSBB(),
                              EASTXOL(),
                              ODENET3(),
                              SANFUSION(),
                              SMISCT(),
                              WHOLESALE()
                            ],
                          )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
