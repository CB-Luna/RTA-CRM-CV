import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rta_crm_cv/providers/crm/dashboard_provider.dart';
import 'package:rta_crm_cv/providers/side_menu_provider.dart';
import 'package:rta_crm_cv/public/colors.dart';
import 'package:rta_crm_cv/theme/theme.dart';
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
                            titlesData: titlesData,
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
        x: 0,
        barRods: [
          BarChartRodData(
            toY: 10,
            color: AppTheme.of(context).secondaryColor,
          ),
          BarChartRodData(
            toY: 8,
            color: AppTheme.of(context).primaryText,

          ),
          BarChartRodData(
            toY: 14,
            color: AppTheme.of(context).primaryColor,
          ),
        ],
      ),
      BarChartGroupData(
        x: 1,
        barRods: [
          BarChartRodData(
            toY: 25,
            color: AppTheme.of(context).secondaryColor,
          ),
          BarChartRodData(
            toY: 39,
            color: AppTheme.of(context).primaryText,

          ),
          BarChartRodData(
            toY: 5,
            color: AppTheme.of(context).primaryColor,
          ),
        ],
      )
    ];

    return data;
  }

  Widget getTitles(double value, TitleMeta meta) {
    final style = TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    String text;
    switch (value.toInt()) {
      case 0:
        text = 'Jan';
        break;
      case 1:
        text = 'Feb';
        break;
      case 2:
        text = 'Mar';
        break;
      case 3:
        text = 'Apr';
        break;
      case 4:
        text = 'May';
        break;
      case 5:
        text = 'Jun';
        break;
      case 6:
        text = 'Jul';
        break;
      default:
        text = '';
        break;
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 4,
      child: Text(text, style: style),
    );
  }

  FlTitlesData get titlesData => FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            getTitlesWidget: getTitles,
          ),
        ),
        leftTitles:  AxisTitles(
          sideTitles: SideTitles(showTitles: true),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles:  AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      );

}
