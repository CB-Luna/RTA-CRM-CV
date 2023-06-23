import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rta_crm_cv/providers/crm/dashboard_provider.dart';
import 'package:rta_crm_cv/providers/side_menu_provider.dart';
import 'package:rta_crm_cv/public/colors.dart';
import 'package:rta_crm_cv/widgets/card_header.dart';
import 'package:rta_crm_cv/widgets/side_menu/sidemenu.dart';
import 'package:fl_chart/fl_chart.dart';

import '../../widgets/custom_card.dart';

class DashboardsCTRLVPage extends StatefulWidget {
  const DashboardsCTRLVPage({super.key});

  @override
  State<DashboardsCTRLVPage> createState() => _DashboardsCTRLVPageState();
}

class _DashboardsCTRLVPageState extends State<DashboardsCTRLVPage> {
  @override
  Widget build(BuildContext context) {
    void initState() {
      super.initState();

      WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
        final DashboardCRMProvider provider = Provider.of<DashboardCRMProvider>(
          context,
          listen: false,
        );
        await provider.updateState();
      });
    }

    SideMenuProvider provider = Provider.of<SideMenuProvider>(context);
    provider.setIndex(9);

    return Material(
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width - 20,
        child: Container(
          decoration: BoxDecoration(gradient: whiteGradient),
          height: 1500,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const SideMenu(),
              Container(
                alignment: Alignment.topCenter,
                child: CustomCard(
                  width: MediaQuery.of(context).size.width - 200,
                  height: MediaQuery.of(context).size.height,
                  title: "Dashboard CV",
                  child: Column(
                    children: [
                      Container(
                        height: 500,
                        child: BarChart(
                          BarChartData(
                            barGroups: _getdata(),
                          ),
                          swapAnimationDuration:
                              Duration(milliseconds: 150), // Optional
                          swapAnimationCurve: Curves.linear, // Optional
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  List<BarChartGroupData> _getdata() {
    List<BarChartGroupData> data = [
      BarChartGroupData(
        x: 1,
        barRods: [
          BarChartRodData(
            toY: 10,
            color: Colors.red,
          ),
          BarChartRodData(
            toY: 8,
            color: Colors.green,

          ),
          BarChartRodData(
            toY: 14,
            color: Colors.blue,
          ),
        ],
      ),
      BarChartGroupData(
        x: 2,
        barRods: [
          BarChartRodData(
            toY: 10,
            color: Colors.red,
          ),
          BarChartRodData(
            toY: 8,
            color: Colors.green,

          ),
          BarChartRodData(
            toY: 14,
            color: Colors.blue,
          ),
        ],
      )
    ];

    return data;
  }
}
