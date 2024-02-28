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
    // "Abr 2023",
    // "Mar 2023"
  ];
  Widget bottomTitles(double value, TitleMeta meta) {
    const style = TextStyle(fontSize: 10);
    String text;

    if (value >= 0 && value < names.length) {
      text = names[value.toInt()];
    } else {
      text = '';
    }
    // switch (value.toInt()) {
    //   case 0:
    //     text = names[0];
    //     break;
    //   case 1:
    //     text = names[1];
    //     break;
    //   case 2:
    //     text = names[2];
    //     break;
    //   case 3:
    //     text = names[3];
    //     break;
    //   case 4:
    //     text = names[4];
    //     break;
    //   case 5:
    //     text = names[5];
    //     break;
    //   case 6:
    //     text = names[6];
    //     break;
    //   case 7:
    //     text = names[7];
    //     break;
    //   case 8:
    //     text = names[8];
    //     break;
    //   case 9:
    //     text = names[9];
    //     break;
    //   case 10:
    //     text = names[10];
    //     break;
    //   case 11:
    //     text = names[11];
    //     break;
    //   default:
    //     text = '';
    //     break;
    // }
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
