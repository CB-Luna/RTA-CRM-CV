import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:rta_crm_cv/theme/theme.dart';

class BarChartExample extends StatelessWidget {
  final List<String> labels;
  final List<double> totaldocuments;
  final List<double> totalsigned;
  final List<double> totalpending;
  final List<double> totalDraft;

  final Color? color;

  const BarChartExample(
      {super.key,
      required this.labels,
      required this.totaldocuments,
      required this.totalsigned,
      required this.totalpending,
      required this.totalDraft,
      this.color = Colors.white});

  @override
  Widget build(BuildContext context) {
    return BarChart(BarChartData(
        alignment: BarChartAlignment.spaceAround,
        maxY: totaldocuments
                .reduce((value, element) => value > element ? value : element) +
            10,
        barTouchData: BarTouchData(enabled: true),
        titlesData: FlTitlesData(
            show: true,
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  if (value.toInt() >= 0 && value.toInt() < labels.length) {
                    return Text(labels[value.toInt()]);
                  }
                  return const SizedBox();
                },
              ),
            ),
            leftTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: true, reservedSize: 50)),
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false))),
        borderData: FlBorderData(show: false),
        barGroups: List.generate(
            labels.length,
            (index) => BarChartGroupData(x: index, barRods: [
                  BarChartRodData(
                      toY: totaldocuments[index],
                      color: AppTheme.of(context).primaryColor),
                  BarChartRodData(toY: totalsigned[index], color: Colors.green),
                  BarChartRodData(
                      toY: totalpending[index],
                      color: AppTheme.of(context).smiPrimary),
                  BarChartRodData(
                      toY: totalDraft[index],
                      color: AppTheme.of(context).odePrimary)
                ]))));
  }
}


// import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter/material.dart';

// class JSAGraphics extends StatefulWidget {
//   JSAGraphics({super.key});

//   final Color dark = Colors.black;
//   final Color normal = Colors.cyan;
//   final Color light = Colors.cyanAccent;

//   @override
//   State<StatefulWidget> createState() => JSAGraphicsState();
// }

// class JSAGraphicsState extends State<JSAGraphics> {
//   List<String> names = [
//     "Jan",
//     "Feb",
//     "Mar",
//     "Apr",
//     "May",
//     "Jun",
//     "Jul",
//     "Ago",
//     "Sep",
//     "Oct",
//     "Nov",
//     "Dec"
//   ];
//   List<int> value1 = [1, 2, 3, 4, 5, 6, 7, 8, 9, 3, 11, 13];
//   List<int> totalsigned = [9, 8, 7, 6, 5, 4, 3, 2, 1, 4, 10, 11];
//   List<int> totalpending = [1, 2, 2, 3, 4, 6, 1, 2, 3, 10, 3, 12];

//   Widget bottomTitles(double value, TitleMeta meta) {
//     const style = TextStyle(fontSize: 10);
//     String text;

//     if (value >= 0 && value < names.length) {
//       text = names[value.toInt()];
//     } else {
//       text = '';
//     }

//     return SideTitleWidget(
//       axisSide: meta.axisSide,
//       child: Text(text, style: style),
//     );
//   }

//   Widget leftTitles(double value, TitleMeta meta) {
//     if (value == meta.max) {
//       return Container();
//     }
//     const style = TextStyle(
//       fontSize: 10,
//     );
//     return SideTitleWidget(
//       axisSide: meta.axisSide,
//       child: Text(
//         meta.formattedValue,
//         style: style,
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     List<BarChartGroupData> barChartData = [];

//     for (int i = 0; i < names.length; i++) {
//       BarChartGroupData barChartGroupData = BarChartGroupData(
//         x: i,
//         barsSpace: 5,
//         barRods: [
//           BarChartRodData(
//             toY: totalpending[i].toDouble(),
//             rodStackItems: [
//               BarChartRodStackItem(value1[i].toDouble(), totalsigned[i].toDouble(),
//                   Colors.blue), // Powercode
//               BarChartRodStackItem(value1[i].toDouble(), totalsigned[i].toDouble(),
//                   Colors.red), // Powercode
//               BarChartRodStackItem(value1[i].toDouble(), totalsigned[i].toDouble(),
//                   Colors.green), // Powercode
//             ],
//             // borderRadius: BorderRadius.zero,
//             width: 30,
//           ),
//         ],
//       );
//       barChartData.add(barChartGroupData);
//     }
//     return AspectRatio(
//       aspectRatio: 1.66,
//       child: Padding(
//         padding: const EdgeInsets.only(top: 16),
//         child: LayoutBuilder(
//           builder: (context, constraints) {
//             // final barsSpace = 4.0 * constraints.maxWidth / 400;
//             final barsSpace = 4.0 * constraints.maxWidth / 200;

//             final barsWidth = 8.0 * constraints.maxWidth / 400;
//             return BarChart(
//               BarChartData(
//                   alignment: BarChartAlignment.center,
//                   barTouchData: BarTouchData(
//                     enabled: false,
//                   ),
//                   titlesData: FlTitlesData(
//                     show: true,
//                     bottomTitles: AxisTitles(
//                       sideTitles: SideTitles(
//                         showTitles: true,
//                         reservedSize: 28,
//                         getTitlesWidget: bottomTitles,
//                       ),
//                     ),
//                     leftTitles: AxisTitles(
//                       sideTitles: SideTitles(
//                         showTitles: true,
//                         reservedSize: 40,
//                         getTitlesWidget: leftTitles,
//                       ),
//                     ),
//                     topTitles: AxisTitles(
//                       sideTitles: SideTitles(showTitles: false),
//                     ),
//                     rightTitles: AxisTitles(
//                       sideTitles: SideTitles(showTitles: false),
//                     ),
//                   ),
//                   gridData: FlGridData(
//                     show: true,
//                     checkToShowHorizontalLine: (value) => value % 10 == 0,
//                     getDrawingHorizontalLine: (value) => FlLine(
//                       color: Colors.black,
//                       strokeWidth: 1,
//                     ),
//                     drawVerticalLine: false,
//                   ),
//                   borderData: FlBorderData(
//                     show: true,
//                   ),
//                   groupsSpace: barsSpace,
//                   barGroups: barChartData),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
