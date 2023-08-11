import 'dart:convert';
import 'dart:developer';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart' hide State;
import 'package:pluto_grid/pluto_grid.dart';
import 'package:rta_crm_cv/helpers/globals.dart';
import 'package:rta_crm_cv/models/accounts/quotes_model.dart';
import 'package:rta_crm_cv/models/issues_dashboards.dart';
import 'package:rta_crm_cv/models/leads_history.dart';

import 'package:rta_crm_cv/models/x2crm/x2crm_quote_model.dart';
import 'package:rta_crm_cv/theme/theme.dart';

class DashboardCVProvider extends ChangeNotifier {
  final searchController = TextEditingController();
  List<PlutoRow> rows = [], rows2 = [];
  List<Quotes> quotess = [];
  List<IssuesDashboards> issuesDashboards = [];
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

  Color azul = const Color(0xFF2E5899), rojo = const Color(0xFFD20030), naranja = const Color.fromRGBO(255, 138, 0, 1);
  double cry = 0, ode = 0, smi = 0;
  //Radianes grafica barra
  /* LinearGradient get gradientRoja => LinearGradient(
        colors: [
          Colors.rojo.shade900,
          Colors.rojo,
          Colors.rojo.shade100,
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
  DashboardCVProvider() {
    touchedValue = -1;
    updateState();
    clearAll();
  }
  var titleGroup = AutoSizeGroup();
  Future<void> updateState() async {
    await getHistory();
    await getIssues(null);
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
    getIssues(null);
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
  // Future<void> getX2CRMQuotes() async {
  //   var headers = {
  //     'Authorization': 'Basic YWxleGM6NW1saDM5UjhQUVc4WnI3TzhDcGlPSDJvZE1xaGtFOE8=',
  //     //'Cookie': 'PHPSESSID=u3lgismtbbamh7g3k6b8dqteuk; YII_CSRF_TOKEN=Z2VybTVsZERNcV9faDVSUlE1VFRZeHk3WmNUWmRiSEMSMv7x7artFlmFwAp6GLyf7Qsi4oYOGXtsrcYz02xGJg%3D%3D'
  //   };
  //   var request = http.Request('GET', Uri.parse('http://34.130.182.108/X2CRM-master/x2engine/index.php/api2/Quotes'));

  //   request.headers.addAll(headers);

  //   http.StreamedResponse response = await request.send();

  //   if (response.statusCode == 200) {
  //     x2crmQuotes.clear();

  //     var res = jsonDecode(await response.stream.bytesToString());

  //     x2crmQuotes = (res as List<dynamic>).map((quote) => X2CrmQuote.fromJson(jsonEncode(quote))).toList();
  //   } else {
  //     log(response.reasonPhrase.toString());
  //   }
  // }

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
      for (IssuesDashboards issue in issuesDashboards) {
        // Bucket Inspection
        issue.bucketInspectionR.toMap().forEach((key, value) {
          if (value == false) {
            String nameIssue = key.replaceAll("_", " ").capitalize;
            DateTime dateAdded =
                DateTime.parse(issue.bucketInspectionR.toMap()["date_added"]);
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
            if (issue.company == "CRY") cry++;
            if (issue.company == "ODE") ode++;
            if (issue.company == "SMI") smi++;
          }
        });
        issue.bucketInspectionD.toMap().forEach((key, value) {
          if (value == false) {
            String nameIssue = key.replaceAll("_", " ").capitalize;
            DateTime dateAdded =
                DateTime.parse(issue.bucketInspectionD.toMap()["date_added"]);
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
            if (issue.company == "CRY") cry++;
            if (issue.company == "ODE") ode++;
            if (issue.company == "SMI") smi++;
          }
        });
        // Car Bodywork
        issue.carBodyworkR.toMap().forEach((key, value) {
          if (value == false) {
            String nameIssue = key.replaceAll("_", " ").capitalize;
            DateTime dateAdded =
                DateTime.parse(issue.carBodyworkR.toMap()["date_added"]);
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
            if (issue.company == "CRY") cry++;
            if (issue.company == "ODE") ode++;
            if (issue.company == "SMI") smi++;
          }
        });
        issue.carBodyworkD.toMap().forEach((key, value) {
          if (value == false) {
            String nameIssue = key.replaceAll("_", " ").capitalize;
            DateTime dateAdded =
                DateTime.parse(issue.carBodyworkD.toMap()["date_added"]);
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
            if (issue.company == "CRY") cry++;
            if (issue.company == "ODE") ode++;
            if (issue.company == "SMI") smi++;
          }
        });
        // Equipment
        issue.equipmentR.toMap().forEach((key, value) {
          if (value == false) {
            String nameIssue = key.replaceAll("_", " ").capitalize;
            DateTime dateAdded =
                DateTime.parse(issue.equipmentR.toMap()["date_added"]);
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
            if (issue.company == "CRY") cry++;
            if (issue.company == "ODE") ode++;
            if (issue.company == "SMI") smi++;
          }
        });
        issue.equipmentD.toMap().forEach((key, value) {
          if (value == false) {
            String nameIssue = key.replaceAll("_", " ").capitalize;
            DateTime dateAdded =
                DateTime.parse(issue.equipmentD.toMap()["date_added"]);
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
            if (issue.company == "CRY") cry++;
            if (issue.company == "ODE") ode++;
            if (issue.company == "SMI") smi++;
          }
        });
        // Extra
        issue.extraR.toMap().forEach((key, value) {
          if (value == false) {
            String nameIssue = key.replaceAll("_", " ").capitalize;
            DateTime dateAdded =
                DateTime.parse(issue.extraR.toMap()["date_added"]);
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
            if (issue.company == "CRY") cry++;
            if (issue.company == "ODE") ode++;
            if (issue.company == "SMI") smi++;
          }
        });
        issue.extraD.toMap().forEach((key, value) {
          if (value == false) {
            String nameIssue = key.replaceAll("_", " ").capitalize;
            DateTime dateAdded =
                DateTime.parse(issue.extraD.toMap()["date_added"]);
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
            if (issue.company == "CRY") cry++;
            if (issue.company == "ODE") ode++;
            if (issue.company == "SMI") smi++;
          }
        });
        // Fluid Check
        issue.fluidCheckR.toMap().forEach((key, value) {
          if (value == false) {
            String nameIssue = key.replaceAll("_", " ").capitalize;
            DateTime dateAdded =
                DateTime.parse(issue.fluidCheckR.toMap()["date_added"]);
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
            if (issue.company == "CRY") cry++;
            if (issue.company == "ODE") ode++;
            if (issue.company == "SMI") smi++;
          }
        });
        issue.fluidCheckD.toMap().forEach((key, value) {
          if (value == false) {
            String nameIssue = key.replaceAll("_", " ").capitalize;
            DateTime dateAdded =
                DateTime.parse(issue.fluidCheckD.toMap()["date_added"]);
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
            if (issue.company == "CRY") cry++;
            if (issue.company == "ODE") ode++;
            if (issue.company == "SMI") smi++;
          }
        });
        // Lights
        issue.lightsR.toMap().forEach((key, value) {
          if (value == false) {
            String nameIssue = key.replaceAll("_", " ").capitalize;
            DateTime dateAdded =
                DateTime.parse(issue.lightsR.toMap()["date_added"]);
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
            if (issue.company == "CRY") cry++;
            if (issue.company == "ODE") ode++;
            if (issue.company == "SMI") smi++;
          }
        });
        issue.lightsD.toMap().forEach((key, value) {
          if (value == false) {
            String nameIssue = key.replaceAll("_", " ").capitalize;
            DateTime dateAdded =
                DateTime.parse(issue.lightsD.toMap()["date_added"]);
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
            if (issue.company == "CRY") cry++;
            if (issue.company == "ODE") ode++;
            if (issue.company == "SMI") smi++;
          }
        });
        // Security
        issue.securityR.toMap().forEach((key, value) {
          if (value == false) {
            String nameIssue = key.replaceAll("_", " ").capitalize;
            DateTime dateAdded =
                DateTime.parse(issue.securityR.toMap()["date_added"]);
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
            if (issue.company == "CRY") cry++;
            if (issue.company == "ODE") ode++;
            if (issue.company == "SMI") smi++;
          }
        });
        issue.securityD.toMap().forEach((key, value) {
          if (value == false) {
            String nameIssue = key.replaceAll("_", " ").capitalize;
            DateTime dateAdded =
                DateTime.parse(issue.securityD.toMap()["date_added"]);
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
            if (issue.company == "CRY") cry++;
            if (issue.company == "ODE") ode++;
            if (issue.company == "SMI") smi++;
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
              toY: 10,
              color: azul,
              rodStackItems: [
                BarChartRodStackItem(0, 10, azul),
              ],
              borderRadius: const BorderRadius.all(Radius.zero)),
          BarChartRodData(
              width: 20,
              toY: 1,
              color: rojo,
              rodStackItems: [
                BarChartRodStackItem(0, 1, rojo),
              ],
              borderRadius: const BorderRadius.all(Radius.zero)),
          BarChartRodData(
            width: 20,
            toY: 1,
            color: naranja,
            rodStackItems: [
              BarChartRodStackItem(0, 1, naranja),
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
              toY: 7,
              color: azul,
              rodStackItems: [
                BarChartRodStackItem(0, 7, azul),
              ],
              borderRadius: const BorderRadius.all(Radius.zero)),
          BarChartRodData(
              width: 20,
              toY: 1,
              color: rojo,
              rodStackItems: [
                BarChartRodStackItem(0, 1, rojo),
              ],
              borderRadius: const BorderRadius.all(Radius.zero)),
          BarChartRodData(
            width: 20,
            toY: 5,
            color: naranja,
            rodStackItems: [
              BarChartRodStackItem(0, 5, naranja),
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
              toY: 1,
              color: azul,
              rodStackItems: [
                BarChartRodStackItem(0, 1, azul),
              ],
              borderRadius: const BorderRadius.all(Radius.zero)),
          BarChartRodData(
              width: 20,
              toY: 2,
              color: rojo,
              rodStackItems: [
                BarChartRodStackItem(0, 2, rojo),
              ],
              borderRadius: const BorderRadius.all(Radius.zero)),
          BarChartRodData(
            width: 20,
            toY: 1,
            color: naranja,
            rodStackItems: [
              BarChartRodStackItem(0, 1, naranja),
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
              toY: 2,
              color: azul,
              rodStackItems: [
                BarChartRodStackItem(0, 2, azul),
              ],
              borderRadius: const BorderRadius.all(Radius.zero)),
          BarChartRodData(
              width: 20,
              toY: 0,
              color: rojo,
              rodStackItems: [
                BarChartRodStackItem(0, 0, rojo),
              ],
              borderRadius: const BorderRadius.all(Radius.zero)),
          BarChartRodData(
            width: 20,
            toY: 0,
            color: naranja,
            rodStackItems: [
              BarChartRodStackItem(0, 0, naranja),
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
              toY: 11,
              color: azul,
              rodStackItems: [
                BarChartRodStackItem(0, 11, azul),
              ],
              borderRadius: const BorderRadius.all(Radius.zero)),
          BarChartRodData(
              width: 20,
              toY: 4,
              color: rojo,
              rodStackItems: [
                BarChartRodStackItem(0, 4, rojo),
              ],
              borderRadius: const BorderRadius.all(Radius.zero)),
          BarChartRodData(
            width: 20,
            toY: 1,
            color: naranja,
            rodStackItems: [
              BarChartRodStackItem(0, 1, naranja),
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
              toY: 2,
              color: azul,
              rodStackItems: [
                BarChartRodStackItem(0, 2, azul),
              ],
              borderRadius: const BorderRadius.all(Radius.zero)),
          BarChartRodData(
              width: 20,
              toY: 1,
              color: rojo,
              rodStackItems: [
                BarChartRodStackItem(0, 1, rojo),
              ],
              borderRadius: const BorderRadius.all(Radius.zero)),
          BarChartRodData(
            width: 20,
            toY: 4,
            color: naranja,
            rodStackItems: [
              BarChartRodStackItem(0, 4, naranja),
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
              toY: 6,
              color: azul,
              rodStackItems: [
                BarChartRodStackItem(0, 6, azul),
              ],
              borderRadius: const BorderRadius.all(Radius.zero)),
          BarChartRodData(
              width: 20,
              toY: 3,
              color: rojo,
              rodStackItems: [
                BarChartRodStackItem(0, 3, rojo),
              ],
              borderRadius: const BorderRadius.all(Radius.zero)),
          BarChartRodData(
            width: 20,
            toY: 2,
            color: naranja,
            rodStackItems: [
              BarChartRodStackItem(0, 2, naranja),
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
              toY: 5,
              color: azul,
              rodStackItems: [
                BarChartRodStackItem(0, 5, azul),
              ],
              borderRadius: const BorderRadius.all(Radius.zero)),
          BarChartRodData(
              width: 20,
              toY: 9,
              color: rojo,
              rodStackItems: [
                BarChartRodStackItem(0, 9, rojo),
              ],
              borderRadius: const BorderRadius.all(Radius.zero)),
          BarChartRodData(
            width: 20,
            toY: 8,
            color: naranja,
            rodStackItems: [
              BarChartRodStackItem(0, 8, naranja),
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
              toY: 1,
              color: azul,
              rodStackItems: [
                BarChartRodStackItem(0, 1, azul),
              ],
              borderRadius: const BorderRadius.all(Radius.zero)),
          BarChartRodData(
              width: 20,
              toY: 4,
              color: rojo,
              rodStackItems: [
                BarChartRodStackItem(0, 4, rojo),
              ],
              borderRadius: const BorderRadius.all(Radius.zero)),
          BarChartRodData(
            width: 20,
            toY: 4,
            color: naranja,
            rodStackItems: [
              BarChartRodStackItem(0, 4, naranja),
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
              toY: 2,
              color: azul,
              rodStackItems: [
                BarChartRodStackItem(0, 2, azul),
              ],
              borderRadius: const BorderRadius.all(Radius.zero)),
          BarChartRodData(
              width: 20,
              toY: 3,
              color: rojo,
              rodStackItems: [
                BarChartRodStackItem(0, 3, rojo),
              ],
              borderRadius: const BorderRadius.all(Radius.zero)),
          BarChartRodData(
            width: 20,
            toY: 1,
            color: naranja,
            rodStackItems: [
              BarChartRodStackItem(0, 1, naranja),
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
              toY: 2,
              color: azul,
              rodStackItems: [
                BarChartRodStackItem(0, 2, azul),
              ],
              borderRadius: const BorderRadius.all(Radius.zero)),
          BarChartRodData(
              width: 20,
              toY: 2,
              color: rojo,
              rodStackItems: [
                BarChartRodStackItem(0, 2, rojo),
              ],
              borderRadius: const BorderRadius.all(Radius.zero)),
          BarChartRodData(
            width: 20,
            toY: 1,
            color: naranja,
            rodStackItems: [
              BarChartRodStackItem(0, 1, naranja),
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
              toY: 11,
              color: azul,
              rodStackItems: [
                BarChartRodStackItem(0, 11, azul),
              ],
              borderRadius: const BorderRadius.all(Radius.zero)),
          BarChartRodData(
              width: 20,
              toY: 0,
              color: rojo,
              rodStackItems: [
                BarChartRodStackItem(0, 0, rojo),
              ],
              borderRadius: const BorderRadius.all(Radius.zero)),
          BarChartRodData(
            width: 20,
            toY: 0,
            color: naranja,
            rodStackItems: [
              BarChartRodStackItem(0, 0, naranja),
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
        const FlSpot(0, 12),
        const FlSpot(1, 13),
        const FlSpot(2, 4),
        const FlSpot(3, 2),
        const FlSpot(4, 16),
        const FlSpot(5, 7),
        const FlSpot(6, 11),
        const FlSpot(7, 23),
        const FlSpot(8, 9),
        const FlSpot(9, 6),
        const FlSpot(10, 5),
        const FlSpot(11, 11),
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
        const FlSpot(0, 10),
        const FlSpot(1, 7),
        const FlSpot(2, 1),
        const FlSpot(3, 2),
        const FlSpot(4, 11),
        const FlSpot(5, 2),
        const FlSpot(6, 6),
        const FlSpot(7, 5),
        const FlSpot(8, 1),
        const FlSpot(9, 2),
        const FlSpot(10, 2),
        const FlSpot(11, 11),
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
        const FlSpot(0, 1),
        const FlSpot(1, 1),
        const FlSpot(2, 2),
        const FlSpot(3, 0),
        const FlSpot(4, 4),
        const FlSpot(5, 1),
        const FlSpot(6, 3),
        const FlSpot(7, 9),
        const FlSpot(8, 4),
        const FlSpot(9, 3),
        const FlSpot(10, 2),
        const FlSpot(11, 0),
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
        const FlSpot(0, 1),
        const FlSpot(1, 5),
        const FlSpot(2, 1),
        const FlSpot(3, 0),
        const FlSpot(4, 1),
        const FlSpot(5, 4),
        const FlSpot(6, 2),
        const FlSpot(7, 8),
        const FlSpot(8, 4),
        const FlSpot(9, 1),
        const FlSpot(10, 1),
        const FlSpot(11, 0),
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
