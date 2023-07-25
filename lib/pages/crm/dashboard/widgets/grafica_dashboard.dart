import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rta_crm_cv/functions/date_format.dart';
import 'package:rta_crm_cv/functions/money_format.dart';
import 'package:rta_crm_cv/functions/sizes.dart';
import 'package:rta_crm_cv/providers/crm/dashboard_provider.dart';
import 'package:rta_crm_cv/theme/theme.dart';
import 'package:rta_crm_cv/widgets/captura/custom_ddown_menu/custom_dropdown_dashboard.dart';
import 'package:rta_crm_cv/widgets/custom_card.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:rta_crm_cv/widgets/custom_scrollbar.dart';
import 'package:rta_crm_cv/widgets/custom_text_icon_button.dart';
import 'package:rta_crm_cv/widgets/dateranges.dart';
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
      final isTouched = value == provider.touchedIndex;
      final style = TextStyle(
        fontFamily: 'UniNeue',
        fontWeight: isTouched ? FontWeight.bold : FontWeight.normal,
        color: isTouched ? AppTheme.of(context).primaryColor : AppTheme.of(context).primaryText,
        fontSize: 15,
      );
      return SideTitleWidget(
        axisSide: meta.axisSide,
        //angle: 11,
        //angle: provider.dateList[0].length > 5 ? 7 : 0,
        space: 40,
        child: Text(
            provider.range.start == findFirstDateOfTheYear(DateTime.now()) ||
                    provider.range.start ==
                        findFirstDateOfTheYear(DateTime(DateTime.now().year - 1, 1))
                ? provider.weekList[value.toInt()]
                : 'Week: ${provider.weekList[value.toInt()]}',
            textAlign: TextAlign.center,
            style: style),
      );
    }

    return CustomCard(
      width: getWidth(1030, context),
      height: getHeight(432.91, context),
      title: 'Overview',
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
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
                              textColor: provider.touchedIndex == 0 ? Colors.black : Colors.grey,
                            ),
                            SizedBox(width: getWidth(10, context)),
                            Indicator(
                              color: provider.amarillo,
                              text: 'Quotes',
                              isSquare: false,
                              size: provider.touchedIndex == 1 ? 18 : 16,
                              textColor: provider.touchedIndex == 1 ? Colors.black : Colors.grey,
                            ),
                            SizedBox(width: getWidth(10, context)),
                            Indicator(
                              color: provider.rojo,
                              text: 'Canceled',
                              isSquare: false,
                              size: provider.touchedIndex == 2 ? 18 : 16,
                              textColor: provider.touchedIndex == 2 ? Colors.black : Colors.grey,
                            ),
                            SizedBox(width: getWidth(56, context)),
                          ],
                        )
                      : SizedBox(width: getWidth(56, context)),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: CustomTextIconButton(
                      isLoading: false,
                      icon:
                          Icon(Icons.calendar_month, color: AppTheme.of(context).primaryBackground),
                      text:
                          '${dateFormat(provider.range.start)} - ${dateFormat(provider.range.end)}',
                      onTap: () {
                        showDialog(
                          barrierColor: Colors.transparent,
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            shadowColor: Colors.transparent,
                            backgroundColor: Colors.transparent,
                            alignment: Alignment.centerLeft,
                            content: Container(
                                color: AppTheme.of(context).primaryBackground,
                                width: MediaQuery.of(context).size.width * 0.4,
                                height: MediaQuery.of(context).size.height * 0.32,
                                child: provider.datePickerBuilder(
                                  context,
                                  (p0) {},
                                )),
                          ),
                        );
                      },
                    ),
                  ),
                  /* CustomeDDownMenuDashboard(
                    icon: Icons.calendar_month,
                    width: 170,
                    list: provider.timeList,
                    dropdownValue: provider.selectTimeValue,
                    onChanged: (p0) {
                      if (p0 != null) {
                        provider.selectTime(p0);
                      }
                    },
                  ), */
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
            width: getWidth(1440, context), //670
            height: getHeight(300, context), //350
            child: provider.selectChartValue == 'Totals Barchart'
                ? provider.weekList.isEmpty
                    ? const CircularProgressIndicator()
                    : BarChart(
                        BarChartData(
                          alignment: BarChartAlignment.spaceAround,
                          barTouchData: BarTouchData(
                            enabled: true,
                            touchTooltipData: BarTouchTooltipData(
                              tooltipBgColor: const Color.fromARGB(255, 204, 204, 204),
                              getTooltipItem: (group, groupIndex, rod, rodIndex) {
                                return BarTooltipItem(
                                  'Totals: \$${provider.totalList[group.x]}',
                                  TextStyle(
                                    color: AppTheme.of(context).primaryColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                );
                              },
                            ),
                            touchCallback: (FlTouchEvent event, barTouchResponse) {
                              setState(() {
                                if (!event.isInterestedForInteractions ||
                                    barTouchResponse == null ||
                                    barTouchResponse.spot == null) {
                                  provider.touchedIndex = -1;
                                  return;
                                }
                                provider.touchedIndex = barTouchResponse.spot!.touchedBarGroupIndex;
                              });
                            },
                          ),
                          titlesData: FlTitlesData(
                            show: true,
                            bottomTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                reservedSize: 80,
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
                              sideTitles: SideTitles(
                                showTitles: true,
                                reservedSize: 80,
                                getTitlesWidget: (value, meta) {
                                  return const Text('');
                                },
                              ),
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
                            for (int i = 0; i < provider.totalList.length; i++)
                              provider.puntos(i, provider.totalList[i], azul)
                          ],
                        ),
                      )
                : provider.selectChartValue == 'Barchart'
                    ? provider.weekList.isEmpty
                        ? const CircularProgressIndicator()
                        : BarChart(
                            BarChartData(
                              alignment: BarChartAlignment.spaceAround,
                              barTouchData: BarTouchData(
                                enabled: true,
                                touchTooltipData: BarTouchTooltipData(
                                    getTooltipItem: (group, groupIndex, rod, rodIndex) {
                                      return BarTooltipItem(
                                          rodIndex == 0
                                              ? 'Order: ${provider.orderList[group.x]}'
                                              : rodIndex == 1
                                                  ? 'Quote: ${provider.quotesList[group.x]}'
                                                  : 'Canceled: ${provider.canceledList[group.x]}',
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
                                    tooltipBgColor: const Color.fromARGB(255, 204, 204, 204)),
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
                                    reservedSize: 100,
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
                                for (int i = 0; i < provider.orderList.length; i++)
                                  provider.getData(
                                    i,
                                    provider.orderList[i],
                                    provider.quotesList[i],
                                    provider.canceledList[i],
                                  ),
                              ], // provider.getData(),
                            ),
                          )
                    : provider.selectChartValue == 'Linechart'
                        ? provider.weekList.isEmpty
                            ? const CircularProgressIndicator()
                            : LineChart(
                                LineChartData(
                                  borderData: FlBorderData(
                                      show: true,
                                      border: Border(
                                          top: BorderSide(
                                              color: AppTheme.of(context).primaryText,
                                              width: 1,
                                              style: BorderStyle.solid),
                                          bottom: BorderSide(
                                              color: AppTheme.of(context).primaryText,
                                              width: 1,
                                              style: BorderStyle.solid),
                                          left: BorderSide(
                                              color: AppTheme.of(context).primaryText,
                                              width: 1,
                                              style: BorderStyle.solid),
                                          right: BorderSide(
                                              color: AppTheme.of(context).primaryText,
                                              width: 1,
                                              style: BorderStyle.solid))),
                                  lineTouchData: LineTouchData(
                                    enabled: true,
                                    touchCallback: (FlTouchEvent event, lineTouch) {
                                      if (!event.isInterestedForInteractions ||
                                          lineTouch == null ||
                                          lineTouch.lineBarSpots == null) {
                                        setState(() {
                                          provider.touchedIndex = -1;
                                        });
                                        return;
                                      }
                                      final value = lineTouch.lineBarSpots![0].x;
                                      setState(() {
                                        provider.touchedIndex = value.toInt();
                                      });
                                    },
                                    touchTooltipData: LineTouchTooltipData(
                                      maxContentWidth: 300,
                                      tooltipBgColor: const Color.fromARGB(255, 204, 204, 204),
                                      getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
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
                                    provider.lineTotals(azul),
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
                                          reservedSize: 80),
                                    ),
                                    leftTitles: AxisTitles(
                                      sideTitles: SideTitles(
                                        showTitles: true,
                                        getTitlesWidget: leftTitleWidgets,
                                        reservedSize: 90,
                                      ),
                                    ),
                                    topTitles: AxisTitles(
                                      sideTitles: SideTitles(showTitles: false),
                                    ),
                                    rightTitles: AxisTitles(
                                      sideTitles: SideTitles(
                                        showTitles: true,
                                        reservedSize: 90,
                                        getTitlesWidget: (value, meta) => const Text(''),
                                      ),
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
                        : provider.weekList.isEmpty
                            ? const CircularProgressIndicator()
                            : provider.selectChartValue == 'PieChart'
                                ? PieChart(
                                    PieChartData(
                                        pieTouchData: PieTouchData(
                                            touchCallback: (FlTouchEvent event, pieTouchResponse) {
                                          setState(() {
                                            if (!event.isInterestedForInteractions ||
                                                pieTouchResponse == null ||
                                                pieTouchResponse.touchedSection == null) {
                                              provider.touchedIndex = -1;
                                              return;
                                            }
                                            provider.touchedIndex = pieTouchResponse
                                                .touchedSection!.touchedSectionIndex;
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
