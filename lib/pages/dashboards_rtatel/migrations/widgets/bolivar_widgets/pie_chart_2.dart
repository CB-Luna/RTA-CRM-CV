import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class PieChart2 extends StatelessWidget {
  PieChart2(
      {super.key,
      Color? mainLineColor,
      Color? belowLineColor,
      Color? aboveLineColor,
      required this.valor})
      : mainLineColor = mainLineColor ?? Colors.blue,
        belowLineColor = belowLineColor ?? Colors.green,
        aboveLineColor = aboveLineColor ?? Colors.red;

  final Color mainLineColor;
  final Color belowLineColor;
  final Color aboveLineColor;
  final double valor;

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    String text;
    switch (value.toInt()) {
      case 0:
        text = '0';
        break;
      case 1:
        text = '0.1';
        break;
      case 2:
        text = '0.2';
        break;
      case 3:
        text = '0.3';
        break;
      case 4:
        text = '0.4';
        break;
      case 5:
        text = '0.5';
        break;
      case 6:
        text = '0.6';
        break;
      case 7:
        text = '0.7';
        break;
      case 8:
        text = '0.8';
        break;
      case 9:
        text = '0.9';
        break;
      case 10:
        text = '1';
        break;

      default:
        return Container();
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 4,
      child: Text(
        text,
        style: TextStyle(
          fontSize: 10,
          color: mainLineColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Colors.black,
      fontSize: 12,
    );
    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text('\$ ${value + 0.5}', style: style),
    );
  }

  @override
  Widget build(BuildContext context) {
    const cutOffYValue = 5.0;
    List<FlSpot> spots = [];
    int numberOfPoints = 10;
    for (int i = 0; i < numberOfPoints; i++) {
      double x = i /
          (numberOfPoints -
              1); // Ajusta para obtener valores en el rango [0, 1]
      double y = 0.7;
      /* Aquí puedes calcular el valor en función de x */
      spots.add(FlSpot(x, y));
    }

    return AspectRatio(
        aspectRatio: 2,
        child: Padding(
          padding: const EdgeInsets.only(
            left: 12,
            right: 28,
            top: 22,
            bottom: 12,
          ),
          child: LineChart(
            LineChartData(
              gridData: FlGridData(show: false),
              titlesData: FlTitlesData(show: false),
              borderData: FlBorderData(
                show: true,
                border: Border.all(
                  color: const Color(0xff37434d),
                  width: 1,
                ),
              ),
              minX: 0,
              maxX: 1,
              minY: 0,
              maxY: 1,
              lineBarsData: [
                LineChartBarData(
                  spots: spots,
                  isCurved: true,
                  color: Colors.blue,
                  dotData: FlDotData(show: false),
                  belowBarData: BarAreaData(show: false),
                ),
              ],
            ),
          ),
        ));
  }
}
