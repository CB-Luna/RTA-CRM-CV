import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:provider/provider.dart';
import 'package:rta_crm_cv/helpers/constants.dart';
import 'package:rta_crm_cv/providers/dashboard_rta/monitoring_dashboard_provider.dart';

import 'bar_chart_example.dart';

class SMISCT extends StatefulWidget {
  const SMISCT({super.key});

  @override
  State<SMISCT> createState() => _SMISCTState();
}

class _SMISCTState extends State<SMISCT> {
  @override
  Widget build(BuildContext context) {
    MonitoringDashboardProvider provider =
        Provider.of<MonitoringDashboardProvider>(context);

    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.75,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      decoration: BoxDecoration(color: Colors.purple, border: Border.all()),
      child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
        Column(
          children: [
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
                    title: 'Error Type',
                    field: 'error_type',
                    width: 220,
                    enableContextMenu: false,
                    enableDropToResize: false,
                    titleTextAlign: PlutoColumnTextAlign.center,
                    textAlign: PlutoColumnTextAlign.center,
                    type: PlutoColumnType.number(),
                    enableEditingMode: false,
                  ),
                  PlutoColumn(
                    title: 'Incidents',
                    field: 'error_incidents',
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
                    title: 'Weekday',
                    field: 'weekday',
                    width: 220,
                    enableContextMenu: false,
                    enableDropToResize: false,
                    titleTextAlign: PlutoColumnTextAlign.center,
                    textAlign: PlutoColumnTextAlign.center,
                    type: PlutoColumnType.number(),
                    enableEditingMode: false,
                  ),
                  PlutoColumn(
                    title: 'Incidents',
                    field: 'error_incidents',
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.07,
                width: MediaQuery.of(context).size.width * 0.2,
                alignment: Alignment.center,
                margin: const EdgeInsets.only(top: 10),
                decoration: BoxDecoration(
                  color: Colors.grey[850],
                  border: Border.symmetric(
                      vertical: BorderSide(color: Colors.black, width: 1.5)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.purple[300]!,
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: const Text("CRY/SBB",
                    style: TextStyle(
                        fontFamily: 'Gotham-Regular',
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold)),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.6,
                margin: const EdgeInsets.all(10),
                color: Colors.white,
                child: BarChartSample2(),
              ),
            ],
          ),
        )
      ]),
    );
  }
}
