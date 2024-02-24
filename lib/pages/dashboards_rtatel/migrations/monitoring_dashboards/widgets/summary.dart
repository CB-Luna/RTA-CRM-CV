import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:provider/provider.dart';
import 'package:rta_crm_cv/helpers/constants.dart';
import 'package:rta_crm_cv/providers/dashboard_rta/monitoring_provider.dart';

import 'bar_chart_example.dart';

class Summary extends StatefulWidget {
  const Summary({super.key});

  @override
  State<Summary> createState() => _SummaryState();
}

class _SummaryState extends State<Summary> {
  @override
  Widget build(BuildContext context) {
    MonitoringDashboardProvider provider =
        Provider.of<MonitoringDashboardProvider>(context);

    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 1.05,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      decoration: BoxDecoration(color: Colors.grey, border: Border.all()),
      child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
        Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.07,
              width: MediaQuery.of(context).size.width * 0.2,
              alignment: Alignment.center,
              margin: const EdgeInsets.only(top: 10),
              decoration: BoxDecoration(
                color: Colors.blue,
                border: Border.all(color: Colors.black, width: 1.5),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: const Text("Summary",
                  style: TextStyle(
                      fontFamily: 'Gotham-Regular',
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold)),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.22,
              height: MediaQuery.of(context).size.height * 0.3,
              margin: const EdgeInsets.all(10),
              child: PlutoGrid(
                key: UniqueKey(),
                configuration: PlutoGridConfiguration(
                  localeText: const PlutoGridLocaleText.spanish(),
                  scrollbar: plutoGridScrollbarConfig(context),
                  style: plutoGridStyleConfigMonitoringDashboard(context),
                  columnFilter: PlutoGridColumnFilterConfig(
                    filters: const [
                      ...FilterHelper.defaultFilters,
                    ],
                    resolveDefaultColumnFilter: (column, resolver) {
                      return resolver<PlutoFilterTypeContains>()
                          as PlutoFilterType;
                    },
                  ),
                ),
                columns: [
                  PlutoColumn(
                    title: 'Month',
                    field: 'month',
                    width: 220,
                    enableContextMenu: false,
                    enableDropToResize: false,
                    titleTextAlign: PlutoColumnTextAlign.center,
                    textAlign: PlutoColumnTextAlign.center,
                    type: PlutoColumnType.number(),
                    enableEditingMode: false,
                  ),
                  PlutoColumn(
                    title: 'System',
                    field: 'system',
                    width: 120,
                    enableContextMenu: false,
                    enableDropToResize: false,
                    titleTextAlign: PlutoColumnTextAlign.center,
                    textAlign: PlutoColumnTextAlign.center,
                    type: PlutoColumnType.text(),
                    enableEditingMode: false,
                  ),
                ],
                rows: provider.monthRows,
                createFooter: (stateManager) {
                  stateManager.setPageSize(
                    20,
                    notify: false,
                  );
                  return PlutoPagination(stateManager);
                },
                onLoaded: (event) {
                  provider.monthstateManager = event.stateManager;
                },
                onRowChecked: (event) {},
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.22,
              height: MediaQuery.of(context).size.height * 0.3,
              margin: const EdgeInsets.all(10),
              child: PlutoGrid(
                key: UniqueKey(),
                configuration: PlutoGridConfiguration(
                  localeText: const PlutoGridLocaleText.spanish(),
                  scrollbar: plutoGridScrollbarConfig(context),
                  style: plutoGridStyleConfigMonitoringDashboard(context),
                  columnFilter: PlutoGridColumnFilterConfig(
                    filters: const [
                      ...FilterHelper.defaultFilters,
                    ],
                    resolveDefaultColumnFilter: (column, resolver) {
                      return resolver<PlutoFilterTypeContains>()
                          as PlutoFilterType;
                    },
                  ),
                ),
                columns: [
                  PlutoColumn(
                    title: 'System',
                    field: 'system',
                    width: 220,
                    enableContextMenu: false,
                    enableDropToResize: false,
                    titleTextAlign: PlutoColumnTextAlign.center,
                    textAlign: PlutoColumnTextAlign.center,
                    type: PlutoColumnType.number(),
                    enableEditingMode: false,
                  ),
                  PlutoColumn(
                    title: '',
                    field: 'value_system',
                    width: 120,
                    enableContextMenu: false,
                    enableDropToResize: false,
                    titleTextAlign: PlutoColumnTextAlign.center,
                    textAlign: PlutoColumnTextAlign.center,
                    type: PlutoColumnType.text(),
                    enableEditingMode: false,
                  ),
                ],
                rows: provider.monthRows,
                createFooter: (stateManager) {
                  stateManager.setPageSize(
                    20,
                    notify: false,
                  );
                  return PlutoPagination(stateManager);
                },
                onLoaded: (event) {
                  provider.monthstateManager = event.stateManager;
                },
                onRowChecked: (event) {},
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.22,
              height: MediaQuery.of(context).size.height * 0.25,
              margin: const EdgeInsets.all(10),
              child: PlutoGrid(
                key: UniqueKey(),
                configuration: PlutoGridConfiguration(
                  localeText: const PlutoGridLocaleText.spanish(),
                  scrollbar: plutoGridScrollbarConfig(context),
                  style: plutoGridStyleConfigMonitoringDashboard(context),
                  columnFilter: PlutoGridColumnFilterConfig(
                    filters: const [
                      ...FilterHelper.defaultFilters,
                    ],
                    resolveDefaultColumnFilter: (column, resolver) {
                      return resolver<PlutoFilterTypeContains>()
                          as PlutoFilterType;
                    },
                  ),
                ),
                columns: [
                  PlutoColumn(
                    title: 'Action Taken',
                    field: 'action_taken',
                    width: 220,
                    enableContextMenu: false,
                    enableDropToResize: false,
                    titleTextAlign: PlutoColumnTextAlign.center,
                    textAlign: PlutoColumnTextAlign.center,
                    type: PlutoColumnType.number(),
                    enableEditingMode: false,
                  ),
                  PlutoColumn(
                    title: '',
                    field: 'value_action',
                    width: 120,
                    enableContextMenu: false,
                    enableDropToResize: false,
                    titleTextAlign: PlutoColumnTextAlign.center,
                    textAlign: PlutoColumnTextAlign.center,
                    type: PlutoColumnType.text(),
                    enableEditingMode: false,
                  ),
                ],
                rows: provider.monthRows,
                createFooter: (stateManager) {
                  stateManager.setPageSize(
                    20,
                    notify: false,
                  );
                  return PlutoPagination(stateManager);
                },
                onLoaded: (event) {
                  provider.monthstateManager = event.stateManager;
                },
                onRowChecked: (event) {},
              ),
            ),
          ],
        ),
        Expanded(
            child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.8,
          margin: const EdgeInsets.all(10),
          color: Colors.white,
          child: BarChartSample2(),
        ))
      ]),
    );
  }
}
