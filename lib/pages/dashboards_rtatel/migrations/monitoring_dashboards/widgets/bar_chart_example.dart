import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class BarChartSample2 extends StatefulWidget {
  BarChartSample2({super.key});

  final Color dark = Colors.black;
  final Color normal = Colors.cyan;
  final Color light = Colors.cyanAccent;

  @override
  State<StatefulWidget> createState() => BarChartSample2State();
}

class BarChartSample2State extends State<BarChartSample2> {
  List<String> names = [
    "Feb 2024",
    "Ene 2024",
    "Dic 2023",
    "Nov 2023",
    "Oct 2023",
    "Sep 2023",
    "Ago 2023",
    "Jul 2023",
    "Jun 2023",
    "May 2023",
    "Abr 2023",
    "Mar 2023"
  ];
  Widget bottomTitles(double value, TitleMeta meta) {
    const style = TextStyle(fontSize: 10);
    String text;
    switch (value.toInt()) {
      case 0:
        text = names[0];
        break;
      case 1:
        text = names[1];
        break;
      case 2:
        text = names[2];
        break;
      case 3:
        text = names[3];
        break;
      case 4:
        text = names[4];
        break;
      case 5:
        text = names[5];
        break;
      case 6:
        text = names[6];
        break;
      case 7:
        text = names[7];
        break;
      case 8:
        text = names[8];
        break;
      case 9:
        text = names[9];
        break;
      case 10:
        text = names[10];
        break;
      case 11:
        text = names[11];
        break;
      default:
        text = '';
        break;
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text(text, style: style),
    );
  }

  Widget leftTitles(double value, TitleMeta meta) {
    if (value == meta.max) {
      return Container();
    }
    const style = TextStyle(
      fontSize: 10,
    );
    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text(
        meta.formattedValue,
        style: style,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.66,
      child: Padding(
        padding: const EdgeInsets.only(top: 16),
        child: LayoutBuilder(
          builder: (context, constraints) {
            // final barsSpace = 4.0 * constraints.maxWidth / 400;
            final barsSpace = 4.0 * constraints.maxWidth / 200;

            final barsWidth = 8.0 * constraints.maxWidth / 400;
            return BarChart(
              BarChartData(
                alignment: BarChartAlignment.center,
                barTouchData: BarTouchData(
                  enabled: false,
                ),
                titlesData: FlTitlesData(
                  show: true,
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 28,
                      getTitlesWidget: bottomTitles,
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 40,
                      getTitlesWidget: leftTitles,
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
                    color: Colors.black,
                    strokeWidth: 1,
                  ),
                  drawVerticalLine: false,
                ),
                borderData: FlBorderData(
                  show: false,
                ),
                groupsSpace: barsSpace,
                barGroups: getData(barsWidth, barsSpace),
              ),
            );
          },
        ),
      ),
    );
  }

  List<BarChartGroupData> getData(double barsWidth, double barsSpace) {
    //  final barGroup1 = makeGroupData(0, 18, 16, 0);
//     final barGroup2 = makeGroupData(1, 37, 30, 0);
//     final barGroup3 = makeGroupData(2, 12, 23, 1);
//     final barGroup4 = makeGroupData(3, 0, 27, 0);
//     final barGroup5 = makeGroupData(4, 0, 13, 0);
//     final barGroup6 = makeGroupData(5, 4, 10, 0);
//     final barGroup7 = makeGroupData(6, 2, 18, 0);
//     final barGroup8 = makeGroupData(7, 0, 22, 0);
//     final barGroup9 = makeGroupData(8, 7, 33, 0);
//     final barGroup10 = makeGroupData(9, 10, 15, 0);
//     final barGroup11 = makeGroupData(10, 3, 35, 0);
//     final barGroup12 = makeGroupData(11, 7, 21, 0);
    List<double> one = [37, 30, 0];

    double sumarLista(List<double> lista) {
      double suma = 0;
      for (double numero in lista) {
        suma += numero;
      }
      return suma;
    }

    double i = sumarLista(one);

    return [
      // 1
      BarChartGroupData(
        x: 0,
        barsSpace: barsSpace,
        barRods: [
          BarChartRodData(
            toY: 70,
            rodStackItems: [
              BarChartRodStackItem(18, 18, Colors.blue), // Powercode
              BarChartRodStackItem(16, 16, widget.normal), //Solarwinds
              BarChartRodStackItem(0, 0, widget.light), // Email Request
            ],
            borderRadius: BorderRadius.zero,
            width: barsWidth,
          ),
        ],
      ),
      BarChartGroupData(
        x: 2,
        barsSpace: barsSpace,
        barRods: [
          BarChartRodData(
            toY: i,
            rodStackItems: [
              BarChartRodStackItem(37, i, Colors.blue),
              BarChartRodStackItem(30, i, Colors.orange),
              BarChartRodStackItem(0, 0, Colors.red),
            ],
            borderRadius: BorderRadius.zero,
            width: barsWidth,
          ),
        ],
      ),
      BarChartGroupData(
        x: 2,
        barsSpace: barsSpace,
        barRods: [
          BarChartRodData(
            toY: 70,
            rodStackItems: [
              BarChartRodStackItem(0, 40, widget.dark),
              BarChartRodStackItem(40, 140, widget.normal),
              BarChartRodStackItem(140, 70, widget.light),
            ],
            borderRadius: BorderRadius.zero,
            width: barsWidth,
          ),
        ],
      ),
      BarChartGroupData(
        x: 3,
        barsSpace: barsSpace,
        barRods: [
          BarChartRodData(
            toY: 70,
            rodStackItems: [
              BarChartRodStackItem(0, 40, widget.dark),
              BarChartRodStackItem(40, 140, widget.normal),
              BarChartRodStackItem(140, 70, widget.light),
            ],
            borderRadius: BorderRadius.zero,
            width: barsWidth,
          ),
        ],
      ),
      BarChartGroupData(
        x: 4,
        barsSpace: barsSpace,
        barRods: [
          BarChartRodData(
            toY: 70,
            rodStackItems: [
              BarChartRodStackItem(0, 40, widget.dark),
              BarChartRodStackItem(40, 140, widget.normal),
              BarChartRodStackItem(140, 70, widget.light),
            ],
            borderRadius: BorderRadius.zero,
            width: barsWidth,
          ),
        ],
      ),
      BarChartGroupData(
        x: 5,
        barsSpace: barsSpace,
        barRods: [
          BarChartRodData(
            toY: 70,
            rodStackItems: [
              BarChartRodStackItem(0, 40, widget.dark),
              BarChartRodStackItem(40, 140, widget.normal),
              BarChartRodStackItem(140, 70, widget.light),
            ],
            borderRadius: BorderRadius.zero,
            width: barsWidth,
          ),
        ],
      ),
      BarChartGroupData(
        x: 6,
        barsSpace: barsSpace,
        barRods: [
          BarChartRodData(
            toY: 70,
            rodStackItems: [
              BarChartRodStackItem(0, 40, widget.dark),
              BarChartRodStackItem(40, 140, widget.normal),
              BarChartRodStackItem(140, 70, widget.light),
            ],
            borderRadius: BorderRadius.zero,
            width: barsWidth,
          ),
        ],
      ),
      BarChartGroupData(
        x: 7,
        barsSpace: barsSpace,
        barRods: [
          BarChartRodData(
            toY: 70,
            rodStackItems: [
              BarChartRodStackItem(0, 40, widget.dark),
              BarChartRodStackItem(40, 140, widget.normal),
              BarChartRodStackItem(140, 70, widget.light),
            ],
            borderRadius: BorderRadius.zero,
            width: barsWidth,
          ),
        ],
      ),
      BarChartGroupData(
        x: 8,
        barsSpace: barsSpace,
        barRods: [
          BarChartRodData(
            toY: 70,
            rodStackItems: [
              BarChartRodStackItem(0, 40, widget.dark),
              BarChartRodStackItem(40, 140, widget.normal),
              BarChartRodStackItem(140, 70, widget.light),
            ],
            borderRadius: BorderRadius.zero,
            width: barsWidth,
          ),
        ],
      ),
      BarChartGroupData(
        x: 9,
        barsSpace: barsSpace,
        barRods: [
          BarChartRodData(
            toY: 70,
            rodStackItems: [
              BarChartRodStackItem(0, 40, widget.dark),
              BarChartRodStackItem(40, 140, widget.normal),
              BarChartRodStackItem(140, 70, widget.light),
            ],
            borderRadius: BorderRadius.zero,
            width: barsWidth,
          ),
        ],
      ),
      BarChartGroupData(
        x: 10,
        barsSpace: barsSpace,
        barRods: [
          BarChartRodData(
            toY: 70,
            rodStackItems: [
              BarChartRodStackItem(0, 40, widget.dark),
              BarChartRodStackItem(40, 140, widget.normal),
              BarChartRodStackItem(140, 70, widget.light),
            ],
            borderRadius: BorderRadius.zero,
            width: barsWidth,
          ),
        ],
      ),
      BarChartGroupData(
        x: 11,
        barsSpace: barsSpace,
        barRods: [
          BarChartRodData(
            toY: 70,
            rodStackItems: [
              BarChartRodStackItem(0, 40, widget.dark),
              BarChartRodStackItem(40, 140, widget.normal),
              BarChartRodStackItem(140, 70, widget.light),
            ],
            borderRadius: BorderRadius.zero,
            width: barsWidth,
          ),
        ],
      ),
    ];
  }
}

// import 'dart:async';
// import 'dart:math';

// import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter/material.dart';

// class BarChartSample2 extends StatefulWidget {
//   BarChartSample2({super.key});

//   List<Color> get availableColors => const <Color>[
//         Colors.purple,
//         Colors.yellow,
//         Colors.blue,
//         Colors.orange,
//         Colors.pink,
//         Colors.red,
//         Colors.black
//       ];

//   final Color barBackgroundColor = Colors.white.withOpacity(0.3);
//   final Color barColor = Colors.green;
//   final Color touchedBarColor = Colors.blue[400]!;

//   @override
//   State<StatefulWidget> createState() => BarChartSample2State();
// }

// class BarChartSample2State extends State<BarChartSample2> {
//   final Duration animDuration = const Duration(milliseconds: 250);

//   int touchedIndex = -1;

//   bool isPlaying = false;

//   @override
//   Widget build(BuildContext context) {
//     return AspectRatio(
//       aspectRatio: 1,
//       child: Stack(
//         children: <Widget>[
//           Padding(
//             padding: const EdgeInsets.all(16),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: <Widget>[
//                 const Text(
//                   'Mingguan',
//                   style: TextStyle(
//                     color: Colors.green,
//                     fontSize: 24,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 4,
//                 ),
//                 Text(
//                   'Grafik konsumsi kalori',
//                   style: TextStyle(
//                     color: Colors.green,
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 38,
//                 ),
//                 Expanded(
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 8),
//                     child: BarChart(
//                       isPlaying ? randomData() : mainBarData(),
//                       swapAnimationDuration: animDuration,
//                     ),
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 12,
//                 ),
//               ],
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8),
//             child: Align(
//               alignment: Alignment.topRight,
//               child: IconButton(
//                 icon: Icon(
//                   isPlaying ? Icons.pause : Icons.play_arrow,
//                   color: Colors.black,
//                 ),
//                 onPressed: () {
//                   setState(() {
//                     isPlaying = !isPlaying;
//                     if (isPlaying) {
//                       refreshState();
//                     }
//                   });
//                 },
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }

//   BarChartGroupData makeGroupData(
//     int x,
//     double y, {
//     bool isTouched = false,
//     Color? barColor,
//     double width = 22,
//     List<int> showTooltips = const [],
//   }) {
//     barColor ??= widget.barColor;
//     return BarChartGroupData(
//       x: x,
//       barRods: [
//         BarChartRodData(
//           toY: isTouched ? y + 1 : y,
//           color: isTouched ? widget.touchedBarColor : barColor,
//           width: width,
//           borderSide: isTouched
//               ? BorderSide(color: widget.touchedBarColor)
//               : const BorderSide(color: Colors.white, width: 0),
//           backDrawRodData: BackgroundBarChartRodData(
//             show: true,
//             toY: 20,
//             color: widget.barBackgroundColor,
//           ),
//         ),
//       ],
//       showingTooltipIndicators: showTooltips,
//     );
//   }

//   List<BarChartGroupData> showingGroups() => List.generate(7, (i) {
//         switch (i) {
//           case 0:
//             return makeGroupData(0, 5, isTouched: i == touchedIndex);
//           case 1:
//             return makeGroupData(1, 6.5, isTouched: i == touchedIndex);
//           case 2:
//             return makeGroupData(2, 5, isTouched: i == touchedIndex);
//           case 3:
//             return makeGroupData(3, 7.5, isTouched: i == touchedIndex);
//           case 4:
//             return makeGroupData(4, 9, isTouched: i == touchedIndex);
//           case 5:
//             return makeGroupData(5, 11.5, isTouched: i == touchedIndex);
//           case 6:
//             return makeGroupData(6, 6.5, isTouched: i == touchedIndex);
//           case 7:
//             return makeGroupData(7, 10, isTouched: i == touchedIndex);
//           default:
//             return throw Error();
//         }
//       });

//   BarChartData mainBarData() {
//     return BarChartData(
//       barTouchData: BarTouchData(
//         touchTooltipData: BarTouchTooltipData(
//           tooltipBgColor: Colors.blueGrey,
//           tooltipHorizontalAlignment: FLHorizontalAlignment.right,
//           tooltipMargin: -10,
//           getTooltipItem: (group, groupIndex, rod, rodIndex) {
//             String weekDay;
//             switch (group.x) {
//               case 0:
//                 weekDay = 'Monday';
//                 break;
//               case 1:
//                 weekDay = 'Tuesday';
//                 break;
//               case 2:
//                 weekDay = 'Wednesday';
//                 break;
//               case 3:
//                 weekDay = 'Thursday';
//                 break;
//               case 4:
//                 weekDay = 'Friday';
//                 break;
//               case 5:
//                 weekDay = 'Saturday';
//                 break;
//               case 6:
//                 weekDay = 'Sunday';
//                 break;
//               case 7:
//                 weekDay = 'Seven';
//                 break;
//               default:
//                 throw Error();
//             }
//             return BarTooltipItem(
//               '$weekDay\n',
//               const TextStyle(
//                 color: Colors.white,
//                 fontWeight: FontWeight.bold,
//                 fontSize: 18,
//               ),
//               children: <TextSpan>[
//                 TextSpan(
//                   text: (rod.toY - 1).toString(),
//                   style: TextStyle(
//                     color: widget.touchedBarColor,
//                     fontSize: 16,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//               ],
//             );
//           },
//         ),
//         touchCallback: (FlTouchEvent event, barTouchResponse) {
//           setState(() {
//             if (!event.isInterestedForInteractions ||
//                 barTouchResponse == null ||
//                 barTouchResponse.spot == null) {
//               touchedIndex = -1;
//               return;
//             }
//             touchedIndex = barTouchResponse.spot!.touchedBarGroupIndex;
//           });
//         },
//       ),
//       titlesData: FlTitlesData(
//         show: true,
//         rightTitles: AxisTitles(
//           sideTitles: SideTitles(showTitles: false),
//         ),
//         topTitles: AxisTitles(
//           sideTitles: SideTitles(showTitles: false),
//         ),
//         bottomTitles: AxisTitles(
//           sideTitles: SideTitles(
//             showTitles: true,
//             getTitlesWidget: getTitles,
//             reservedSize: 38,
//           ),
//         ),
//         leftTitles: AxisTitles(
//           sideTitles: SideTitles(
//             showTitles: false,
//           ),
//         ),
//       ),
//       borderData: FlBorderData(
//         show: false,
//       ),
//       barGroups: showingGroups(),
//       gridData: FlGridData(show: false),
//     );
//   }

//   Widget getTitles(double value, TitleMeta meta) {
//     const style = TextStyle(
//       color: Colors.white,
//       fontWeight: FontWeight.bold,
//       fontSize: 14,
//     );
//     Widget text;
//     switch (value.toInt()) {
//       case 0:
//         text = const Text('M', style: style);
//         break;
//       case 1:
//         text = const Text('T', style: style);
//         break;
//       case 2:
//         text = const Text('W', style: style);
//         break;
//       case 3:
//         text = const Text('T', style: style);
//         break;
//       case 4:
//         text = const Text('F', style: style);
//         break;
//       case 5:
//         text = const Text('S', style: style);
//         break;
//       case 6:
//         text = const Text('S', style: style);
//         break;
//       case 7:
//         text = const Text('SS', style: style);
//         break;
//       default:
//         text = const Text('', style: style);
//         break;
//     }
//     return SideTitleWidget(
//       axisSide: meta.axisSide,
//       space: 16,
//       child: text,
//     );
//   }

//   BarChartData randomData() {
//     return BarChartData(
//       barTouchData: BarTouchData(
//         enabled: false,
//       ),
//       titlesData: FlTitlesData(
//         show: true,
//         bottomTitles: AxisTitles(
//           sideTitles: SideTitles(
//             showTitles: true,
//             getTitlesWidget: getTitles,
//             reservedSize: 38,
//           ),
//         ),
//         leftTitles: AxisTitles(
//           sideTitles: SideTitles(
//             showTitles: false,
//           ),
//         ),
//         topTitles: AxisTitles(
//           sideTitles: SideTitles(
//             showTitles: false,
//           ),
//         ),
//         rightTitles: AxisTitles(
//           sideTitles: SideTitles(
//             showTitles: false,
//           ),
//         ),
//       ),
//       borderData: FlBorderData(
//         show: false,
//       ),
//       barGroups: List.generate(8, (i) {
//         switch (i) {
//           case 0:
//             return makeGroupData(
//               0,
//               Random().nextInt(15).toDouble() + 6,
//               barColor: widget.availableColors[
//                   Random().nextInt(widget.availableColors.length)],
//             );
//           case 1:
//             return makeGroupData(
//               1,
//               Random().nextInt(15).toDouble() + 6,
//               barColor: widget.availableColors[
//                   Random().nextInt(widget.availableColors.length)],
//             );
//           case 2:
//             return makeGroupData(
//               2,
//               Random().nextInt(15).toDouble() + 6,
//               barColor: widget.availableColors[
//                   Random().nextInt(widget.availableColors.length)],
//             );
//           case 3:
//             return makeGroupData(
//               3,
//               Random().nextInt(15).toDouble() + 6,
//               barColor: widget.availableColors[
//                   Random().nextInt(widget.availableColors.length)],
//             );
//           case 4:
//             return makeGroupData(
//               4,
//               Random().nextInt(15).toDouble() + 6,
//               barColor: widget.availableColors[
//                   Random().nextInt(widget.availableColors.length)],
//             );
//           case 5:
//             return makeGroupData(
//               5,
//               Random().nextInt(15).toDouble() + 6,
//               barColor: widget.availableColors[
//                   Random().nextInt(widget.availableColors.length)],
//             );
//           case 6:
//             return makeGroupData(
//               6,
//               Random().nextInt(15).toDouble() + 6,
//               barColor: widget.availableColors[
//                   Random().nextInt(widget.availableColors.length)],
//             );
//           case 7:
//             return makeGroupData(
//               7,
//               Random().nextInt(15).toDouble() + 6,
//               barColor: widget.availableColors[
//                   Random().nextInt(widget.availableColors.length)],
//             );
//           default:
//             return throw Error();
//         }
//       }),
//       gridData: FlGridData(show: false),
//     );
//   }

//   Future<dynamic> refreshState() async {
//     setState(() {});
//     await Future<dynamic>.delayed(
//       animDuration + const Duration(milliseconds: 50),
//     );
//     if (isPlaying) {
//       await refreshState();
//     }
//   }
// }

// import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter/material.dart';

// class BarChartSample2 extends StatefulWidget {
//   BarChartSample2({super.key});
//   final Color leftBarColor = Colors.yellow;
//   final Color rightBarColor = Colors.red;
//   final Color avgColor = Colors.green;
//   @override
//   State<StatefulWidget> createState() => BarChartSample2State();
// }

// class BarChartSample2State extends State<BarChartSample2> {
//   final double width = 7;

//   late List<BarChartGroupData> rawBarGroups;
//   late List<BarChartGroupData> showingBarGroups;

//   int touchedGroupIndex = -1;

//   @override
//   void initState() {
//     super.initState();
//     // Powercode, Solarwdins, Email
//     final barGroup1 = makeGroupData(0, 18, 16, 0);
//     final barGroup2 = makeGroupData(1, 37, 30, 0);
//     final barGroup3 = makeGroupData(2, 12, 23, 1);
//     final barGroup4 = makeGroupData(3, 0, 27, 0);
//     final barGroup5 = makeGroupData(4, 0, 13, 0);
//     final barGroup6 = makeGroupData(5, 4, 10, 0);
//     final barGroup7 = makeGroupData(6, 2, 18, 0);
//     final barGroup8 = makeGroupData(7, 0, 22, 0);
//     final barGroup9 = makeGroupData(8, 7, 33, 0);
//     final barGroup10 = makeGroupData(9, 10, 15, 0);
//     final barGroup11 = makeGroupData(10, 3, 35, 0);
//     final barGroup12 = makeGroupData(11, 7, 21, 0);

//     final items = [
//       barGroup1,
//       barGroup2,
//       barGroup3,
//       barGroup4,
//       barGroup5,
//       barGroup6,
//       barGroup7,
//       barGroup8,
//       barGroup9,
//       barGroup10,
//       barGroup11,
//       barGroup12,
//     ];

//     rawBarGroups = items;

//     showingBarGroups = rawBarGroups;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return AspectRatio(
//       aspectRatio: 1,
//       child: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: <Widget>[
//             // Row(
//             //   mainAxisSize: MainAxisSize.min,
//             //   children: <Widget>[
//             //     makeTransactionsIcon(),
//             //     const SizedBox(
//             //       width: 38,
//             //     ),
//             //     const Text(
//             //       'Transactions',
//             //       style: TextStyle(color: Colors.black, fontSize: 22),
//             //     ),
//             //     const SizedBox(
//             //       width: 4,
//             //     ),
//             //     const Text(
//             //       'state',
//             //       style: TextStyle(color: Color(0xff77839a), fontSize: 16),
//             //     ),
//             //   ],
//             // ),
//             const SizedBox(
//               height: 38,
//             ),
//             Expanded(
//               child: BarChart(
//                 BarChartData(
//                   maxY: 35,
//                   barTouchData: BarTouchData(
//                     touchTooltipData: BarTouchTooltipData(
//                       tooltipBgColor: Colors.grey,
//                       getTooltipItem: (a, b, c, d) => null,
//                     ),
//                     // touchCallback: (FlTouchEvent event, response) {
//                     //   if (response == null || response.spot == null) {
//                     //     setState(() {
//                     //       touchedGroupIndex = -1;
//                     //       showingBarGroups = List.of(rawBarGroups);
//                     //     });
//                     //     return;
//                     //   }

//                     //   touchedGroupIndex = response.spot!.touchedBarGroupIndex;

//                     //   setState(() {
//                     //     if (!event.isInterestedForInteractions) {
//                     //       touchedGroupIndex = -1;
//                     //       showingBarGroups = List.of(rawBarGroups);
//                     //       return;
//                     //     }
//                     //     showingBarGroups = List.of(rawBarGroups);
//                     //     if (touchedGroupIndex != -1) {
//                     //       var sum = 0.0;
//                     //       for (final rod
//                     //           in showingBarGroups[touchedGroupIndex].barRods) {
//                     //         sum += rod.toY;
//                     //       }
//                     //       final avg = sum /
//                     //           showingBarGroups[touchedGroupIndex]
//                     //               .barRods
//                     //               .length;

//                     //       showingBarGroups[touchedGroupIndex] =
//                     //           showingBarGroups[touchedGroupIndex].copyWith(
//                     //         barRods: showingBarGroups[touchedGroupIndex]
//                     //             .barRods
//                     //             .map((rod) {
//                     //           return rod.copyWith(
//                     //               toY: avg, color: widget.avgColor);
//                     //         }).toList(),
//                     //       );
//                     //     }
//                     //   });
//                     // },
//                   ),
//                   titlesData: FlTitlesData(
//                     show: true,
//                     rightTitles: AxisTitles(
//                       sideTitles: SideTitles(showTitles: false),
//                     ),
//                     topTitles: AxisTitles(
//                       sideTitles: SideTitles(showTitles: false),
//                     ),
//                     bottomTitles: AxisTitles(
//                       sideTitles: SideTitles(
//                         showTitles: true,
//                         getTitlesWidget: bottomTitles,
//                         reservedSize: 42,
//                       ),
//                     ),
//                     leftTitles: AxisTitles(
//                       sideTitles: SideTitles(
//                         showTitles: true,
//                         reservedSize: 28,
//                         interval: 1,
//                         getTitlesWidget: leftTitles,
//                       ),
//                     ),
//                   ),
//                   borderData: FlBorderData(
//                     show: false,
//                   ),
//                   barGroups: showingBarGroups,
//                   gridData: FlGridData(show: false),
//                 ),
//               ),
//             ),
//             const SizedBox(
//               height: 12,
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget leftTitles(double value, TitleMeta meta) {
//     const style = TextStyle(
//       color: Color(0xff7589a2),
//       fontWeight: FontWeight.bold,
//       fontSize: 14,
//     );
//     String text;
//     if (value == 0) {
//       text = '0';
//     } else if (value == 10) {
//       text = '10';
//     } else if (value == 20) {
//       text = '20';
//     } else if (value == 30) {
//       text = '30';
//     } else if (value == 40) {
//       text = '40';
//     } else if (value == 50) {
//       text = '50';
//     } else if (value == 60) {
//       text = '60';
//     } else if (value == 70) {
//       text = '70';
//     } else {
//       return Container();
//     }
//     return SideTitleWidget(
//       axisSide: meta.axisSide,
//       space: 0,
//       child: Text(text, style: style),
//     );
//   }

//   Widget bottomTitles(double value, TitleMeta meta) {
//     final titles = <String>[
//       'Feb 2024',
//       'Ene 2024',
//       'Dic 2023',
//       'Nov 2023',
//       'Oct 2023',
//       'Sep 2023',
//       'ago 2023',
//       'jul 2023',
//       'jun 2023',
//       'may 2023',
//       'abr 2023',
//       'mar 2023'
//     ];

//     final Widget text = Text(
//       titles[value.toInt()],
//       style: const TextStyle(
//         color: Color(0xff7589a2),
//         fontWeight: FontWeight.bold,
//         fontSize: 14,
//       ),
//     );

//     return SideTitleWidget(
//       axisSide: meta.axisSide,
//       space: 16, //margin top
//       child: text,
//     );
//   }

//   BarChartGroupData makeGroupData(int x, double y1, double y2, double y3) {
//     return BarChartGroupData(
//       // showingTooltipIndicators: [0],
//       barsSpace: 4,
//       x: x,
//       barRods: [
//         // Azul es Powercode
//         BarChartRodData(
//           toY: y1,
//           color: Colors.blue,
//           width: width,
//         ),
//         // Amarillo es Solarwind
//         BarChartRodData(
//           toY: y2,
//           color: Colors.yellow,
//           width: width,
//         ),
//         // Rojo es Email Request
//         BarChartRodData(
//           toY: y3,
//           color: Colors.red,
//           width: width,
//         ),
//       ],
//     );
//   }

//   Widget makeTransactionsIcon() {
//     const width = 4.5;
//     const space = 3.5;
//     return Row(
//       mainAxisSize: MainAxisSize.min,
//       children: <Widget>[
//         Container(
//           width: width,
//           height: 10,
//           color: Colors.white.withOpacity(0.4),
//         ),
//         const SizedBox(
//           width: space,
//         ),
//         Container(
//           width: width,
//           height: 28,
//           color: Colors.white.withOpacity(0.8),
//         ),
//         const SizedBox(
//           width: space,
//         ),
//         Container(
//           width: width,
//           height: 42,
//           color: Colors.white.withOpacity(1),
//         ),
//         const SizedBox(
//           width: space,
//         ),
//         Container(
//           width: width,
//           height: 28,
//           color: Colors.white.withOpacity(0.8),
//         ),
//         const SizedBox(
//           width: space,
//         ),
//         Container(
//           width: width,
//           height: 10,
//           color: Colors.white.withOpacity(0.4),
//         ),
//       ],
//     );
//   }
// }
