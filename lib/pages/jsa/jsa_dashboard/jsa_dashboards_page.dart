import 'package:flutter/material.dart';
import 'package:rta_crm_cv/pages/jsa/jsa_dashboard/widgets/dashboard_jsa.dart';
import 'package:rta_crm_cv/public/colors.dart';
import 'package:rta_crm_cv/widgets/custom_scrollbar.dart';
import 'package:rta_crm_cv/widgets/side_menu/sidemenu.dart';

import '../../../theme/theme.dart';

class JSADashboardsPageDesktop extends StatefulWidget {
  const JSADashboardsPageDesktop({super.key});

  @override
  State<JSADashboardsPageDesktop> createState() =>
      _JSADashboardsPageDesktopState();
}

class _JSADashboardsPageDesktopState extends State<JSADashboardsPageDesktop> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SideMenu(),
            Flexible(
              child: Container(
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(gradient: whiteGradient),
                child: CustomScrollBar(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 10, top: 10, right: 10, bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: SizedBox(
                                    height: 40,
                                    width: 40,
                                    child: Icon(
                                      Icons.menu_outlined,
                                      color: AppTheme.of(context).primaryColor,
                                      size: 35,
                                    ))),
                            Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: SizedBox(
                                height: 40,
                                child: Text('JSA Dashboards',
                                    style: AppTheme.of(context).title1),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const DashboardJsa()
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
