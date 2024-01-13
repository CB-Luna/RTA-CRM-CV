import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:provider/provider.dart';
import 'package:rta_crm_cv/theme/theme.dart';

import '../../../../helpers/constants.dart';
import '../../../../providers/job_complete_technicians_provider.dart';
import '../../../../public/colors.dart';
import '../../../../widgets/custom_icon_button.dart';

class JobCompleteTechniPopUp extends StatefulWidget {
  const JobCompleteTechniPopUp({super.key});

  @override
  State<JobCompleteTechniPopUp> createState() => _JobCompleteTechniPopUpState();
}

class _JobCompleteTechniPopUpState extends State<JobCompleteTechniPopUp> {
  // JobCompleteProvider

  @override
  Widget build(BuildContext context) {
    JobCompleteProvider provider = Provider.of<JobCompleteProvider>(context);

    return AlertDialog(
      contentPadding: const EdgeInsets.all(0),
      content: Container(
        height: MediaQuery.of(context).size.height * 0.6,
        width: MediaQuery.of(context).size.width * 0.75,
        color: Colors.white,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              height: MediaQuery.of(context).size.height * 0.1,
              width: MediaQuery.of(context).size.width * 4,
              decoration: const BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.black))),
              child: Text(
                "Surveys Details",
                style: AppTheme.of(context).subtitle1,
              ),
            ),
            Expanded(
              child: Container(
                height: MediaQuery.of(context).size.height,
                padding: const EdgeInsets.all(0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                ),
                child: Column(children: [
                  Flexible(
                    child: Container(
                      // height: MediaQuery.of(context).size.height * 0.418,
                      height: MediaQuery.of(context).size.height * 0.5,
                      padding: const EdgeInsets.all(0),
                      margin: const EdgeInsets.only(bottom: 2),
                      decoration: const BoxDecoration(
                        border: Border(bottom: BorderSide(color: Colors.black)),
                      ),
                      child: Column(
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height * 0.05,
                            width: MediaQuery.of(context).size.width,
                            margin: const EdgeInsets.only(
                                top: 10, left: 10, right: 10),
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                color: const Color(0xffF7F7F7),
                                border: Border.all(
                                    color: AppTheme.of(context).gris)),
                            child: const Text("Excelent service job detail"),
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height * 0.35,
                            margin: const EdgeInsets.only(
                                bottom: 15, left: 10, right: 10),
                            child: PlutoGrid(
                              key: UniqueKey(),
                              configuration: PlutoGridConfiguration(
                                scrollbar:
                                    plutoGridScrollbarConfigDashboard(context),
                                style: plutoGridStyleConfigDashboard(context),
                                columnFilter: PlutoGridColumnFilterConfig(
                                  filters: const [
                                    ...FilterHelper.defaultFilters,
                                  ],
                                  resolveDefaultColumnFilter:
                                      (column, resolver) {
                                    if (column.field == 'ID_Column') {
                                      return resolver<PlutoFilterTypeContains>()
                                          as PlutoFilterType;
                                    } else if (column.field ==
                                        'AVATAR_Column') {
                                      return resolver<PlutoFilterTypeContains>()
                                          as PlutoFilterType;
                                    } else if (column.field == 'USER_Column') {
                                      return resolver<PlutoFilterTypeContains>()
                                          as PlutoFilterType;
                                    } else if (column.field == 'ROLE_Column') {
                                      return resolver<PlutoFilterTypeContains>()
                                          as PlutoFilterType;
                                    } else if (column.field == 'EMAIL_Column') {
                                      return resolver<PlutoFilterTypeContains>()
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
                                    WidgetSpan(
                                        child: Icon(Icons.vpn_key_outlined,
                                            color: AppTheme.of(context)
                                                .primaryBackground)),
                                    const WidgetSpan(
                                        child: SizedBox(width: 10)),
                                    TextSpan(
                                        text: 'Tech',
                                        style: AppTheme.of(context)
                                            .encabezadoTablasBlack)
                                  ]),
                                  backgroundColor:
                                      AppTheme.of(context).primaryBackground,
                                  title: 'Tech',
                                  field: 'Tech',
                                  titleTextAlign: PlutoColumnTextAlign.start,
                                  textAlign: PlutoColumnTextAlign.center,
                                  type: PlutoColumnType.text(),
                                  enableRowDrag: false,
                                  enableDropToResize: false,
                                  enableEditingMode: false,
                                  width: 120,
                                  cellPadding: EdgeInsets.zero,
                                  renderer: (rendererContext) {
                                    return Container(
                                      height: rowHeight,
                                      // width: rendererContext.cell.column.width,
                                      decoration: BoxDecoration(
                                          gradient: whiteGradient),
                                      child: Center(
                                        child: Text(
                                          rendererContext.cell.value.toString(),
                                          style: AppTheme.of(context)
                                              .contenidoTablas
                                              .override(
                                                  fontFamily: 'Gotham-Regular',
                                                  useGoogleFonts: false,
                                                  color: AppTheme.of(context)
                                                      .primaryColor),
                                        ),
                                      ),
                                    );
                                  },
                                  footerRenderer: (context) {
                                    return SizedBox(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          CustomIconButton(
                                            icon: Icons
                                                .keyboard_arrow_down_outlined,
                                            toolTip: 'less',
                                            onTap: () {
                                              provider.setPageSize('less');
                                            },
                                          ),
                                          const SizedBox(width: 10),
                                          Text(
                                            provider.pageRowCount.toString(),
                                            style: const TextStyle(
                                                color: Colors.white),
                                          ),
                                          const SizedBox(width: 10),
                                          CustomIconButton(
                                            icon: Icons
                                                .keyboard_arrow_up_outlined,
                                            toolTip: 'more',
                                            onTap: () {
                                              provider.setPageSize('more');
                                            },
                                          ),
                                          const SizedBox(width: 10),
                                          /* CustomIconButton(
                                          icon: const Icon(Icons.refresh_rounded),
                                          toolTip: 'load',
                                          onTap: () {
                                            provider.load();
                                          },
                                        ), */
                                        ],
                                      ),
                                    );
                                  },
                                ),
                                PlutoColumn(
                                  titleSpan: TextSpan(children: [
                                    WidgetSpan(
                                        child: Icon(Icons.person_outline,
                                            color: AppTheme.of(context)
                                                .primaryBackground)),
                                    const WidgetSpan(
                                        child: SizedBox(width: 10)),
                                    TextSpan(
                                        text: 'Jobld',
                                        style: AppTheme.of(context)
                                            .encabezadoTablasBlack)
                                  ]),
                                  backgroundColor:
                                      AppTheme.of(context).primaryBackground,
                                  title: 'Jobld',
                                  field: 'Jobld',
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
                                  footerRenderer: (context) {
                                    return SizedBox(
                                      height: 50,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          CustomIconButton(
                                            icon: Icons
                                                .keyboard_double_arrow_left,
                                            toolTip: 'start',
                                            onTap: () {
                                              provider.setPage('start');
                                            },
                                          ),
                                          const SizedBox(width: 2),
                                          CustomIconButton(
                                            icon: Icons
                                                .keyboard_arrow_left_outlined,
                                            toolTip: 'previous',
                                            onTap: () {
                                              provider.setPage('previous');
                                            },
                                          ),
                                          const SizedBox(width: 5),
                                          SizedBox(
                                            width: 30,
                                            child: Center(
                                              child: Text(
                                                provider.page.toString(),
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 5),
                                          CustomIconButton(
                                            icon: Icons
                                                .keyboard_arrow_right_outlined,
                                            toolTip: 'next',
                                            onTap: () {
                                              provider.setPage('next');
                                            },
                                          ),
                                          const SizedBox(width: 2),
                                          CustomIconButton(
                                            icon: Icons
                                                .keyboard_double_arrow_right,
                                            toolTip: 'end',
                                            onTap: () {
                                              provider.setPage('end');
                                            },
                                          ),
                                        ],
                                      ),
                                    );
                                    //PlutoPagination(context.stateManager);
                                  },
                                ),
                                PlutoColumn(
                                  titleSpan: TextSpan(children: [
                                    WidgetSpan(
                                        child: Icon(Icons.local_offer_outlined,
                                            color: AppTheme.of(context)
                                                .primaryBackground)),
                                    const WidgetSpan(
                                        child: SizedBox(width: 10)),
                                    TextSpan(
                                        text: 'Type',
                                        style: AppTheme.of(context)
                                            .encabezadoTablasBlack)
                                  ]),
                                  backgroundColor:
                                      AppTheme.of(context).primaryBackground,
                                  title: 'Type',
                                  field: 'Type',
                                  width: 150,
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
                                    WidgetSpan(
                                        child: Icon(Icons.alternate_email,
                                            color: AppTheme.of(context)
                                                .primaryBackground)),
                                    const WidgetSpan(
                                        child: SizedBox(width: 10)),
                                    TextSpan(
                                        text: 'Account',
                                        style: AppTheme.of(context)
                                            .encabezadoTablasBlack)
                                  ]),
                                  backgroundColor:
                                      AppTheme.of(context).primaryBackground,
                                  title: 'Account',
                                  field: 'Account',
                                  width: 170,
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
                                    WidgetSpan(
                                        child: Icon(Icons.phone_outlined,
                                            color: AppTheme.of(context)
                                                .primaryBackground)),
                                    const WidgetSpan(
                                        child: SizedBox(width: 10)),
                                    TextSpan(
                                        text: 'Deserve Tip',
                                        style: AppTheme.of(context)
                                            .encabezadoTablasBlack)
                                  ]),
                                  backgroundColor:
                                      AppTheme.of(context).primaryBackground,
                                  title: 'Deserve Tip',
                                  field: 'Deserve Tip',
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
                                PlutoColumn(
                                  titleSpan: TextSpan(children: [
                                    WidgetSpan(
                                        child: Icon(Icons.home_outlined,
                                            color: AppTheme.of(context)
                                                .primaryBackground)),
                                    const WidgetSpan(
                                        child: SizedBox(width: 10)),
                                    TextSpan(
                                        text: 'Customer \n Message',
                                        style: AppTheme.of(context)
                                            .encabezadoTablasBlack)
                                  ]),
                                  backgroundColor:
                                      AppTheme.of(context).primaryBackground,
                                  title: 'Customer \n Message',
                                  field: 'Customer \n Message',
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
                                PlutoColumn(
                                  titleSpan: TextSpan(children: [
                                    WidgetSpan(
                                        child: Icon(Icons.location_on_outlined,
                                            color: AppTheme.of(context)
                                                .primaryBackground)),
                                    const WidgetSpan(
                                        child: SizedBox(width: 10)),
                                    TextSpan(
                                        text: 'Date Completed',
                                        style: AppTheme.of(context)
                                            .encabezadoTablasBlack)
                                  ]),
                                  backgroundColor:
                                      AppTheme.of(context).primaryBackground,
                                  title: 'Date Completed',
                                  field: 'Date Completed',
                                  width: 175,
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
                                stateManager.setPageSize(provider.pageRowCount,
                                    notify: false);
                                stateManager.setPage(provider.page);
                                return const SizedBox(height: 0, width: 0);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(5),
                    alignment: Alignment.bottomRight,
                    child: ElevatedButton(
                        onPressed: () {
                          context.pop();
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff6C757D)),
                        child: const Text(
                          "Close",
                          style: TextStyle(color: Colors.white),
                        )),
                  )
                ]),
              ),
            )
          ],
        ),
      ),
    );
  }
}
