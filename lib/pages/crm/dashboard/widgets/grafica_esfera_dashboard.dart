import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rta_crm_cv/functions/sizes.dart';
import 'package:rta_crm_cv/providers/crm/dashboard_provider.dart';
import 'package:rta_crm_cv/public/colors.dart';
import 'package:rta_crm_cv/theme/theme.dart';

class GraficaEsferaDashboard extends StatefulWidget {
  const GraficaEsferaDashboard({Key? key}) : super(key: key);

  @override
  State<GraficaEsferaDashboard> createState() => _GraficaDashboardState();
}

class _GraficaDashboardState extends State<GraficaEsferaDashboard> {
  @override
  Widget build(BuildContext context) {
    DashboardCRMProvider provider = Provider.of<DashboardCRMProvider>(context);
    List<int> selectedSpots = [];
    //int touchedIndex = -1;
    return Container(
      width: getWidth(280, context),
      height: getHeight(640, context),
      decoration: BoxDecoration(
        border: Border.all(color: AppTheme.of(context).primaryColor, width: 2),
        borderRadius: BorderRadius.circular(10),
        gradient: whiteGradient,
      ),
      child: Column(
        children: [
          //Activity
          Column(
            children: [
              Text(
                'Activity',
                style: TextStyle(
                    fontFamily: 'UniNeue',
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.of(context).primaryText),
              ),
              SizedBox(
                width: getWidth(220, context),
                height: getHeight(280, context),
                /* decoration: BoxDecoration(
                  border: Border.all(
                      color: AppTheme.of(context).primaryColor, width: 2),
                  borderRadius: BorderRadius.circular(10),
                  gradient: whiteGradient,
                ), */
                child: ScatterChart(
                  ScatterChartData(
                    scatterSpots: [
                      ScatterSpot(
                        4,
                        5,
                        color: selectedSpots.contains(0)
                            ? Colors.grey
                            : Colors.green,
                        radius: 80,
                      ),
                      ScatterSpot(
                        3,
                        3,
                        color: selectedSpots.contains(1)
                            ? Colors.grey
                            : Colors.yellow,
                        radius: 60,
                      ),
                      ScatterSpot(
                        5,
                        2,
                        color: selectedSpots.contains(2)
                            ? Colors.grey
                            : Colors.red,
                        radius: 40,
                      ),
                    ],
                    minX: 0,
                    maxX: 8,
                    minY: 0,
                    maxY: 8,
                    borderData: FlBorderData(
                      show: false,
                    ),
                    gridData: FlGridData(
                      show: false,
                      drawHorizontalLine: true,
                      checkToShowHorizontalLine: (value) => true,
                      getDrawingHorizontalLine: (value) => FlLine(
                        color: AppTheme.of(context).primaryColor,
                      ),
                      drawVerticalLine: true,
                      checkToShowVerticalLine: (value) => true,
                      getDrawingVerticalLine: (value) => FlLine(
                        color: AppTheme.of(context).primaryColor,
                      ),
                    ),
                    titlesData: FlTitlesData(
                      show: false,
                    ),
                    showingTooltipIndicators: selectedSpots,
                    scatterTouchData: ScatterTouchData(
                      enabled: true,
                      handleBuiltInTouches: true,
                      mouseCursorResolver: (FlTouchEvent touchEvent,
                          ScatterTouchResponse? response) {
                        return response == null || response.touchedSpot == null
                            ? MouseCursor.defer
                            : SystemMouseCursors.click;
                      },
                      touchTooltipData: ScatterTouchTooltipData(
                        fitInsideHorizontally: true,
                        fitInsideVertically: true,
                        tooltipBorder: BorderSide(
                            strokeAlign: BorderSide.strokeAlignCenter,
                            color: AppTheme.of(context).primaryColor),
                        tooltipBgColor: AppTheme.of(context).primaryBackground,
                        getTooltipItems: (ScatterSpot touchedBarSpot) {
                          String x, y;
                          switch (touchedBarSpot.x.toInt()) {
                            case 4:
                              x = '3.20';
                              y = 'Leads';
                              break;
                            case 3:
                              x = '1.20';
                              y = 'Opportunity';
                              break;
                            case 5:
                              x = '0.80';
                              y = 'Quotes';
                              break;
                            default:
                              throw Error();
                          }
                          return ScatterTooltipItem(
                            '\$$x\n',
                            textStyle: TextStyle(
                                fontFamily: 'UniNeue',
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: AppTheme.of(context).primaryText),
                            children: [
                              TextSpan(
                                text: y,
                                style: TextStyle(
                                    fontFamily: 'UniNeue',
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: AppTheme.of(context).primaryText),
                              ),
                            ],
                          );
                        },
                      ),
                      touchCallback: (FlTouchEvent event,
                          ScatterTouchResponse? touchResponse) {
                        if (touchResponse == null ||
                            touchResponse.touchedSpot == null) {
                          provider.touchedIndex = -1;
                          return;
                        }
                        if (event is FlTapUpEvent) {
                          provider.touchedIndex =
                              touchResponse.touchedSpot!.spotIndex;
                          setState(
                            () {
                              if (selectedSpots
                                  .contains(provider.touchedIndex)) {
                                selectedSpots.remove(provider.touchedIndex);
                              } else {
                                selectedSpots.add(provider.touchedIndex);
                              }
                            },
                          );
                        }
                      },
                    ),
                  ),
                ),
              )
            ],
          ),
          //Comparation Month
          Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Comparation Month',
                style: TextStyle(
                    fontFamily: 'UniNeue',
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.of(context).primaryText),
              ),
              SizedBox(
                width: getWidth(220, context),
                height: getHeight(280, context),
                /* decoration: BoxDecoration(
                  border: Border.all(
                      color: AppTheme.of(context).primaryColor, width: 2),
                  borderRadius: BorderRadius.circular(10),
                  gradient: whiteGradient,
                ), */
                child: Column(
                  children: [
                    Container(
                      width: getWidth(150, context),
                      height: getHeight(150, context),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        shape: BoxShape.circle,
                        border: Border.all(
                            color: const Color(0xFF2FDC40), width: 2),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('\$3.50',
                              style: TextStyle(
                                  fontFamily: 'UniNeue',
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: AppTheme.of(context).primaryText),
                              textAlign: TextAlign.center),
                          Text('Leads',
                              style: TextStyle(
                                  fontFamily: 'UniNeue',
                                  fontSize: 16,
                                  color: AppTheme.of(context).primaryText),
                              textAlign: TextAlign.center)
                        ],
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                          width: getWidth(120, context),
                          height: getHeight(120, context),
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: const Color(0xFFE7C037), width: 2),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('\$1.50',
                                  style: TextStyle(
                                      fontFamily: 'UniNeue',
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      color: AppTheme.of(context).primaryText),
                                  textAlign: TextAlign.center),
                              Text('Opportunity',
                                  style: TextStyle(
                                      fontFamily: 'UniNeue',
                                      fontSize: 16,
                                      color: AppTheme.of(context).primaryText),
                                  textAlign: TextAlign.center)
                            ],
                          ),
                        ),
                        Container(
                          width: getWidth(95, context),
                          height: getHeight(95, context),
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: const Color(0xFFB2333A), width: 2),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('\$3.50',
                                  style: TextStyle(
                                      fontFamily: 'UniNeue',
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      color: AppTheme.of(context).primaryText),
                                  textAlign: TextAlign.center),
                              Text('Quotes',
                                  style: TextStyle(
                                      fontFamily: 'UniNeue',
                                      fontSize: 16,
                                      color: AppTheme.of(context).primaryText),
                                  textAlign: TextAlign.center)
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
