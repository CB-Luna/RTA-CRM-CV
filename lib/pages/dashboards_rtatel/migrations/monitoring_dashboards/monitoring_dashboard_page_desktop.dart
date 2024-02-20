import 'dart:math';

import 'package:flutter/material.dart';
import 'package:rta_crm_cv/functions/sizes.dart';
import 'package:rta_crm_cv/helpers/globals.dart';
import 'package:rta_crm_cv/pages/dashboards_rtatel/migrations/monitoring_dashboards/widgets/summary.dart';
import 'package:rta_crm_cv/widgets/side_menu/sidemenu.dart';

import '../../../../public/colors.dart';
import '../../../../theme/theme.dart';
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
    return Material(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(gradient: whiteGradient),
        child: Row(
          children: [
            const SideMenu(),
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: ListView(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.1,
                      child: Row(
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
                                height:
                                    MediaQuery.of(context).size.height * 0.08,
                                alignment: Alignment.center,
                                color: AppTheme.of(context).primaryColor,
                                child: const Text(
                                    "After Hours Monitoring Report",
                                    style: TextStyle(
                                        fontFamily: 'Gotham-Regular',
                                        color: Colors.white,
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold)),
                              ),
                            )
                          ]),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    const TopBarButtons(),
                    const Summary(),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
