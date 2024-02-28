import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:provider/provider.dart';
import 'package:rta_crm_cv/helpers/constants.dart';
import 'package:rta_crm_cv/providers/dashboard_rta/monitoring_dashboard_provider.dart';

import 'bar_chart_example.dart';

class SANFUSION extends StatefulWidget {
  const SANFUSION({super.key});

  @override
  State<SANFUSION> createState() => _SANFUSIONState();
}

class _SANFUSIONState extends State<SANFUSION> {
  @override
  Widget build(BuildContext context) {
    MonitoringDashboardProvider provider =
        Provider.of<MonitoringDashboardProvider>(context);

    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.75,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      decoration:
          BoxDecoration(color: const Color(0xffC51D86), border: Border.all()),
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.07,
                width: MediaQuery.of(context).size.width * 0.2,
                alignment: Alignment.center,
                margin: const EdgeInsets.only(top: 10, left: 10),
                decoration: const BoxDecoration(
                  color: Color(0xff263238),
                  border: Border.symmetric(
                      horizontal:
                          BorderSide(color: Color(0xffF10096), width: 6)),
                ),
                child: const Text("SAN/FUSION",
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
