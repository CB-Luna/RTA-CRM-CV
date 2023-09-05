import 'dart:convert';
import 'dart:developer';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart' hide State;
import 'package:pluto_grid/pluto_grid.dart';
import 'package:rta_crm_cv/helpers/globals.dart';
import 'package:rta_crm_cv/models/issues_dashboards.dart';

import 'package:rta_crm_cv/theme/theme.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DashboardCVProvider extends ChangeNotifier {
  final searchController = TextEditingController();
  List<PlutoRow> rows = [], rows2 = [];
  List<IssuesDashboards> issuesDashboards = [];
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

  Color azul = const Color(0xFF2E5899), rojo = const Color(0xFFD20030), naranja = const Color.fromRGBO(255, 138, 0, 1);
  double cry = 0, ode = 0, smi = 0;
  int vehiclesCRY = 0, vehiclesODE = 0, vehiclesSMI = 0;
  double actualMonthEndCry = 0;
  double oneMonthAgoEndCry = 0;
  double twoMonthsAgoEndCry = 0;
  double threeMonthsAgoEndCry = 0;
  double fourMonthsAgoEndCry = 0;
  double fiveMonthsAgoEndCry = 0;
  double sixMonthsAgoEndCry = 0;
  double sevenMonthsAgoEndCry = 0;
  double eightMonthsAgoEndCry = 0;
  double nineMonthsAgoEndCry = 0;
  double tenMonthsAgoEndCry = 0;
  double elevenMonthsAgoEndCry = 0;

  double actualMonthEndOde = 0;
  double oneMonthAgoEndOde = 0;
  double twoMonthsAgoEndOde = 0;
  double threeMonthsAgoEndOde = 0;
  double fourMonthsAgoEndOde = 0;
  double fiveMonthsAgoEndOde = 0;
  double sixMonthsAgoEndOde = 0;
  double sevenMonthsAgoEndOde = 0;
  double eightMonthsAgoEndOde = 0;
  double nineMonthsAgoEndOde = 0;
  double tenMonthsAgoEndOde = 0;
  double elevenMonthsAgoEndOde = 0;

  double actualMonthEndSmi = 0;
  double oneMonthAgoEndSmi = 0;
  double twoMonthsAgoEndSmi = 0;
  double threeMonthsAgoEndSmi = 0;
  double fourMonthsAgoEndSmi = 0;
  double fiveMonthsAgoEndSmi = 0;
  double sixMonthsAgoEndSmi = 0;
  double sevenMonthsAgoEndSmi = 0;
  double eightMonthsAgoEndSmi = 0;
  double nineMonthsAgoEndSmi = 0;
  double tenMonthsAgoEndSmi = 0;
  double elevenMonthsAgoEndSmi = 0;

  DashboardCVProvider() {
    touchedValue = -1;
    updateState();
    clearAll();
  }

  var titleGroup = AutoSizeGroup();
  Future<void> updateState() async {
    await getVehicles();
    await getIssues(null);
  }

  clearAll() {
    selectChartValue = chartList.last;
    selectTimeValue = timeList.last;
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
    getIssues(null);
    notifyListeners();
  }

  Future<void> getIssues(String? status) async {
    if (stateManager != null) {
      stateManager!.setShowLoading(true);
      notifyListeners();
    }
    try {
      dynamic resCTRLV;
      if (status != null) {
        // res = await supabaseCRM.from('quotes_view').select().eq('status', status);
      } else {
        resCTRLV = await supabaseCtrlV.from('dashboards_cv_view').select().gt('date_added_r', dateRange.start).lt('date_added_r', dateRange.end);
      }

      if (resCTRLV == null) {
        log('Error en getIssues()');
        return;
      }
      issuesDashboards = (resCTRLV as List<dynamic>).map((issue) => IssuesDashboards.fromJson(jsonEncode(issue))).toList();

      rows2.clear();
      cry = 0;
      ode = 0;
      smi = 0;
      actualMonthEndCry = 0;
      oneMonthAgoEndCry = 0;
      twoMonthsAgoEndCry = 0;
      threeMonthsAgoEndCry = 0;
      fourMonthsAgoEndCry = 0;
      fiveMonthsAgoEndCry = 0;
      sixMonthsAgoEndCry = 0;
      sevenMonthsAgoEndCry = 0;
      eightMonthsAgoEndCry = 0;
      nineMonthsAgoEndCry = 0;
      tenMonthsAgoEndCry = 0;
      elevenMonthsAgoEndCry = 0;

      actualMonthEndOde = 0;
      oneMonthAgoEndOde = 0;
      twoMonthsAgoEndOde = 0;
      threeMonthsAgoEndOde = 0;
      fourMonthsAgoEndOde = 0;
      fiveMonthsAgoEndOde = 0;
      sixMonthsAgoEndOde = 0;
      sevenMonthsAgoEndOde = 0;
      eightMonthsAgoEndOde = 0;
      nineMonthsAgoEndOde = 0;
      tenMonthsAgoEndOde = 0;
      elevenMonthsAgoEndOde = 0;

      actualMonthEndSmi = 0;
      oneMonthAgoEndSmi = 0;
      twoMonthsAgoEndSmi = 0;
      threeMonthsAgoEndSmi = 0;
      fourMonthsAgoEndSmi = 0;
      fiveMonthsAgoEndSmi = 0;
      sixMonthsAgoEndSmi = 0;
      sevenMonthsAgoEndSmi = 0;
      eightMonthsAgoEndSmi = 0;
      nineMonthsAgoEndSmi = 0;
      tenMonthsAgoEndSmi = 0;
      elevenMonthsAgoEndSmi = 0;

      for (IssuesDashboards issue in issuesDashboards) {
        // Bucket Inspection
        issue.bucketInspectionR.toMap().forEach((key, value) {
          if (value == false) {
            String nameIssue = key.replaceAll("_", " ").capitalize;
            DateTime dateAdded = DateTime.parse(issue.bucketInspectionR.toMap()["date_added"]);
            rows2.add(
              PlutoRow(
                cells: {
                  'COMPANY_Column': PlutoCell(value: issue.company),
                  'LICENSE_PLATES_Column': PlutoCell(value: issue.licensePlates),
                  'ISSUE_Column': PlutoCell(value: nameIssue),
                  'USER_Column': PlutoCell(value: "${issue.userProfile.name} ${issue.userProfile.lastName}"),
                  'TYPE_FORM_Column': PlutoCell(value: "Check Out"),
                  'DATE_Column': PlutoCell(value: dateAdded),
                },
              ),
            );
            if (issue.company == "CRY") {
              cry++;
              if (dateAdded.month == dateRange.end.month && dateAdded.isBefore(dateRange.end)) actualMonthEndCry++;
              if (dateAdded.month == (dateRange.end.month - 1) && dateAdded.isAfter(dateRange.start)) oneMonthAgoEndCry++;
              if (dateAdded.month == (dateRange.end.month - 2) && dateAdded.isAfter(dateRange.start)) twoMonthsAgoEndCry++;
              if (dateAdded.month == (dateRange.end.month - 3) && dateAdded.isAfter(dateRange.start)) threeMonthsAgoEndCry++;
              if (dateAdded.month == (dateRange.end.month - 4) && dateAdded.isAfter(dateRange.start)) fourMonthsAgoEndCry++;
              if (dateAdded.month == (dateRange.end.month - 5) && dateAdded.isAfter(dateRange.start)) fiveMonthsAgoEndCry++;
              if (dateAdded.month == (dateRange.end.month - 6) && dateAdded.isAfter(dateRange.start)) sixMonthsAgoEndCry++;
              if (dateAdded.month == (dateRange.end.month - 7) && dateAdded.isAfter(dateRange.start)) sevenMonthsAgoEndCry++;
              if (dateAdded.month == (dateRange.end.month - 8) && dateAdded.isAfter(dateRange.start)) eightMonthsAgoEndCry++;
              if (dateAdded.month == (dateRange.end.month - 9) && dateAdded.isAfter(dateRange.start)) nineMonthsAgoEndCry++;
              if (dateAdded.month == (dateRange.end.month - 10) && dateAdded.isAfter(dateRange.start)) tenMonthsAgoEndCry++;
              if (dateAdded.month == (dateRange.end.month - 11) && dateAdded.isAfter(dateRange.start)) elevenMonthsAgoEndCry++;
            }
            if (issue.company == "ODE") {
              ode++;
              if (dateAdded.month == dateRange.end.month && dateAdded.isBefore(dateRange.end)) actualMonthEndOde++;
              if (dateAdded.month == (dateRange.end.month - 1) && dateAdded.isAfter(dateRange.start)) oneMonthAgoEndOde++;
              if (dateAdded.month == (dateRange.end.month - 2) && dateAdded.isAfter(dateRange.start)) twoMonthsAgoEndOde++;
              if (dateAdded.month == (dateRange.end.month - 3) && dateAdded.isAfter(dateRange.start)) threeMonthsAgoEndOde++;
              if (dateAdded.month == (dateRange.end.month - 4) && dateAdded.isAfter(dateRange.start)) fourMonthsAgoEndOde++;
              if (dateAdded.month == (dateRange.end.month - 5) && dateAdded.isAfter(dateRange.start)) fiveMonthsAgoEndOde++;
              if (dateAdded.month == (dateRange.end.month - 6) && dateAdded.isAfter(dateRange.start)) sixMonthsAgoEndOde++;
              if (dateAdded.month == (dateRange.end.month - 7) && dateAdded.isAfter(dateRange.start)) sevenMonthsAgoEndOde++;
              if (dateAdded.month == (dateRange.end.month - 8) && dateAdded.isAfter(dateRange.start)) eightMonthsAgoEndOde++;
              if (dateAdded.month == (dateRange.end.month - 9) && dateAdded.isAfter(dateRange.start)) nineMonthsAgoEndOde++;
              if (dateAdded.month == (dateRange.end.month - 10) && dateAdded.isAfter(dateRange.start)) tenMonthsAgoEndOde++;
              if (dateAdded.month == (dateRange.end.month - 11) && dateAdded.isAfter(dateRange.start)) elevenMonthsAgoEndOde++;
            }
            if (issue.company == "SMI") {
              smi++;
              if (dateAdded.month == dateRange.end.month && dateAdded.isBefore(dateRange.end)) actualMonthEndSmi++;
              if (dateAdded.month == (dateRange.end.month - 1) && dateAdded.isAfter(dateRange.start)) oneMonthAgoEndSmi++;
              if (dateAdded.month == (dateRange.end.month - 2) && dateAdded.isAfter(dateRange.start)) twoMonthsAgoEndSmi++;
              if (dateAdded.month == (dateRange.end.month - 3) && dateAdded.isAfter(dateRange.start)) threeMonthsAgoEndSmi++;
              if (dateAdded.month == (dateRange.end.month - 4) && dateAdded.isAfter(dateRange.start)) fourMonthsAgoEndSmi++;
              if (dateAdded.month == (dateRange.end.month - 5) && dateAdded.isAfter(dateRange.start)) fiveMonthsAgoEndSmi++;
              if (dateAdded.month == (dateRange.end.month - 6) && dateAdded.isAfter(dateRange.start)) sixMonthsAgoEndSmi++;
              if (dateAdded.month == (dateRange.end.month - 7) && dateAdded.isAfter(dateRange.start)) sevenMonthsAgoEndSmi++;
              if (dateAdded.month == (dateRange.end.month - 8) && dateAdded.isAfter(dateRange.start)) eightMonthsAgoEndSmi++;
              if (dateAdded.month == (dateRange.end.month - 9) && dateAdded.isAfter(dateRange.start)) nineMonthsAgoEndSmi++;
              if (dateAdded.month == (dateRange.end.month - 10) && dateAdded.isAfter(dateRange.start)) tenMonthsAgoEndSmi++;
              if (dateAdded.month == (dateRange.end.month - 11) && dateAdded.isAfter(dateRange.start)) elevenMonthsAgoEndSmi++;
            }
          }
        });
        issue.bucketInspectionD.toMap().forEach((key, value) {
          if (value == false) {
            String nameIssue = key.replaceAll("_", " ").capitalize;
            DateTime dateAdded = DateTime.parse(issue.bucketInspectionD.toMap()["date_added"]);
            rows2.add(
              PlutoRow(
                cells: {
                  'COMPANY_Column': PlutoCell(value: issue.company),
                  'LICENSE_PLATES_Column': PlutoCell(value: issue.licensePlates),
                  'ISSUE_Column': PlutoCell(value: nameIssue),
                  'USER_Column': PlutoCell(value: "${issue.userProfile.name} ${issue.userProfile.lastName}"),
                  'TYPE_FORM_Column': PlutoCell(value: "Check In"),
                  'DATE_Column': PlutoCell(value: dateAdded),
                },
              ),
            );
            if (issue.company == "CRY") {
              cry++;
              if (dateAdded.month == dateRange.end.month && dateAdded.isBefore(dateRange.end)) actualMonthEndCry++;
              if (dateAdded.month == (dateRange.end.month - 1) && dateAdded.isAfter(dateRange.start)) oneMonthAgoEndCry++;
              if (dateAdded.month == (dateRange.end.month - 2) && dateAdded.isAfter(dateRange.start)) twoMonthsAgoEndCry++;
              if (dateAdded.month == (dateRange.end.month - 3) && dateAdded.isAfter(dateRange.start)) threeMonthsAgoEndCry++;
              if (dateAdded.month == (dateRange.end.month - 4) && dateAdded.isAfter(dateRange.start)) fourMonthsAgoEndCry++;
              if (dateAdded.month == (dateRange.end.month - 5) && dateAdded.isAfter(dateRange.start)) fiveMonthsAgoEndCry++;
              if (dateAdded.month == (dateRange.end.month - 6) && dateAdded.isAfter(dateRange.start)) sixMonthsAgoEndCry++;
              if (dateAdded.month == (dateRange.end.month - 7) && dateAdded.isAfter(dateRange.start)) sevenMonthsAgoEndCry++;
              if (dateAdded.month == (dateRange.end.month - 8) && dateAdded.isAfter(dateRange.start)) eightMonthsAgoEndCry++;
              if (dateAdded.month == (dateRange.end.month - 9) && dateAdded.isAfter(dateRange.start)) nineMonthsAgoEndCry++;
              if (dateAdded.month == (dateRange.end.month - 10) && dateAdded.isAfter(dateRange.start)) tenMonthsAgoEndCry++;
              if (dateAdded.month == (dateRange.end.month - 11) && dateAdded.isAfter(dateRange.start)) elevenMonthsAgoEndCry++;
            }
            if (issue.company == "ODE") {
              ode++;
              if (dateAdded.month == dateRange.end.month && dateAdded.isBefore(dateRange.end)) actualMonthEndOde++;
              if (dateAdded.month == (dateRange.end.month - 1) && dateAdded.isAfter(dateRange.start)) oneMonthAgoEndOde++;
              if (dateAdded.month == (dateRange.end.month - 2) && dateAdded.isAfter(dateRange.start)) twoMonthsAgoEndOde++;
              if (dateAdded.month == (dateRange.end.month - 3) && dateAdded.isAfter(dateRange.start)) threeMonthsAgoEndOde++;
              if (dateAdded.month == (dateRange.end.month - 4) && dateAdded.isAfter(dateRange.start)) fourMonthsAgoEndOde++;
              if (dateAdded.month == (dateRange.end.month - 5) && dateAdded.isAfter(dateRange.start)) fiveMonthsAgoEndOde++;
              if (dateAdded.month == (dateRange.end.month - 6) && dateAdded.isAfter(dateRange.start)) sixMonthsAgoEndOde++;
              if (dateAdded.month == (dateRange.end.month - 7) && dateAdded.isAfter(dateRange.start)) sevenMonthsAgoEndOde++;
              if (dateAdded.month == (dateRange.end.month - 8) && dateAdded.isAfter(dateRange.start)) eightMonthsAgoEndOde++;
              if (dateAdded.month == (dateRange.end.month - 9) && dateAdded.isAfter(dateRange.start)) nineMonthsAgoEndOde++;
              if (dateAdded.month == (dateRange.end.month - 10) && dateAdded.isAfter(dateRange.start)) tenMonthsAgoEndOde++;
              if (dateAdded.month == (dateRange.end.month - 11) && dateAdded.isAfter(dateRange.start)) elevenMonthsAgoEndOde++;
            }
            if (issue.company == "SMI") {
              smi++;
              if (dateAdded.month == dateRange.end.month && dateAdded.isBefore(dateRange.end)) actualMonthEndSmi++;
              if (dateAdded.month == (dateRange.end.month - 1) && dateAdded.isAfter(dateRange.start)) oneMonthAgoEndSmi++;
              if (dateAdded.month == (dateRange.end.month - 2) && dateAdded.isAfter(dateRange.start)) twoMonthsAgoEndSmi++;
              if (dateAdded.month == (dateRange.end.month - 3) && dateAdded.isAfter(dateRange.start)) threeMonthsAgoEndSmi++;
              if (dateAdded.month == (dateRange.end.month - 4) && dateAdded.isAfter(dateRange.start)) fourMonthsAgoEndSmi++;
              if (dateAdded.month == (dateRange.end.month - 5) && dateAdded.isAfter(dateRange.start)) fiveMonthsAgoEndSmi++;
              if (dateAdded.month == (dateRange.end.month - 6) && dateAdded.isAfter(dateRange.start)) sixMonthsAgoEndSmi++;
              if (dateAdded.month == (dateRange.end.month - 7) && dateAdded.isAfter(dateRange.start)) sevenMonthsAgoEndSmi++;
              if (dateAdded.month == (dateRange.end.month - 8) && dateAdded.isAfter(dateRange.start)) eightMonthsAgoEndSmi++;
              if (dateAdded.month == (dateRange.end.month - 9) && dateAdded.isAfter(dateRange.start)) nineMonthsAgoEndSmi++;
              if (dateAdded.month == (dateRange.end.month - 10) && dateAdded.isAfter(dateRange.start)) tenMonthsAgoEndSmi++;
              if (dateAdded.month == (dateRange.end.month - 11) && dateAdded.isAfter(dateRange.start)) elevenMonthsAgoEndSmi++;
            }
          }
        });
        // Car Bodywork
        issue.carBodyworkR.toMap().forEach((key, value) {
          if (value == false) {
            String nameIssue = key.replaceAll("_", " ").capitalize;
            DateTime dateAdded = DateTime.parse(issue.carBodyworkR.toMap()["date_added"]);
            rows2.add(
              PlutoRow(
                cells: {
                  'COMPANY_Column': PlutoCell(value: issue.company),
                  'LICENSE_PLATES_Column': PlutoCell(value: issue.licensePlates),
                  'ISSUE_Column': PlutoCell(value: nameIssue),
                  'USER_Column': PlutoCell(value: "${issue.userProfile.name} ${issue.userProfile.lastName}"),
                  'TYPE_FORM_Column': PlutoCell(value: "Check Out"),
                  'DATE_Column': PlutoCell(value: dateAdded),
                },
              ),
            );
            if (issue.company == "CRY") {
              cry++;
              if (dateAdded.month == dateRange.end.month && dateAdded.isBefore(dateRange.end)) actualMonthEndCry++;
              if (dateAdded.month == (dateRange.end.month - 1) && dateAdded.isAfter(dateRange.start)) oneMonthAgoEndCry++;
              if (dateAdded.month == (dateRange.end.month - 2) && dateAdded.isAfter(dateRange.start)) twoMonthsAgoEndCry++;
              if (dateAdded.month == (dateRange.end.month - 3) && dateAdded.isAfter(dateRange.start)) threeMonthsAgoEndCry++;
              if (dateAdded.month == (dateRange.end.month - 4) && dateAdded.isAfter(dateRange.start)) fourMonthsAgoEndCry++;
              if (dateAdded.month == (dateRange.end.month - 5) && dateAdded.isAfter(dateRange.start)) fiveMonthsAgoEndCry++;
              if (dateAdded.month == (dateRange.end.month - 6) && dateAdded.isAfter(dateRange.start)) sixMonthsAgoEndCry++;
              if (dateAdded.month == (dateRange.end.month - 7) && dateAdded.isAfter(dateRange.start)) sevenMonthsAgoEndCry++;
              if (dateAdded.month == (dateRange.end.month - 8) && dateAdded.isAfter(dateRange.start)) eightMonthsAgoEndCry++;
              if (dateAdded.month == (dateRange.end.month - 9) && dateAdded.isAfter(dateRange.start)) nineMonthsAgoEndCry++;
              if (dateAdded.month == (dateRange.end.month - 10) && dateAdded.isAfter(dateRange.start)) tenMonthsAgoEndCry++;
              if (dateAdded.month == (dateRange.end.month - 11) && dateAdded.isAfter(dateRange.start)) elevenMonthsAgoEndCry++;
            }
            if (issue.company == "ODE") {
              ode++;
              if (dateAdded.month == dateRange.end.month && dateAdded.isBefore(dateRange.end)) actualMonthEndOde++;
              if (dateAdded.month == (dateRange.end.month - 1) && dateAdded.isAfter(dateRange.start)) oneMonthAgoEndOde++;
              if (dateAdded.month == (dateRange.end.month - 2) && dateAdded.isAfter(dateRange.start)) twoMonthsAgoEndOde++;
              if (dateAdded.month == (dateRange.end.month - 3) && dateAdded.isAfter(dateRange.start)) threeMonthsAgoEndOde++;
              if (dateAdded.month == (dateRange.end.month - 4) && dateAdded.isAfter(dateRange.start)) fourMonthsAgoEndOde++;
              if (dateAdded.month == (dateRange.end.month - 5) && dateAdded.isAfter(dateRange.start)) fiveMonthsAgoEndOde++;
              if (dateAdded.month == (dateRange.end.month - 6) && dateAdded.isAfter(dateRange.start)) sixMonthsAgoEndOde++;
              if (dateAdded.month == (dateRange.end.month - 7) && dateAdded.isAfter(dateRange.start)) sevenMonthsAgoEndOde++;
              if (dateAdded.month == (dateRange.end.month - 8) && dateAdded.isAfter(dateRange.start)) eightMonthsAgoEndOde++;
              if (dateAdded.month == (dateRange.end.month - 9) && dateAdded.isAfter(dateRange.start)) nineMonthsAgoEndOde++;
              if (dateAdded.month == (dateRange.end.month - 10) && dateAdded.isAfter(dateRange.start)) tenMonthsAgoEndOde++;
              if (dateAdded.month == (dateRange.end.month - 11) && dateAdded.isAfter(dateRange.start)) elevenMonthsAgoEndOde++;
            }
            if (issue.company == "SMI") {
              smi++;
              if (dateAdded.month == dateRange.end.month && dateAdded.isBefore(dateRange.end)) actualMonthEndSmi++;
              if (dateAdded.month == (dateRange.end.month - 1) && dateAdded.isAfter(dateRange.start)) oneMonthAgoEndSmi++;
              if (dateAdded.month == (dateRange.end.month - 2) && dateAdded.isAfter(dateRange.start)) twoMonthsAgoEndSmi++;
              if (dateAdded.month == (dateRange.end.month - 3) && dateAdded.isAfter(dateRange.start)) threeMonthsAgoEndSmi++;
              if (dateAdded.month == (dateRange.end.month - 4) && dateAdded.isAfter(dateRange.start)) fourMonthsAgoEndSmi++;
              if (dateAdded.month == (dateRange.end.month - 5) && dateAdded.isAfter(dateRange.start)) fiveMonthsAgoEndSmi++;
              if (dateAdded.month == (dateRange.end.month - 6) && dateAdded.isAfter(dateRange.start)) sixMonthsAgoEndSmi++;
              if (dateAdded.month == (dateRange.end.month - 7) && dateAdded.isAfter(dateRange.start)) sevenMonthsAgoEndSmi++;
              if (dateAdded.month == (dateRange.end.month - 8) && dateAdded.isAfter(dateRange.start)) eightMonthsAgoEndSmi++;
              if (dateAdded.month == (dateRange.end.month - 9) && dateAdded.isAfter(dateRange.start)) nineMonthsAgoEndSmi++;
              if (dateAdded.month == (dateRange.end.month - 10) && dateAdded.isAfter(dateRange.start)) tenMonthsAgoEndSmi++;
              if (dateAdded.month == (dateRange.end.month - 11) && dateAdded.isAfter(dateRange.start)) elevenMonthsAgoEndSmi++;
            }
          }
        });
        issue.carBodyworkD.toMap().forEach((key, value) {
          if (value == false) {
            String nameIssue = key.replaceAll("_", " ").capitalize;
            DateTime dateAdded = DateTime.parse(issue.carBodyworkD.toMap()["date_added"]);
            rows2.add(
              PlutoRow(
                cells: {
                  'COMPANY_Column': PlutoCell(value: issue.company),
                  'LICENSE_PLATES_Column': PlutoCell(value: issue.licensePlates),
                  'ISSUE_Column': PlutoCell(value: nameIssue),
                  'USER_Column': PlutoCell(value: "${issue.userProfile.name} ${issue.userProfile.lastName}"),
                  'TYPE_FORM_Column': PlutoCell(value: "Check In"),
                  'DATE_Column': PlutoCell(value: dateAdded),
                },
              ),
            );
            if (issue.company == "CRY") {
              cry++;
              if (dateAdded.month == dateRange.end.month && dateAdded.isBefore(dateRange.end)) actualMonthEndCry++;
              if (dateAdded.month == (dateRange.end.month - 1) && dateAdded.isAfter(dateRange.start)) oneMonthAgoEndCry++;
              if (dateAdded.month == (dateRange.end.month - 2) && dateAdded.isAfter(dateRange.start)) twoMonthsAgoEndCry++;
              if (dateAdded.month == (dateRange.end.month - 3) && dateAdded.isAfter(dateRange.start)) threeMonthsAgoEndCry++;
              if (dateAdded.month == (dateRange.end.month - 4) && dateAdded.isAfter(dateRange.start)) fourMonthsAgoEndCry++;
              if (dateAdded.month == (dateRange.end.month - 5) && dateAdded.isAfter(dateRange.start)) fiveMonthsAgoEndCry++;
              if (dateAdded.month == (dateRange.end.month - 6) && dateAdded.isAfter(dateRange.start)) sixMonthsAgoEndCry++;
              if (dateAdded.month == (dateRange.end.month - 7) && dateAdded.isAfter(dateRange.start)) sevenMonthsAgoEndCry++;
              if (dateAdded.month == (dateRange.end.month - 8) && dateAdded.isAfter(dateRange.start)) eightMonthsAgoEndCry++;
              if (dateAdded.month == (dateRange.end.month - 9) && dateAdded.isAfter(dateRange.start)) nineMonthsAgoEndCry++;
              if (dateAdded.month == (dateRange.end.month - 10) && dateAdded.isAfter(dateRange.start)) tenMonthsAgoEndCry++;
              if (dateAdded.month == (dateRange.end.month - 11) && dateAdded.isAfter(dateRange.start)) elevenMonthsAgoEndCry++;
            }
            if (issue.company == "ODE") {
              ode++;
              if (dateAdded.month == dateRange.end.month && dateAdded.isBefore(dateRange.end)) actualMonthEndOde++;
              if (dateAdded.month == (dateRange.end.month - 1) && dateAdded.isAfter(dateRange.start)) oneMonthAgoEndOde++;
              if (dateAdded.month == (dateRange.end.month - 2) && dateAdded.isAfter(dateRange.start)) twoMonthsAgoEndOde++;
              if (dateAdded.month == (dateRange.end.month - 3) && dateAdded.isAfter(dateRange.start)) threeMonthsAgoEndOde++;
              if (dateAdded.month == (dateRange.end.month - 4) && dateAdded.isAfter(dateRange.start)) fourMonthsAgoEndOde++;
              if (dateAdded.month == (dateRange.end.month - 5) && dateAdded.isAfter(dateRange.start)) fiveMonthsAgoEndOde++;
              if (dateAdded.month == (dateRange.end.month - 6) && dateAdded.isAfter(dateRange.start)) sixMonthsAgoEndOde++;
              if (dateAdded.month == (dateRange.end.month - 7) && dateAdded.isAfter(dateRange.start)) sevenMonthsAgoEndOde++;
              if (dateAdded.month == (dateRange.end.month - 8) && dateAdded.isAfter(dateRange.start)) eightMonthsAgoEndOde++;
              if (dateAdded.month == (dateRange.end.month - 9) && dateAdded.isAfter(dateRange.start)) nineMonthsAgoEndOde++;
              if (dateAdded.month == (dateRange.end.month - 10) && dateAdded.isAfter(dateRange.start)) tenMonthsAgoEndOde++;
              if (dateAdded.month == (dateRange.end.month - 11) && dateAdded.isAfter(dateRange.start)) elevenMonthsAgoEndOde++;
            }
            if (issue.company == "SMI") {
              smi++;
              if (dateAdded.month == dateRange.end.month && dateAdded.isBefore(dateRange.end)) actualMonthEndSmi++;
              if (dateAdded.month == (dateRange.end.month - 1) && dateAdded.isAfter(dateRange.start)) oneMonthAgoEndSmi++;
              if (dateAdded.month == (dateRange.end.month - 2) && dateAdded.isAfter(dateRange.start)) twoMonthsAgoEndSmi++;
              if (dateAdded.month == (dateRange.end.month - 3) && dateAdded.isAfter(dateRange.start)) threeMonthsAgoEndSmi++;
              if (dateAdded.month == (dateRange.end.month - 4) && dateAdded.isAfter(dateRange.start)) fourMonthsAgoEndSmi++;
              if (dateAdded.month == (dateRange.end.month - 5) && dateAdded.isAfter(dateRange.start)) fiveMonthsAgoEndSmi++;
              if (dateAdded.month == (dateRange.end.month - 6) && dateAdded.isAfter(dateRange.start)) sixMonthsAgoEndSmi++;
              if (dateAdded.month == (dateRange.end.month - 7) && dateAdded.isAfter(dateRange.start)) sevenMonthsAgoEndSmi++;
              if (dateAdded.month == (dateRange.end.month - 8) && dateAdded.isAfter(dateRange.start)) eightMonthsAgoEndSmi++;
              if (dateAdded.month == (dateRange.end.month - 9) && dateAdded.isAfter(dateRange.start)) nineMonthsAgoEndSmi++;
              if (dateAdded.month == (dateRange.end.month - 10) && dateAdded.isAfter(dateRange.start)) tenMonthsAgoEndSmi++;
              if (dateAdded.month == (dateRange.end.month - 11) && dateAdded.isAfter(dateRange.start)) elevenMonthsAgoEndSmi++;
            }
          }
        });
        // Equipment
        issue.equipmentR.toMap().forEach((key, value) {
          if (value == false) {
            String nameIssue = key.replaceAll("_", " ").capitalize;
            DateTime dateAdded = DateTime.parse(issue.equipmentR.toMap()["date_added"]);
            rows2.add(
              PlutoRow(
                cells: {
                  'COMPANY_Column': PlutoCell(value: issue.company),
                  'LICENSE_PLATES_Column': PlutoCell(value: issue.licensePlates),
                  'ISSUE_Column': PlutoCell(value: nameIssue),
                  'USER_Column': PlutoCell(value: "${issue.userProfile.name} ${issue.userProfile.lastName}"),
                  'TYPE_FORM_Column': PlutoCell(value: "Check Out"),
                  'DATE_Column': PlutoCell(value: dateAdded),
                },
              ),
            );
            if (issue.company == "CRY") {
              cry++;
              if (dateAdded.month == dateRange.end.month && dateAdded.isBefore(dateRange.end)) actualMonthEndCry++;
              if (dateAdded.month == (dateRange.end.month - 1) && dateAdded.isAfter(dateRange.start)) oneMonthAgoEndCry++;
              if (dateAdded.month == (dateRange.end.month - 2) && dateAdded.isAfter(dateRange.start)) twoMonthsAgoEndCry++;
              if (dateAdded.month == (dateRange.end.month - 3) && dateAdded.isAfter(dateRange.start)) threeMonthsAgoEndCry++;
              if (dateAdded.month == (dateRange.end.month - 4) && dateAdded.isAfter(dateRange.start)) fourMonthsAgoEndCry++;
              if (dateAdded.month == (dateRange.end.month - 5) && dateAdded.isAfter(dateRange.start)) fiveMonthsAgoEndCry++;
              if (dateAdded.month == (dateRange.end.month - 6) && dateAdded.isAfter(dateRange.start)) sixMonthsAgoEndCry++;
              if (dateAdded.month == (dateRange.end.month - 7) && dateAdded.isAfter(dateRange.start)) sevenMonthsAgoEndCry++;
              if (dateAdded.month == (dateRange.end.month - 8) && dateAdded.isAfter(dateRange.start)) eightMonthsAgoEndCry++;
              if (dateAdded.month == (dateRange.end.month - 9) && dateAdded.isAfter(dateRange.start)) nineMonthsAgoEndCry++;
              if (dateAdded.month == (dateRange.end.month - 10) && dateAdded.isAfter(dateRange.start)) tenMonthsAgoEndCry++;
              if (dateAdded.month == (dateRange.end.month - 11) && dateAdded.isAfter(dateRange.start)) elevenMonthsAgoEndCry++;
            }
            if (issue.company == "ODE") {
              ode++;
              if (dateAdded.month == dateRange.end.month && dateAdded.isBefore(dateRange.end)) actualMonthEndOde++;
              if (dateAdded.month == (dateRange.end.month - 1) && dateAdded.isAfter(dateRange.start)) oneMonthAgoEndOde++;
              if (dateAdded.month == (dateRange.end.month - 2) && dateAdded.isAfter(dateRange.start)) twoMonthsAgoEndOde++;
              if (dateAdded.month == (dateRange.end.month - 3) && dateAdded.isAfter(dateRange.start)) threeMonthsAgoEndOde++;
              if (dateAdded.month == (dateRange.end.month - 4) && dateAdded.isAfter(dateRange.start)) fourMonthsAgoEndOde++;
              if (dateAdded.month == (dateRange.end.month - 5) && dateAdded.isAfter(dateRange.start)) fiveMonthsAgoEndOde++;
              if (dateAdded.month == (dateRange.end.month - 6) && dateAdded.isAfter(dateRange.start)) sixMonthsAgoEndOde++;
              if (dateAdded.month == (dateRange.end.month - 7) && dateAdded.isAfter(dateRange.start)) sevenMonthsAgoEndOde++;
              if (dateAdded.month == (dateRange.end.month - 8) && dateAdded.isAfter(dateRange.start)) eightMonthsAgoEndOde++;
              if (dateAdded.month == (dateRange.end.month - 9) && dateAdded.isAfter(dateRange.start)) nineMonthsAgoEndOde++;
              if (dateAdded.month == (dateRange.end.month - 10) && dateAdded.isAfter(dateRange.start)) tenMonthsAgoEndOde++;
              if (dateAdded.month == (dateRange.end.month - 11) && dateAdded.isAfter(dateRange.start)) elevenMonthsAgoEndOde++;
            }
            if (issue.company == "SMI") {
              smi++;
              if (dateAdded.month == dateRange.end.month && dateAdded.isBefore(dateRange.end)) actualMonthEndSmi++;
              if (dateAdded.month == (dateRange.end.month - 1) && dateAdded.isAfter(dateRange.start)) oneMonthAgoEndSmi++;
              if (dateAdded.month == (dateRange.end.month - 2) && dateAdded.isAfter(dateRange.start)) twoMonthsAgoEndSmi++;
              if (dateAdded.month == (dateRange.end.month - 3) && dateAdded.isAfter(dateRange.start)) threeMonthsAgoEndSmi++;
              if (dateAdded.month == (dateRange.end.month - 4) && dateAdded.isAfter(dateRange.start)) fourMonthsAgoEndSmi++;
              if (dateAdded.month == (dateRange.end.month - 5) && dateAdded.isAfter(dateRange.start)) fiveMonthsAgoEndSmi++;
              if (dateAdded.month == (dateRange.end.month - 6) && dateAdded.isAfter(dateRange.start)) sixMonthsAgoEndSmi++;
              if (dateAdded.month == (dateRange.end.month - 7) && dateAdded.isAfter(dateRange.start)) sevenMonthsAgoEndSmi++;
              if (dateAdded.month == (dateRange.end.month - 8) && dateAdded.isAfter(dateRange.start)) eightMonthsAgoEndSmi++;
              if (dateAdded.month == (dateRange.end.month - 9) && dateAdded.isAfter(dateRange.start)) nineMonthsAgoEndSmi++;
              if (dateAdded.month == (dateRange.end.month - 10) && dateAdded.isAfter(dateRange.start)) tenMonthsAgoEndSmi++;
              if (dateAdded.month == (dateRange.end.month - 11) && dateAdded.isAfter(dateRange.start)) elevenMonthsAgoEndSmi++;
            }
          }
        });
        issue.equipmentD.toMap().forEach((key, value) {
          if (value == false) {
            String nameIssue = key.replaceAll("_", " ").capitalize;
            DateTime dateAdded = DateTime.parse(issue.equipmentD.toMap()["date_added"]);
            rows2.add(
              PlutoRow(
                cells: {
                  'COMPANY_Column': PlutoCell(value: issue.company),
                  'LICENSE_PLATES_Column': PlutoCell(value: issue.licensePlates),
                  'ISSUE_Column': PlutoCell(value: nameIssue),
                  'USER_Column': PlutoCell(value: "${issue.userProfile.name} ${issue.userProfile.lastName}"),
                  'TYPE_FORM_Column': PlutoCell(value: "Check In"),
                  'DATE_Column': PlutoCell(value: dateAdded),
                },
              ),
            );
            if (issue.company == "CRY") {
              cry++;
              if (dateAdded.month == dateRange.end.month && dateAdded.isBefore(dateRange.end)) actualMonthEndCry++;
              if (dateAdded.month == (dateRange.end.month - 1) && dateAdded.isAfter(dateRange.start)) oneMonthAgoEndCry++;
              if (dateAdded.month == (dateRange.end.month - 2) && dateAdded.isAfter(dateRange.start)) twoMonthsAgoEndCry++;
              if (dateAdded.month == (dateRange.end.month - 3) && dateAdded.isAfter(dateRange.start)) threeMonthsAgoEndCry++;
              if (dateAdded.month == (dateRange.end.month - 4) && dateAdded.isAfter(dateRange.start)) fourMonthsAgoEndCry++;
              if (dateAdded.month == (dateRange.end.month - 5) && dateAdded.isAfter(dateRange.start)) fiveMonthsAgoEndCry++;
              if (dateAdded.month == (dateRange.end.month - 6) && dateAdded.isAfter(dateRange.start)) sixMonthsAgoEndCry++;
              if (dateAdded.month == (dateRange.end.month - 7) && dateAdded.isAfter(dateRange.start)) sevenMonthsAgoEndCry++;
              if (dateAdded.month == (dateRange.end.month - 8) && dateAdded.isAfter(dateRange.start)) eightMonthsAgoEndCry++;
              if (dateAdded.month == (dateRange.end.month - 9) && dateAdded.isAfter(dateRange.start)) nineMonthsAgoEndCry++;
              if (dateAdded.month == (dateRange.end.month - 10) && dateAdded.isAfter(dateRange.start)) tenMonthsAgoEndCry++;
              if (dateAdded.month == (dateRange.end.month - 11) && dateAdded.isAfter(dateRange.start)) elevenMonthsAgoEndCry++;
            }
            if (issue.company == "ODE") {
              ode++;
              if (dateAdded.month == dateRange.end.month && dateAdded.isBefore(dateRange.end)) actualMonthEndOde++;
              if (dateAdded.month == (dateRange.end.month - 1) && dateAdded.isAfter(dateRange.start)) oneMonthAgoEndOde++;
              if (dateAdded.month == (dateRange.end.month - 2) && dateAdded.isAfter(dateRange.start)) twoMonthsAgoEndOde++;
              if (dateAdded.month == (dateRange.end.month - 3) && dateAdded.isAfter(dateRange.start)) threeMonthsAgoEndOde++;
              if (dateAdded.month == (dateRange.end.month - 4) && dateAdded.isAfter(dateRange.start)) fourMonthsAgoEndOde++;
              if (dateAdded.month == (dateRange.end.month - 5) && dateAdded.isAfter(dateRange.start)) fiveMonthsAgoEndOde++;
              if (dateAdded.month == (dateRange.end.month - 6) && dateAdded.isAfter(dateRange.start)) sixMonthsAgoEndOde++;
              if (dateAdded.month == (dateRange.end.month - 7) && dateAdded.isAfter(dateRange.start)) sevenMonthsAgoEndOde++;
              if (dateAdded.month == (dateRange.end.month - 8) && dateAdded.isAfter(dateRange.start)) eightMonthsAgoEndOde++;
              if (dateAdded.month == (dateRange.end.month - 9) && dateAdded.isAfter(dateRange.start)) nineMonthsAgoEndOde++;
              if (dateAdded.month == (dateRange.end.month - 10) && dateAdded.isAfter(dateRange.start)) tenMonthsAgoEndOde++;
              if (dateAdded.month == (dateRange.end.month - 11) && dateAdded.isAfter(dateRange.start)) elevenMonthsAgoEndOde++;
            }
            if (issue.company == "SMI") {
              smi++;
              if (dateAdded.month == dateRange.end.month && dateAdded.isBefore(dateRange.end)) actualMonthEndSmi++;
              if (dateAdded.month == (dateRange.end.month - 1) && dateAdded.isAfter(dateRange.start)) oneMonthAgoEndSmi++;
              if (dateAdded.month == (dateRange.end.month - 2) && dateAdded.isAfter(dateRange.start)) twoMonthsAgoEndSmi++;
              if (dateAdded.month == (dateRange.end.month - 3) && dateAdded.isAfter(dateRange.start)) threeMonthsAgoEndSmi++;
              if (dateAdded.month == (dateRange.end.month - 4) && dateAdded.isAfter(dateRange.start)) fourMonthsAgoEndSmi++;
              if (dateAdded.month == (dateRange.end.month - 5) && dateAdded.isAfter(dateRange.start)) fiveMonthsAgoEndSmi++;
              if (dateAdded.month == (dateRange.end.month - 6) && dateAdded.isAfter(dateRange.start)) sixMonthsAgoEndSmi++;
              if (dateAdded.month == (dateRange.end.month - 7) && dateAdded.isAfter(dateRange.start)) sevenMonthsAgoEndSmi++;
              if (dateAdded.month == (dateRange.end.month - 8) && dateAdded.isAfter(dateRange.start)) eightMonthsAgoEndSmi++;
              if (dateAdded.month == (dateRange.end.month - 9) && dateAdded.isAfter(dateRange.start)) nineMonthsAgoEndSmi++;
              if (dateAdded.month == (dateRange.end.month - 10) && dateAdded.isAfter(dateRange.start)) tenMonthsAgoEndSmi++;
              if (dateAdded.month == (dateRange.end.month - 11) && dateAdded.isAfter(dateRange.start)) elevenMonthsAgoEndSmi++;
            }
          }
        });
        // Extra
        issue.extraR.toMap().forEach((key, value) {
          if (value == false) {
            String nameIssue = key.replaceAll("_", " ").capitalize;
            DateTime dateAdded = DateTime.parse(issue.extraR.toMap()["date_added"]);
            rows2.add(
              PlutoRow(
                cells: {
                  'COMPANY_Column': PlutoCell(value: issue.company),
                  'LICENSE_PLATES_Column': PlutoCell(value: issue.licensePlates),
                  'ISSUE_Column': PlutoCell(value: nameIssue),
                  'USER_Column': PlutoCell(value: "${issue.userProfile.name} ${issue.userProfile.lastName}"),
                  'TYPE_FORM_Column': PlutoCell(value: "Check Out"),
                  'DATE_Column': PlutoCell(value: dateAdded),
                },
              ),
            );
            if (issue.company == "CRY") {
              cry++;
              if (dateAdded.month == dateRange.end.month && dateAdded.isBefore(dateRange.end)) actualMonthEndCry++;
              if (dateAdded.month == (dateRange.end.month - 1) && dateAdded.isAfter(dateRange.start)) oneMonthAgoEndCry++;
              if (dateAdded.month == (dateRange.end.month - 2) && dateAdded.isAfter(dateRange.start)) twoMonthsAgoEndCry++;
              if (dateAdded.month == (dateRange.end.month - 3) && dateAdded.isAfter(dateRange.start)) threeMonthsAgoEndCry++;
              if (dateAdded.month == (dateRange.end.month - 4) && dateAdded.isAfter(dateRange.start)) fourMonthsAgoEndCry++;
              if (dateAdded.month == (dateRange.end.month - 5) && dateAdded.isAfter(dateRange.start)) fiveMonthsAgoEndCry++;
              if (dateAdded.month == (dateRange.end.month - 6) && dateAdded.isAfter(dateRange.start)) sixMonthsAgoEndCry++;
              if (dateAdded.month == (dateRange.end.month - 7) && dateAdded.isAfter(dateRange.start)) sevenMonthsAgoEndCry++;
              if (dateAdded.month == (dateRange.end.month - 8) && dateAdded.isAfter(dateRange.start)) eightMonthsAgoEndCry++;
              if (dateAdded.month == (dateRange.end.month - 9) && dateAdded.isAfter(dateRange.start)) nineMonthsAgoEndCry++;
              if (dateAdded.month == (dateRange.end.month - 10) && dateAdded.isAfter(dateRange.start)) tenMonthsAgoEndCry++;
              if (dateAdded.month == (dateRange.end.month - 11) && dateAdded.isAfter(dateRange.start)) elevenMonthsAgoEndCry++;
            }
            if (issue.company == "ODE") {
              ode++;
              if (dateAdded.month == dateRange.end.month && dateAdded.isBefore(dateRange.end)) actualMonthEndOde++;
              if (dateAdded.month == (dateRange.end.month - 1) && dateAdded.isAfter(dateRange.start)) oneMonthAgoEndOde++;
              if (dateAdded.month == (dateRange.end.month - 2) && dateAdded.isAfter(dateRange.start)) twoMonthsAgoEndOde++;
              if (dateAdded.month == (dateRange.end.month - 3) && dateAdded.isAfter(dateRange.start)) threeMonthsAgoEndOde++;
              if (dateAdded.month == (dateRange.end.month - 4) && dateAdded.isAfter(dateRange.start)) fourMonthsAgoEndOde++;
              if (dateAdded.month == (dateRange.end.month - 5) && dateAdded.isAfter(dateRange.start)) fiveMonthsAgoEndOde++;
              if (dateAdded.month == (dateRange.end.month - 6) && dateAdded.isAfter(dateRange.start)) sixMonthsAgoEndOde++;
              if (dateAdded.month == (dateRange.end.month - 7) && dateAdded.isAfter(dateRange.start)) sevenMonthsAgoEndOde++;
              if (dateAdded.month == (dateRange.end.month - 8) && dateAdded.isAfter(dateRange.start)) eightMonthsAgoEndOde++;
              if (dateAdded.month == (dateRange.end.month - 9) && dateAdded.isAfter(dateRange.start)) nineMonthsAgoEndOde++;
              if (dateAdded.month == (dateRange.end.month - 10) && dateAdded.isAfter(dateRange.start)) tenMonthsAgoEndOde++;
              if (dateAdded.month == (dateRange.end.month - 11) && dateAdded.isAfter(dateRange.start)) elevenMonthsAgoEndOde++;
            }
            if (issue.company == "SMI") {
              smi++;
              if (dateAdded.month == dateRange.end.month && dateAdded.isBefore(dateRange.end)) actualMonthEndSmi++;
              if (dateAdded.month == (dateRange.end.month - 1) && dateAdded.isAfter(dateRange.start)) oneMonthAgoEndSmi++;
              if (dateAdded.month == (dateRange.end.month - 2) && dateAdded.isAfter(dateRange.start)) twoMonthsAgoEndSmi++;
              if (dateAdded.month == (dateRange.end.month - 3) && dateAdded.isAfter(dateRange.start)) threeMonthsAgoEndSmi++;
              if (dateAdded.month == (dateRange.end.month - 4) && dateAdded.isAfter(dateRange.start)) fourMonthsAgoEndSmi++;
              if (dateAdded.month == (dateRange.end.month - 5) && dateAdded.isAfter(dateRange.start)) fiveMonthsAgoEndSmi++;
              if (dateAdded.month == (dateRange.end.month - 6) && dateAdded.isAfter(dateRange.start)) sixMonthsAgoEndSmi++;
              if (dateAdded.month == (dateRange.end.month - 7) && dateAdded.isAfter(dateRange.start)) sevenMonthsAgoEndSmi++;
              if (dateAdded.month == (dateRange.end.month - 8) && dateAdded.isAfter(dateRange.start)) eightMonthsAgoEndSmi++;
              if (dateAdded.month == (dateRange.end.month - 9) && dateAdded.isAfter(dateRange.start)) nineMonthsAgoEndSmi++;
              if (dateAdded.month == (dateRange.end.month - 10) && dateAdded.isAfter(dateRange.start)) tenMonthsAgoEndSmi++;
              if (dateAdded.month == (dateRange.end.month - 11) && dateAdded.isAfter(dateRange.start)) elevenMonthsAgoEndSmi++;
            }
          }
        });
        issue.extraD.toMap().forEach((key, value) {
          if (value == false) {
            String nameIssue = key.replaceAll("_", " ").capitalize;
            DateTime dateAdded = DateTime.parse(issue.extraD.toMap()["date_added"]);
            rows2.add(
              PlutoRow(
                cells: {
                  'COMPANY_Column': PlutoCell(value: issue.company),
                  'LICENSE_PLATES_Column': PlutoCell(value: issue.licensePlates),
                  'ISSUE_Column': PlutoCell(value: nameIssue),
                  'USER_Column': PlutoCell(value: "${issue.userProfile.name} ${issue.userProfile.lastName}"),
                  'TYPE_FORM_Column': PlutoCell(value: "Check In"),
                  'DATE_Column': PlutoCell(value: dateAdded),
                },
              ),
            );
            if (issue.company == "CRY") {
              cry++;
              if (dateAdded.month == dateRange.end.month && dateAdded.isBefore(dateRange.end)) actualMonthEndCry++;
              if (dateAdded.month == (dateRange.end.month - 1) && dateAdded.isAfter(dateRange.start)) oneMonthAgoEndCry++;
              if (dateAdded.month == (dateRange.end.month - 2) && dateAdded.isAfter(dateRange.start)) twoMonthsAgoEndCry++;
              if (dateAdded.month == (dateRange.end.month - 3) && dateAdded.isAfter(dateRange.start)) threeMonthsAgoEndCry++;
              if (dateAdded.month == (dateRange.end.month - 4) && dateAdded.isAfter(dateRange.start)) fourMonthsAgoEndCry++;
              if (dateAdded.month == (dateRange.end.month - 5) && dateAdded.isAfter(dateRange.start)) fiveMonthsAgoEndCry++;
              if (dateAdded.month == (dateRange.end.month - 6) && dateAdded.isAfter(dateRange.start)) sixMonthsAgoEndCry++;
              if (dateAdded.month == (dateRange.end.month - 7) && dateAdded.isAfter(dateRange.start)) sevenMonthsAgoEndCry++;
              if (dateAdded.month == (dateRange.end.month - 8) && dateAdded.isAfter(dateRange.start)) eightMonthsAgoEndCry++;
              if (dateAdded.month == (dateRange.end.month - 9) && dateAdded.isAfter(dateRange.start)) nineMonthsAgoEndCry++;
              if (dateAdded.month == (dateRange.end.month - 10) && dateAdded.isAfter(dateRange.start)) tenMonthsAgoEndCry++;
              if (dateAdded.month == (dateRange.end.month - 11) && dateAdded.isAfter(dateRange.start)) elevenMonthsAgoEndCry++;
            }
            if (issue.company == "ODE") {
              ode++;
              if (dateAdded.month == dateRange.end.month && dateAdded.isBefore(dateRange.end)) actualMonthEndOde++;
              if (dateAdded.month == (dateRange.end.month - 1) && dateAdded.isAfter(dateRange.start)) oneMonthAgoEndOde++;
              if (dateAdded.month == (dateRange.end.month - 2) && dateAdded.isAfter(dateRange.start)) twoMonthsAgoEndOde++;
              if (dateAdded.month == (dateRange.end.month - 3) && dateAdded.isAfter(dateRange.start)) threeMonthsAgoEndOde++;
              if (dateAdded.month == (dateRange.end.month - 4) && dateAdded.isAfter(dateRange.start)) fourMonthsAgoEndOde++;
              if (dateAdded.month == (dateRange.end.month - 5) && dateAdded.isAfter(dateRange.start)) fiveMonthsAgoEndOde++;
              if (dateAdded.month == (dateRange.end.month - 6) && dateAdded.isAfter(dateRange.start)) sixMonthsAgoEndOde++;
              if (dateAdded.month == (dateRange.end.month - 7) && dateAdded.isAfter(dateRange.start)) sevenMonthsAgoEndOde++;
              if (dateAdded.month == (dateRange.end.month - 8) && dateAdded.isAfter(dateRange.start)) eightMonthsAgoEndOde++;
              if (dateAdded.month == (dateRange.end.month - 9) && dateAdded.isAfter(dateRange.start)) nineMonthsAgoEndOde++;
              if (dateAdded.month == (dateRange.end.month - 10) && dateAdded.isAfter(dateRange.start)) tenMonthsAgoEndOde++;
              if (dateAdded.month == (dateRange.end.month - 11) && dateAdded.isAfter(dateRange.start)) elevenMonthsAgoEndOde++;
            }
            if (issue.company == "SMI") {
              smi++;
              if (dateAdded.month == dateRange.end.month && dateAdded.isBefore(dateRange.end)) actualMonthEndSmi++;
              if (dateAdded.month == (dateRange.end.month - 1) && dateAdded.isAfter(dateRange.start)) oneMonthAgoEndSmi++;
              if (dateAdded.month == (dateRange.end.month - 2) && dateAdded.isAfter(dateRange.start)) twoMonthsAgoEndSmi++;
              if (dateAdded.month == (dateRange.end.month - 3) && dateAdded.isAfter(dateRange.start)) threeMonthsAgoEndSmi++;
              if (dateAdded.month == (dateRange.end.month - 4) && dateAdded.isAfter(dateRange.start)) fourMonthsAgoEndSmi++;
              if (dateAdded.month == (dateRange.end.month - 5) && dateAdded.isAfter(dateRange.start)) fiveMonthsAgoEndSmi++;
              if (dateAdded.month == (dateRange.end.month - 6) && dateAdded.isAfter(dateRange.start)) sixMonthsAgoEndSmi++;
              if (dateAdded.month == (dateRange.end.month - 7) && dateAdded.isAfter(dateRange.start)) sevenMonthsAgoEndSmi++;
              if (dateAdded.month == (dateRange.end.month - 8) && dateAdded.isAfter(dateRange.start)) eightMonthsAgoEndSmi++;
              if (dateAdded.month == (dateRange.end.month - 9) && dateAdded.isAfter(dateRange.start)) nineMonthsAgoEndSmi++;
              if (dateAdded.month == (dateRange.end.month - 10) && dateAdded.isAfter(dateRange.start)) tenMonthsAgoEndSmi++;
              if (dateAdded.month == (dateRange.end.month - 11) && dateAdded.isAfter(dateRange.start)) elevenMonthsAgoEndSmi++;
            }
          }
        });
        // Fluid Check
        issue.fluidCheckR.toMap().forEach((key, value) {
          if (value == false) {
            String nameIssue = key.replaceAll("_", " ").capitalize;
            DateTime dateAdded = DateTime.parse(issue.fluidCheckR.toMap()["date_added"]);
            rows2.add(
              PlutoRow(
                cells: {
                  'COMPANY_Column': PlutoCell(value: issue.company),
                  'LICENSE_PLATES_Column': PlutoCell(value: issue.licensePlates),
                  'ISSUE_Column': PlutoCell(value: nameIssue),
                  'USER_Column': PlutoCell(value: "${issue.userProfile.name} ${issue.userProfile.lastName}"),
                  'TYPE_FORM_Column': PlutoCell(value: "Check Out"),
                  'DATE_Column': PlutoCell(value: dateAdded),
                },
              ),
            );
            if (issue.company == "CRY") {
              cry++;
              if (dateAdded.month == dateRange.end.month && dateAdded.isBefore(dateRange.end)) actualMonthEndCry++;
              if (dateAdded.month == (dateRange.end.month - 1) && dateAdded.isAfter(dateRange.start)) oneMonthAgoEndCry++;
              if (dateAdded.month == (dateRange.end.month - 2) && dateAdded.isAfter(dateRange.start)) twoMonthsAgoEndCry++;
              if (dateAdded.month == (dateRange.end.month - 3) && dateAdded.isAfter(dateRange.start)) threeMonthsAgoEndCry++;
              if (dateAdded.month == (dateRange.end.month - 4) && dateAdded.isAfter(dateRange.start)) fourMonthsAgoEndCry++;
              if (dateAdded.month == (dateRange.end.month - 5) && dateAdded.isAfter(dateRange.start)) fiveMonthsAgoEndCry++;
              if (dateAdded.month == (dateRange.end.month - 6) && dateAdded.isAfter(dateRange.start)) sixMonthsAgoEndCry++;
              if (dateAdded.month == (dateRange.end.month - 7) && dateAdded.isAfter(dateRange.start)) sevenMonthsAgoEndCry++;
              if (dateAdded.month == (dateRange.end.month - 8) && dateAdded.isAfter(dateRange.start)) eightMonthsAgoEndCry++;
              if (dateAdded.month == (dateRange.end.month - 9) && dateAdded.isAfter(dateRange.start)) nineMonthsAgoEndCry++;
              if (dateAdded.month == (dateRange.end.month - 10) && dateAdded.isAfter(dateRange.start)) tenMonthsAgoEndCry++;
              if (dateAdded.month == (dateRange.end.month - 11) && dateAdded.isAfter(dateRange.start)) elevenMonthsAgoEndCry++;
            }
            if (issue.company == "ODE") {
              ode++;
              if (dateAdded.month == dateRange.end.month && dateAdded.isBefore(dateRange.end)) actualMonthEndOde++;
              if (dateAdded.month == (dateRange.end.month - 1) && dateAdded.isAfter(dateRange.start)) oneMonthAgoEndOde++;
              if (dateAdded.month == (dateRange.end.month - 2) && dateAdded.isAfter(dateRange.start)) twoMonthsAgoEndOde++;
              if (dateAdded.month == (dateRange.end.month - 3) && dateAdded.isAfter(dateRange.start)) threeMonthsAgoEndOde++;
              if (dateAdded.month == (dateRange.end.month - 4) && dateAdded.isAfter(dateRange.start)) fourMonthsAgoEndOde++;
              if (dateAdded.month == (dateRange.end.month - 5) && dateAdded.isAfter(dateRange.start)) fiveMonthsAgoEndOde++;
              if (dateAdded.month == (dateRange.end.month - 6) && dateAdded.isAfter(dateRange.start)) sixMonthsAgoEndOde++;
              if (dateAdded.month == (dateRange.end.month - 7) && dateAdded.isAfter(dateRange.start)) sevenMonthsAgoEndOde++;
              if (dateAdded.month == (dateRange.end.month - 8) && dateAdded.isAfter(dateRange.start)) eightMonthsAgoEndOde++;
              if (dateAdded.month == (dateRange.end.month - 9) && dateAdded.isAfter(dateRange.start)) nineMonthsAgoEndOde++;
              if (dateAdded.month == (dateRange.end.month - 10) && dateAdded.isAfter(dateRange.start)) tenMonthsAgoEndOde++;
              if (dateAdded.month == (dateRange.end.month - 11) && dateAdded.isAfter(dateRange.start)) elevenMonthsAgoEndOde++;
            }
            if (issue.company == "SMI") {
              smi++;
              if (dateAdded.month == dateRange.end.month && dateAdded.isBefore(dateRange.end)) actualMonthEndSmi++;
              if (dateAdded.month == (dateRange.end.month - 1) && dateAdded.isAfter(dateRange.start)) oneMonthAgoEndSmi++;
              if (dateAdded.month == (dateRange.end.month - 2) && dateAdded.isAfter(dateRange.start)) twoMonthsAgoEndSmi++;
              if (dateAdded.month == (dateRange.end.month - 3) && dateAdded.isAfter(dateRange.start)) threeMonthsAgoEndSmi++;
              if (dateAdded.month == (dateRange.end.month - 4) && dateAdded.isAfter(dateRange.start)) fourMonthsAgoEndSmi++;
              if (dateAdded.month == (dateRange.end.month - 5) && dateAdded.isAfter(dateRange.start)) fiveMonthsAgoEndSmi++;
              if (dateAdded.month == (dateRange.end.month - 6) && dateAdded.isAfter(dateRange.start)) sixMonthsAgoEndSmi++;
              if (dateAdded.month == (dateRange.end.month - 7) && dateAdded.isAfter(dateRange.start)) sevenMonthsAgoEndSmi++;
              if (dateAdded.month == (dateRange.end.month - 8) && dateAdded.isAfter(dateRange.start)) eightMonthsAgoEndSmi++;
              if (dateAdded.month == (dateRange.end.month - 9) && dateAdded.isAfter(dateRange.start)) nineMonthsAgoEndSmi++;
              if (dateAdded.month == (dateRange.end.month - 10) && dateAdded.isAfter(dateRange.start)) tenMonthsAgoEndSmi++;
              if (dateAdded.month == (dateRange.end.month - 11) && dateAdded.isAfter(dateRange.start)) elevenMonthsAgoEndSmi++;
            }
          }
        });
        issue.fluidCheckD.toMap().forEach((key, value) {
          if (value == false) {
            String nameIssue = key.replaceAll("_", " ").capitalize;
            DateTime dateAdded = DateTime.parse(issue.fluidCheckD.toMap()["date_added"]);
            rows2.add(
              PlutoRow(
                cells: {
                  'COMPANY_Column': PlutoCell(value: issue.company),
                  'LICENSE_PLATES_Column': PlutoCell(value: issue.licensePlates),
                  'ISSUE_Column': PlutoCell(value: nameIssue),
                  'USER_Column': PlutoCell(value: "${issue.userProfile.name} ${issue.userProfile.lastName}"),
                  'TYPE_FORM_Column': PlutoCell(value: "Check In"),
                  'DATE_Column': PlutoCell(value: dateAdded),
                },
              ),
            );
            if (issue.company == "CRY") {
              cry++;
              if (dateAdded.month == dateRange.end.month && dateAdded.isBefore(dateRange.end)) actualMonthEndCry++;
              if (dateAdded.month == (dateRange.end.month - 1) && dateAdded.isAfter(dateRange.start)) oneMonthAgoEndCry++;
              if (dateAdded.month == (dateRange.end.month - 2) && dateAdded.isAfter(dateRange.start)) twoMonthsAgoEndCry++;
              if (dateAdded.month == (dateRange.end.month - 3) && dateAdded.isAfter(dateRange.start)) threeMonthsAgoEndCry++;
              if (dateAdded.month == (dateRange.end.month - 4) && dateAdded.isAfter(dateRange.start)) fourMonthsAgoEndCry++;
              if (dateAdded.month == (dateRange.end.month - 5) && dateAdded.isAfter(dateRange.start)) fiveMonthsAgoEndCry++;
              if (dateAdded.month == (dateRange.end.month - 6) && dateAdded.isAfter(dateRange.start)) sixMonthsAgoEndCry++;
              if (dateAdded.month == (dateRange.end.month - 7) && dateAdded.isAfter(dateRange.start)) sevenMonthsAgoEndCry++;
              if (dateAdded.month == (dateRange.end.month - 8) && dateAdded.isAfter(dateRange.start)) eightMonthsAgoEndCry++;
              if (dateAdded.month == (dateRange.end.month - 9) && dateAdded.isAfter(dateRange.start)) nineMonthsAgoEndCry++;
              if (dateAdded.month == (dateRange.end.month - 10) && dateAdded.isAfter(dateRange.start)) tenMonthsAgoEndCry++;
              if (dateAdded.month == (dateRange.end.month - 11) && dateAdded.isAfter(dateRange.start)) elevenMonthsAgoEndCry++;
            }
            if (issue.company == "ODE") {
              ode++;
              if (dateAdded.month == dateRange.end.month && dateAdded.isBefore(dateRange.end)) actualMonthEndOde++;
              if (dateAdded.month == (dateRange.end.month - 1) && dateAdded.isAfter(dateRange.start)) oneMonthAgoEndOde++;
              if (dateAdded.month == (dateRange.end.month - 2) && dateAdded.isAfter(dateRange.start)) twoMonthsAgoEndOde++;
              if (dateAdded.month == (dateRange.end.month - 3) && dateAdded.isAfter(dateRange.start)) threeMonthsAgoEndOde++;
              if (dateAdded.month == (dateRange.end.month - 4) && dateAdded.isAfter(dateRange.start)) fourMonthsAgoEndOde++;
              if (dateAdded.month == (dateRange.end.month - 5) && dateAdded.isAfter(dateRange.start)) fiveMonthsAgoEndOde++;
              if (dateAdded.month == (dateRange.end.month - 6) && dateAdded.isAfter(dateRange.start)) sixMonthsAgoEndOde++;
              if (dateAdded.month == (dateRange.end.month - 7) && dateAdded.isAfter(dateRange.start)) sevenMonthsAgoEndOde++;
              if (dateAdded.month == (dateRange.end.month - 8) && dateAdded.isAfter(dateRange.start)) eightMonthsAgoEndOde++;
              if (dateAdded.month == (dateRange.end.month - 9) && dateAdded.isAfter(dateRange.start)) nineMonthsAgoEndOde++;
              if (dateAdded.month == (dateRange.end.month - 10) && dateAdded.isAfter(dateRange.start)) tenMonthsAgoEndOde++;
              if (dateAdded.month == (dateRange.end.month - 11) && dateAdded.isAfter(dateRange.start)) elevenMonthsAgoEndOde++;
            }
            if (issue.company == "SMI") {
              smi++;
              if (dateAdded.month == dateRange.end.month && dateAdded.isBefore(dateRange.end)) actualMonthEndSmi++;
              if (dateAdded.month == (dateRange.end.month - 1) && dateAdded.isAfter(dateRange.start)) oneMonthAgoEndSmi++;
              if (dateAdded.month == (dateRange.end.month - 2) && dateAdded.isAfter(dateRange.start)) twoMonthsAgoEndSmi++;
              if (dateAdded.month == (dateRange.end.month - 3) && dateAdded.isAfter(dateRange.start)) threeMonthsAgoEndSmi++;
              if (dateAdded.month == (dateRange.end.month - 4) && dateAdded.isAfter(dateRange.start)) fourMonthsAgoEndSmi++;
              if (dateAdded.month == (dateRange.end.month - 5) && dateAdded.isAfter(dateRange.start)) fiveMonthsAgoEndSmi++;
              if (dateAdded.month == (dateRange.end.month - 6) && dateAdded.isAfter(dateRange.start)) sixMonthsAgoEndSmi++;
              if (dateAdded.month == (dateRange.end.month - 7) && dateAdded.isAfter(dateRange.start)) sevenMonthsAgoEndSmi++;
              if (dateAdded.month == (dateRange.end.month - 8) && dateAdded.isAfter(dateRange.start)) eightMonthsAgoEndSmi++;
              if (dateAdded.month == (dateRange.end.month - 9) && dateAdded.isAfter(dateRange.start)) nineMonthsAgoEndSmi++;
              if (dateAdded.month == (dateRange.end.month - 10) && dateAdded.isAfter(dateRange.start)) tenMonthsAgoEndSmi++;
              if (dateAdded.month == (dateRange.end.month - 11) && dateAdded.isAfter(dateRange.start)) elevenMonthsAgoEndSmi++;
            }
          }
        });
        // Lights
        issue.lightsR.toMap().forEach((key, value) {
          if (value == false) {
            String nameIssue = key.replaceAll("_", " ").capitalize;
            DateTime dateAdded = DateTime.parse(issue.lightsR.toMap()["date_added"]);
            rows2.add(
              PlutoRow(
                cells: {
                  'COMPANY_Column': PlutoCell(value: issue.company),
                  'LICENSE_PLATES_Column': PlutoCell(value: issue.licensePlates),
                  'ISSUE_Column': PlutoCell(value: nameIssue),
                  'USER_Column': PlutoCell(value: "${issue.userProfile.name} ${issue.userProfile.lastName}"),
                  'TYPE_FORM_Column': PlutoCell(value: "Check Out"),
                  'DATE_Column': PlutoCell(value: dateAdded),
                },
              ),
            );
            if (issue.company == "CRY") {
              cry++;
              if (dateAdded.month == dateRange.end.month && dateAdded.isBefore(dateRange.end)) actualMonthEndCry++;
              if (dateAdded.month == (dateRange.end.month - 1) && dateAdded.isAfter(dateRange.start)) oneMonthAgoEndCry++;
              if (dateAdded.month == (dateRange.end.month - 2) && dateAdded.isAfter(dateRange.start)) twoMonthsAgoEndCry++;
              if (dateAdded.month == (dateRange.end.month - 3) && dateAdded.isAfter(dateRange.start)) threeMonthsAgoEndCry++;
              if (dateAdded.month == (dateRange.end.month - 4) && dateAdded.isAfter(dateRange.start)) fourMonthsAgoEndCry++;
              if (dateAdded.month == (dateRange.end.month - 5) && dateAdded.isAfter(dateRange.start)) fiveMonthsAgoEndCry++;
              if (dateAdded.month == (dateRange.end.month - 6) && dateAdded.isAfter(dateRange.start)) sixMonthsAgoEndCry++;
              if (dateAdded.month == (dateRange.end.month - 7) && dateAdded.isAfter(dateRange.start)) sevenMonthsAgoEndCry++;
              if (dateAdded.month == (dateRange.end.month - 8) && dateAdded.isAfter(dateRange.start)) eightMonthsAgoEndCry++;
              if (dateAdded.month == (dateRange.end.month - 9) && dateAdded.isAfter(dateRange.start)) nineMonthsAgoEndCry++;
              if (dateAdded.month == (dateRange.end.month - 10) && dateAdded.isAfter(dateRange.start)) tenMonthsAgoEndCry++;
              if (dateAdded.month == (dateRange.end.month - 11) && dateAdded.isAfter(dateRange.start)) elevenMonthsAgoEndCry++;
            }
            if (issue.company == "ODE") {
              ode++;
              if (dateAdded.month == dateRange.end.month && dateAdded.isBefore(dateRange.end)) actualMonthEndOde++;
              if (dateAdded.month == (dateRange.end.month - 1) && dateAdded.isAfter(dateRange.start)) oneMonthAgoEndOde++;
              if (dateAdded.month == (dateRange.end.month - 2) && dateAdded.isAfter(dateRange.start)) twoMonthsAgoEndOde++;
              if (dateAdded.month == (dateRange.end.month - 3) && dateAdded.isAfter(dateRange.start)) threeMonthsAgoEndOde++;
              if (dateAdded.month == (dateRange.end.month - 4) && dateAdded.isAfter(dateRange.start)) fourMonthsAgoEndOde++;
              if (dateAdded.month == (dateRange.end.month - 5) && dateAdded.isAfter(dateRange.start)) fiveMonthsAgoEndOde++;
              if (dateAdded.month == (dateRange.end.month - 6) && dateAdded.isAfter(dateRange.start)) sixMonthsAgoEndOde++;
              if (dateAdded.month == (dateRange.end.month - 7) && dateAdded.isAfter(dateRange.start)) sevenMonthsAgoEndOde++;
              if (dateAdded.month == (dateRange.end.month - 8) && dateAdded.isAfter(dateRange.start)) eightMonthsAgoEndOde++;
              if (dateAdded.month == (dateRange.end.month - 9) && dateAdded.isAfter(dateRange.start)) nineMonthsAgoEndOde++;
              if (dateAdded.month == (dateRange.end.month - 10) && dateAdded.isAfter(dateRange.start)) tenMonthsAgoEndOde++;
              if (dateAdded.month == (dateRange.end.month - 11) && dateAdded.isAfter(dateRange.start)) elevenMonthsAgoEndOde++;
            }
            if (issue.company == "SMI") {
              smi++;
              if (dateAdded.month == dateRange.end.month && dateAdded.isBefore(dateRange.end)) actualMonthEndSmi++;
              if (dateAdded.month == (dateRange.end.month - 1) && dateAdded.isAfter(dateRange.start)) oneMonthAgoEndSmi++;
              if (dateAdded.month == (dateRange.end.month - 2) && dateAdded.isAfter(dateRange.start)) twoMonthsAgoEndSmi++;
              if (dateAdded.month == (dateRange.end.month - 3) && dateAdded.isAfter(dateRange.start)) threeMonthsAgoEndSmi++;
              if (dateAdded.month == (dateRange.end.month - 4) && dateAdded.isAfter(dateRange.start)) fourMonthsAgoEndSmi++;
              if (dateAdded.month == (dateRange.end.month - 5) && dateAdded.isAfter(dateRange.start)) fiveMonthsAgoEndSmi++;
              if (dateAdded.month == (dateRange.end.month - 6) && dateAdded.isAfter(dateRange.start)) sixMonthsAgoEndSmi++;
              if (dateAdded.month == (dateRange.end.month - 7) && dateAdded.isAfter(dateRange.start)) sevenMonthsAgoEndSmi++;
              if (dateAdded.month == (dateRange.end.month - 8) && dateAdded.isAfter(dateRange.start)) eightMonthsAgoEndSmi++;
              if (dateAdded.month == (dateRange.end.month - 9) && dateAdded.isAfter(dateRange.start)) nineMonthsAgoEndSmi++;
              if (dateAdded.month == (dateRange.end.month - 10) && dateAdded.isAfter(dateRange.start)) tenMonthsAgoEndSmi++;
              if (dateAdded.month == (dateRange.end.month - 11) && dateAdded.isAfter(dateRange.start)) elevenMonthsAgoEndSmi++;
            }
          }
        });
        issue.lightsD.toMap().forEach((key, value) {
          if (value == false) {
            String nameIssue = key.replaceAll("_", " ").capitalize;
            DateTime dateAdded = DateTime.parse(issue.lightsD.toMap()["date_added"]);
            rows2.add(
              PlutoRow(
                cells: {
                  'COMPANY_Column': PlutoCell(value: issue.company),
                  'LICENSE_PLATES_Column': PlutoCell(value: issue.licensePlates),
                  'ISSUE_Column': PlutoCell(value: nameIssue),
                  'USER_Column': PlutoCell(value: "${issue.userProfile.name} ${issue.userProfile.lastName}"),
                  'TYPE_FORM_Column': PlutoCell(value: "Check In"),
                  'DATE_Column': PlutoCell(value: dateAdded),
                },
              ),
            );
            if (issue.company == "CRY") {
              cry++;
              if (dateAdded.month == dateRange.end.month && dateAdded.isBefore(dateRange.end)) actualMonthEndCry++;
              if (dateAdded.month == (dateRange.end.month - 1) && dateAdded.isAfter(dateRange.start)) oneMonthAgoEndCry++;
              if (dateAdded.month == (dateRange.end.month - 2) && dateAdded.isAfter(dateRange.start)) twoMonthsAgoEndCry++;
              if (dateAdded.month == (dateRange.end.month - 3) && dateAdded.isAfter(dateRange.start)) threeMonthsAgoEndCry++;
              if (dateAdded.month == (dateRange.end.month - 4) && dateAdded.isAfter(dateRange.start)) fourMonthsAgoEndCry++;
              if (dateAdded.month == (dateRange.end.month - 5) && dateAdded.isAfter(dateRange.start)) fiveMonthsAgoEndCry++;
              if (dateAdded.month == (dateRange.end.month - 6) && dateAdded.isAfter(dateRange.start)) sixMonthsAgoEndCry++;
              if (dateAdded.month == (dateRange.end.month - 7) && dateAdded.isAfter(dateRange.start)) sevenMonthsAgoEndCry++;
              if (dateAdded.month == (dateRange.end.month - 8) && dateAdded.isAfter(dateRange.start)) eightMonthsAgoEndCry++;
              if (dateAdded.month == (dateRange.end.month - 9) && dateAdded.isAfter(dateRange.start)) nineMonthsAgoEndCry++;
              if (dateAdded.month == (dateRange.end.month - 10) && dateAdded.isAfter(dateRange.start)) tenMonthsAgoEndCry++;
              if (dateAdded.month == (dateRange.end.month - 11) && dateAdded.isAfter(dateRange.start)) elevenMonthsAgoEndCry++;
            }
            if (issue.company == "ODE") {
              ode++;
              if (dateAdded.month == dateRange.end.month && dateAdded.isBefore(dateRange.end)) actualMonthEndOde++;
              if (dateAdded.month == (dateRange.end.month - 1) && dateAdded.isAfter(dateRange.start)) oneMonthAgoEndOde++;
              if (dateAdded.month == (dateRange.end.month - 2) && dateAdded.isAfter(dateRange.start)) twoMonthsAgoEndOde++;
              if (dateAdded.month == (dateRange.end.month - 3) && dateAdded.isAfter(dateRange.start)) threeMonthsAgoEndOde++;
              if (dateAdded.month == (dateRange.end.month - 4) && dateAdded.isAfter(dateRange.start)) fourMonthsAgoEndOde++;
              if (dateAdded.month == (dateRange.end.month - 5) && dateAdded.isAfter(dateRange.start)) fiveMonthsAgoEndOde++;
              if (dateAdded.month == (dateRange.end.month - 6) && dateAdded.isAfter(dateRange.start)) sixMonthsAgoEndOde++;
              if (dateAdded.month == (dateRange.end.month - 7) && dateAdded.isAfter(dateRange.start)) sevenMonthsAgoEndOde++;
              if (dateAdded.month == (dateRange.end.month - 8) && dateAdded.isAfter(dateRange.start)) eightMonthsAgoEndOde++;
              if (dateAdded.month == (dateRange.end.month - 9) && dateAdded.isAfter(dateRange.start)) nineMonthsAgoEndOde++;
              if (dateAdded.month == (dateRange.end.month - 10) && dateAdded.isAfter(dateRange.start)) tenMonthsAgoEndOde++;
              if (dateAdded.month == (dateRange.end.month - 11) && dateAdded.isAfter(dateRange.start)) elevenMonthsAgoEndOde++;
            }
            if (issue.company == "SMI") {
              smi++;
              if (dateAdded.month == dateRange.end.month && dateAdded.isBefore(dateRange.end)) actualMonthEndSmi++;
              if (dateAdded.month == (dateRange.end.month - 1) && dateAdded.isAfter(dateRange.start)) oneMonthAgoEndSmi++;
              if (dateAdded.month == (dateRange.end.month - 2) && dateAdded.isAfter(dateRange.start)) twoMonthsAgoEndSmi++;
              if (dateAdded.month == (dateRange.end.month - 3) && dateAdded.isAfter(dateRange.start)) threeMonthsAgoEndSmi++;
              if (dateAdded.month == (dateRange.end.month - 4) && dateAdded.isAfter(dateRange.start)) fourMonthsAgoEndSmi++;
              if (dateAdded.month == (dateRange.end.month - 5) && dateAdded.isAfter(dateRange.start)) fiveMonthsAgoEndSmi++;
              if (dateAdded.month == (dateRange.end.month - 6) && dateAdded.isAfter(dateRange.start)) sixMonthsAgoEndSmi++;
              if (dateAdded.month == (dateRange.end.month - 7) && dateAdded.isAfter(dateRange.start)) sevenMonthsAgoEndSmi++;
              if (dateAdded.month == (dateRange.end.month - 8) && dateAdded.isAfter(dateRange.start)) eightMonthsAgoEndSmi++;
              if (dateAdded.month == (dateRange.end.month - 9) && dateAdded.isAfter(dateRange.start)) nineMonthsAgoEndSmi++;
              if (dateAdded.month == (dateRange.end.month - 10) && dateAdded.isAfter(dateRange.start)) tenMonthsAgoEndSmi++;
              if (dateAdded.month == (dateRange.end.month - 11) && dateAdded.isAfter(dateRange.start)) elevenMonthsAgoEndSmi++;
            }
          }
        });
        // Security
        issue.securityR.toMap().forEach((key, value) {
          if (value == false) {
            String nameIssue = key.replaceAll("_", " ").capitalize;
            DateTime dateAdded = DateTime.parse(issue.securityR.toMap()["date_added"]);
            rows2.add(
              PlutoRow(
                cells: {
                  'COMPANY_Column': PlutoCell(value: issue.company),
                  'LICENSE_PLATES_Column': PlutoCell(value: issue.licensePlates),
                  'ISSUE_Column': PlutoCell(value: nameIssue),
                  'USER_Column': PlutoCell(value: "${issue.userProfile.name} ${issue.userProfile.lastName}"),
                  'TYPE_FORM_Column': PlutoCell(value: "Check Out"),
                  'DATE_Column': PlutoCell(value: dateAdded),
                },
              ),
            );
            if (issue.company == "CRY") {
              cry++;
              if (dateAdded.month == dateRange.end.month && dateAdded.isBefore(dateRange.end)) actualMonthEndCry++;
              if (dateAdded.month == (dateRange.end.month - 1) && dateAdded.isAfter(dateRange.start)) oneMonthAgoEndCry++;
              if (dateAdded.month == (dateRange.end.month - 2) && dateAdded.isAfter(dateRange.start)) twoMonthsAgoEndCry++;
              if (dateAdded.month == (dateRange.end.month - 3) && dateAdded.isAfter(dateRange.start)) threeMonthsAgoEndCry++;
              if (dateAdded.month == (dateRange.end.month - 4) && dateAdded.isAfter(dateRange.start)) fourMonthsAgoEndCry++;
              if (dateAdded.month == (dateRange.end.month - 5) && dateAdded.isAfter(dateRange.start)) fiveMonthsAgoEndCry++;
              if (dateAdded.month == (dateRange.end.month - 6) && dateAdded.isAfter(dateRange.start)) sixMonthsAgoEndCry++;
              if (dateAdded.month == (dateRange.end.month - 7) && dateAdded.isAfter(dateRange.start)) sevenMonthsAgoEndCry++;
              if (dateAdded.month == (dateRange.end.month - 8) && dateAdded.isAfter(dateRange.start)) eightMonthsAgoEndCry++;
              if (dateAdded.month == (dateRange.end.month - 9) && dateAdded.isAfter(dateRange.start)) nineMonthsAgoEndCry++;
              if (dateAdded.month == (dateRange.end.month - 10) && dateAdded.isAfter(dateRange.start)) tenMonthsAgoEndCry++;
              if (dateAdded.month == (dateRange.end.month - 11) && dateAdded.isAfter(dateRange.start)) elevenMonthsAgoEndCry++;
            }
            if (issue.company == "ODE") {
              ode++;
              if (dateAdded.month == dateRange.end.month && dateAdded.isBefore(dateRange.end)) actualMonthEndOde++;
              if (dateAdded.month == (dateRange.end.month - 1) && dateAdded.isAfter(dateRange.start)) oneMonthAgoEndOde++;
              if (dateAdded.month == (dateRange.end.month - 2) && dateAdded.isAfter(dateRange.start)) twoMonthsAgoEndOde++;
              if (dateAdded.month == (dateRange.end.month - 3) && dateAdded.isAfter(dateRange.start)) threeMonthsAgoEndOde++;
              if (dateAdded.month == (dateRange.end.month - 4) && dateAdded.isAfter(dateRange.start)) fourMonthsAgoEndOde++;
              if (dateAdded.month == (dateRange.end.month - 5) && dateAdded.isAfter(dateRange.start)) fiveMonthsAgoEndOde++;
              if (dateAdded.month == (dateRange.end.month - 6) && dateAdded.isAfter(dateRange.start)) sixMonthsAgoEndOde++;
              if (dateAdded.month == (dateRange.end.month - 7) && dateAdded.isAfter(dateRange.start)) sevenMonthsAgoEndOde++;
              if (dateAdded.month == (dateRange.end.month - 8) && dateAdded.isAfter(dateRange.start)) eightMonthsAgoEndOde++;
              if (dateAdded.month == (dateRange.end.month - 9) && dateAdded.isAfter(dateRange.start)) nineMonthsAgoEndOde++;
              if (dateAdded.month == (dateRange.end.month - 10) && dateAdded.isAfter(dateRange.start)) tenMonthsAgoEndOde++;
              if (dateAdded.month == (dateRange.end.month - 11) && dateAdded.isAfter(dateRange.start)) elevenMonthsAgoEndOde++;
            }
            if (issue.company == "SMI") {
              smi++;
              if (dateAdded.month == dateRange.end.month && dateAdded.isBefore(dateRange.end)) actualMonthEndSmi++;
              if (dateAdded.month == (dateRange.end.month - 1) && dateAdded.isAfter(dateRange.start)) oneMonthAgoEndSmi++;
              if (dateAdded.month == (dateRange.end.month - 2) && dateAdded.isAfter(dateRange.start)) twoMonthsAgoEndSmi++;
              if (dateAdded.month == (dateRange.end.month - 3) && dateAdded.isAfter(dateRange.start)) threeMonthsAgoEndSmi++;
              if (dateAdded.month == (dateRange.end.month - 4) && dateAdded.isAfter(dateRange.start)) fourMonthsAgoEndSmi++;
              if (dateAdded.month == (dateRange.end.month - 5) && dateAdded.isAfter(dateRange.start)) fiveMonthsAgoEndSmi++;
              if (dateAdded.month == (dateRange.end.month - 6) && dateAdded.isAfter(dateRange.start)) sixMonthsAgoEndSmi++;
              if (dateAdded.month == (dateRange.end.month - 7) && dateAdded.isAfter(dateRange.start)) sevenMonthsAgoEndSmi++;
              if (dateAdded.month == (dateRange.end.month - 8) && dateAdded.isAfter(dateRange.start)) eightMonthsAgoEndSmi++;
              if (dateAdded.month == (dateRange.end.month - 9) && dateAdded.isAfter(dateRange.start)) nineMonthsAgoEndSmi++;
              if (dateAdded.month == (dateRange.end.month - 10) && dateAdded.isAfter(dateRange.start)) tenMonthsAgoEndSmi++;
              if (dateAdded.month == (dateRange.end.month - 11) && dateAdded.isAfter(dateRange.start)) elevenMonthsAgoEndSmi++;
            }
          }
        });
        issue.securityD.toMap().forEach((key, value) {
          if (value == false) {
            String nameIssue = key.replaceAll("_", " ").capitalize;
            DateTime dateAdded = DateTime.parse(issue.securityD.toMap()["date_added"]);
            rows2.add(
              PlutoRow(
                cells: {
                  'COMPANY_Column': PlutoCell(value: issue.company),
                  'LICENSE_PLATES_Column': PlutoCell(value: issue.licensePlates),
                  'ISSUE_Column': PlutoCell(value: nameIssue),
                  'USER_Column': PlutoCell(value: "${issue.userProfile.name} ${issue.userProfile.lastName}"),
                  'TYPE_FORM_Column': PlutoCell(value: "Check In"),
                  'DATE_Column': PlutoCell(value: dateAdded),
                },
              ),
            );
            if (issue.company == "CRY") {
              cry++;
              if (dateAdded.month == dateRange.end.month && dateAdded.isBefore(dateRange.end)) actualMonthEndCry++;
              if (dateAdded.month == (dateRange.end.month - 1) && dateAdded.isAfter(dateRange.start)) oneMonthAgoEndCry++;
              if (dateAdded.month == (dateRange.end.month - 2) && dateAdded.isAfter(dateRange.start)) twoMonthsAgoEndCry++;
              if (dateAdded.month == (dateRange.end.month - 3) && dateAdded.isAfter(dateRange.start)) threeMonthsAgoEndCry++;
              if (dateAdded.month == (dateRange.end.month - 4) && dateAdded.isAfter(dateRange.start)) fourMonthsAgoEndCry++;
              if (dateAdded.month == (dateRange.end.month - 5) && dateAdded.isAfter(dateRange.start)) fiveMonthsAgoEndCry++;
              if (dateAdded.month == (dateRange.end.month - 6) && dateAdded.isAfter(dateRange.start)) sixMonthsAgoEndCry++;
              if (dateAdded.month == (dateRange.end.month - 7) && dateAdded.isAfter(dateRange.start)) sevenMonthsAgoEndCry++;
              if (dateAdded.month == (dateRange.end.month - 8) && dateAdded.isAfter(dateRange.start)) eightMonthsAgoEndCry++;
              if (dateAdded.month == (dateRange.end.month - 9) && dateAdded.isAfter(dateRange.start)) nineMonthsAgoEndCry++;
              if (dateAdded.month == (dateRange.end.month - 10) && dateAdded.isAfter(dateRange.start)) tenMonthsAgoEndCry++;
              if (dateAdded.month == (dateRange.end.month - 11) && dateAdded.isAfter(dateRange.start)) elevenMonthsAgoEndCry++;
            }
            if (issue.company == "ODE") {
              ode++;
              if (dateAdded.month == dateRange.end.month && dateAdded.isBefore(dateRange.end)) actualMonthEndOde++;
              if (dateAdded.month == (dateRange.end.month - 1) && dateAdded.isAfter(dateRange.start)) oneMonthAgoEndOde++;
              if (dateAdded.month == (dateRange.end.month - 2) && dateAdded.isAfter(dateRange.start)) twoMonthsAgoEndOde++;
              if (dateAdded.month == (dateRange.end.month - 3) && dateAdded.isAfter(dateRange.start)) threeMonthsAgoEndOde++;
              if (dateAdded.month == (dateRange.end.month - 4) && dateAdded.isAfter(dateRange.start)) fourMonthsAgoEndOde++;
              if (dateAdded.month == (dateRange.end.month - 5) && dateAdded.isAfter(dateRange.start)) fiveMonthsAgoEndOde++;
              if (dateAdded.month == (dateRange.end.month - 6) && dateAdded.isAfter(dateRange.start)) sixMonthsAgoEndOde++;
              if (dateAdded.month == (dateRange.end.month - 7) && dateAdded.isAfter(dateRange.start)) sevenMonthsAgoEndOde++;
              if (dateAdded.month == (dateRange.end.month - 8) && dateAdded.isAfter(dateRange.start)) eightMonthsAgoEndOde++;
              if (dateAdded.month == (dateRange.end.month - 9) && dateAdded.isAfter(dateRange.start)) nineMonthsAgoEndOde++;
              if (dateAdded.month == (dateRange.end.month - 10) && dateAdded.isAfter(dateRange.start)) tenMonthsAgoEndOde++;
              if (dateAdded.month == (dateRange.end.month - 11) && dateAdded.isAfter(dateRange.start)) elevenMonthsAgoEndOde++;
            }
            if (issue.company == "SMI") {
              smi++;
              if (dateAdded.month == dateRange.end.month && dateAdded.isBefore(dateRange.end)) actualMonthEndSmi++;
              if (dateAdded.month == (dateRange.end.month - 1) && dateAdded.isAfter(dateRange.start)) oneMonthAgoEndSmi++;
              if (dateAdded.month == (dateRange.end.month - 2) && dateAdded.isAfter(dateRange.start)) twoMonthsAgoEndSmi++;
              if (dateAdded.month == (dateRange.end.month - 3) && dateAdded.isAfter(dateRange.start)) threeMonthsAgoEndSmi++;
              if (dateAdded.month == (dateRange.end.month - 4) && dateAdded.isAfter(dateRange.start)) fourMonthsAgoEndSmi++;
              if (dateAdded.month == (dateRange.end.month - 5) && dateAdded.isAfter(dateRange.start)) fiveMonthsAgoEndSmi++;
              if (dateAdded.month == (dateRange.end.month - 6) && dateAdded.isAfter(dateRange.start)) sixMonthsAgoEndSmi++;
              if (dateAdded.month == (dateRange.end.month - 7) && dateAdded.isAfter(dateRange.start)) sevenMonthsAgoEndSmi++;
              if (dateAdded.month == (dateRange.end.month - 8) && dateAdded.isAfter(dateRange.start)) eightMonthsAgoEndSmi++;
              if (dateAdded.month == (dateRange.end.month - 9) && dateAdded.isAfter(dateRange.start)) nineMonthsAgoEndSmi++;
              if (dateAdded.month == (dateRange.end.month - 10) && dateAdded.isAfter(dateRange.start)) tenMonthsAgoEndSmi++;
              if (dateAdded.month == (dateRange.end.month - 11) && dateAdded.isAfter(dateRange.start)) elevenMonthsAgoEndSmi++;
            }
          }
        });
      }

      if (stateManager != null) stateManager!.notifyListeners();

      // await getX2CRMQuotes();
    } catch (e) {
      log('Error en getIssues() - $e');
    }

    notifyListeners();
  }

  Future<void> getVehicles() async {
    if (stateManager != null) {
      stateManager!.setShowLoading(true);
      notifyListeners();
    }
    try {
      vehiclesCRY = 0;
      vehiclesODE = 0;
      vehiclesSMI = 0;
      List<dynamic>? resCRY;
      List<dynamic>? resODE;
      List<dynamic>? resSMI;

      //Se recupera el Id de CRY
      resCRY = await supabase.from('company').select().eq('company', 'CRY').select<PostgrestList>('id_company');
      //Se recupera el Id de CRY
      resODE = await supabase.from('company').select().eq('company', 'ODE').select<PostgrestList>('id_company');
      //Se recupera el Id de SMI
      resSMI = await supabase.from('company').select().eq('company', 'SMI').select<PostgrestList>('id_company');

      if (resCRY.isNotEmpty) {
        vehiclesCRY = await supabaseCtrlV.from('vehicle').select().eq('id_company_fk', resCRY.first['id_company']).select<PostgrestList>('id_vehicle').then((value) {
          return value.toList().length;
        });
      }

      if (resODE.isNotEmpty) {
        vehiclesODE = await supabaseCtrlV.from('vehicle').select().eq('id_company_fk', resODE.first['id_company']).select<PostgrestList>('id_vehicle').then((value) {
          return value.toList().length;
        });
      }

      if (resSMI.isNotEmpty) {
        vehiclesSMI = await supabaseCtrlV.from('vehicle').select().eq('id_company_fk', resSMI.first['id_company']).select<PostgrestList>('id_vehicle').then((value) {
          return value.toList().length;
        });
      }

      if (stateManager != null) stateManager!.notifyListeners();
    } catch (e) {
      log('Error en getVehicles() - $e');
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
              toY: elevenMonthsAgoEndCry,
              color: azul,
              rodStackItems: [
                BarChartRodStackItem(0, elevenMonthsAgoEndCry, azul),
              ],
              borderRadius: const BorderRadius.all(Radius.zero)),
          BarChartRodData(
              width: 20,
              toY: elevenMonthsAgoEndOde,
              color: rojo,
              rodStackItems: [
                BarChartRodStackItem(0, elevenMonthsAgoEndOde, rojo),
              ],
              borderRadius: const BorderRadius.all(Radius.zero)),
          BarChartRodData(
            width: 20,
            toY: elevenMonthsAgoEndSmi,
            color: naranja,
            rodStackItems: [
              BarChartRodStackItem(0, elevenMonthsAgoEndSmi, naranja),
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
              toY: tenMonthsAgoEndCry,
              color: azul,
              rodStackItems: [
                BarChartRodStackItem(0, tenMonthsAgoEndCry, azul),
              ],
              borderRadius: const BorderRadius.all(Radius.zero)),
          BarChartRodData(
              width: 20,
              toY: tenMonthsAgoEndOde,
              color: rojo,
              rodStackItems: [
                BarChartRodStackItem(0, tenMonthsAgoEndOde, rojo),
              ],
              borderRadius: const BorderRadius.all(Radius.zero)),
          BarChartRodData(
            width: 20,
            toY: tenMonthsAgoEndSmi,
            color: naranja,
            rodStackItems: [
              BarChartRodStackItem(0, tenMonthsAgoEndSmi, naranja),
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
              toY: nineMonthsAgoEndCry,
              color: azul,
              rodStackItems: [
                BarChartRodStackItem(0, nineMonthsAgoEndCry, azul),
              ],
              borderRadius: const BorderRadius.all(Radius.zero)),
          BarChartRodData(
              width: 20,
              toY: nineMonthsAgoEndOde,
              color: rojo,
              rodStackItems: [
                BarChartRodStackItem(0, nineMonthsAgoEndOde, rojo),
              ],
              borderRadius: const BorderRadius.all(Radius.zero)),
          BarChartRodData(
            width: 20,
            toY: nineMonthsAgoEndSmi,
            color: naranja,
            rodStackItems: [
              BarChartRodStackItem(0, nineMonthsAgoEndSmi, naranja),
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
              toY: eightMonthsAgoEndCry,
              color: azul,
              rodStackItems: [
                BarChartRodStackItem(0, eightMonthsAgoEndCry, azul),
              ],
              borderRadius: const BorderRadius.all(Radius.zero)),
          BarChartRodData(
              width: 20,
              toY: eightMonthsAgoEndOde,
              color: rojo,
              rodStackItems: [
                BarChartRodStackItem(0, eightMonthsAgoEndOde, rojo),
              ],
              borderRadius: const BorderRadius.all(Radius.zero)),
          BarChartRodData(
            width: 20,
            toY: eightMonthsAgoEndSmi,
            color: naranja,
            rodStackItems: [
              BarChartRodStackItem(0, eightMonthsAgoEndSmi, naranja),
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
              toY: sevenMonthsAgoEndCry,
              color: azul,
              rodStackItems: [
                BarChartRodStackItem(0, sevenMonthsAgoEndCry, azul),
              ],
              borderRadius: const BorderRadius.all(Radius.zero)),
          BarChartRodData(
              width: 20,
              toY: sevenMonthsAgoEndOde,
              color: rojo,
              rodStackItems: [
                BarChartRodStackItem(0, sevenMonthsAgoEndOde, rojo),
              ],
              borderRadius: const BorderRadius.all(Radius.zero)),
          BarChartRodData(
            width: 20,
            toY: sevenMonthsAgoEndSmi,
            color: naranja,
            rodStackItems: [
              BarChartRodStackItem(0, sevenMonthsAgoEndSmi, naranja),
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
              toY: sixMonthsAgoEndCry,
              color: azul,
              rodStackItems: [
                BarChartRodStackItem(0, sixMonthsAgoEndCry, azul),
              ],
              borderRadius: const BorderRadius.all(Radius.zero)),
          BarChartRodData(
              width: 20,
              toY: sixMonthsAgoEndOde,
              color: rojo,
              rodStackItems: [
                BarChartRodStackItem(0, sixMonthsAgoEndOde, rojo),
              ],
              borderRadius: const BorderRadius.all(Radius.zero)),
          BarChartRodData(
            width: 20,
            toY: sixMonthsAgoEndSmi,
            color: naranja,
            rodStackItems: [
              BarChartRodStackItem(0, sixMonthsAgoEndSmi, naranja),
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
              toY: fiveMonthsAgoEndCry,
              color: azul,
              rodStackItems: [
                BarChartRodStackItem(0, fiveMonthsAgoEndCry, azul),
              ],
              borderRadius: const BorderRadius.all(Radius.zero)),
          BarChartRodData(
              width: 20,
              toY: fiveMonthsAgoEndOde,
              color: rojo,
              rodStackItems: [
                BarChartRodStackItem(0, fiveMonthsAgoEndOde, rojo),
              ],
              borderRadius: const BorderRadius.all(Radius.zero)),
          BarChartRodData(
            width: 20,
            toY: fiveMonthsAgoEndSmi,
            color: naranja,
            rodStackItems: [
              BarChartRodStackItem(0, fiveMonthsAgoEndSmi, naranja),
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
              toY: fourMonthsAgoEndCry,
              color: azul,
              rodStackItems: [
                BarChartRodStackItem(0, fourMonthsAgoEndCry, azul),
              ],
              borderRadius: const BorderRadius.all(Radius.zero)),
          BarChartRodData(
              width: 20,
              toY: fourMonthsAgoEndOde,
              color: rojo,
              rodStackItems: [
                BarChartRodStackItem(0, fourMonthsAgoEndOde, rojo),
              ],
              borderRadius: const BorderRadius.all(Radius.zero)),
          BarChartRodData(
            width: 20,
            toY: fourMonthsAgoEndSmi,
            color: naranja,
            rodStackItems: [
              BarChartRodStackItem(0, fourMonthsAgoEndSmi, naranja),
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
              toY: threeMonthsAgoEndCry,
              color: azul,
              rodStackItems: [
                BarChartRodStackItem(0, threeMonthsAgoEndCry, azul),
              ],
              borderRadius: const BorderRadius.all(Radius.zero)),
          BarChartRodData(
              width: 20,
              toY: threeMonthsAgoEndOde,
              color: rojo,
              rodStackItems: [
                BarChartRodStackItem(0, threeMonthsAgoEndOde, rojo),
              ],
              borderRadius: const BorderRadius.all(Radius.zero)),
          BarChartRodData(
            width: 20,
            toY: threeMonthsAgoEndSmi,
            color: naranja,
            rodStackItems: [
              BarChartRodStackItem(0, threeMonthsAgoEndSmi, naranja),
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
              toY: twoMonthsAgoEndCry,
              color: azul,
              rodStackItems: [
                BarChartRodStackItem(0, twoMonthsAgoEndCry, azul),
              ],
              borderRadius: const BorderRadius.all(Radius.zero)),
          BarChartRodData(
              width: 20,
              toY: twoMonthsAgoEndOde,
              color: rojo,
              rodStackItems: [
                BarChartRodStackItem(0, twoMonthsAgoEndOde, rojo),
              ],
              borderRadius: const BorderRadius.all(Radius.zero)),
          BarChartRodData(
            width: 20,
            toY: twoMonthsAgoEndSmi,
            color: naranja,
            rodStackItems: [
              BarChartRodStackItem(0, twoMonthsAgoEndSmi, naranja),
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
              toY: oneMonthAgoEndCry,
              color: azul,
              rodStackItems: [
                BarChartRodStackItem(0, oneMonthAgoEndCry, azul),
              ],
              borderRadius: const BorderRadius.all(Radius.zero)),
          BarChartRodData(
              width: 20,
              toY: oneMonthAgoEndOde,
              color: rojo,
              rodStackItems: [
                BarChartRodStackItem(0, 2, rojo),
              ],
              borderRadius: const BorderRadius.all(Radius.zero)),
          BarChartRodData(
            width: 20,
            toY: oneMonthAgoEndSmi,
            color: naranja,
            rodStackItems: [
              BarChartRodStackItem(0, oneMonthAgoEndSmi, naranja),
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
              toY: actualMonthEndCry,
              color: azul,
              rodStackItems: [
                BarChartRodStackItem(0, actualMonthEndCry, azul),
              ],
              borderRadius: const BorderRadius.all(Radius.zero)),
          BarChartRodData(
              width: 20,
              toY: actualMonthEndOde,
              color: rojo,
              rodStackItems: [
                BarChartRodStackItem(0, actualMonthEndOde, rojo),
              ],
              borderRadius: const BorderRadius.all(Radius.zero)),
          BarChartRodData(
            width: 20,
            toY: actualMonthEndSmi,
            color: naranja,
            rodStackItems: [
              BarChartRodStackItem(0, actualMonthEndSmi, naranja),
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
        FlSpot(0, elevenMonthsAgoEndCry + elevenMonthsAgoEndOde + elevenMonthsAgoEndSmi),
        FlSpot(1, tenMonthsAgoEndCry + tenMonthsAgoEndOde + tenMonthsAgoEndSmi),
        FlSpot(2, nineMonthsAgoEndCry + nineMonthsAgoEndOde + nineMonthsAgoEndSmi),
        FlSpot(3, eightMonthsAgoEndCry + eightMonthsAgoEndOde + eightMonthsAgoEndSmi),
        FlSpot(4, sevenMonthsAgoEndCry + sevenMonthsAgoEndOde + sevenMonthsAgoEndSmi),
        FlSpot(5, sixMonthsAgoEndCry + sixMonthsAgoEndOde + sixMonthsAgoEndSmi),
        FlSpot(6, fiveMonthsAgoEndCry + fiveMonthsAgoEndOde + fiveMonthsAgoEndSmi),
        FlSpot(7, fourMonthsAgoEndCry + fourMonthsAgoEndOde + fourMonthsAgoEndSmi),
        FlSpot(8, threeMonthsAgoEndCry + threeMonthsAgoEndOde + threeMonthsAgoEndSmi),
        FlSpot(9, twoMonthsAgoEndCry + twoMonthsAgoEndOde + twoMonthsAgoEndSmi),
        FlSpot(10, oneMonthAgoEndCry + oneMonthAgoEndOde + oneMonthAgoEndSmi),
        FlSpot(11, actualMonthEndCry + actualMonthEndOde + actualMonthEndSmi),
      ],
      isCurved: false,
      barWidth: 5,
      color: color,
      dotData: FlDotData(
        show: true,
      ),
    );
  }

  LineChartBarData getCRY() {
    return LineChartBarData(
      spots: [
        FlSpot(0, elevenMonthsAgoEndCry),
        FlSpot(1, tenMonthsAgoEndCry),
        FlSpot(2, nineMonthsAgoEndCry),
        FlSpot(3, eightMonthsAgoEndCry),
        FlSpot(4, sevenMonthsAgoEndCry),
        FlSpot(5, sixMonthsAgoEndCry),
        FlSpot(6, fiveMonthsAgoEndCry),
        FlSpot(7, fourMonthsAgoEndCry),
        FlSpot(8, threeMonthsAgoEndCry),
        FlSpot(9, twoMonthsAgoEndCry),
        FlSpot(10, oneMonthAgoEndCry),
        FlSpot(11, actualMonthEndCry),
      ],
      isCurved: false,
      barWidth: 5,
      color: azul,
      dotData: FlDotData(
        show: true,
      ),
    );
  }

  LineChartBarData getODE() {
    return LineChartBarData(
      spots: [
        FlSpot(0, elevenMonthsAgoEndOde),
        FlSpot(1, tenMonthsAgoEndOde),
        FlSpot(2, nineMonthsAgoEndOde),
        FlSpot(3, eightMonthsAgoEndOde),
        FlSpot(4, sevenMonthsAgoEndOde),
        FlSpot(5, sixMonthsAgoEndOde),
        FlSpot(6, fiveMonthsAgoEndOde),
        FlSpot(7, fourMonthsAgoEndOde),
        FlSpot(8, threeMonthsAgoEndOde),
        FlSpot(9, twoMonthsAgoEndOde),
        FlSpot(10, oneMonthAgoEndOde),
        FlSpot(11, actualMonthEndOde),
      ],
      isCurved: false,
      barWidth: 5,
      color: rojo,
      dotData: FlDotData(
        show: true,
      ),
    );
  }

  LineChartBarData getSMI() {
    return LineChartBarData(
      spots: [
        FlSpot(0, elevenMonthsAgoEndSmi),
        FlSpot(1, tenMonthsAgoEndSmi),
        FlSpot(2, nineMonthsAgoEndSmi),
        FlSpot(3, eightMonthsAgoEndSmi),
        FlSpot(4, sevenMonthsAgoEndSmi),
        FlSpot(5, sixMonthsAgoEndSmi),
        FlSpot(6, fiveMonthsAgoEndSmi),
        FlSpot(7, fourMonthsAgoEndSmi),
        FlSpot(8, threeMonthsAgoEndSmi),
        FlSpot(9, twoMonthsAgoEndSmi),
        FlSpot(10, oneMonthAgoEndSmi),
        FlSpot(11, actualMonthEndSmi),
      ],
      isCurved: false,
      barWidth: 5,
      color: naranja,
      dotData: FlDotData(
        show: true,
      ),
    );
  }

  //pie chart

  List<PieChartSectionData> showingSections() {
    double pcry = (cry / (cry + ode + smi)) * 100, pode = (ode / (cry + ode + smi)) * 100, psmi = (smi / (cry + ode + smi)) * 100;
    String rcry = pcry.toStringAsFixed(2), rode = pode.toStringAsFixed(2), rsmi = psmi.toStringAsFixed(2);
    double dcry = double.parse(rcry), dode = double.parse(rode), dsmi = double.parse(rsmi);
    return List.generate(3, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 25.0 : 15.0;
      final radius = isTouched ? 100.0 : 75.0;
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: azul,
            value: dcry,
            title: '$cry\n$dcry%',
            radius: radius,
            titleStyle: TextStyle(fontFamily: 'UniNeue', fontSize: fontSize, fontWeight: FontWeight.bold, color: const Color(0xffffffff)),
          );
        case 1:
          return PieChartSectionData(
            color: rojo,
            value: dode,
            title: '$ode\n$dode%',
            radius: radius,
            titleStyle: TextStyle(fontFamily: 'UniNeue', fontSize: fontSize, fontWeight: FontWeight.bold, color: const Color(0xffffffff)),
          );
        case 2:
          return PieChartSectionData(
            color: naranja,
            value: dsmi,
            title: '$smi\n$dsmi%',
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
