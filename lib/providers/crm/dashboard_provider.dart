import 'dart:convert';
import 'dart:developer';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart' hide State;
import 'package:flutter_date_range_picker/flutter_date_range_picker.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:rta_crm_cv/helpers/globals.dart';
import 'package:rta_crm_cv/models/dashboard_crm/totals.dart';
import 'package:rta_crm_cv/models/dashboard_crm/x2_quotes.dart';
import 'package:rta_crm_cv/models/leads_history.dart';

import 'package:http/http.dart' as http;

import 'package:rta_crm_cv/models/x2crm/x2crm_quote_model.dart';
import 'package:rta_crm_cv/theme/theme.dart';
import 'package:rta_crm_cv/widgets/dateranges.dart';

class DashboardCRMProvider extends ChangeNotifier {
  final searchController = TextEditingController();
  List<PlutoRow> rows = [], rows2 = [];
  List<X2QuotesDashboard> quotess = [];
  List<Totales> totalss = [];
  List<X2CrmQuote> x2crmQuotes = [];
  List<double> totalList = [], orderList = [], quotesList = [], canceledList = [];
  double mtotal = 0,
      mOrder = 0,
      mQuote = 0,
      mCancel = 0,
      ctotal = 0,
      cOrder = 0,
      cQuote = 0,
      cCancel = 0;
  List<String> weekList = [];
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
  DateTime now = DateTime.now();
  DateRange range = DateRange(DateTime.now().subtract(const Duration(days: 28)), DateTime.now());
  DateTimeRange dateRange =
      DateTimeRange(start: DateTime.now().subtract(const Duration(days: 28)), end: DateTime.now());

  Color verde = const Color(0xFF2FDC40),
      amarillo = Colors.orangeAccent,
      rojo = const Color(0xFFB2333A);
  ////////////////////////////////////////////////////////////////////////////
  DashboardCRMProvider() {
    touchedValue = -1;
    updateState();
    clearAll();
  }
  var titleGroup = AutoSizeGroup();
  Future<void> updateState() async {
    await getHistory();
    await getQuotes(null);
    await getTotals();
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
  Widget datePickerBuilder(BuildContext context, dynamic Function(DateRange?) onDateRangeChanged,
          [bool doubleMonth = true]) =>
      DateRangePickerWidget(
        doubleMonth: doubleMonth,
        quickDateRanges: [
          QuickDateRange(
            label: 'Previous Week',
            dateRange: DateRange(
              findFirstDateOfPreviousWeek(DateTime.now()),
              findLastDateOfPreviousWeek(DateTime.now()),
            ),
          ),
          QuickDateRange(
            label: 'This Month',
            dateRange: DateRange(
              DateTime(DateTime.now().year, DateTime.now().month, 1),
              findLastDateOfTheMonth(
                DateTime(DateTime.now().year, DateTime.now().month, 1),
              ),
            ),
          ),
          QuickDateRange(
            label: 'Previous Month',
            dateRange: DateRange(
              DateTime(DateTime.now().year, DateTime.now().month - 1, 1),
              findLastDateOfTheMonth(
                DateTime(DateTime.now().year, DateTime.now().month - 1, 1),
              ),
            ),
          ),
          QuickDateRange(
            label: 'This Quarter',
            dateRange: DateRange(
              findFirstDateOfTheQuarter(DateTime.now()),
              findLastDateOfTheQuarter(DateTime.now()),
            ),
          ),
          QuickDateRange(
            label: 'Previous Quarter',
            dateRange: DateRange(
              findFirstDateOfThePreviusQuarter(DateTime.now()),
              findLastDateOfThePreviusQuarter(DateTime.now()),
            ),
          ),
          QuickDateRange(
            label: 'This Year',
            dateRange: DateRange(
              findFirstDateOfTheYear(DateTime.now()),
              findLastDateOfTheYear(DateTime.now()),
            ),
          ),
          QuickDateRange(
            label: 'Previous Year',
            dateRange: DateRange(
              findFirstDateOfTheYear(
                DateTime(DateTime.now().year - 1, 1),
              ),
              findLastDateOfTheYear(
                DateTime(DateTime.now().year - 1, 1),
              ),
            ),
          ),
        ],
        initialDateRange: range,
        initialDisplayedDate: range.start,
        onDateRangeChanged: (DateRange? value) async {
          range = value!;
          await getQuotes(null);
          await getTotals();
          notifyListeners();
        },
        theme: CalendarTheme(
          selectedColor: AppTheme.of(context).primaryColor,
          dayNameTextStyle:
              TextStyle(color: AppTheme.of(context).primaryText, fontSize: 10), //texto dias
          inRangeColor:
              AppTheme.of(context).primaryColor.withOpacity(.2), //color rango seleccionado
          inRangeTextStyle: TextStyle(color: AppTheme.of(context).primaryColor),
          selectedTextStyle: TextStyle(color: AppTheme.of(context).primaryBackground),
          todayTextStyle: const TextStyle(fontWeight: FontWeight.bold),
          defaultTextStyle: TextStyle(color: AppTheme.of(context).primaryText, fontSize: 12),
          radius: 10,
          tileSize: 40,
          disabledTextStyle: const TextStyle(color: Colors.grey),
          selectedQuickDateRangeColor: AppTheme.of(context).primaryColor
        ),
      );

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
      List<LeadsHistory> leads =
          (res as List<dynamic>).map((lead) => LeadsHistory.fromJson(jsonEncode(lead))).toList();

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
    var request = http.Request(
        'GET', Uri.parse('http://34.130.182.108/X2CRM-master/x2engine/index.php/api2/Quotes'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      x2crmQuotes.clear();

      var res = jsonDecode(await response.stream.bytesToString());

      x2crmQuotes =
          (res as List<dynamic>).map((quote) => X2CrmQuote.fromJson(jsonEncode(quote))).toList();
    } else {
      log(response.reasonPhrase.toString());
    }
  }

  Future<void> getTotals() async {
    try {
      dynamic res;
      res = await supabase.rpc(
        'get_totals',
        params: {"start_date": range.start.toString(), "end_date": range.end.toString()},
      );
      if (res == null) {
        log('Error en getTotals() 1');
        return;
      }
      totalss = (res as List<dynamic>).map((quote) => Totales.fromJson(jsonEncode(quote))).toList();
      totalList.clear();
      weekList.clear();
      orderList.clear();
      quotesList.clear();
      canceledList.clear();
      for (Totales total in totalss) {
        totalList.add(total.total.total);
        weekList.add(total.week.toString());
        orderList.add(total.total.orders);
        quotesList.add(total.total.quotes);
        canceledList.add(total.total.canceled);
      }
      mtotal = totalss.first.marcadores.mTotals;
      mOrder = totalss.first.marcadores.mOrders;
      mQuote = totalss.first.marcadores.mQuotes;
      mCancel = totalss.first.marcadores.mCanceled;
      ctotal = totalss.first.marcadores.cTotals;
      cOrder = totalss.first.marcadores.cOrders;
      cQuote = totalss.first.marcadores.cQuotes;
      cCancel = totalss.first.marcadores.cCanceled;
    } catch (e) {
      log('Error en  getTotals() 2 - $e');
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
        res = await supabaseCRM.from('x2_quotes_view').select().eq('status', status); // res = await supabaseCRM.from('quotes_view').select().eq('status', status);
      } else {
        if (currentUser!.isSales) {
          res = await supabaseCRM
              .from('x2_quotes_view')
              .select()
              .gt('createdate', range.start) //.gt('created_at', range.start)
              .lt('createdate', range.end); //.lt('created_at', range.end);

          //res = await supabaseCRM.from('quotes_view').select().eq('status', 'Margin Positive').or('margin.lt.22,margin.gt.45');
        } else if (currentUser!.isSenExec) {
          res = await supabaseCRM.from('x2_quotes_view').select().eq('status', 'Opened');
        } else if (currentUser!.isFinance) {
          res = await supabaseCRM
              .from('x2_quotes_view')
              .select()
              .or('status.eq.Sen. Exec. Validate,status.eq.Margin Positive');
        } else if (currentUser!.isOpperations) {
          res = await supabaseCRM
              .from('x2_quotes_view')
              .select()
              .eq('status', 'Finance Validate')
              .or('status.eq.Accepted');
        }
      }

      if (res == null) {
        log('Error en getUsuarios()');
        return;
      }
      quotess = (res as List<dynamic>).map((quote) => X2QuotesDashboard.fromJson(jsonEncode(quote))).toList();
      rows2.clear();
      for (X2QuotesDashboard quote in quotess) {
        rows2.add(
          PlutoRow(
            cells: {
              'ID_Column': PlutoCell(value: quote.quoteid),
              'NAME_Column': PlutoCell(value: quote.quote),
              'TOTAL_Column': PlutoCell(value: quote.total),
              'MARGIN_Column': PlutoCell(value: quote.probability),
              'VENDOR_Column': PlutoCell(value: quote.company),
              'DESCRIPTION_Column': PlutoCell(value: quote.description),
              //'CREATEDATE_Column':PlutoCell(value: quote.createdate),
              'PROBABILITY_Column': PlutoCell(value: quote.probability),
              'STATUS_Column': PlutoCell(value: quote.status),
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

  getspotsList(List<double> trend) {
    List<FlSpot> flspots = [];
    for (int i = 0; i < trend.length; i++) {
      flspots.add(FlSpot(i.toDouble(), trend[i]));
    }
    return flspots;
  }
  //Graficas
  //totales
  BarChartGroupData puntos(int x, double y, Color color /* Gradient gradient */) {
    return BarChartGroupData(
      x: x,
      groupVertically: true,
      barsSpace: 20,
      barRods: [
        BarChartRodData(
            fromY: 0, toY: y, width: 30, borderRadius: const BorderRadius.all(Radius.zero), color: color
            //gradient: gradient,
            ),
      ],
    );
  }

  //Barchart
  BarChartGroupData getData(int x, double y1, y2, y3) {
    return BarChartGroupData(
      x: x,
      barsSpace: 0,
      barRods: [
        BarChartRodData(
            width: 20,
            toY: y1,
            color: verde,
            rodStackItems: [
              BarChartRodStackItem(0, y1, verde),
            ],
            borderRadius: const BorderRadius.all(Radius.zero)),
        BarChartRodData(
            width: 20,
            toY: y2,
            color: amarillo,
            rodStackItems: [
              BarChartRodStackItem(0, y2, amarillo),
            ],
            borderRadius: const BorderRadius.all(Radius.zero)),
        BarChartRodData(
          width: 20,
          toY: y3,
          color: rojo,
          rodStackItems: [
            BarChartRodStackItem(0, y3, rojo),
          ],
          borderRadius: const BorderRadius.all(Radius.zero),
        )
      ],
    );
  }

  //Linecharts
  LineChartBarData lineTotals(Color color) {
    return LineChartBarData(
      spots: getspotsList(totalList),
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
      spots: getspotsList(orderList),
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
      spots: getspotsList(quotesList),
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
      spots: getspotsList(canceledList),
      isCurved: false,
      barWidth: 5,
      color: rojo,
      dotData: FlDotData(
        show: true,
      ),
    );
  }

  //pie chart
  List<PieChartSectionData> showingSections() {
    double porder = (mOrder / (mOrder + mQuote + mCancel)) * 100,
        pquote = (mQuote / (mOrder + mQuote + mCancel)) * 100,
        pcancel = (mCancel / (mOrder + mQuote + mCancel)) * 100;
    String rorder = porder.toStringAsFixed(2),
        rquote = pquote.toStringAsFixed(2),
        rcancel = pcancel.toStringAsFixed(2);
    double dorder = double.parse(rorder),
        dquote = double.parse(rquote),
        dcancel = double.parse(rcancel);
    return List.generate(3, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 25.0 : 15.0;
      final radius = isTouched ? 100.0 : 75.0;
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: verde,
            value: dorder,
            title: '\$$mOrder\n$dorder%',
            radius: radius,
            titleStyle: TextStyle(
                fontFamily: 'UniNeue',
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 1:
          return PieChartSectionData(
            color: amarillo,
            value: dquote,
            title: '\$$mQuote\n$dquote%',
            radius: radius,
            titleStyle: TextStyle(
                fontFamily: 'UniNeue',
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 2:
          return PieChartSectionData(
            color: rojo,
            value: dcancel,
            title: '\$$mCancel\n$dcancel%',
            radius: radius,
            titleStyle: TextStyle(
                fontFamily: 'UniNeue',
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
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
