// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:provider/provider.dart';
import 'package:rta_crm_cv/widgets/custom_icon_button.dart';

import '../../../../functions/sizes.dart';
import '../../../../helpers/constants.dart';
import '../../../../providers/jsa/jsa_dashboards_provider.dart';
import '../../../../public/colors.dart';
import '../../../../theme/theme.dart';
import '../../../../widgets/pluto_grid_cells/pluto_grid_cell_jsa_status.dart';
import '../../../../widgets/side_menu/widgets/surveys/homeowner_ftth_document/widgets/pdf_popup.dart';
import 'pdf_popup.dart';

class PlutoGridDashboardJSA extends StatefulWidget {
  const PlutoGridDashboardJSA({super.key});

  @override
  State<PlutoGridDashboardJSA> createState() => _PlutoGridDashboardJSAState();
}

class _PlutoGridDashboardJSAState extends State<PlutoGridDashboardJSA> {
  @override
  Widget build(BuildContext context) {
    JSADashboardProvider provider = Provider.of<JSADashboardProvider>(context);
    return Container(
      height: getHeight(300, context),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: PlutoGrid(
        key: UniqueKey(),
        configuration: PlutoGridConfiguration(
          scrollbar: plutoGridScrollbarConfig(context),
          style: plutoGridStyleConfigJSA(context),
          columnFilter: PlutoGridColumnFilterConfig(
            filters: const [
              ...FilterHelper.defaultFilters,
            ],
            resolveDefaultColumnFilter: (column, resolver) {
              if (column.field == 'ID_Column') {
                return resolver<PlutoFilterTypeContains>() as PlutoFilterType;
              } else if (column.field == 'ACCOUNT_Column') {
                return resolver<PlutoFilterTypeContains>() as PlutoFilterType;
              } else if (column.field == 'NAME_Column') {
                return resolver<PlutoFilterTypeContains>() as PlutoFilterType;
              } else if (column.field == 'TOTAL_Column') {
                return resolver<PlutoFilterTypeContains>() as PlutoFilterType;
              }
              return resolver<PlutoFilterTypeContains>() as PlutoFilterType;
            },
          ),
        ),
        columns: [
          PlutoColumn(
            titleSpan: TextSpan(children: [
              WidgetSpan(
                  child: Icon(Icons.calendar_today_outlined,
                      color: AppTheme.of(context).primaryBackground)),
              const WidgetSpan(child: SizedBox(width: 10)),
              TextSpan(text: 'ID', style: AppTheme.of(context).encabezadoTablas)
            ]),
            backgroundColor: const Color(0XFF6491F7),
            title: 'ID',
            field: 'ID_Column',
            titleTextAlign: PlutoColumnTextAlign.start,
            textAlign: PlutoColumnTextAlign.center,
            type: PlutoColumnType.text(),
            enableRowDrag: false,
            enableDropToResize: false,
            enableEditingMode: false,
            enableContextMenu: false,
            width: 175,
            cellPadding: EdgeInsets.zero,
            renderer: (rendererContext) {
              return Container(
                height: rowHeightJSA,
                // width: rendererContext.cell.column.width,
                decoration: BoxDecoration(gradient: whiteGradient),
                child: Center(
                  child: Text(
                    rendererContext.cell.value.toString(),
                    style: AppTheme.of(context).contenidoTablas.override(
                        fontFamily: 'Gotham-Regular',
                        useGoogleFonts: false,
                        color: AppTheme.of(context).primaryColor),
                  ),
                ),
              );
            },
            footerRenderer: (context) {
              return SizedBox(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomIconButton(
                      icon: Icons.keyboard_arrow_down_outlined,
                      toolTip: 'less',
                      onTap: () {
                        provider.setPageSize('less');
                      },
                    ),
                    const SizedBox(width: 10),
                    Text(
                      provider.pageRowCount.toString(),
                      style: const TextStyle(color: Colors.white),
                    ),
                    const SizedBox(width: 10),
                    CustomIconButton(
                      icon: Icons.keyboard_arrow_up_outlined,
                      toolTip: 'more',
                      onTap: () {
                        provider.setPageSize('more');
                      },
                    ),
                    const SizedBox(width: 10),
                  ],
                ),
              );
            },
          ),
          PlutoColumn(
            titleSpan: TextSpan(children: [
              WidgetSpan(
                  child: Icon(Icons.description_outlined,
                      color: AppTheme.of(context).primaryBackground)),
              const WidgetSpan(child: SizedBox(width: 10)),
              TextSpan(
                  text: 'Created By',
                  style: AppTheme.of(context).encabezadoTablas)
            ]),
            backgroundColor: const Color(0XFF6491F7),
            title: 'CREATED',
            field: 'CREATED_Column',
            titleTextAlign: PlutoColumnTextAlign.start,
            textAlign: PlutoColumnTextAlign.center,
            type: PlutoColumnType.text(),
            enableRowDrag: false,
            enableDropToResize: false,
            enableEditingMode: false,
            enableContextMenu: false,
            width: 185,
            cellPadding: EdgeInsets.zero,
            renderer: (rendererContext) {
              return Container(
                height: rowHeightJSA,
                // width: rendererContext.cell.column.width,
                decoration: BoxDecoration(gradient: whiteGradient),
                child: Center(
                  child: Text(
                    rendererContext.cell.value.toString(),
                    style: AppTheme.of(context).contenidoTablas.override(
                        fontFamily: 'Gotham-Regular',
                        useGoogleFonts: false,
                        color: AppTheme.of(context).primaryColor),
                  ),
                ),
              );
            },
            footerRenderer: (context) {
              return SizedBox(
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomIconButton(
                      icon: Icons.keyboard_double_arrow_left,
                      toolTip: 'start',
                      onTap: () {
                        provider.setPage('start');
                      },
                    ),
                    const SizedBox(width: 2),
                    CustomIconButton(
                      icon: Icons.keyboard_arrow_left_outlined,
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
                      icon: Icons.keyboard_arrow_right_outlined,
                      toolTip: 'next',
                      onTap: () {
                        provider.setPage('next');
                      },
                    ),
                    const SizedBox(width: 2),
                    CustomIconButton(
                      icon: Icons.keyboard_double_arrow_right,
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
                  child: Icon(Icons.work_outlined,
                      color: AppTheme.of(context).primaryBackground)),
              const WidgetSpan(child: SizedBox(width: 10)),
              TextSpan(
                  text: 'Title', style: AppTheme.of(context).encabezadoTablas)
            ]),
            backgroundColor: const Color(0XFF6491F7),
            title: 'TITLE',
            field: 'TITLE_Column',
            titleTextAlign: PlutoColumnTextAlign.start,
            textAlign: PlutoColumnTextAlign.center,
            type: PlutoColumnType.text(),
            enableRowDrag: false,
            enableDropToResize: false,
            enableContextMenu: false,
            enableEditingMode: false,
            width: 175,
            cellPadding: EdgeInsets.zero,
            renderer: (rendererContext) {
              return Container(
                height: rowHeightJSA,
                // width: rendererContext.cell.column.width,
                decoration: BoxDecoration(gradient: whiteGradient),
                child: Center(
                  child: Text(
                    rendererContext.cell.value.toString(),
                    style: AppTheme.of(context).contenidoTablas.override(
                        fontFamily: 'Gotham-Regular',
                        useGoogleFonts: false,
                        color: AppTheme.of(context).primaryColor),
                  ),
                ),
              );
            },
          ),
          PlutoColumn(
            titleSpan: TextSpan(children: [
              WidgetSpan(
                  child: Icon(Icons.sell_outlined,
                      color: AppTheme.of(context).primaryBackground)),
              const WidgetSpan(child: SizedBox(width: 10)),
              TextSpan(
                  text: 'Num. Employee',
                  style: AppTheme.of(context).encabezadoTablas)
            ]),
            backgroundColor: const Color(0XFF6491F7),
            title: 'NUM_EMPL',
            field: 'NUM_EMPL_Column',
            titleTextAlign: PlutoColumnTextAlign.start,
            textAlign: PlutoColumnTextAlign.center,
            type: PlutoColumnType.text(),
            enableRowDrag: false,
            enableDropToResize: false,
            enableEditingMode: false,
            enableContextMenu: false,
            width: 175,
            cellPadding: EdgeInsets.zero,
            renderer: (rendererContext) {
              return Container(
                height: rowHeightJSA,
                // width: rendererContext.cell.column.width,
                decoration: BoxDecoration(gradient: whiteGradient),
                child: Center(
                  child: Text(
                    rendererContext.cell.value.toString(),
                    style: AppTheme.of(context).contenidoTablas.override(
                        fontFamily: 'Gotham-Regular',
                        useGoogleFonts: false,
                        color: AppTheme.of(context).primaryColor),
                  ),
                ),
              );
            },
          ),
          PlutoColumn(
            titleSpan: TextSpan(children: [
              WidgetSpan(
                  child: Icon(Icons.credit_card_outlined,
                      color: AppTheme.of(context).primaryBackground)),
              const WidgetSpan(child: SizedBox(width: 10)),
              TextSpan(
                  text: 'Creation Date',
                  style: AppTheme.of(context).encabezadoTablas)
            ]),
            backgroundColor: const Color(0XFF6491F7),
            title: 'CREATION',
            field: 'CREATION_Column',
            titleTextAlign: PlutoColumnTextAlign.start,
            textAlign: PlutoColumnTextAlign.center,
            type: PlutoColumnType.text(),
            enableRowDrag: false,
            enableDropToResize: false,
            enableEditingMode: false,
            enableContextMenu: false,
            width: 175,
            cellPadding: EdgeInsets.zero,
            renderer: (rendererContext) {
              return Container(
                height: rowHeightJSA,
                // width: rendererContext.cell.column.width,
                decoration: BoxDecoration(gradient: whiteGradient),
                child: Center(
                  child: Text(
                    rendererContext.cell.value.toString(),
                    style: AppTheme.of(context).contenidoTablas.override(
                        fontFamily: 'Gotham-Regular',
                        useGoogleFonts: false,
                        color: AppTheme.of(context).primaryColor),
                  ),
                ),
              );
            },
          ),
          PlutoColumn(
            titleSpan: TextSpan(children: [
              WidgetSpan(
                  child: Icon(Icons.sell_outlined,
                      color: AppTheme.of(context).primaryBackground)),
              const WidgetSpan(child: SizedBox(width: 10)),
              TextSpan(
                  text: 'Send Date',
                  style: AppTheme.of(context).encabezadoTablas)
            ]),
            backgroundColor: const Color(0XFF6491F7),
            title: 'SEND',
            field: 'SEND_Column',
            titleTextAlign: PlutoColumnTextAlign.start,
            textAlign: PlutoColumnTextAlign.center,
            type: PlutoColumnType.text(),
            enableRowDrag: false,
            enableDropToResize: false,
            enableContextMenu: false,
            enableEditingMode: false,
            width: 175,
            cellPadding: EdgeInsets.zero,
            renderer: (rendererContext) {
              return Container(
                height: rowHeightJSA,
                // width: rendererContext.cell.column.width,
                decoration: BoxDecoration(gradient: whiteGradient),
                child: Center(
                  child: Text(
                    rendererContext.cell.value.toString(),
                    style: AppTheme.of(context).contenidoTablas.override(
                        fontFamily: 'Gotham-Regular',
                        useGoogleFonts: false,
                        color: AppTheme.of(context).primaryColor),
                  ),
                ),
              );
            },
          ),
          PlutoColumn(
            titleSpan: TextSpan(children: [
              WidgetSpan(
                  child: Icon(Icons.sell_outlined,
                      color: AppTheme.of(context).primaryBackground)),
              const WidgetSpan(child: SizedBox(width: 10)),
              TextSpan(
                  text: 'Status', style: AppTheme.of(context).encabezadoTablas)
            ]),
            backgroundColor: const Color(0XFF6491F7),
            title: 'STATUS',
            field: 'STATUS_Column',
            titleTextAlign: PlutoColumnTextAlign.start,
            textAlign: PlutoColumnTextAlign.center,
            type: PlutoColumnType.text(),
            enableRowDrag: false,
            enableContextMenu: false,
            enableDropToResize: false,
            enableEditingMode: false,
            width: 175,
            cellPadding: EdgeInsets.zero,
            renderer: (rendererContext) {
              return PlutoGrdiJsaStatus(
                  text: rendererContext.cell.value ?? "-");
            },
          ),
          PlutoColumn(
            titleSpan: TextSpan(children: [
              WidgetSpan(
                  child: Icon(Icons.menu_outlined,
                      color: AppTheme.of(context).primaryBackground)),
              const WidgetSpan(child: SizedBox(width: 10)),
              TextSpan(
                  text: 'Preview', style: AppTheme.of(context).encabezadoTablas)
            ]),
            backgroundColor: const Color(0XFF6491F7),
            title: 'PREVIEW',
            field: 'PREVIEW_Column',
            titleTextAlign: PlutoColumnTextAlign.start,
            textAlign: PlutoColumnTextAlign.center,
            type: PlutoColumnType.text(),
            enableRowDrag: false,
            enableDropToResize: false,
            enableContextMenu: false,
            enableEditingMode: false,
            width: 175,
            cellPadding: EdgeInsets.zero,
            renderer: (rendererContext) {
              return InkWell(
                onTap: () async {
                  await provider.pickDocument(rendererContext.cell.value);
                  await showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return const PdfPopupJSA();
                    },
                  );
                },
                child: Container(
                  height: rowHeightJSA,
                  // width: rendererContext.cell.column.width,
                  decoration: BoxDecoration(gradient: whiteGradient),
                  child: Center(
                      child: Icon(
                    Icons.remove_red_eye_outlined,
                    color: AppTheme.of(context).primaryColor,
                  )),
                ),
              );
            },
          ),
        ],
        rows: provider.rows,
        onLoaded: (event) async {
          event.stateManager.setShowLoading(provider.loadingGrid);
          provider.stateManager = event.stateManager;
        },
        createFooter: (stateManager) {
          stateManager.setPageSize(provider.pageRowCount);
          stateManager.setPage(provider.page);
          return const SizedBox(height: 0, width: 0);
        },
      ),
    );
  }
}
