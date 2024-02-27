import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:provider/provider.dart';
import 'package:rta_crm_cv/helpers/constants.dart';
import 'package:rta_crm_cv/pages/dashboards_rtatel/migrations/monitoring_dashboards/widgets/weekly_error_trends_bar_chart.dart';
import 'package:rta_crm_cv/providers/dashboard_rta/monitoring_dashboard_provider.dart';

class WeeklyErrorTrends extends StatefulWidget {
  const WeeklyErrorTrends({super.key});

  @override
  State<WeeklyErrorTrends> createState() => _WeeklyErrorTrendsState();
}

class _WeeklyErrorTrendsState extends State<WeeklyErrorTrends> {
  @override
  Widget build(BuildContext context) {
    MonitoringDashboardProvider provider =
        Provider.of<MonitoringDashboardProvider>(context);

    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 2.10,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      decoration: BoxDecoration(color: Colors.blue[900], border: Border.all()),
      child: Column(
        children: [
          // Sector 1
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  height: MediaQuery.of(context).size.height * 0.3,
                  margin: const EdgeInsets.all(10),
                  color: Colors.white,
                  child: const WeeklyErrorTrendsBarChart(),
                ),
                // const SizedBox(
                //   height: 40,
                // ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  height: MediaQuery.of(context).size.height * 0.3,
                  margin: const EdgeInsets.all(10),
                  color: Colors.white,
                  child: const WeeklyErrorTrendsBarChart(),
                )
              ],
            ),
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
                            BorderSide(color: Colors.blue[700]!, width: 5)),
                    // border: Border.all(color: Colors.black, width: 1.5),
                  ),
                  child: const Text("Weekly Error Trends",
                      style: TextStyle(
                          fontFamily: 'Gotham-Regular',
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold)),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.07,
                  width: MediaQuery.of(context).size.width * 0.2,
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(top: 10),
                  decoration: BoxDecoration(
                    color: Colors.blue[100],
                  ),
                  child: Text("Select a Month",
                      style: TextStyle(
                          decoration: TextDecoration.underline,
                          fontFamily: 'Gotham-Regular',
                          color: Colors.blue[500],
                          fontSize: 25,
                          fontWeight: FontWeight.bold)),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.22,
                  height: MediaQuery.of(context).size.height * 0.47,
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
              ],
            ),
          ]),
          // Sector 2
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.10,
                  width: MediaQuery.of(context).size.width * 0.10,
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(top: 10),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    border: Border.symmetric(
                        horizontal:
                            BorderSide(color: Colors.blue[700]!, width: 5)),
                    // border: Border.all(color: Colors.black, width: 1.5),
                  ),
                  child: const Text("Up to \n Feb 2024",
                      style: TextStyle(
                          fontFamily: 'Gotham-Regular',
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold)),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.37,
                  height: MediaQuery.of(context).size.height * 0.58,
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
                        title: 'Powercode',
                        field: 'powercode',
                        width: 120,
                        enableContextMenu: false,
                        enableDropToResize: false,
                        titleTextAlign: PlutoColumnTextAlign.center,
                        textAlign: PlutoColumnTextAlign.center,
                        type: PlutoColumnType.text(),
                        enableEditingMode: false,
                      ),
                      PlutoColumn(
                        title: 'Solarwinds',
                        field: 'solarwinds',
                        width: 120,
                        enableContextMenu: false,
                        enableDropToResize: false,
                        titleTextAlign: PlutoColumnTextAlign.center,
                        textAlign: PlutoColumnTextAlign.center,
                        type: PlutoColumnType.text(),
                        enableEditingMode: false,
                      ),
                      PlutoColumn(
                        title: 'Total',
                        field: 'total',
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
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  height: MediaQuery.of(context).size.height * 0.3,
                  margin: const EdgeInsets.all(10),
                  color: Colors.white,
                  child: const WeeklyErrorTrendsBarChart(),
                ),
                const SizedBox(
                  height: 40,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  height: MediaQuery.of(context).size.height * 0.3,
                  margin: const EdgeInsets.all(10),
                  color: Colors.white,
                  child: const WeeklyErrorTrendsBarChart(),
                )
              ],
            ),
          ]),
          // Sector 3
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
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
                        field: 'error_type_powercode',
                        width: 120,
                        enableContextMenu: false,
                        enableDropToResize: false,
                        titleTextAlign: PlutoColumnTextAlign.center,
                        textAlign: PlutoColumnTextAlign.center,
                        type: PlutoColumnType.number(),
                        enableEditingMode: false,
                      ),
                      PlutoColumn(
                        title: 'Powercode Events',
                        field: 'powercode_events',
                        width: 220,
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
                        title: 'Error Type',
                        field: 'error_type_solarwinds',
                        width: 120,
                        enableContextMenu: false,
                        enableDropToResize: false,
                        titleTextAlign: PlutoColumnTextAlign.center,
                        textAlign: PlutoColumnTextAlign.center,
                        type: PlutoColumnType.number(),
                        enableEditingMode: false,
                      ),
                      PlutoColumn(
                        title: 'Solarwinds Events',
                        field: 'solarwinds_events',
                        width: 220,
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
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  height: MediaQuery.of(context).size.height * 0.3,
                  margin: const EdgeInsets.all(10),
                  color: Colors.white,
                  child: const WeeklyErrorTrendsBarChart(),
                ),
                const SizedBox(
                  height: 40,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  height: MediaQuery.of(context).size.height * 0.3,
                  margin: const EdgeInsets.all(10),
                  color: Colors.white,
                  child: const WeeklyErrorTrendsBarChart(),
                )
              ],
            ),
          ]),
        ],
      ),
    );
  }
}
