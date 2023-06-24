import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rta_crm_cv/functions/money_format.dart';
import 'package:rta_crm_cv/functions/sizes.dart';
import 'package:rta_crm_cv/providers/crm/dashboard_provider.dart';
import 'package:rta_crm_cv/theme/theme.dart';
import 'package:rta_crm_cv/widgets/custom_card.dart';
import 'package:fl_chart/fl_chart.dart';

class GraficaDashboard extends StatefulWidget {
  const GraficaDashboard({Key? key}) : super(key: key);

  @override
  State<GraficaDashboard> createState() => _GraficaDashboardState();
}

class _GraficaDashboardState extends State<GraficaDashboard> {
  @override
  Widget build(BuildContext context) {
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
          text = 'Jan';

          break;
        case 1:
          text = 'Feb';
          break;
        case 2:
          text = 'Mar';

          break;
        case 3:
          text = 'Apr';
          break;
        case 4:
          text = 'may';

          break;
        case 5:
          text = 'Jun';
          break;
        case 6:
          text = 'Jul';

          break;
        case 7:
          text = 'Ago';
          break;
        case 8:
          text = 'Sep';

          break;
        case 9:
          text = 'Oct';
          break;
        case 10:
          text = 'Nov';

          break;
        case 11:
          text = 'Dic';
          break;
        default:
          text = '';
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
      title: 'Overwiew',
      child: SizedBox(
        width: getWidth(670, context),
        height: getHeight(350, context),
        child: BarChart(
          BarChartData(
            alignment: BarChartAlignment.spaceAround,
            barTouchData: BarTouchData(
              enabled: true,
              touchTooltipData: BarTouchTooltipData(
                  tooltipBgColor: const Color.fromARGB(255, 204, 204, 204),
                  getTooltipItem: (group, groupIndex, rod, rodIndex) {
                    String ace;
                    switch (group.x.toInt()) {
                      case 0:
                        ace = '2434';
                        break;
                      case 1:
                        ace = '215';
                        break;
                      case 2:
                        ace = '764';
                        break;
                      case 3:
                        ace = '500';
                        break;
                      case 4:
                        ace = '1700';
                        break;
                      case 5:
                        ace = '940';
                        break;
                      case 6:
                        ace = '1900';
                        break;
                      case 7:
                        ace = '450';
                        break;
                      case 8:
                        ace = '2000';
                        break;
                      case 9:
                        ace = '753';
                        break;
                      case 10:
                        ace = '687';
                        break;
                      case 11:
                        ace = '1974';
                        break;
                      default:
                        throw Error();
                    }
                    return BarTooltipItem(
                      '\$ $ace',
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
              /*  provider.puntos(0, 2434, provider.gradientVer),
              provider.puntos(1, 215, provider.gradientRoja),
              provider.puntos(2, 764, provider.gradientAma),
              provider.puntos(3, 500, provider.gradientRoja),
              provider.puntos(4, 1700, provider.gradientVer),
              provider.puntos(5, 940, provider.gradientAma),
              provider.puntos(6, 1900, provider.gradientVer),
              provider.puntos(7, 450, provider.gradientRoja),
              provider.puntos(8, 2000, provider.gradientVer),
              provider.puntos(9, 753, provider.gradientAma),
              provider.puntos(10, 687, provider.gradientAma),
              provider.puntos(11, 1974, provider.gradientVer), */
              provider.puntos(0, 2434, const Color(0xFF2FDC40)),
              provider.puntos(1, 215, const Color(0xFFB2333A)),
              provider.puntos(2, 764, const Color(0xFFE7C037)),
              provider.puntos(3, 500, const Color(0xFFE7C037)),
              provider.puntos(4, 1700, const Color(0xFF2FDC40)),
              provider.puntos(5, 940, const Color(0xFFE7C037)),
              provider.puntos(6, 1900, const Color(0xFF2FDC40)),
              provider.puntos(7, 450, const Color(0xFFB2333A)),
              provider.puntos(8, 2000, const Color(0xFF2FDC40)),
              provider.puntos(9, 753, const Color(0xFFE7C037)),
              provider.puntos(10, 687, const Color(0xFFE7C037)),
              provider.puntos(11, 1974, const Color(0xFF2FDC40)),
            ],
          ),
        ),
      ),
    );
  }
}
