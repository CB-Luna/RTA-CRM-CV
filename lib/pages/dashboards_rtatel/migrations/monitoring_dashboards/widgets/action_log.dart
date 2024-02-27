import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:provider/provider.dart';
import 'package:rta_crm_cv/helpers/constants.dart';
import 'package:rta_crm_cv/pages/dashboards_rtatel/migrations/monitoring_dashboards/widgets/weekly_error_trends_bar_chart.dart';
import 'package:rta_crm_cv/providers/dashboard_rta/monitoring_dashboard_provider.dart';

class ActionLog extends StatefulWidget {
  const ActionLog({super.key});

  @override
  State<ActionLog> createState() => _ActionLogState();
}

class _ActionLogState extends State<ActionLog> {
  @override
  Widget build(BuildContext context) {
    MonitoringDashboardProvider provider =
        Provider.of<MonitoringDashboardProvider>(context);

    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 1.35,
      margin: const EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 5),
      // margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      decoration: BoxDecoration(color: Colors.grey, border: Border.all()),
      child: Column(
        children: [
          // Sector 1
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.07,
                  width: MediaQuery.of(context).size.width * 0.2,
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(top: 10),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    border: Border.symmetric(
                        horizontal:
                            BorderSide(color: Colors.grey[700]!, width: 5)),
                    // border: Border.all(color: Colors.black, width: 1.5),
                  ),
                  child: const Text("Action Log",
                      style: TextStyle(
                          fontFamily: 'Gotham-Regular',
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold)),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.22,
                  height: MediaQuery.of(context).size.height * 0.60,
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
                        title: 'Cbluna Resource',
                        field: 'cbluna_resource',
                        width: 235,
                        enableContextMenu: false,
                        enableDropToResize: false,
                        titleTextAlign: PlutoColumnTextAlign.center,
                        textAlign: PlutoColumnTextAlign.center,
                        type: PlutoColumnType.number(),
                        enableEditingMode: false,
                      ),
                      PlutoColumn(
                        title: ' ',
                        field: 'value_cbluna',
                        width: 100,
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
            Container(
              width: MediaQuery.of(context).size.width * 0.5,
              height: MediaQuery.of(context).size.height * 0.60,
              margin: const EdgeInsets.only(top: 55),
              color: Colors.white,
              child: const WeeklyErrorTrendsBarChart(),
            ),
          ]),

          // Sector 3
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.22,
              height: MediaQuery.of(context).size.height * 0.6,
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
                    title: 'RTA Resource Contacted',
                    field: 'rta_resource_contacted',
                    width: 235,
                    enableContextMenu: false,
                    enableDropToResize: false,
                    titleTextAlign: PlutoColumnTextAlign.center,
                    textAlign: PlutoColumnTextAlign.center,
                    type: PlutoColumnType.number(),
                    enableEditingMode: false,
                  ),
                  PlutoColumn(
                    title: ' ',
                    field: 'value_rta',
                    width: 100,
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
              width: MediaQuery.of(context).size.width * 0.5,
              height: MediaQuery.of(context).size.height * 0.6,
              margin: const EdgeInsets.all(10),
              color: Colors.white,
              child: const WeeklyErrorTrendsBarChart(),
            ),
          ]),
        ],
      ),
    );
  }
}
