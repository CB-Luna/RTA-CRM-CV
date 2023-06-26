import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rta_crm_cv/providers/crm/dashboard_provider.dart';
import 'package:rta_crm_cv/providers/side_menu_provider.dart';
import 'package:rta_crm_cv/public/colors.dart';
import 'package:rta_crm_cv/theme/theme.dart';
import 'package:rta_crm_cv/widgets/side_menu/sidemenu.dart';
import 'package:fl_chart/fl_chart.dart';

import '../../widgets/custom_card.dart';

class DashboardsCTRLVPage extends StatefulWidget {
  const DashboardsCTRLVPage({super.key});

  @override
  State<DashboardsCTRLVPage> createState() => _DashboardsCTRLVPageState();
}

class _DashboardsCTRLVPageState extends State<DashboardsCTRLVPage> {
  @override
  Widget build(BuildContext context) {
    void initState() {
      super.initState();

      WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
        final DashboardCRMProvider provider = Provider.of<DashboardCRMProvider>(
          context,
          listen: false,
        );
        await provider.updateState();
      });
    }

    SideMenuProvider provider = Provider.of<SideMenuProvider>(context);
    provider.setIndex(9);
    final List<double> data = [30, 25, 45];
    final List<double> data2 = [40, 40, 20];
    final List<String> title = ["Available", "Not\nAvailable", "In Repair"];
    final List<Color> colors = [
      AppTheme.lightTheme.primaryColor,
      AppTheme.lightTheme.secondaryColor,
      AppTheme.lightTheme.primaryText
    ];

    return Material(
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width - 20,
        child: Container(
          decoration: BoxDecoration(gradient: whiteGradient),
          height: 1500,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const SideMenu(),
              Container(
                alignment: Alignment.topCenter,
                child: CustomCard(
                  width: MediaQuery.of(context).size.width - 200,
                  height: MediaQuery.of(context).size.height,
                  title: "Dashboard CV",
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width / 2,
                            height: 550,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 40),
                                      child: Text(
                                        "Issues Per Company",
                                        style: TextStyle(
                                          color:
                                              AppTheme.of(context).primaryText,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                Container(
                                  height: 500,
                                  child: BarChart(
                                    BarChartData(
                                      barGroups: _getdata(),
                                      titlesData: titlesData,
                                    ),
                                    swapAnimationDuration:
                                        Duration(milliseconds: 150), // Optional
                                    swapAnimationCurve:
                                        Curves.linear, // Optional
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width:
                                    MediaQuery.of(context).size.width / 2 - 250,
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 20),
                                          child: Text(
                                            "Vehicles Per Company",
                                            style: TextStyle(
                                              color: AppTheme.of(context)
                                                  .primaryText,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          child: Row(
                                            children: [
                                              Text("Cry",
                                                  style: TextStyle(
                                                    color: AppTheme.of(context)
                                                        .primaryText,
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                  )),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 5, right: 5),
                                                child: Text("Ode",
                                                    style: TextStyle(
                                                      color:
                                                          AppTheme.of(context)
                                                              .primaryText,
                                                      fontSize: 20,
                                                    )),
                                              ),
                                              Text("Smi",
                                                  style: TextStyle(
                                                    color: AppTheme.of(context)
                                                        .primaryText,
                                                    fontSize: 20,
                                                  )),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      height: 250,
                                      child: PieChart(
                                        PieChartData(
                                          sections: List.generate(
                                            data.length,
                                            (index) => PieChartSectionData(
                                              value: data[index],
                                              color: colors[index],
                                              title: '${title[index]}',
                                              radius: 70,
                                              titleStyle: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width:
                                    MediaQuery.of(context).size.width / 2 - 250,
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 20),
                                          child: Text(
                                            "Employees Per Company",
                                            style: TextStyle(
                                              color: AppTheme.of(context)
                                                  .primaryText,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          child: Row(
                                            children: [
                                              Text("Cry",
                                                  style: TextStyle(
                                                    color: AppTheme.of(context)
                                                        .primaryText,
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                  )),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 5, right: 5),
                                                child: Text("Ode",
                                                    style: TextStyle(
                                                      color:
                                                          AppTheme.of(context)
                                                              .primaryText,
                                                      fontSize: 20,
                                                    )),
                                              ),
                                              Text("Smi",
                                                  style: TextStyle(
                                                    color: AppTheme.of(context)
                                                        .primaryText,
                                                    fontSize: 20,
                                                  )),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      height: 250,
                                      child: PieChart(
                                        PieChartData(
                                          sections: List.generate(
                                            data.length,
                                            (index) => PieChartSectionData(
                                              value: data2[index],
                                              color: colors[index],
                                              title: '${data2[index]}%',
                                              radius: 70,
                                              titleStyle: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      Container(
                        height: 800,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 40),
                                  child: Text(
                                    "Mileage Per Vehicle",
                                    style: TextStyle(
                                      color: AppTheme.of(context).primaryText,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Container(
                              height: 500,
                              child: BarChart(
                                BarChartData(
                                  barGroups: _getdataMileage(),
                                  titlesData: licenseData,
                                ),
                                swapAnimationDuration:
                                    Duration(milliseconds: 150), // Optional
                                swapAnimationCurve: Curves.linear, // Optional
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 800,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 40),
                                  child: Text(
                                    "Gas/Diesel % Per Vehicle",
                                    style: TextStyle(
                                      color: AppTheme.of(context).primaryText,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Container(
                              height: 500,
                              child: BarChart(
                                BarChartData(
                                  barGroups: _getdataGas(),
                                  titlesData: licenseData,
                                  //Para cambiar informacion del Hover
                                  // barTouchData: BarTouchData(
                                  //   touchTooltipData: BarTouchTooltipData(
                                  //     //color fondo de hover
                                  //       tooltipBgColor: const Color.fromARGB(
                                  //           255, 204, 204, 204),
                                  //           //informacion que se desplegara en hover
                                  //       getTooltipItem:
                                  //           (group, groupIndex, rod, rodIndex) {
                                  //         String ace;
                                  //         switch (group.x.toInt()) {
                                  //           case 0:
                                  //             ace = '2434';
                                  //             break;
                                  //           case 1:
                                  //             ace = '215';
                                  //             break;
                                  //           default:
                                  //             throw Error();
                                  //         }
                                  //         return BarTooltipItem(
                                  //           '\$ $ace',
                                  //           TextStyle(
                                  //             color: AppTheme.of(context)
                                  //                 .primaryColor,
                                  //             fontWeight: FontWeight.bold,
                                  //             fontSize: 18,
                                  //           ),
                                  //         );
                                  //       }),
                                  // ),
                                ),
                                swapAnimationDuration:
                                    Duration(milliseconds: 150), // Optional
                                swapAnimationCurve: Curves.linear, // Optional
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  List<BarChartGroupData> _getdata() {
    List<BarChartGroupData> data = [
      BarChartGroupData(
        x: 0,
        barRods: [
          BarChartRodData(
            toY: 10,
            color: AppTheme.of(context).secondaryColor,
          ),
          BarChartRodData(
            toY: 8,
            color: AppTheme.of(context).primaryText,
          ),
          BarChartRodData(
            toY: 14,
            color: AppTheme.of(context).primaryColor,
          ),
        ],
      ),
      BarChartGroupData(
        x: 1,
        barRods: [
          BarChartRodData(
            toY: 25,
            color: AppTheme.of(context).secondaryColor,
          ),
          BarChartRodData(
            toY: 39,
            color: AppTheme.of(context).primaryText,
          ),
          BarChartRodData(
            toY: 5,
            color: AppTheme.of(context).primaryColor,
          ),
        ],
      ),
      BarChartGroupData(
        x: 2,
        barRods: [
          BarChartRodData(
            toY: 15,
            color: AppTheme.of(context).secondaryColor,
          ),
          BarChartRodData(
            toY: 3,
            color: AppTheme.of(context).primaryText,
          ),
          BarChartRodData(
            toY: 22,
            color: AppTheme.of(context).primaryColor,
          ),
        ],
      ),
      BarChartGroupData(
        x: 3,
        barRods: [
          BarChartRodData(
            toY: 25,
            color: AppTheme.of(context).secondaryColor,
          ),
          BarChartRodData(
            toY: 19,
            color: AppTheme.of(context).primaryText,
          ),
          BarChartRodData(
            toY: 20,
            color: AppTheme.of(context).primaryColor,
          ),
        ],
      ),
      BarChartGroupData(
        x: 4,
        barRods: [
          BarChartRodData(
            toY: 30,
            color: AppTheme.of(context).secondaryColor,
          ),
          BarChartRodData(
            toY: 28,
            color: AppTheme.of(context).primaryText,
          ),
          BarChartRodData(
            toY: 26,
            color: AppTheme.of(context).primaryColor,
          ),
        ],
      ),
      BarChartGroupData(
        x: 5,
        barRods: [
          BarChartRodData(
            toY: 30,
            color: AppTheme.of(context).secondaryColor,
          ),
          BarChartRodData(
            toY: 32,
            color: AppTheme.of(context).primaryText,
          ),
          BarChartRodData(
            toY: 30,
            color: AppTheme.of(context).primaryColor,
          ),
        ],
      ),
      BarChartGroupData(
        x: 6,
        barRods: [
          BarChartRodData(
            toY: 36,
            color: AppTheme.of(context).secondaryColor,
          ),
          BarChartRodData(
            toY: 33,
            color: AppTheme.of(context).primaryText,
          ),
          BarChartRodData(
            toY: 20,
            color: AppTheme.of(context).primaryColor,
          ),
        ],
      ),
    ];

    return data;
  }

  List<BarChartGroupData> _getdataMileage() {
    List<BarChartGroupData> data = [
      BarChartGroupData(
        x: 0,
        barRods: [
          BarChartRodData(
            toY: 14500,
            color: AppTheme.of(context).secondaryColor,
            width: 10,
          ),
        ],
      ),
      BarChartGroupData(
        x: 1,
        barRods: [
          BarChartRodData(
            toY: 6500,
            color: AppTheme.of(context).primaryColor,
            width: 10,
          ),
        ],
      ),
      BarChartGroupData(
        x: 2,
        barRods: [
          BarChartRodData(
            toY: 9500,
            color: AppTheme.of(context).secondaryColor,
            width: 10,
          ),
        ],
      ),
      BarChartGroupData(
        x: 3,
        barRods: [
          BarChartRodData(
            toY: 8740,
            color: AppTheme.of(context).primaryText,
            width: 10,
          ),
        ],
      ),
      BarChartGroupData(
        x: 4,
        barRods: [
          BarChartRodData(
            toY: 25000,
            color: AppTheme.of(context).secondaryColor,
            width: 10,
          ),
        ],
      ),
      BarChartGroupData(
        x: 5,
        barRods: [
          BarChartRodData(
            toY: 18490,
            color: AppTheme.of(context).primaryColor,
            width: 10,
          ),
        ],
      ),
    ];

    return data;
  }

  List<BarChartGroupData> _getdataGas() {
    List<BarChartGroupData> data = [
      BarChartGroupData(
        x: 0,
        barRods: [
          BarChartRodData(
            toY: 90,
            color: AppTheme.of(context).secondaryColor,
            width: 10,
          ),
        ],
      ),
      BarChartGroupData(
        x: 1,
        barRods: [
          BarChartRodData(
            toY: 50,
            color: AppTheme.of(context).primaryColor,
            width: 10,
          ),
        ],
      ),
      BarChartGroupData(
        x: 2,
        barRods: [
          BarChartRodData(
            toY: 35,
            color: AppTheme.of(context).secondaryColor,
            width: 10,
          ),
        ],
      ),
      BarChartGroupData(
        x: 3,
        barRods: [
          BarChartRodData(
            toY: 48,
            color: AppTheme.of(context).primaryText,
            width: 10,
          ),
        ],
      ),
      BarChartGroupData(
        x: 4,
        barRods: [
          BarChartRodData(
            toY: 25,
            color: AppTheme.of(context).secondaryColor,
            width: 10,
          ),
        ],
      ),
      BarChartGroupData(
        x: 5,
        barRods: [
          BarChartRodData(
            toY: 62,
            color: AppTheme.of(context).primaryColor,
            width: 10,
          ),
        ],
      ),
      BarChartGroupData(
        x: 6,
        barRods: [
          BarChartRodData(
            toY: 100,
            color: AppTheme.of(context).primaryColor,
            width: 10,
          ),
        ],
      ),
    ];

    return data;
  }

  Widget getTitles(double value, TitleMeta meta) {
    final style = TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
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
        text = 'May';
        break;
      case 5:
        text = 'Jun';
        break;
      case 6:
        text = 'Jul';
        break;
      default:
        text = '';
        break;
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 4,
      child: Text(text, style: style),
    );
  }

  Widget getLicenses(double value, TitleMeta meta) {
    final style = TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    String text;
    switch (value.toInt()) {
      case 0:
        text = 'TSX-3291';
        break;
      case 1:
        text = 'FGB-6424';
        break;
      case 2:
        text = 'THG-6912';
        break;
      case 3:
        text = 'YRT-5193';
        break;
      case 4:
        text = 'POT-1234';
        break;
      case 5:
        text = 'TSX-9582';
        break;
      case 6:
        text = 'CAL-5931';
        break;
      default:
        text = '';
        break;
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 4,
      child: Text(text, style: style),
    );
  }

  FlTitlesData get titlesData => FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            getTitlesWidget: getTitles,
          ),
        ),
        leftTitles: AxisTitles(
          axisNameSize: 15,
          sideTitles: SideTitles(showTitles: true,
          reservedSize: 40,),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      );

  FlTitlesData get licenseData => FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            getTitlesWidget: getLicenses,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: true, reservedSize: 40),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      );
}
