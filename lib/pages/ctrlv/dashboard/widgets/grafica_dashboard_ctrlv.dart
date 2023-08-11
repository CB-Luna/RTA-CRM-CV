import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rta_crm_cv/functions/date_format.dart';
import 'package:rta_crm_cv/functions/sizes.dart';
import 'package:rta_crm_cv/providers/ctrlv/dashboard_provider.dart';
import 'package:rta_crm_cv/theme/theme.dart';
import 'package:rta_crm_cv/widgets/captura/custom_ddown_menu/custom_dropdown_dashboard.dart';
import 'package:rta_crm_cv/widgets/custom_card.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:rta_crm_cv/widgets/custom_scrollbar.dart';
import 'package:rta_crm_cv/widgets/custom_text_icon_button.dart';
import 'package:rta_crm_cv/widgets/indicator.dart';

class GraficaDashboardCtrlV extends StatefulWidget {
  const GraficaDashboardCtrlV({Key? key}) : super(key: key);

  @override
  State<GraficaDashboardCtrlV> createState() => _GraficaDashboardCtrlVState();
}

class _GraficaDashboardCtrlVState extends State<GraficaDashboardCtrlV> {
  @override
  Widget build(BuildContext context) {
    Color verde = AppTheme.of(context).tertiaryColor;
    DashboardCVProvider provider = Provider.of<DashboardCVProvider>(context);
    Widget leftTitleWidgets(double value, TitleMeta meta) {
      if (value == meta.max) {
        return Container();
      }
      return SideTitleWidget(
        axisSide: meta.axisSide,
        child: Text(value.toString(),
            style: TextStyle(
              fontSize: 15,
              fontFamily: 'UniNeue',
              fontWeight: FontWeight.normal,
              color: AppTheme.of(context).primaryText,
            )),
      );
    }

    Widget bottomTitles(double value, TitleMeta meta) {
      String text;
      switch (value.toInt()) {
        case 0:
          text = DateFormat("MMM").format(DateTime(provider.dateRange.end.year, provider.dateRange.end.month - 11));
          break;
        case 1:
          text = DateFormat("MMM").format(DateTime(provider.dateRange.end.year, provider.dateRange.end.month - 10));
          break;
        case 2:
          text = DateFormat("MMM").format(DateTime(provider.dateRange.end.year, provider.dateRange.end.month - 9));
          break;
        case 3:
          text = DateFormat("MMM").format(DateTime(provider.dateRange.end.year, provider.dateRange.end.month - 8));
          break;
        case 4:
          text = DateFormat("MMM").format(DateTime(provider.dateRange.end.year, provider.dateRange.end.month - 7));
          break;
        case 5:
          text = DateFormat("MMM").format(DateTime(provider.dateRange.end.year, provider.dateRange.end.month - 6));
          break;
        case 6:
          text = DateFormat("MMM").format(DateTime(provider.dateRange.end.year, provider.dateRange.end.month - 5));
          break;
        case 7:
          text = DateFormat("MMM").format(DateTime(provider.dateRange.end.year, provider.dateRange.end.month - 4));
          break;
        case 8:
          text = DateFormat("MMM").format(DateTime(provider.dateRange.end.year, provider.dateRange.end.month - 3));
          break;
        case 9:
          text = DateFormat("MMM").format(DateTime(provider.dateRange.end.year, provider.dateRange.end.month - 2));
          break;
        case 10:
          text = DateFormat("MMM").format(DateTime(provider.dateRange.end.year, provider.dateRange.end.month - 1));
          break;
        case 11:
          text = DateFormat("MMM").format(provider.dateRange.end);
          break;
        default:
          text = '\$';
          break;
      }
      return SideTitleWidget(
        axisSide: meta.axisSide,
        child: TextButton(
          onPressed: (() {
            switch (value.toInt()) {
              case 0:
                break;
              case 1:
                break;
              case 2:
                break;
              case 3:
                break;
              case 4:
                break;
            }
          }),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15,
              fontFamily: 'UniNeue',
              fontWeight: FontWeight.normal,
              color: AppTheme.of(context).primaryText,
            ),
          ),
        ),
      );
    }

    return CustomCard(
      width: getWidth(670, context),
      height: getHeight(432.91, context),
      title: 'Overview',
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: CustomScrollBar(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  provider.selectChartValue == 'PieChart'
                      ? Row(
                          children: [
                            Indicator(
                              color: provider.azul,
                              text: 'CRY',
                              isSquare: false,
                              size: provider.touchedIndex == 0 ? 18 : 16,
                              textColor: provider.touchedIndex == 0
                                  ? Colors.black
                                  : Colors.grey,
                            ),
                            SizedBox(width: getWidth(10, context)),
                            Indicator(
                              color: provider.rojo,
                              text: 'ODE',
                              isSquare: false,
                              size: provider.touchedIndex == 1 ? 18 : 16,
                              textColor: provider.touchedIndex == 1
                                  ? Colors.black
                                  : Colors.grey,
                            ),
                            SizedBox(width: getWidth(10, context)),
                            Indicator(
                              color: provider.naranja,
                              text: 'SMI',
                              isSquare: false,
                              size: provider.touchedIndex == 2 ? 18 : 16,
                              textColor: provider.touchedIndex == 2
                                  ? Colors.black
                                  : Colors.grey,
                            ),
                            SizedBox(width: getWidth(56, context)),
                          ],
                        )
                      : SizedBox(width: getWidth(56, context)),
                  CustomTextIconButton(
                    isLoading: false,
                    icon: Icon(Icons.calendar_month,
                        color: AppTheme.of(context).primaryBackground),
                    text:
                        '${dateFormat(provider.dateRange.start)} - ${dateFormat(provider.dateRange.end)}',
                    onTap: () {
                      provider.pickDateRange(context);
                    },
                  ),
                  SizedBox(width: getWidth(56, context)),
                  CustomeDDownMenuDashboard(
                    icon: Icons.bar_chart,
                    width: 173,
                    list: provider.chartList,
                    dropdownValue: provider.selectChartValue,
                    onChanged: (p0) {
                      if (p0 != null) {
                        provider.selectChart(p0);
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            width: getWidth(670, context), //670
            height: getHeight(300, context), //350
            child: provider.selectChartValue == 'Totals Barchart'
                ? BarChart(
                    BarChartData(
                      alignment: BarChartAlignment.spaceAround,
                      barTouchData: BarTouchData(
                        enabled: true,
                        touchTooltipData: BarTouchTooltipData(
                            tooltipBgColor:
                                const Color.fromARGB(255, 204, 204, 204),
                            getTooltipItem: (group, groupIndex, rod, rodIndex) {
                              String ace;
                              switch (group.x.toInt()) {
                                case 0:
                                  ace = (provider.elevenMonthsAgoEndCry + provider.elevenMonthsAgoEndOde + provider.elevenMonthsAgoEndSmi).toString();
                                  break;
                                case 1:
                                  ace = (provider.tenMonthsAgoEndCry + provider.tenMonthsAgoEndOde + provider.tenMonthsAgoEndSmi).toString();
                                  break;
                                case 2:
                                  ace = (provider.nineMonthsAgoEndCry + provider.nineMonthsAgoEndOde + provider.nineMonthsAgoEndSmi).toString();
                                  break;
                                case 3:
                                  ace = (provider.eightMonthsAgoEndCry + provider.eightMonthsAgoEndOde + provider.eightMonthsAgoEndSmi).toString();
                                  break;
                                case 4:
                                  ace = (provider.sevenMonthsAgoEndCry + provider.sevenMonthsAgoEndOde + provider.sevenMonthsAgoEndSmi).toString();
                                  break;
                                case 5:
                                  ace = (provider.sixMonthsAgoEndCry + provider.sixMonthsAgoEndOde + provider.sixMonthsAgoEndSmi).toString();
                                  break;
                                case 6:
                                  ace = (provider.fiveMonthsAgoEndCry + provider.fiveMonthsAgoEndOde + provider.fiveMonthsAgoEndSmi).toString();
                                  break;
                                case 7:
                                  ace = (provider.fourMonthsAgoEndCry + provider.fourMonthsAgoEndOde + provider.fourMonthsAgoEndSmi).toString();
                                  break;
                                case 8:
                                  ace = (provider.threeMonthsAgoEndCry + provider.threeMonthsAgoEndOde + provider.threeMonthsAgoEndSmi).toString();
                                  break;
                                case 9:
                                  ace = (provider.twoMonthsAgoEndCry + provider.twoMonthsAgoEndOde + provider.twoMonthsAgoEndSmi).toString();
                                  break;
                                case 10:
                                  ace = (provider.oneMonthAgoEndCry + provider.oneMonthAgoEndOde + provider.oneMonthAgoEndSmi).toString();
                                  break;
                                case 11:
                                  ace = (provider.actualMonthEndCry + provider.actualMonthEndOde + provider.actualMonthEndSmi).toString();
                                  break;
                                default:
                                  throw Error();
                              }
                              return BarTooltipItem(
                                '$ace Issues',
                                TextStyle(
                                  color: AppTheme.of(context).tertiaryColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              );
                            }),
                        touchCallback: (FlTouchEvent event, barTouchResponse) {
                          setState(() {
                            if (!event.isInterestedForInteractions ||
                                barTouchResponse == null ||
                                barTouchResponse.spot == null) {
                              provider.touchedIndex = -1;
                              return;
                            }
                            provider.touchedIndex =
                                barTouchResponse.spot!.touchedBarGroupIndex;
                          });
                        },
                      ),
                      titlesData: FlTitlesData(
                        show: true,
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 30,
                            getTitlesWidget: bottomTitles,
                          ),
                        ),
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 80,
                            getTitlesWidget: leftTitleWidgets,
                          ),
                        ),
                        topTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        rightTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                      ),
                      gridData: FlGridData(
                        show: true,
                        checkToShowHorizontalLine: (value) => value % 10 == 0,
                        getDrawingHorizontalLine: (value) => FlLine(
                          color: const Color(0xffe7e8ec),
                          strokeWidth: 1,
                        ),
                        drawVerticalLine: false,
                      ),
                      borderData: FlBorderData(
                        show: true,
                      ),
                      groupsSpace: 50,
                      barGroups: [
                        provider.puntos(0, provider.elevenMonthsAgoEndCry + provider.elevenMonthsAgoEndOde + provider.elevenMonthsAgoEndSmi, verde),
                        provider.puntos(1, provider.tenMonthsAgoEndCry + provider.tenMonthsAgoEndOde + provider.tenMonthsAgoEndSmi, verde),
                        provider.puntos(2, provider.nineMonthsAgoEndCry + provider.nineMonthsAgoEndOde + provider.nineMonthsAgoEndSmi, verde), //Color(0xFFE7C037)
                        provider.puntos(3, provider.eightMonthsAgoEndCry + provider.eightMonthsAgoEndOde + provider.eightMonthsAgoEndSmi, verde),
                        provider.puntos(4, provider.sevenMonthsAgoEndCry + provider.sevenMonthsAgoEndOde + provider.sevenMonthsAgoEndSmi, verde),
                        provider.puntos(5, provider.sixMonthsAgoEndCry + provider.sixMonthsAgoEndOde + provider.sixMonthsAgoEndSmi, verde),
                        provider.puntos(6, provider.fiveMonthsAgoEndCry + provider.fiveMonthsAgoEndOde + provider.fiveMonthsAgoEndSmi, verde),
                        provider.puntos(7, provider.fourMonthsAgoEndCry + provider.fourMonthsAgoEndOde + provider.fourMonthsAgoEndSmi, verde),
                        provider.puntos(8, provider.threeMonthsAgoEndCry + provider.threeMonthsAgoEndOde + provider.threeMonthsAgoEndSmi, verde),
                        provider.puntos(9, provider.twoMonthsAgoEndCry + provider.twoMonthsAgoEndOde + provider.twoMonthsAgoEndSmi, verde),
                        provider.puntos(10, provider.oneMonthAgoEndCry + provider.oneMonthAgoEndOde + provider.oneMonthAgoEndSmi, verde),
                        provider.puntos(11, provider.actualMonthEndCry + provider.actualMonthEndOde + provider.actualMonthEndSmi, verde),
                      ],
                    ),
                  )
                : provider.selectChartValue == 'Barchart'
                    ? BarChart(
                        BarChartData(
                          alignment: BarChartAlignment.spaceAround,
                          barTouchData: BarTouchData(
                            enabled: true,
                            touchTooltipData: BarTouchTooltipData(
                                getTooltipItem:
                                    (group, groupIndex, rod, rodIndex) {
                                  String? n1;
                                  if (group.x == 0) {
                                    switch (rodIndex) {
                                      case 0:
                                        n1 = provider.elevenMonthsAgoEndCry.toString();
                                        break;
                                      case 1:
                                        n1 = provider.elevenMonthsAgoEndOde.toString();
                                        break;
                                      case 2:
                                        n1 = provider.elevenMonthsAgoEndSmi.toString();
                                        break;
                                      default:
                                        throw Error();
                                    }
                                  } else if (group.x == 1) {
                                    switch (rodIndex) {
                                      case 0:
                                        n1 = provider.tenMonthsAgoEndCry.toString();
                                        break;
                                      case 1:
                                        n1 = provider.tenMonthsAgoEndOde.toString();
                                        break;
                                      case 2:
                                        n1 = provider.tenMonthsAgoEndSmi.toString();
                                        break;
                                      default:
                                        throw Error();
                                    }
                                  } else if (group.x == 2) {
                                    switch (rodIndex) {
                                      case 0:
                                        n1 = provider.nineMonthsAgoEndCry.toString();
                                        break;
                                      case 1:
                                        n1 = provider.nineMonthsAgoEndOde.toString();
                                        break;
                                      case 2:
                                        n1 = provider.nineMonthsAgoEndSmi.toString();
                                        break;

                                      default:
                                        throw Error();
                                    }
                                  } else if (group.x == 3) {
                                    switch (rodIndex) {
                                      case 0:
                                        n1 = provider.eightMonthsAgoEndCry.toString();
                                        break;
                                      case 1:
                                        n1 = provider.eightMonthsAgoEndOde.toString();
                                        break;
                                      case 2:
                                        n1 = provider.eightMonthsAgoEndSmi.toString();
                                        break;

                                      default:
                                        throw Error();
                                    }
                                  } else if (group.x == 4) {
                                    switch (rodIndex) {
                                      case 0:
                                        n1 = provider.sevenMonthsAgoEndCry.toString();
                                        break;
                                      case 1:
                                        n1 = provider.sevenMonthsAgoEndOde.toString();
                                        break;
                                      case 2:
                                        n1 = provider.sevenMonthsAgoEndSmi.toString();
                                        break;

                                      default:
                                        throw Error();
                                    }
                                  } else if (group.x == 5) {
                                    switch (rodIndex) {
                                      case 0:
                                        n1 = provider.sixMonthsAgoEndCry.toString();
                                        break;
                                      case 1:
                                        n1 = provider.sixMonthsAgoEndOde.toString();
                                        break;
                                      case 2:
                                        n1 = provider.sixMonthsAgoEndSmi.toString();
                                        break;

                                      default:
                                        throw Error();
                                    }
                                  } else if (group.x == 6) {
                                    switch (rodIndex) {
                                      case 0:
                                        n1 = provider.fiveMonthsAgoEndCry.toString();
                                        break;
                                      case 1:
                                        n1 = provider.fiveMonthsAgoEndOde.toString();
                                        break;
                                      case 2:
                                        n1 = provider.fiveMonthsAgoEndSmi.toString();
                                        break;
                                      default:
                                        throw Error();
                                    }
                                  } else if (group.x == 7) {
                                    switch (rodIndex) {
                                      case 0:
                                        n1 = provider.fourMonthsAgoEndCry.toString();
                                        break;
                                      case 1:
                                        n1 = provider.fourMonthsAgoEndOde.toString();
                                        break;
                                      case 2:
                                        n1 = provider.fourMonthsAgoEndSmi.toString();
                                        break;

                                      default:
                                        throw Error();
                                    }
                                  } else if (group.x == 8) {
                                    switch (rodIndex) {
                                      case 0:
                                        n1 = provider.threeMonthsAgoEndCry.toString();
                                        break;
                                      case 1:
                                        n1 = provider.threeMonthsAgoEndOde.toString();
                                        break;
                                      case 2:
                                        n1 = provider.threeMonthsAgoEndSmi.toString();
                                        break;

                                      default:
                                        throw Error();
                                    }
                                  } else if (group.x == 9) {
                                    switch (rodIndex) {
                                      case 0:
                                        n1 = provider.twoMonthsAgoEndCry.toString();
                                        break;
                                      case 1:
                                        n1 = provider.twoMonthsAgoEndOde.toString();
                                        break;
                                      case 2:
                                        n1 = provider.twoMonthsAgoEndSmi.toString();
                                        break;

                                      default:
                                        throw Error();
                                    }
                                  } else if (group.x == 10) {
                                    switch (rodIndex) {
                                      case 0:
                                        n1 = provider.oneMonthAgoEndCry.toString();
                                        break;
                                      case 1:
                                        n1 = provider.oneMonthAgoEndOde.toString();
                                        break;
                                      case 2:
                                        n1 = provider.oneMonthAgoEndSmi.toString();
                                        break;

                                      default:
                                        throw Error();
                                    }
                                  } else if (group.x == 11) {
                                    switch (rodIndex) {
                                      case 0:
                                        n1 = provider.actualMonthEndCry.toString();
                                        break;
                                      case 1:
                                        n1 = provider.actualMonthEndOde.toString();
                                        break;
                                      case 2:
                                        n1 = provider.actualMonthEndSmi.toString();
                                        break;

                                      default:
                                        throw Error();
                                    }
                                  }
                                  return BarTooltipItem(
                                      rodIndex == 0
                                          ? 'CRY: $n1'
                                          : rodIndex == 1
                                              ? 'ODE: $n1'
                                              : 'SMI: $n1',
                                      TextStyle(
                                        color: rodIndex == 0
                                            ? provider.azul
                                            : rodIndex == 1
                                                ? provider.rojo
                                                : provider.naranja,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ));
                                },
                                tooltipBgColor:
                                    const Color.fromARGB(255, 204, 204, 204)),
                            touchCallback:
                                (FlTouchEvent event, barTouchResponse) {
                              setState(() {
                                if (!event.isInterestedForInteractions ||
                                    barTouchResponse == null ||
                                    barTouchResponse.spot == null) {
                                  provider.touchedIndex = -1;
                                  return;
                                }
                                provider.touchedIndex =
                                    barTouchResponse.spot!.touchedBarGroupIndex;
                              });
                            },
                          ),
                          titlesData: FlTitlesData(
                            show: true,
                            bottomTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                reservedSize: 30,
                                getTitlesWidget: bottomTitles,
                              ),
                            ),
                            leftTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                reservedSize: 80,
                                getTitlesWidget: leftTitleWidgets,
                              ),
                            ),
                            topTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                            rightTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                          ),
                          gridData: FlGridData(
                            show: true,
                            checkToShowHorizontalLine: (value) =>
                                value % 10 == 0,
                            getDrawingHorizontalLine: (value) => FlLine(
                              color: const Color(0xffe7e8ec),
                              strokeWidth: 1,
                            ),
                            drawVerticalLine: false,
                          ),
                          borderData: FlBorderData(
                            show: true,
                          ),
                          groupsSpace: 50,
                          barGroups: provider.getData(),
                        ),
                      )
                    : provider.selectChartValue == 'Linechart'
                        ? LineChart(
                            LineChartData(
                              borderData: FlBorderData(
                                  show: true,
                                  border: Border(
                                      top: BorderSide(
                                          color:
                                              AppTheme.of(context).primaryText,
                                          width: 1,
                                          style: BorderStyle.solid),
                                      bottom: BorderSide(
                                          color:
                                              AppTheme.of(context).primaryText,
                                          width: 1,
                                          style: BorderStyle.solid),
                                      left: BorderSide(
                                          color:
                                              AppTheme.of(context).primaryText,
                                          width: 1,
                                          style: BorderStyle.solid),
                                      right: BorderSide(
                                          color:
                                              AppTheme.of(context).primaryText,
                                          width: 1,
                                          style: BorderStyle.solid))),
                              lineTouchData: LineTouchData(
                                enabled: true,
                                touchTooltipData: LineTouchTooltipData(
                                  maxContentWidth: 300,
                                  tooltipBgColor:
                                      const Color.fromARGB(255, 204, 204, 204),
                                  getTooltipItems:
                                      (List<LineBarSpot> touchedBarSpots) {
                                    return touchedBarSpots.map(
                                      (barSpot) {
                                        final flSpot = barSpot;
                                        return LineTooltipItem(
                                          flSpot.barIndex == 0
                                              ? 'Total: ${flSpot.y}'
                                              : flSpot.barIndex == 1
                                                  ? 'CRY: ${flSpot.y} '
                                                  : flSpot.barIndex == 2
                                                      ? 'ODE: ${flSpot.y} '
                                                      : 'SMI: ${flSpot.y} ',
                                          TextStyle(
                                            color: flSpot.barIndex == 0
                                                ? verde
                                                : flSpot.barIndex == 1
                                                    ? provider.azul
                                                    : flSpot.barIndex == 2
                                                        ? provider.rojo
                                                        : provider.naranja,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        );
                                      },
                                    ).toList();
                                  },
                                ),
                              ),
                              lineBarsData: [
                                provider.totals(verde),
                                provider.getCRY(),
                                provider.getODE(),
                                provider.getSMI(),
                              ],
                              minY: 0,
                              titlesData: FlTitlesData(
                                bottomTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                      showTitles: true,
                                      interval: 1,
                                      getTitlesWidget: bottomTitles,
                                      reservedSize: 30),
                                ),
                                leftTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                    showTitles: true,
                                    getTitlesWidget: leftTitleWidgets,
                                    reservedSize: 80,
                                  ),
                                ),
                                topTitles: AxisTitles(
                                  sideTitles: SideTitles(showTitles: false),
                                ),
                                rightTitles: AxisTitles(
                                  sideTitles: SideTitles(showTitles: false),
                                ),
                              ),
                              gridData: FlGridData(
                                show: true,
                                drawVerticalLine: false,
                                getDrawingHorizontalLine: (value) => FlLine(
                                  color: const Color(0xffe7e8ec),
                                  strokeWidth: 1,
                                ),
                              ),
                              //maxY: providertablero.puntos.first.septiembre.ahorro,
                            ),
                          )
                        : provider.selectChartValue == 'PieChart'
                            ? PieChart(
                                PieChartData(
                                    pieTouchData: PieTouchData(touchCallback:
                                        (FlTouchEvent event, pieTouchResponse) {
                                      setState(() {
                                        if (!event
                                                .isInterestedForInteractions ||
                                            pieTouchResponse == null ||
                                            pieTouchResponse.touchedSection ==
                                                null) {
                                          provider.touchedIndex = -1;
                                          return;
                                        }
                                        provider.touchedIndex = pieTouchResponse
                                            .touchedSection!
                                            .touchedSectionIndex;
                                      });
                                    }),
                                    borderData: FlBorderData(
                                      show: false,
                                    ),
                                    sectionsSpace: 0,
                                    centerSpaceRadius: 60,
                                    sections: provider.showingSections()),
                              )
                            : Container(),
          ),
        ],
      ),
    );
  }
}
