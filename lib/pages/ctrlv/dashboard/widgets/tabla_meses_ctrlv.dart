import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:provider/provider.dart';
import 'package:rta_crm_cv/functions/sizes.dart';
import 'package:rta_crm_cv/helpers/constants.dart';
import 'package:rta_crm_cv/providers/ctrlv/dashboard_provider.dart';
import 'package:rta_crm_cv/public/colors.dart';
import 'package:rta_crm_cv/theme/theme.dart';
import 'package:rta_crm_cv/widgets/captura/custom_text_field.dart';
import 'package:rta_crm_cv/widgets/custom_card.dart';
import 'package:rta_crm_cv/widgets/custom_icon_button.dart';
import 'package:rta_crm_cv/widgets/custom_scrollbar.dart';
import 'package:rta_crm_cv/widgets/custom_text_icon_button.dart';

class TablaMesesCtrlV extends StatefulWidget {
  const TablaMesesCtrlV({Key? key}) : super(key: key);

  @override
  State<TablaMesesCtrlV> createState() => _TablaMesesCtrlVState();
}

class _TablaMesesCtrlVState extends State<TablaMesesCtrlV> {
  @override
  Widget build(BuildContext context) {
    DashboardCVProvider provider = Provider.of<DashboardCVProvider>(context);
    return CustomCard(
      width: getWidth(670, context),
      height: getHeight(432.91, context),
      title: 'Issues Overview History',
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: CustomScrollBar(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(
                    width: 250,
                    child: Row(
                      children: [
                        CustomTextIconButton(
                          isLoading: false,
                          icon: Icon(Icons.filter_alt_outlined,
                              color: AppTheme.of(context).primaryBackground),
                          text: 'Filter',
                          onTap: () => provider.stateManager!
                              .setShowColumnFilter(
                                  !provider.stateManager!.showColumnFilter),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: CustomTextIconButton(
                            isLoading: false,
                            icon: Icon(Icons.view_column_outlined,
                                color: AppTheme.of(context).primaryBackground),
                            text: 'Set Columns',
                            onTap: () => provider.stateManager!
                                .showSetColumnsPopup(context),
                          ),
                        ),
                      ],
                    ),
                  ),
                  CustomTextField(
                    width: 200,
                    enabled: true,
                    controller: provider.searchController,
                    icon: Icons.search,
                    label: 'Search',
                    keyboardType: TextInputType.text,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: getHeight(700, context),
            //width: getWidth(2450, context),
            child: PlutoGrid(
              key: UniqueKey(),
              configuration: PlutoGridConfiguration(
                scrollbar: plutoGridScrollbarConfig(context),
                style: plutoGridStyleConfig(context),
                columnFilter: PlutoGridColumnFilterConfig(
                  filters: const [
                    ...FilterHelper.defaultFilters,
                  ],
                  resolveDefaultColumnFilter: (column, resolver) {
                    if (column.field == 'COMPANY_Column') {
                      return resolver<PlutoFilterTypeContains>()
                          as PlutoFilterType;
                    } else if (column.field == 'LICENSE_PLATES_Column') {
                      return resolver<PlutoFilterTypeContains>()
                          as PlutoFilterType;
                    } else if (column.field == 'ISSUE_Column') {
                      return resolver<PlutoFilterTypeContains>()
                          as PlutoFilterType;
                    } else if (column.field == 'DATE_Column') {
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
                        child: Icon(Icons.warehouse_outlined,
                            color: AppTheme.of(context).primaryBackground)),
                    const WidgetSpan(child: SizedBox(width: 10)),
                    TextSpan(
                        text: 'Company',
                        style: AppTheme.of(context).encabezadoTablas)
                  ]),
                  backgroundColor: const Color(0XFF6491F7),
                  title: 'Company',
                  field: 'COMPANY_Column',
                  titleTextAlign: PlutoColumnTextAlign.start,
                  textAlign: PlutoColumnTextAlign.center,
                  type: PlutoColumnType.text(),
                  width: 170,
                  cellPadding: EdgeInsets.zero,
                  renderer: (rendererContext) {
                    return Container(
                      height: rowHeight,
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
                        ],
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
                        text: 'L. Plates',
                        style: AppTheme.of(context).encabezadoTablas)
                  ]),
                  backgroundColor: const Color(0XFF6491F7),
                  title: 'License Plates',
                  field: 'LICENSE_PLATES_Column',
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
                      decoration: BoxDecoration(gradient: whiteGradient),
                      child: Center(
                        child: Text(
                          rendererContext.cell.value ?? '-',
                          style: AppTheme.of(context).contenidoTablas.override(
                              fontFamily: 'Gotham-Regular',
                              useGoogleFonts: false),
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
                                  child: Text(provider.page.toString(),
                                      style: const TextStyle(
                                          color: Colors.white)))),
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
                  },
                ),
                PlutoColumn(
                  titleSpan: TextSpan(children: [
                    WidgetSpan(
                        child: Icon(Icons.build_outlined,
                            color: AppTheme.of(context).primaryBackground)),
                    const WidgetSpan(child: SizedBox(width: 10)),
                    TextSpan(
                        text: 'Issue',
                        style: AppTheme.of(context).encabezadoTablas)
                  ]),
                  backgroundColor: const Color(0XFF6491F7),
                  title: 'Issue',
                  field: 'ISSUE_Column',
                  width: 160,
                  titleTextAlign: PlutoColumnTextAlign.start,
                  textAlign: PlutoColumnTextAlign.center,
                  type: PlutoColumnType.text(),
                  enableEditingMode: false,
                  cellPadding: EdgeInsets.zero,
                  renderer: (rendererContext) {
                    return Container(
                      height: rowHeight,
                      // width: rendererContext.cell.column.width,
                      decoration: BoxDecoration(gradient: whiteGradient),
                      child: Center(
                          child: Text(
                        '${rendererContext.cell.value}',
                        style: AppTheme.of(context).contenidoTablas.override(
                            fontFamily: 'Gotham-Regular',
                            useGoogleFonts: false),
                      )),
                    );
                  },
                ),
                PlutoColumn(
                  titleSpan: TextSpan(children: [
                    WidgetSpan(
                        child: Icon(Icons.person_outline,
                            color: AppTheme.of(context).primaryBackground)),
                    const WidgetSpan(child: SizedBox(width: 10)),
                    TextSpan(
                        text: 'User',
                        style: AppTheme.of(context).encabezadoTablas)
                  ]),
                  backgroundColor: const Color(0XFF6491F7),
                  title: 'User',
                  field: 'USER_Column',
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
                      decoration: BoxDecoration(gradient: whiteGradient),
                      child: Center(
                          child: Text(
                        '${rendererContext.cell.value}',
                        style: AppTheme.of(context).contenidoTablas.override(
                            fontFamily: 'Gotham-Regular',
                            useGoogleFonts: false),
                      )),
                    );
                  },
                ),
                PlutoColumn(
                  titleSpan: TextSpan(children: [
                    WidgetSpan(
                        child: Icon(Icons.assignment_outlined,
                            color: AppTheme.of(context).primaryBackground)),
                    const WidgetSpan(child: SizedBox(width: 10)),
                    TextSpan(
                        text: 'Type Form',
                        style: AppTheme.of(context).encabezadoTablas)
                  ]),
                  backgroundColor: const Color(0XFF6491F7),
                  title: 'Type Form',
                  field: 'TYPE_FORM_Column',
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
                      decoration: BoxDecoration(gradient: whiteGradient),
                      child: Center(
                          child: Text(
                        '${rendererContext.cell.value}',
                        style: AppTheme.of(context).contenidoTablas.override(
                            fontFamily: 'Gotham-Regular',
                            useGoogleFonts: false),
                      )),
                    );
                  },
                ),
                PlutoColumn(
                  titleSpan: TextSpan(children: [
                    WidgetSpan(
                        child: Icon(Icons.calendar_month,
                            color: AppTheme.of(context).primaryBackground)),
                    const WidgetSpan(child: SizedBox(width: 10)),
                    TextSpan(
                        text: 'Date',
                        style: AppTheme.of(context).encabezadoTablas)
                  ]),
                  backgroundColor: const Color(0XFF6491F7),
                  title: 'Date',
                  field: 'DATE_Column',
                  width: 225,
                  titleTextAlign: PlutoColumnTextAlign.start,
                  textAlign: PlutoColumnTextAlign.center,
                  type: PlutoColumnType.text(),
                  enableEditingMode: false,
                  cellPadding: EdgeInsets.zero,
                  renderer: (rendererContext) {
                    return Container(
                      height: rowHeight,
                      // width: rendererContext.cell.column.width,
                      decoration: BoxDecoration(gradient: whiteGradient),
                      child: Center(
                        child: Text(
                          DateFormat("MMM-dd-yyyy hh:mm:ss").format(rendererContext.cell.value),
                          style: AppTheme.of(context).contenidoTablas.override(
                              fontFamily: 'Gotham-Regular',
                              useGoogleFonts: false),
                        ),
                      ),
                    );
                  },
                ),
              ],
              rows: provider.rows2,
              onLoaded: (event) async {
                provider.stateManager = event.stateManager;
              },
              createFooter: (stateManager) {
                stateManager.setPageSize(provider.pageRowCount);
                stateManager.setPage(provider.page);
                return const SizedBox(height: 0, width: 0);
              },
            ),
          ),
        ],
      ),
    );
  }
}
