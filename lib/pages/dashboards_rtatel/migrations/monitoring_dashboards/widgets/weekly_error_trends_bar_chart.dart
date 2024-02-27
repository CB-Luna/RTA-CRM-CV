import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class WeeklyErrorTrendsBarChart extends StatefulWidget {
  const WeeklyErrorTrendsBarChart({super.key});
  final Color leftBarColor = Colors.yellow;
  final Color rightBarColor = Colors.red;
  final Color avgColor = Colors.green;
  @override
  State<StatefulWidget> createState() => WeeklyErrorTrendsBarChartState();
}

class WeeklyErrorTrendsBarChartState extends State<WeeklyErrorTrendsBarChart> {
  final double width = 7;

  late List<BarChartGroupData> rawBarGroups;
  late List<BarChartGroupData> showingBarGroups;

  int touchedGroupIndex = -1;

  @override
  void initState() {
    super.initState();
    // Powercode, Solarwdins, Email
    final barGroup1 = makeGroupData(0, 18, 16, 0);
    final barGroup2 = makeGroupData(1, 37, 30, 0);
    final barGroup3 = makeGroupData(2, 12, 23, 1);
    final barGroup4 = makeGroupData(3, 0, 27, 0);
    final barGroup5 = makeGroupData(4, 0, 13, 0);
    final barGroup6 = makeGroupData(5, 4, 10, 0);
    final barGroup7 = makeGroupData(6, 2, 18, 0);
    final barGroup8 = makeGroupData(7, 0, 22, 0);
    final barGroup9 = makeGroupData(8, 7, 33, 0);
    final barGroup10 = makeGroupData(9, 10, 15, 0);
    final barGroup11 = makeGroupData(10, 3, 35, 0);
    final barGroup12 = makeGroupData(11, 7, 21, 0);

    final items = [
      barGroup1,
      barGroup2,
      barGroup3,
      barGroup4,
      barGroup5,
      barGroup6,
      barGroup7,
      barGroup8,
      barGroup9,
      barGroup10,
      barGroup11,
      barGroup12,
    ];

    rawBarGroups = items;

    showingBarGroups = rawBarGroups;
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // Row(
            //   mainAxisSize: MainAxisSize.min,
            //   children: <Widget>[
            //     makeTransactionsIcon(),
            //     const SizedBox(
            //       width: 38,
            //     ),
            //     const Text(
            //       'Transactions',
            //       style: TextStyle(color: Colors.black, fontSize: 22),
            //     ),
            //     const SizedBox(
            //       width: 4,
            //     ),
            //     const Text(
            //       'state',
            //       style: TextStyle(color: Color(0xff77839a), fontSize: 16),
            //     ),
            //   ],
            // ),
            const SizedBox(
              height: 38,
            ),
            Expanded(
              child: BarChart(
                BarChartData(
                  maxY: 35,
                  barTouchData: BarTouchData(
                    touchTooltipData: BarTouchTooltipData(
                      tooltipBgColor: Colors.grey,
                      getTooltipItem: (a, b, c, d) => null,
                    ),
                    // touchCallback: (FlTouchEvent event, response) {
                    //   if (response == null || response.spot == null) {
                    //     setState(() {
                    //       touchedGroupIndex = -1;
                    //       showingBarGroups = List.of(rawBarGroups);
                    //     });
                    //     return;
                    //   }

                    //   touchedGroupIndex = response.spot!.touchedBarGroupIndex;

                    //   setState(() {
                    //     if (!event.isInterestedForInteractions) {
                    //       touchedGroupIndex = -1;
                    //       showingBarGroups = List.of(rawBarGroups);
                    //       return;
                    //     }
                    //     showingBarGroups = List.of(rawBarGroups);
                    //     if (touchedGroupIndex != -1) {
                    //       var sum = 0.0;
                    //       for (final rod
                    //           in showingBarGroups[touchedGroupIndex].barRods) {
                    //         sum += rod.toY;
                    //       }
                    //       final avg = sum /
                    //           showingBarGroups[touchedGroupIndex]
                    //               .barRods
                    //               .length;

                    //       showingBarGroups[touchedGroupIndex] =
                    //           showingBarGroups[touchedGroupIndex].copyWith(
                    //         barRods: showingBarGroups[touchedGroupIndex]
                    //             .barRods
                    //             .map((rod) {
                    //           return rod.copyWith(
                    //               toY: avg, color: widget.avgColor);
                    //         }).toList(),
                    //       );
                    //     }
                    //   });
                    // },
                  ),
                  titlesData: FlTitlesData(
                    show: true,
                    rightTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    topTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: bottomTitles,
                        reservedSize: 42,
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 28,
                        interval: 1,
                        getTitlesWidget: leftTitles,
                      ),
                    ),
                  ),
                  borderData: FlBorderData(
                    show: false,
                  ),
                  barGroups: showingBarGroups,
                  gridData: FlGridData(show: false),
                ),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
          ],
        ),
      ),
    );
  }

  Widget leftTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color(0xff7589a2),
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    String text;
    if (value == 0) {
      text = '0';
    } else if (value == 10) {
      text = '10';
    } else if (value == 20) {
      text = '20';
    } else if (value == 30) {
      text = '30';
    } else if (value == 40) {
      text = '40';
    } else if (value == 50) {
      text = '50';
    } else if (value == 60) {
      text = '60';
    } else if (value == 70) {
      text = '70';
    } else {
      return Container();
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 0,
      child: Text(text, style: style),
    );
  }

  Widget bottomTitles(double value, TitleMeta meta) {
    final titles = <String>[
      'Feb 2024',
      'Ene 2024',
      'Dic 2023',
      'Nov 2023',
      'Oct 2023',
      'Sep 2023',
      'ago 2023',
      'jul 2023',
      'jun 2023',
      'may 2023',
      'abr 2023',
      'mar 2023'
    ];

    final Widget text = Text(
      titles[value.toInt()],
      style: const TextStyle(
        color: Color(0xff7589a2),
        fontWeight: FontWeight.bold,
        fontSize: 14,
      ),
    );

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 16, //margin top
      child: text,
    );
  }

  BarChartGroupData makeGroupData(int x, double y1, double y2, double y3) {
    return BarChartGroupData(
      // showingTooltipIndicators: [0],
      barsSpace: 4,
      x: x,
      barRods: [
        // Azul es Powercode
        BarChartRodData(
          toY: y1,
          color: Colors.blue,
          width: width,
        ),
        // Amarillo es Solarwind
        BarChartRodData(
          toY: y2,
          color: Colors.yellow,
          width: width,
        ),
        // Rojo es Email Request
        BarChartRodData(
          toY: y3,
          color: Colors.red,
          width: width,
        ),
      ],
    );
  }

  Widget makeTransactionsIcon() {
    const width = 4.5;
    const space = 3.5;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          width: width,
          height: 10,
          color: Colors.white.withOpacity(0.4),
        ),
        const SizedBox(
          width: space,
        ),
        Container(
          width: width,
          height: 28,
          color: Colors.white.withOpacity(0.8),
        ),
        const SizedBox(
          width: space,
        ),
        Container(
          width: width,
          height: 42,
          color: Colors.white.withOpacity(1),
        ),
        const SizedBox(
          width: space,
        ),
        Container(
          width: width,
          height: 28,
          color: Colors.white.withOpacity(0.8),
        ),
        const SizedBox(
          width: space,
        ),
        Container(
          width: width,
          height: 10,
          color: Colors.white.withOpacity(0.4),
        ),
      ],
    );
  }
}
