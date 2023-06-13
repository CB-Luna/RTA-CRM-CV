import 'dart:math';

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
  List<ScatterSpot> flutterLogoData() {
    DashboardCRMProvider provider = Provider.of<DashboardCRMProvider>(context);
    return [
      /// section 1
      ScatterSpot(20, 14.5, color: Colors.blue, radius: provider.radius),
      ScatterSpot(22, 16.5, color: Colors.blue, radius: provider.radius),
      ScatterSpot(24, 18.5, color: Colors.blue, radius: provider.radius),

      ScatterSpot(22, 12.5, color: Colors.blue, radius: provider.radius),
      ScatterSpot(24, 14.5, color: Colors.blue, radius: provider.radius),
      ScatterSpot(26, 16.5, color: Colors.blue, radius: provider.radius),

      ScatterSpot(24, 10.5, color: Colors.blue, radius: provider.radius),
      ScatterSpot(26, 12.5, color: Colors.blue, radius: provider.radius),
      ScatterSpot(28, 14.5, color: Colors.blue, radius: provider.radius),

      ScatterSpot(26, 8.5, color: Colors.blue, radius: provider.radius),
      ScatterSpot(28, 10.5, color: Colors.blue, radius: provider.radius),
      ScatterSpot(30, 12.5, color: Colors.blue, radius: provider.radius),

      ScatterSpot(28, 6.5, color: Colors.blue, radius: provider.radius),
      ScatterSpot(30, 8.5, color: Colors.blue, radius: provider.radius),
      ScatterSpot(32, 10.5, color: Colors.blue, radius: provider.radius),

      ScatterSpot(30, 4.5, color: Colors.blue, radius: provider.radius),
      ScatterSpot(32, 6.5, color: Colors.blue, radius: provider.radius),
      ScatterSpot(34, 8.5, color: Colors.blue, radius: provider.radius),

      ScatterSpot(34, 4.5, color: Colors.blue, radius: provider.radius),
      ScatterSpot(36, 6.5, color: Colors.blue, radius: provider.radius),

      ScatterSpot(38, 4.5, color: Colors.blue, radius: provider.radius),

      /// section 2
      ScatterSpot(20, 14.5, color: Colors.green, radius: provider.radius),
      ScatterSpot(22, 12.5, color: Colors.green, radius: provider.radius),
      ScatterSpot(24, 10.5, color: Colors.green, radius: provider.radius),

      ScatterSpot(22, 16.5, color: Colors.green, radius: provider.radius),
      ScatterSpot(24, 14.5, color: Colors.green, radius: provider.radius),
      ScatterSpot(26, 12.5, color: Colors.green, radius: provider.radius),

      ScatterSpot(24, 18.5, color: Colors.green, radius: provider.radius),
      ScatterSpot(26, 16.5, color: Colors.green, radius: provider.radius),
      ScatterSpot(28, 14.5, color: Colors.green, radius: provider.radius),

      ScatterSpot(26, 20.5, color: Colors.green, radius: provider.radius),
      ScatterSpot(28, 18.5, color: Colors.green, radius: provider.radius),
      ScatterSpot(30, 16.5, color: Colors.green, radius: provider.radius),

      ScatterSpot(28, 22.5, color: Colors.green, radius: provider.radius),
      ScatterSpot(30, 20.5, color: Colors.green, radius: provider.radius),
      ScatterSpot(32, 18.5, color: Colors.green, radius: provider.radius),

      ScatterSpot(30, 24.5, color: Colors.green, radius: provider.radius),
      ScatterSpot(32, 22.5, color: Colors.green, radius: provider.radius),
      ScatterSpot(34, 20.5, color: Colors.green, radius: provider.radius),

      ScatterSpot(34, 24.5, color: Colors.green, radius: provider.radius),
      ScatterSpot(36, 22.5, color: Colors.green, radius: provider.radius),

      ScatterSpot(38, 24.5, color: Colors.green, radius: provider.radius),

      /// section 3
      ScatterSpot(10, 25, color: Colors.green, radius: provider.radius),
      ScatterSpot(12, 23, color: Colors.green, radius: provider.radius),
      ScatterSpot(14, 21, color: Colors.green, radius: provider.radius),

      ScatterSpot(12, 27, color: Colors.green, radius: provider.radius),
      ScatterSpot(14, 25, color: Colors.green, radius: provider.radius),
      ScatterSpot(16, 23, color: Colors.green, radius: provider.radius),

      ScatterSpot(14, 29, color: Colors.green, radius: provider.radius),
      ScatterSpot(16, 27, color: Colors.green, radius: provider.radius),
      ScatterSpot(18, 25, color: Colors.green, radius: provider.radius),

      ScatterSpot(16, 31, color: Colors.green, radius: provider.radius),
      ScatterSpot(18, 29, color: Colors.green, radius: provider.radius),
      ScatterSpot(20, 27, color: Colors.green, radius: provider.radius),

      ScatterSpot(18, 33, color: Colors.green, radius: provider.radius),
      ScatterSpot(20, 31, color: Colors.green, radius: provider.radius),
      ScatterSpot(22, 29, color: Colors.green, radius: provider.radius),

      ScatterSpot(20, 35, color: Colors.green, radius: provider.radius),
      ScatterSpot(22, 33, color: Colors.green, radius: provider.radius),
      ScatterSpot(24, 31, color: Colors.green, radius: provider.radius),

      ScatterSpot(22, 37, color: Colors.green, radius: provider.radius),
      ScatterSpot(24, 35, color: Colors.green, radius: provider.radius),
      ScatterSpot(26, 33, color: Colors.green, radius: provider.radius),

      ScatterSpot(24, 39, color: Colors.green, radius: provider.radius),
      ScatterSpot(26, 37, color: Colors.green, radius: provider.radius),
      ScatterSpot(28, 35, color: Colors.green, radius: provider.radius),

      ScatterSpot(26, 41, color: Colors.green, radius: provider.radius),
      ScatterSpot(28, 39, color: Colors.green, radius: provider.radius),
      ScatterSpot(30, 37, color: Colors.green, radius: provider.radius),

      ScatterSpot(28, 43, color: Colors.green, radius: provider.radius),
      ScatterSpot(30, 41, color: Colors.green, radius: provider.radius),
      ScatterSpot(32, 39, color: Colors.green, radius: provider.radius),

      ScatterSpot(30, 45, color: Colors.green, radius: provider.radius),
      ScatterSpot(32, 43, color: Colors.green, radius: provider.radius),
      ScatterSpot(34, 41, color: Colors.green, radius: provider.radius),

      ScatterSpot(34, 45, color: Colors.green, radius: provider.radius),
      ScatterSpot(36, 43, color: Colors.green, radius: provider.radius),

      ScatterSpot(38, 45, color: Colors.green, radius: provider.radius),
    ];
  }

  List<ScatterSpot> randomData() {
    DashboardCRMProvider provider = Provider.of<DashboardCRMProvider>(context);
    const blue1Count = 21;
    const blue2Count = 57;
    return List.generate(blue1Count + blue2Count, (i) {
      Color color;
      if (i < blue1Count) {
        color = Colors.blue;
      } else {
        color = Colors.green;
      }

      return ScatterSpot(
        (Random().nextDouble() * (provider.maxX - 8)) + 4,
        (Random().nextDouble() * (provider.maxY - 8)) + 4,
        color: color,
        radius: (Random().nextDouble() * 16) + 4,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    DashboardCRMProvider provider = Provider.of<DashboardCRMProvider>(context);
    List<int> selectedSpots = [];
    int touchedIndex = -1;
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
              Container(
                width: 230,
                height: 300,
                decoration: BoxDecoration(
                  border: Border.all(
                      color: AppTheme.of(context).primaryColor, width: 2),
                  borderRadius: BorderRadius.circular(10),
                  gradient: whiteGradient,
                ),
                child: /* GestureDetector(
                  onTap: () {
                    setState(() {
                      provider.showFlutter = !provider.showFlutter;
                    });
                  },
                  child: ScatterChart(
                    ScatterChartData(
                      scatterSpots: provider.showFlutter
                          ? flutterLogoData()
                          : randomData(),
                      minX: 0,
                      maxX: provider.maxX,
                      minY: 0,
                      maxY: provider.maxY,
                      borderData: FlBorderData(
                        show: false,
                      ),
                      gridData: FlGridData(
                        show: false,
                      ),
                      titlesData: FlTitlesData(
                        show: false,
                      ),
                      scatterTouchData: ScatterTouchData(
                        enabled: false,
                      ),
                    ),
                    swapAnimationDuration: const Duration(milliseconds: 600),
                    swapAnimationCurve: Curves.fastOutSlowIn,
                  ),
                ), */
              ScatterChart(
                  ScatterChartData(
                    clipData: FlClipData.all(),
                    scatterSpots: [
                      ScatterSpot(
                        4,
                        5,
                        color: selectedSpots.contains(0)
                            ? Colors.green
                            : Colors.green,
                        radius: 100,
                      ),
                      ScatterSpot(
                        3,
                        3,
                        color: selectedSpots.contains(1)
                            ? Colors.yellow
                            : Colors.yellow,
                        radius: 80,
                      ),
                      ScatterSpot(
                        5,
                        2,
                        color:
                            selectedSpots.contains(2) ? Colors.red : Colors.red,
                        radius: 60,
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
                        tooltipBgColor: Colors.black,
                        getTooltipItems: (ScatterSpot touchedBarSpot) {
                          return ScatterTooltipItem(
                            'X: ',
                            textStyle: TextStyle(
                              height: 1.2,
                              color: Colors.grey[100],
                              fontStyle: FontStyle.italic,
                            ),
                            bottomMargin: 10,
                            children: [
                              TextSpan(
                                text: '${touchedBarSpot.x.toInt()} \n',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextSpan(
                                text: 'Y: ',
                                style: TextStyle(
                                  height: 1.2,
                                  color: Colors.grey[100],
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                              TextSpan(
                                text: touchedBarSpot.y.toInt().toString(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                      touchCallback: (FlTouchEvent event,
                          ScatterTouchResponse? touchResponse) {
                        if (touchResponse == null ||
                            touchResponse.touchedSpot == null) {
                          return;
                        }
                        if (event is FlTapUpEvent) {
                          final sectionIndex =
                              touchResponse.touchedSpot!.spotIndex;
                          setState(
                            () {
                              if (selectedSpots.contains(sectionIndex)) {
                                selectedSpots.remove(sectionIndex);
                              } else {
                                selectedSpots.add(sectionIndex);
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
            children: [
              Text(
                'Comparation Month',
                style: TextStyle(
                    fontFamily: 'UniNeue',
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.of(context).primaryText),
              ),
              Container(
                width: 230,
                height: 300,
                decoration: BoxDecoration(
                  border: Border.all(
                      color: AppTheme.of(context).primaryColor, width: 2),
                  borderRadius: BorderRadius.circular(10),
                  gradient: whiteGradient,
                ),
                 ),
            ],
          ),
        ],
      ),
    );
  }
}
