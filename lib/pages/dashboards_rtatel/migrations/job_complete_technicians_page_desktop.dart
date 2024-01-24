import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:provider/provider.dart';
import 'package:rta_crm_cv/helpers/globals.dart';
import 'package:rta_crm_cv/pages/dashboards_rtatel/migrations/widgets/container_widget.dart';
import 'package:rta_crm_cv/pages/dashboards_rtatel/migrations/widgets/indicator_card_widget.dart';
import 'package:rta_crm_cv/pages/dashboards_rtatel/migrations/widgets/pie_chart_1.dart';
import 'package:rta_crm_cv/theme/theme.dart';
import 'package:rta_crm_cv/widgets/side_menu/sidemenu.dart';

import '../../../helpers/constants.dart';
import '../../../providers/job_complete_technicians_provider.dart';
import '../../../public/colors.dart';
import '../../../widgets/custom_icon_button.dart';

class JobCompleteTechniciansPage extends StatefulWidget {
  const JobCompleteTechniciansPage({super.key});

  @override
  State<JobCompleteTechniciansPage> createState() =>
      _JobCompleteTechniciansPageState();
}

class _JobCompleteTechniciansPageState
    extends State<JobCompleteTechniciansPage> {
  @override
  Widget build(BuildContext context) {
    // SideMenuProvider provider = Provider.of<SideMenuProvider>(context);
    JobCompleteProvider provider = Provider.of<JobCompleteProvider>(context);

    return Material(
        child: SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Row(children: [
        const SideMenu(),
        Expanded(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: ListView(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.1,
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    "Dashboard ${currentUser!.name}",
                    style: AppTheme.of(context).title1,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.all(10),
                  height: MediaQuery.of(context).size.height * 0.07,
                  width: MediaQuery.of(context).size.width,
                  color: const Color(0xffE9ECEF),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                          "Job Complete Service Experience Survey Results"),
                      Container(
                        width: 150,
                        height: 100,
                        color: Colors.white,
                      )
                    ],
                  ),
                ),
                const Row(
                  children: [
                    IndicatorCardWidget(
                      card: 1,
                    ),
                    IndicatorCardWidget(
                      card: 2,
                    ),
                    IndicatorCardWidget(
                      card: 3,
                    ),
                    IndicatorCardWidget(
                      card: 4,
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ContainerWidget(
                          text: "Technician Ranking",
                          icon: const Icon(Icons.graphic_eq_sharp),
                          card: 1,
                          widget: Container(
                              width: MediaQuery.of(context).size.width * 0.3,
                              padding: const EdgeInsets.all(10),
                              child: PlutoGrid(
                                key: UniqueKey(),
                                configuration: PlutoGridConfiguration(
                                  scrollbar: plutoGridScrollbarConfigDashboard(
                                      context),
                                  style: plutoGridStyleConfigDashboard(context),
                                  columnFilter: PlutoGridColumnFilterConfig(
                                    filters: const [
                                      ...FilterHelper.defaultFilters,
                                    ],
                                    resolveDefaultColumnFilter:
                                        (column, resolver) {
                                      if (column.field == '#') {
                                        return resolver<
                                                PlutoFilterTypeContains>()
                                            as PlutoFilterType;
                                      } else if (column.field == 'Technician') {
                                        return resolver<
                                                PlutoFilterTypeContains>()
                                            as PlutoFilterType;
                                      } else if (column.field == 'Ranking') {
                                        return resolver<
                                                PlutoFilterTypeContains>()
                                            as PlutoFilterType;
                                      }
                                      return resolver<PlutoFilterTypeContains>()
                                          as PlutoFilterType;
                                    },
                                  ),
                                ),
                                columns: [
                                  PlutoColumn(
                                    titleSpan: TextSpan(children: [
                                      // WidgetSpan(
                                      //     child: Icon(Icons.vpn_key_outlined,
                                      //         color: AppTheme.of(context)
                                      //             .primaryBackground)),
                                      // const WidgetSpan(
                                      //     child: SizedBox(width: 10)),
                                      TextSpan(
                                          text: '#',
                                          style: AppTheme.of(context)
                                              .encabezadoTablasBlack)
                                    ]),
                                    backgroundColor:
                                        AppTheme.of(context).primaryBackground,
                                    title: '#',
                                    field: '#',
                                    titleTextAlign: PlutoColumnTextAlign.start,
                                    textAlign: PlutoColumnTextAlign.center,
                                    type: PlutoColumnType.text(),
                                    enableRowDrag: false,
                                    enableDropToResize: false,
                                    enableEditingMode: false,
                                    width: 150,
                                    cellPadding: EdgeInsets.zero,
                                    renderer: (rendererContext) {
                                      return Container(
                                        height: rowHeight,
                                        // width: rendererContext.cell.column.width,
                                        decoration: BoxDecoration(
                                            gradient: whiteGradient),
                                        child: Center(
                                          child: Text(
                                            rendererContext.cell.value
                                                .toString(),
                                            style: AppTheme.of(context)
                                                .contenidoTablas
                                                .override(
                                                    fontFamily:
                                                        'Gotham-Regular',
                                                    useGoogleFonts: false,
                                                    color: AppTheme.of(context)
                                                        .primaryColor),
                                          ),
                                        ),
                                      );
                                    },
                                    // footerRenderer: (context) {
                                    //   return SizedBox(
                                    //     child: Row(
                                    //       mainAxisAlignment:
                                    //           MainAxisAlignment.center,
                                    //       children: [
                                    //         CustomIconButton(
                                    //           icon: Icons
                                    //               .keyboard_arrow_down_outlined,
                                    //           toolTip: 'less',
                                    //           onTap: () {
                                    //             provider.setPageSize('less');
                                    //           },
                                    //         ),
                                    //         const SizedBox(width: 10),
                                    //         Text(
                                    //           provider.pageRowCount.toString(),
                                    //           style: const TextStyle(
                                    //               color: Colors.white),
                                    //         ),
                                    //         const SizedBox(width: 10),
                                    //         CustomIconButton(
                                    //           icon: Icons
                                    //               .keyboard_arrow_up_outlined,
                                    //           toolTip: 'more',
                                    //           onTap: () {
                                    //             provider.setPageSize('more');
                                    //           },
                                    //         ),
                                    //         const SizedBox(width: 10),
                                    //         /* CustomIconButton(
                                    //         icon: const Icon(Icons.refresh_rounded),
                                    //         toolTip: 'load',
                                    //         onTap: () {
                                    //           provider.load();
                                    //         },
                                    //       ), */
                                    //       ],
                                    //     ),
                                    //   );
                                    // },
                                  ),
                                  PlutoColumn(
                                    titleSpan: TextSpan(children: [
                                      // WidgetSpan(
                                      //     child: Icon(Icons.person_outline,
                                      //         color: AppTheme.of(context)
                                      //             .primaryBackground)),
                                      // const WidgetSpan(
                                      //     child: SizedBox(width: 10)),
                                      TextSpan(
                                          text: 'Technician',
                                          style: AppTheme.of(context)
                                              .encabezadoTablasBlack)
                                    ]),
                                    backgroundColor:
                                        AppTheme.of(context).primaryBackground,
                                    title: 'Technician',
                                    field: 'Technician',
                                    width: 300,
                                    titleTextAlign: PlutoColumnTextAlign.start,
                                    textAlign: PlutoColumnTextAlign.center,
                                    type: PlutoColumnType.text(),
                                    enableEditingMode: false,
                                    cellPadding: EdgeInsets.zero,
                                    renderer: (rendererContext) {
                                      return Container(
                                        height: rowHeight,
                                        // width: rendererContext.cell.column.width,
                                        decoration: BoxDecoration(
                                            gradient: whiteGradient),
                                        child: Center(
                                            child: Text(
                                          rendererContext.cell.value ?? '-',
                                          style: AppTheme.of(context)
                                              .contenidoTablas
                                              .override(
                                                  fontFamily: 'Gotham-Regular',
                                                  useGoogleFonts: false),
                                        )),
                                      );
                                    },
                                  ),
                                  PlutoColumn(
                                    titleSpan: TextSpan(children: [
                                      // WidgetSpan(
                                      //     child: Icon(Icons.local_offer_outlined,
                                      //         color: AppTheme.of(context)
                                      //             .primaryBackground)),
                                      // const WidgetSpan(
                                      //     child: SizedBox(width: 10)),
                                      TextSpan(
                                          text: 'Ranking',
                                          style: AppTheme.of(context)
                                              .encabezadoTablasBlack)
                                    ]),
                                    backgroundColor:
                                        AppTheme.of(context).primaryBackground,
                                    title: 'Ranking',
                                    field: 'Ranking',
                                    width: 200,
                                    titleTextAlign: PlutoColumnTextAlign.start,
                                    textAlign: PlutoColumnTextAlign.center,
                                    type: PlutoColumnType.text(),
                                    enableEditingMode: false,
                                    cellPadding: EdgeInsets.zero,
                                    renderer: (rendererContext) {
                                      return Container(
                                        height: rowHeight,
                                        // width: rendererContext.cell.column.width,
                                        decoration: BoxDecoration(
                                            gradient: whiteGradient),
                                        child: Center(
                                            child: Text(
                                          rendererContext.cell.value ?? '-',
                                          style: AppTheme.of(context)
                                              .contenidoTablas
                                              .override(
                                                  fontFamily: 'Gotham-Regular',
                                                  useGoogleFonts: false),
                                        )),
                                      );
                                    },
                                  ),
                                ],
                                rows: provider.rows,
                                onLoaded: (event) async {
                                  provider.stateManager = event.stateManager;
                                  // provider.stateManager!.setShowColumnFilter(true);
                                  // provider.stateManager!.showFilterPopup(context);
                                  // provider.stateManager!.setPage(10);
                                },
                                createFooter: (stateManager) {
                                  stateManager.setPageSize(
                                      provider.pageRowCount,
                                      notify: false);
                                  stateManager.setPage(provider.page);
                                  return const SizedBox(height: 0, width: 0);
                                },
                              )),
                        ),
                        ContainerWidget(
                          text:
                              " List of surveys by technician that resulted in an incentive",
                          card: 2,
                          widget: Container(
                              width: MediaQuery.of(context).size.width * 0.3,
                              padding: const EdgeInsets.all(10),
                              child: PlutoGrid(
                                key: UniqueKey(),
                                configuration: PlutoGridConfiguration(
                                  scrollbar: plutoGridScrollbarConfigDashboard(
                                      context),
                                  style: plutoGridStyleConfigDashboard(context),
                                  columnFilter: PlutoGridColumnFilterConfig(
                                    filters: const [
                                      ...FilterHelper.defaultFilters,
                                    ],
                                    resolveDefaultColumnFilter:
                                        (column, resolver) {
                                      if (column.field == 'Technician') {
                                        return resolver<
                                                PlutoFilterTypeContains>()
                                            as PlutoFilterType;
                                      } else if (column.field == 'Total') {
                                        return resolver<
                                                PlutoFilterTypeContains>()
                                            as PlutoFilterType;
                                      }
                                      return resolver<PlutoFilterTypeContains>()
                                          as PlutoFilterType;
                                    },
                                  ),
                                ),
                                columns: [
                                  PlutoColumn(
                                    titleSpan: TextSpan(children: [
                                      // WidgetSpan(
                                      //     child: Icon(Icons.person_outline,
                                      //         color: AppTheme.of(context)
                                      //             .primaryBackground)),
                                      // const WidgetSpan(
                                      //     child: SizedBox(width: 10)),
                                      TextSpan(
                                          text: 'Technician',
                                          style: AppTheme.of(context)
                                              .encabezadoTablasBlack)
                                    ]),
                                    backgroundColor:
                                        AppTheme.of(context).primaryBackground,
                                    title: 'Technician',
                                    field: 'Technician',
                                    width: 400,
                                    titleTextAlign: PlutoColumnTextAlign.start,
                                    textAlign: PlutoColumnTextAlign.center,
                                    type: PlutoColumnType.text(),
                                    enableEditingMode: false,
                                    cellPadding: EdgeInsets.zero,
                                    renderer: (rendererContext) {
                                      return Container(
                                        height: rowHeight,
                                        // width: rendererContext.cell.column.width,
                                        decoration: BoxDecoration(
                                            gradient: whiteGradient),
                                        child: Center(
                                            child: Text(
                                          rendererContext.cell.value ?? '-',
                                          style: AppTheme.of(context)
                                              .contenidoTablas
                                              .override(
                                                  fontFamily: 'Gotham-Regular',
                                                  useGoogleFonts: false),
                                        )),
                                      );
                                    },
                                  ),
                                  PlutoColumn(
                                    titleSpan: TextSpan(children: [
                                      // WidgetSpan(
                                      //     child: Icon(Icons.local_offer_outlined,
                                      //         color: AppTheme.of(context)
                                      //             .primaryBackground)),
                                      // const WidgetSpan(
                                      //     child: SizedBox(width: 10)),
                                      TextSpan(
                                          text: 'Total',
                                          style: AppTheme.of(context)
                                              .encabezadoTablasBlack)
                                    ]),
                                    backgroundColor:
                                        AppTheme.of(context).primaryBackground,
                                    title: 'Total',
                                    field: 'Total',
                                    width: 200,
                                    titleTextAlign: PlutoColumnTextAlign.start,
                                    textAlign: PlutoColumnTextAlign.center,
                                    type: PlutoColumnType.text(),
                                    enableEditingMode: false,
                                    cellPadding: EdgeInsets.zero,
                                    renderer: (rendererContext) {
                                      return Container(
                                        height: rowHeight,
                                        // width: rendererContext.cell.column.width,
                                        decoration: BoxDecoration(
                                            gradient: whiteGradient),
                                        child: Center(
                                            child: Text(
                                          rendererContext.cell.value ?? '-',
                                          style: AppTheme.of(context)
                                              .contenidoTablas
                                              .override(
                                                  fontFamily: 'Gotham-Regular',
                                                  useGoogleFonts: false),
                                        )),
                                      );
                                    },
                                  ),
                                ],
                                rows: provider.rows,
                                onLoaded: (event) async {
                                  provider.stateManager = event.stateManager;
                                  // provider.stateManager!.setShowColumnFilter(true);
                                  // provider.stateManager!.showFilterPopup(context);
                                  // provider.stateManager!.setPage(10);
                                },
                                createFooter: (stateManager) {
                                  stateManager.setPageSize(
                                      provider.pageRowCount,
                                      notify: false);
                                  stateManager.setPage(provider.page);
                                  return const SizedBox(height: 0, width: 0);
                                },
                              )),
                        )
                      ],
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ContainerWidget(
                          text: " Total Survey Results",
                          widget: PieChartSample2(),
                        ),
                        ContainerWidget(
                          text: "  Total Survey Sent vs Completed",
                        )
                      ],
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ContainerWidget(
                          text: " Survey Results Breakdown Trend",
                        ),
                        ContainerWidget(
                          text: " Total Survey Trend",
                        )
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        )
      ]),
    ));
  }
}
