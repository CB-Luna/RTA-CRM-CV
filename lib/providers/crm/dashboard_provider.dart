import 'dart:convert';
import 'dart:developer';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart' hide State;
import 'package:pluto_grid/pluto_grid.dart';
import 'package:rta_crm_cv/helpers/globals.dart';
import 'package:rta_crm_cv/models/accounts/quotes_model.dart';
import 'package:rta_crm_cv/models/leads_history.dart';

import 'package:http/http.dart' as http;

import 'package:rta_crm_cv/models/x2crm/x2crm_quote_model.dart';
import 'package:rta_crm_cv/theme/theme.dart';

class DashboardCRMProvider extends ChangeNotifier {
  final searchController = TextEditingController();
  List<PlutoRow> rows = [], rows2 = [];
  List<Quotes> quotess = [];
  List<X2CrmQuote> x2crmQuotes = [];
  PlutoGridStateManager? stateManager;
  bool editmode = false;
  int pageRowCount = 10;
  int page = 1;
  int touchedIndex = -1;
  // grafica esferas
  final maxX = 50.0;
  final maxY = 50.0;
  final radius = 8.0;
  bool showFlutter = true;
  late double touchedValue;
  DateTimeRange dateRange = DateTimeRange(start: DateTime.now().subtract(const Duration(days: 28)), end: DateTime.now());

  Color verde = const Color(0xFF2FDC40), amarillo = Colors.orangeAccent, rojo = const Color(0xFFB2333A);
  //Radianes grafica barra
  /* LinearGradient get gradientRoja => LinearGradient(
        colors: [
          Colors.red.shade900,
          Colors.red,
          Colors.red.shade100,
        ],
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
      );
  LinearGradient get gradientAma => LinearGradient(
        colors: [
          Colors.yellow.shade900,
          Colors.yellow,
          Colors.yellow.shade100,
        ],
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
      );
  LinearGradient get gradientVer => LinearGradient(
        colors: [
          Colors.green.shade900,
          Colors.green,
          Colors.green.shade100,
        ],
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
      );
 */ ////////////////////////////////////////////////////////////////////////////
  DashboardCRMProvider() {
    touchedValue = -1;
    updateState();
    clearAll();
  }
  var titleGroup = AutoSizeGroup();
  Future<void> updateState() async {
    await getHistory();
    await getQuotes(null);
  }

  clearAll() {
    selectChartValue = chartList.first;
    selectTimeValue = timeList.first;
  }

  late String selectChartValue, selectTimeValue;
  List<String> chartList = [
    'Totals Barchart',
    'Barchart',
    'Linechart',
    'PieChart',
  ];
  List<String> timeList = [
    'This Year',
    'This Month',
    'Months',
    'Years',
    'Quarter',
  ];
  void selectChart(String selected) {
    selectChartValue = selected;
    notifyListeners();
  }

  void selectTime(String selected) {
    selectTimeValue = selected;
    notifyListeners();
  }

//Calendario
  Future<void> pickDateRange(
    BuildContext context,
  ) async {
    DateTimeRange? newDateRange = await showDateRangePicker(
        context: context,
        //locale: const Locale("es", ""),
        initialDateRange: dateRange,
        firstDate: DateTime(2000),
        lastDate: DateTime(2025),
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: ColorScheme.light(
                primary: AppTheme.of(context).primaryColor, // color Appbar
                onPrimary: AppTheme.of(context).primaryBackground, // Color letras
                onSurface: AppTheme.of(context).primaryColor, // Color Meses
              ),
              dialogBackgroundColor: AppTheme.of(context).primaryBackground,
            ),
            child: child!,
          );
        },
        initialEntryMode: DatePickerEntryMode.input);
    if (newDateRange == null) return;
    dateRange = newDateRange;
    getQuotes(null);
    notifyListeners();
  }

//Tabla History Leads
  Future<void> getHistory() async {
    if (stateManager != null) {
      stateManager!.setShowLoading(true);
      notifyListeners();
    }
    try {
      final res = await supabaseCRM.from('leads_history').select();
      if (res == null) {
        log('Error en getHistory()');
        return;
      }
      List<LeadsHistory> leads = (res as List<dynamic>).map((lead) => LeadsHistory.fromJson(jsonEncode(lead))).toList();

      rows.clear();
      for (LeadsHistory lead in leads) {
        rows.add(
          PlutoRow(
            cells: {
              'ID': PlutoCell(value: lead.id),
              'CREATE_AT': PlutoCell(value: lead.createdAt),
              'USER': PlutoCell(value: lead.user),
              'ACTION': PlutoCell(value: lead.action),
              'DESCRIPTION': PlutoCell(value: lead.description),
              'TABLE': PlutoCell(value: lead.table),
              'ID_TABLE': PlutoCell(value: lead.idTable),
              'NAME': PlutoCell(value: lead.name),
              'ACTIONS_Column': PlutoCell(value: ''),
            },
          ),
        );
      }
      if (stateManager != null) stateManager!.notifyListeners();
    } catch (e) {
      log('Error en gethistory() - $e');
    }

    notifyListeners();
  }

//Tabla overview history
  Future<void> getX2CRMQuotes() async {
    var headers = {
      'Authorization': 'Basic YWxleGM6NW1saDM5UjhQUVc4WnI3TzhDcGlPSDJvZE1xaGtFOE8=',
      //'Cookie': 'PHPSESSID=u3lgismtbbamh7g3k6b8dqteuk; YII_CSRF_TOKEN=Z2VybTVsZERNcV9faDVSUlE1VFRZeHk3WmNUWmRiSEMSMv7x7artFlmFwAp6GLyf7Qsi4oYOGXtsrcYz02xGJg%3D%3D'
    };
    var request = http.Request('GET', Uri.parse('http://34.130.182.108/X2CRM-master/x2engine/index.php/api2/Quotes'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      x2crmQuotes.clear();

      var res = jsonDecode(await response.stream.bytesToString());

      x2crmQuotes = (res as List<dynamic>).map((quote) => X2CrmQuote.fromJson(jsonEncode(quote))).toList();
    } else {
      log(response.reasonPhrase.toString());
    }
  }

  Future<void> getQuotes(String? status) async {
    if (stateManager != null) {
      stateManager!.setShowLoading(true);
      notifyListeners();
    }
    try {
      dynamic res;
      if (status != null) {
        res = await supabaseCRM.from('quotes_view').select().eq('status', status);
      } else {
        if (currentUser!.isSales) {
          res = await supabaseCRM.from('quotes_view').select().gt('updated_at', dateRange.start).lt('updated_at', dateRange.end);

          //res = await supabaseCRM.from('quotes_view').select().eq('status', 'Margin Positive').or('margin.lt.22,margin.gt.45');
        } else if (currentUser!.isSenExec) {
          res = await supabaseCRM.from('quotes_view').select().eq('status', 'Opened');
        } else if (currentUser!.isFinance) {
          res = await supabaseCRM.from('quotes_view').select().or('status.eq.Sen. Exec. Validate,status.eq.Margin Positive');
        } else if (currentUser!.isOpperations) {
          res = await supabaseCRM.from('quotes_view').select().eq('status', 'Finance Validate').or('status.eq.Accepted');
        }
      }

      if (res == null) {
        log('Error en getUsuarios()');
        return;
      }
      quotess = (res as List<dynamic>).map((quote) => Quotes.fromJson(jsonEncode(quote))).toList();

      rows2.clear();
      for (Quotes quote in quotess) {
        rows2.add(
          PlutoRow(
            cells: {
              'ID_Column': PlutoCell(value: quote.id),
              'ACCOUNT_Column': PlutoCell(value: quote.account),
              'NAME_Column': PlutoCell(value: quote.organitationName),
              'TOTAL_Column': PlutoCell(value: quote.total),
              'MARGIN_Column': PlutoCell(value: quote.margin),
              'VENDOR_Column': PlutoCell(value: quote.vendorName),
              'ORDER_Column': PlutoCell(value: ' ${quote.orderInfo.type} ${quote.orderInfo.orderType}'),
              'DESCRIPTION_Column': PlutoCell(value: quote.items.first.lineItem),
              'DATACENTER_Column': PlutoCell(value: quote.orderInfo.dataCenterLocation),
              'PROBABILITY_Column': PlutoCell(value: quote.leadProbability),
              'CLOSED_Column': PlutoCell(value: quote.expectedClose),
              'ASSIGNED_Column': PlutoCell(value: quote.assignedTo),
              'LAST_Column': PlutoCell(value: quote.updatedAt),
              'STATUS_Column': PlutoCell(value: quote.status),
              'ACTIONS_Column': PlutoCell(value: quote.idQuoteOrigin),
              'ID_LEAD_Column': PlutoCell(value: quote.idLead),
            },
          ),
        );
      }

      if (stateManager != null) stateManager!.notifyListeners();

      await getX2CRMQuotes();
    } catch (e) {
      log('Error en getQuotes() - $e');
    }

    notifyListeners();
  }

  //Graficas
  //totales
  BarChartGroupData puntos(int x, double y, Color color /* Gradient gradient */) {
    return BarChartGroupData(
      x: x,
      groupVertically: true,
      barsSpace: 20,
      barRods: [
        BarChartRodData(fromY: 0, toY: y, width: 40, borderRadius: BorderRadius.circular(15), color: color
            //gradient: gradient,
            ),
      ],
    );
  }

  //Barchart
  List<BarChartGroupData> getData() {
    return [
      BarChartGroupData(
        x: 0,
        barsSpace: 0,
        barRods: [
          BarChartRodData(
              width: 20,
              toY: 1500,
              color: verde,
              rodStackItems: [
                BarChartRodStackItem(0, 1500, verde),
              ],
              borderRadius: const BorderRadius.all(Radius.zero)),
          BarChartRodData(
              width: 20,
              toY: 800,
              color: amarillo,
              rodStackItems: [
                BarChartRodStackItem(0, 800, amarillo),
              ],
              borderRadius: const BorderRadius.all(Radius.zero)),
          BarChartRodData(
            width: 20,
            toY: 134,
            color: rojo,
            rodStackItems: [
              BarChartRodStackItem(0, 134, rojo),
            ],
            borderRadius: const BorderRadius.all(Radius.zero),
          )
        ],
      ),
      BarChartGroupData(
        x: 1,
        barsSpace: 0,
        barRods: [
          BarChartRodData(
              width: 20,
              toY: 120,
              color: verde,
              rodStackItems: [
                BarChartRodStackItem(0, 120, verde),
              ],
              borderRadius: const BorderRadius.all(Radius.zero)),
          BarChartRodData(
              width: 20,
              toY: 60,
              color: amarillo,
              rodStackItems: [
                BarChartRodStackItem(0, 60, amarillo),
              ],
              borderRadius: const BorderRadius.all(Radius.zero)),
          BarChartRodData(
            width: 20,
            toY: 35,
            color: rojo,
            rodStackItems: [
              BarChartRodStackItem(0, 35, rojo),
            ],
            borderRadius: const BorderRadius.all(Radius.zero),
          )
        ],
      ),
      BarChartGroupData(
        x: 2,
        barsSpace: 0,
        barRods: [
          BarChartRodData(
              width: 20,
              toY: 245,
              color: verde,
              rodStackItems: [
                BarChartRodStackItem(0, 245, verde),
              ],
              borderRadius: const BorderRadius.all(Radius.zero)),
          BarChartRodData(
              width: 20,
              toY: 400,
              color: amarillo,
              rodStackItems: [
                BarChartRodStackItem(0, 400, amarillo),
              ],
              borderRadius: const BorderRadius.all(Radius.zero)),
          BarChartRodData(
            width: 20,
            toY: 120,
            color: rojo,
            rodStackItems: [
              BarChartRodStackItem(0, 120, rojo),
            ],
            borderRadius: const BorderRadius.all(Radius.zero),
          )
        ],
      ),
      BarChartGroupData(
        x: 3,
        barsSpace: 0,
        barRods: [
          BarChartRodData(
              width: 20,
              toY: 293,
              color: verde,
              rodStackItems: [
                BarChartRodStackItem(0, 293, verde),
              ],
              borderRadius: const BorderRadius.all(Radius.zero)),
          BarChartRodData(
              width: 20,
              toY: 127,
              color: amarillo,
              rodStackItems: [
                BarChartRodStackItem(0, 127, amarillo),
              ],
              borderRadius: const BorderRadius.all(Radius.zero)),
          BarChartRodData(
            width: 20,
            toY: 80,
            color: rojo,
            rodStackItems: [
              BarChartRodStackItem(0, 80, rojo),
            ],
            borderRadius: const BorderRadius.all(Radius.zero),
          )
        ],
      ),
      BarChartGroupData(
        x: 4,
        barsSpace: 0,
        barRods: [
          BarChartRodData(
              width: 20,
              toY: 800,
              color: verde,
              rodStackItems: [
                BarChartRodStackItem(0, 800, verde),
              ],
              borderRadius: const BorderRadius.all(Radius.zero)),
          BarChartRodData(
              width: 20,
              toY: 784,
              color: amarillo,
              rodStackItems: [
                BarChartRodStackItem(0, 784, amarillo),
              ],
              borderRadius: const BorderRadius.all(Radius.zero)),
          BarChartRodData(
            width: 20,
            toY: 116,
            color: rojo,
            rodStackItems: [
              BarChartRodStackItem(0, 116, rojo),
            ],
            borderRadius: const BorderRadius.all(Radius.zero),
          )
        ],
      ),
      BarChartGroupData(
        x: 5,
        barsSpace: 0,
        barRods: [
          BarChartRodData(
              width: 20,
              toY: 617,
              color: verde,
              rodStackItems: [
                BarChartRodStackItem(0, 617, verde),
              ],
              borderRadius: const BorderRadius.all(Radius.zero)),
          BarChartRodData(
              width: 20,
              toY: 175,
              color: amarillo,
              rodStackItems: [
                BarChartRodStackItem(0, 175, amarillo),
              ],
              borderRadius: const BorderRadius.all(Radius.zero)),
          BarChartRodData(
            width: 20,
            toY: 148,
            color: rojo,
            rodStackItems: [
              BarChartRodStackItem(0, 148, rojo),
            ],
            borderRadius: const BorderRadius.all(Radius.zero),
          )
        ],
      ),
      BarChartGroupData(
        x: 6,
        barsSpace: 0,
        barRods: [
          BarChartRodData(
              width: 20,
              toY: 679,
              color: verde,
              rodStackItems: [
                BarChartRodStackItem(0, 679, verde),
              ],
              borderRadius: const BorderRadius.all(Radius.zero)),
          BarChartRodData(
              width: 20,
              toY: 894,
              color: amarillo,
              rodStackItems: [
                BarChartRodStackItem(0, 894, amarillo),
              ],
              borderRadius: const BorderRadius.all(Radius.zero)),
          BarChartRodData(
            width: 20,
            toY: 327,
            color: rojo,
            rodStackItems: [
              BarChartRodStackItem(0, 327, rojo),
            ],
            borderRadius: const BorderRadius.all(Radius.zero),
          )
        ],
      ),
      BarChartGroupData(
        x: 7,
        barsSpace: 0,
        barRods: [
          BarChartRodData(
              width: 20,
              toY: 171,
              color: verde,
              rodStackItems: [
                BarChartRodStackItem(0, 171, verde),
              ],
              borderRadius: const BorderRadius.all(Radius.zero)),
          BarChartRodData(
              width: 20,
              toY: 95,
              color: amarillo,
              rodStackItems: [
                BarChartRodStackItem(0, 95, amarillo),
              ],
              borderRadius: const BorderRadius.all(Radius.zero)),
          BarChartRodData(
            width: 20,
            toY: 184,
            color: rojo,
            rodStackItems: [
              BarChartRodStackItem(0, 184, rojo),
            ],
            borderRadius: const BorderRadius.all(Radius.zero),
          )
        ],
      ),
      BarChartGroupData(
        x: 8,
        barsSpace: 0,
        barRods: [
          BarChartRodData(
              width: 20,
              toY: 764,
              color: verde,
              rodStackItems: [
                BarChartRodStackItem(0, 764, verde),
              ],
              borderRadius: const BorderRadius.all(Radius.zero)),
          BarChartRodData(
              width: 20,
              toY: 748,
              color: amarillo,
              rodStackItems: [
                BarChartRodStackItem(0, 748, amarillo),
              ],
              borderRadius: const BorderRadius.all(Radius.zero)),
          BarChartRodData(
            width: 20,
            toY: 488,
            color: rojo,
            rodStackItems: [
              BarChartRodStackItem(0, 488, rojo),
            ],
            borderRadius: const BorderRadius.all(Radius.zero),
          )
        ],
      ),
      BarChartGroupData(
        x: 9,
        barsSpace: 0,
        barRods: [
          BarChartRodData(
              width: 20,
              toY: 542,
              color: verde,
              rodStackItems: [
                BarChartRodStackItem(0, 542, verde),
              ],
              borderRadius: const BorderRadius.all(Radius.zero)),
          BarChartRodData(
              width: 20,
              toY: 184,
              color: amarillo,
              rodStackItems: [
                BarChartRodStackItem(0, 184, amarillo),
              ],
              borderRadius: const BorderRadius.all(Radius.zero)),
          BarChartRodData(
            width: 20,
            toY: 27,
            color: rojo,
            rodStackItems: [
              BarChartRodStackItem(0, 27, rojo),
            ],
            borderRadius: const BorderRadius.all(Radius.zero),
          )
        ],
      ),
      BarChartGroupData(
        x: 10,
        barsSpace: 0,
        barRods: [
          BarChartRodData(
              width: 20,
              toY: 483,
              color: verde,
              rodStackItems: [
                BarChartRodStackItem(0, 483, verde),
              ],
              borderRadius: const BorderRadius.all(Radius.zero)),
          BarChartRodData(
              width: 20,
              toY: 96,
              color: amarillo,
              rodStackItems: [
                BarChartRodStackItem(0, 96, amarillo),
              ],
              borderRadius: const BorderRadius.all(Radius.zero)),
          BarChartRodData(
            width: 20,
            toY: 108,
            color: rojo,
            rodStackItems: [
              BarChartRodStackItem(0, 108, rojo),
            ],
            borderRadius: const BorderRadius.all(Radius.zero),
          )
        ],
      ),
      BarChartGroupData(
        x: 11,
        barsSpace: 0,
        barRods: [
          BarChartRodData(
              width: 20,
              toY: 1682,
              color: verde,
              rodStackItems: [
                BarChartRodStackItem(0, 1682, verde),
              ],
              borderRadius: const BorderRadius.all(Radius.zero)),
          BarChartRodData(
              width: 20,
              toY: 180,
              color: amarillo,
              rodStackItems: [
                BarChartRodStackItem(0, 180, amarillo),
              ],
              borderRadius: const BorderRadius.all(Radius.zero)),
          BarChartRodData(
            width: 20,
            toY: 112,
            color: rojo,
            rodStackItems: [
              BarChartRodStackItem(0, 112, rojo),
            ],
            borderRadius: const BorderRadius.all(Radius.zero),
          )
        ],
      ),
    ];
  }

  //Linecharts
  LineChartBarData totals(Color color) {
    return LineChartBarData(
      spots: [
        const FlSpot(0, 2300),
        const FlSpot(1, 180),
        const FlSpot(2, 644),
        const FlSpot(3, 420),
        const FlSpot(4, 1594),
        const FlSpot(5, 792),
        const FlSpot(6, 1573),
        const FlSpot(7, 266),
        const FlSpot(8, 1512),
        const FlSpot(9, 726),
        const FlSpot(10, 570),
        const FlSpot(11, 1862),
      ],
      isCurved: false,
      barWidth: 5,
      color: color,
      dotData: FlDotData(
        show: true,
      ),
    );
  }

  LineChartBarData order() {
    return LineChartBarData(
      spots: [
        const FlSpot(0, 1500),
        const FlSpot(1, 120),
        const FlSpot(2, 245),
        const FlSpot(3, 293),
        const FlSpot(4, 800),
        const FlSpot(5, 617),
        const FlSpot(6, 679),
        const FlSpot(7, 171),
        const FlSpot(8, 764),
        const FlSpot(9, 542),
        const FlSpot(10, 483),
        const FlSpot(11, 1682),
      ],
      isCurved: false,
      barWidth: 5,
      color: verde,
      dotData: FlDotData(
        show: true,
      ),
    );
  }

  LineChartBarData quotes() {
    return LineChartBarData(
      spots: [
        const FlSpot(0, 800),
        const FlSpot(1, 60),
        const FlSpot(2, 400),
        const FlSpot(3, 127),
        const FlSpot(4, 784),
        const FlSpot(5, 175),
        const FlSpot(6, 894),
        const FlSpot(7, 95),
        const FlSpot(8, 748),
        const FlSpot(9, 184),
        const FlSpot(10, 96),
        const FlSpot(11, 180),
      ],
      isCurved: false,
      barWidth: 5,
      color: amarillo,
      dotData: FlDotData(
        show: true,
      ),
    );
  }

  LineChartBarData canceled() {
    return LineChartBarData(
      spots: [
        const FlSpot(0, 134),
        const FlSpot(1, 35),
        const FlSpot(2, 120),
        const FlSpot(3, 80),
        const FlSpot(4, 116),
        const FlSpot(5, 148),
        const FlSpot(6, 327),
        const FlSpot(7, 184),
        const FlSpot(8, 488),
        const FlSpot(9, 27),
        const FlSpot(10, 108),
        const FlSpot(11, 112),
      ],
      isCurved: false,
      barWidth: 5,
      color: rojo,
      dotData: FlDotData(
        show: true,
      ),
    );
  }

  //pie chart
  double orderpie = 7896, quote = 4543, cancel = 1879;
  List<PieChartSectionData> showingSections() {
    double porder = (orderpie / (orderpie + quote + cancel)) * 100, pquote = (quote / (orderpie + quote + cancel)) * 100, pcancel = (cancel / (orderpie + quote + cancel)) * 100;
    String rorder = porder.toStringAsFixed(2), rquote = pquote.toStringAsFixed(2), rcancel = pcancel.toStringAsFixed(2);
    double dorder = double.parse(rorder), dquote = double.parse(rquote), dcancel = double.parse(rcancel);
    return List.generate(3, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 25.0 : 15.0;
      final radius = isTouched ? 100.0 : 75.0;
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: verde,
            value: dorder,
            title: '\$$orderpie\n$dorder%',
            radius: radius,
            titleStyle: TextStyle(fontFamily: 'UniNeue', fontSize: fontSize, fontWeight: FontWeight.bold, color: const Color(0xffffffff)),
          );
        case 1:
          return PieChartSectionData(
            color: amarillo,
            value: dquote,
            title: '\$$quote\n$dquote%',
            radius: radius,
            titleStyle: TextStyle(fontFamily: 'UniNeue', fontSize: fontSize, fontWeight: FontWeight.bold, color: const Color(0xffffffff)),
          );
        case 2:
          return PieChartSectionData(
            color: rojo,
            value: dcancel,
            title: '\$$cancel\n$dcancel%',
            radius: radius,
            titleStyle: TextStyle(fontFamily: 'UniNeue', fontSize: fontSize, fontWeight: FontWeight.bold, color: const Color(0xffffffff)),
          );

        default:
          throw Error();
      }
    });
  }

//Controladores Paginado Pluto?
  void clearControllers({bool notify = true}) {
    searchController.clear();

    if (notify) notifyListeners();
  }

  void setPageSize(String x) {
    switch (x) {
      case 'more':
        if (pageRowCount < rows.length) pageRowCount++;
        break;
      case 'less':
        if (pageRowCount > 1) pageRowCount--;
        break;
      default:
        return;
    }
    stateManager!.createFooter;
    notifyListeners();
  }

  void setPage(String x) {
    switch (x) {
      case 'next':
        if (page < stateManager!.totalPage) page++;
        break;
      case 'previous':
        if (page > 1) page--;
        break;
      case 'start':
        page = 1;
        break;
      case 'end':
        page = stateManager!.totalPage;
        break;
      default:
        return;
    }
    stateManager!.setPage(page);
    notifyListeners();
  }

  void load() {
    stateManager!.setShowLoading(true);
  }
}
