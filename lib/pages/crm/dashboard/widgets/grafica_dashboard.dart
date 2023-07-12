import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rta_crm_cv/functions/money_format.dart';
import 'package:rta_crm_cv/functions/sizes.dart';
import 'package:rta_crm_cv/providers/crm/dashboard_provider.dart';
import 'package:rta_crm_cv/theme/theme.dart';
import 'package:rta_crm_cv/widgets/captura/custom_ddown_menu/custom_dropdown_dashboard.dart';
import 'package:rta_crm_cv/widgets/custom_card.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:rta_crm_cv/widgets/custom_scrollbar.dart';
import 'package:rta_crm_cv/widgets/indicator.dart';

class GraficaDashboard extends StatefulWidget {
  const GraficaDashboard({Key? key}) : super(key: key);

  @override
  State<GraficaDashboard> createState() => _GraficaDashboardState();
}

class _GraficaDashboardState extends State<GraficaDashboard> {
  @override
  Widget build(BuildContext context) {
    Color azul = AppTheme.of(context).primaryColor;
    DashboardCRMProvider provider = Provider.of<DashboardCRMProvider>(context);
    Widget leftTitleWidgets(double value, TitleMeta meta) {
      if (value == meta.max) {
        return Container();
      }
      return SideTitleWidget(
        axisSide: meta.axisSide,
        child: Text('\$${moneyFormat(value)}',
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
          text = 'Jul';

          break;
        case 1:
          text = 'Ago';
          break;
        case 2:
          text = 'Sep';

          break;
        case 3:
          text = 'Oct';
          break;
        case 4:
          text = 'Nov';

          break;
        case 5:
          text = 'Dec';
          break;
        case 6:
          text = 'Jan';

          break;
        case 7:
          text = 'Feb';
          break;
        case 8:
          text = 'Mar';

          break;
        case 9:
          text = 'Apr';
          break;
        case 10:
          text = 'May';

          break;
        case 11:
          text = 'Jun';
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
                              color: provider.verde,
                              text: 'Orders',
                              isSquare: false,
                              size: provider.touchedIndex == 0 ? 18 : 16,
                              textColor: provider.touchedIndex == 0
                                  ? Colors.black
                                  : Colors.grey,
                            ),
                            SizedBox(width: getWidth(10, context)),
                            Indicator(
                              color: provider.amarillo,
                              text: 'Quotes',
                              isSquare: false,
                              size: provider.touchedIndex == 1 ? 18 : 16,
                              textColor: provider.touchedIndex == 1
                                  ? Colors.black
                                  : Colors.grey,
                            ),
                            SizedBox(width: getWidth(10, context)),
                            Indicator(
                              color: provider.rojo,
                              text: 'Canceled',
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
                  CustomeDDownMenuDashboard(
                    icon: Icons.calendar_month,
                    width: 170,
                    list: provider.timeList,
                    dropdownValue: provider.selectTimeValue,
                    onChanged: (p0) {
                      if (p0 != null) {
                        provider.selectTime(p0);
                      }
                    },
                  ),
                  SizedBox(width: getWidth(56, context)),
                  CustomeDDownMenuDashboard(
                    icon: Icons.bar_chart,
                    width: 171,
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
                                  ace = '2300';
                                  break;
                                case 1:
                                  ace = '180';
                                  break;
                                case 2:
                                  ace = '644';
                                  break;
                                case 3:
                                  ace = '420';
                                  break;
                                case 4:
                                  ace = '1594';
                                  break;
                                case 5:
                                  ace = '792';
                                  break;
                                case 6:
                                  ace = '1573';
                                  break;
                                case 7:
                                  ace = '266';
                                  break;
                                case 8:
                                  ace = '1512';
                                  break;
                                case 9:
                                  ace = '726';
                                  break;
                                case 10:
                                  ace = '570';
                                  break;
                                case 11:
                                  ace = '1862';
                                  break;
                                default:
                                  throw Error();
                              }
                              return BarTooltipItem(
                                'Totals: \$$ace',
                                TextStyle(
                                  color: AppTheme.of(context).primaryColor,
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
                        provider.puntos(0, 2300, azul),
                        provider.puntos(1, 180, azul),
                        provider.puntos(2, 644, azul), //Color(0xFFE7C037)
                        provider.puntos(3, 420, azul),
                        provider.puntos(4, 1594, azul),
                        provider.puntos(5, 792, azul),
                        provider.puntos(6, 1573, azul),
                        provider.puntos(7, 266, azul),
                        provider.puntos(8, 1512, azul),
                        provider.puntos(9, 726, azul),
                        provider.puntos(10, 570, azul),
                        provider.puntos(11, 1862, azul),
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
                                        n1 = '\$1500';
                                        break;
                                      case 1:
                                        n1 = '\$800';
                                        break;
                                      case 2:
                                        n1 = '\$134';
                                        break;
                                      default:
                                        throw Error();
                                    }
                                  } else if (group.x == 1) {
                                    switch (rodIndex) {
                                      case 0:
                                        n1 = '\$120';
                                        break;
                                      case 1:
                                        n1 = '\$60';
                                        break;
                                      case 2:
                                        n1 = '\$35';
                                        break;
                                      default:
                                        throw Error();
                                    }
                                  } else if (group.x == 2) {
                                    switch (rodIndex) {
                                      case 0:
                                        n1 = '\$245';
                                        break;
                                      case 1:
                                        n1 = '\$400';
                                        break;
                                      case 2:
                                        n1 = '\$120';
                                        break;

                                      default:
                                        throw Error();
                                    }
                                  } else if (group.x == 3) {
                                    switch (rodIndex) {
                                      case 0:
                                        n1 = '\$293';
                                        break;
                                      case 1:
                                        n1 = '\$127';
                                        break;
                                      case 2:
                                        n1 = '\$80';
                                        break;

                                      default:
                                        throw Error();
                                    }
                                  } else if (group.x == 4) {
                                    switch (rodIndex) {
                                      case 0:
                                        n1 = '\$800';
                                        break;
                                      case 1:
                                        n1 = '\$784';
                                        break;
                                      case 2:
                                        n1 = '\$116';
                                        break;

                                      default:
                                        throw Error();
                                    }
                                  } else if (group.x == 5) {
                                    switch (rodIndex) {
                                      case 0:
                                        n1 = '\$617';
                                        break;
                                      case 1:
                                        n1 = '\$175';
                                        break;
                                      case 2:
                                        n1 = '\$148';
                                        break;

                                      default:
                                        throw Error();
                                    }
                                  } else if (group.x == 6) {
                                    switch (rodIndex) {
                                      case 0:
                                        n1 = '\$679';
                                        break;
                                      case 1:
                                        n1 = '\$894';
                                        break;
                                      case 2:
                                        n1 = '\$327';
                                        break;
                                      default:
                                        throw Error();
                                    }
                                  } else if (group.x == 7) {
                                    switch (rodIndex) {
                                      case 0:
                                        n1 = '\$171';
                                        break;
                                      case 1:
                                        n1 = '\$95';
                                        break;
                                      case 2:
                                        n1 = '\$184';
                                        break;

                                      default:
                                        throw Error();
                                    }
                                  } else if (group.x == 8) {
                                    switch (rodIndex) {
                                      case 0:
                                        n1 = '\$764';
                                        break;
                                      case 1:
                                        n1 = '\$748';
                                        break;
                                      case 2:
                                        n1 = '\$488';
                                        break;

                                      default:
                                        throw Error();
                                    }
                                  } else if (group.x == 9) {
                                    switch (rodIndex) {
                                      case 0:
                                        n1 = '\$542';
                                        break;
                                      case 1:
                                        n1 = '\$184';
                                        break;
                                      case 2:
                                        n1 = '\$27';
                                        break;

                                      default:
                                        throw Error();
                                    }
                                  } else if (group.x == 10) {
                                    switch (rodIndex) {
                                      case 0:
                                        n1 = '\$483';
                                        break;
                                      case 1:
                                        n1 = '\$96';
                                        break;
                                      case 2:
                                        n1 = '\$108';
                                        break;

                                      default:
                                        throw Error();
                                    }
                                  } else if (group.x == 11) {
                                    switch (rodIndex) {
                                      case 0:
                                        n1 = '\$1682';
                                        break;
                                      case 1:
                                        n1 = '\$181';
                                        break;
                                      case 2:
                                        n1 = '\$112';
                                        break;

                                      default:
                                        throw Error();
                                    }
                                  }
                                  return BarTooltipItem(
                                      rodIndex == 0
                                          ? 'Order: $n1'
                                          : rodIndex == 1
                                              ? 'Quote: $n1'
                                              : 'Canceled: $n1',
                                      TextStyle(
                                        color: rodIndex == 0
                                            ? provider.verde
                                            : rodIndex == 1
                                                ? provider.amarillo
                                                : provider.rojo,
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
                                              ? 'Total: \$ ${moneyFormat(flSpot.y)}'
                                              : flSpot.barIndex == 1
                                                  ? 'Order: \$ ${moneyFormat(flSpot.y)} '
                                                  : flSpot.barIndex == 2
                                                      ? 'Quotes: \$ ${moneyFormat(flSpot.y)} '
                                                      : 'Canceled: \$ ${moneyFormat(flSpot.y)} ',
                                          TextStyle(
                                            color: flSpot.barIndex == 0
                                                ? azul
                                                : flSpot.barIndex == 1
                                                    ? provider.verde
                                                    : flSpot.barIndex == 2
                                                        ? provider.amarillo
                                                        : provider.rojo,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        );
                                      },
                                    ).toList();
                                  },
                                ),
                              ),
                              lineBarsData: [
                                provider.totals(azul),
                                provider.order(),
                                provider.quotes(),
                                provider.canceled(),
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
