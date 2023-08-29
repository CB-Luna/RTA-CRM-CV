import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:provider/provider.dart';
import 'package:rta_crm_cv/functions/sizes.dart';
import 'package:rta_crm_cv/helpers/constants.dart';
import 'package:rta_crm_cv/providers/crm/dashboard_provider.dart';
import 'package:rta_crm_cv/public/colors.dart';
import 'package:rta_crm_cv/theme/theme.dart';
import 'package:rta_crm_cv/widgets/captura/custom_text_field.dart';
import 'package:rta_crm_cv/widgets/custom_card.dart';
import 'package:rta_crm_cv/widgets/custom_icon_button.dart';
import 'package:rta_crm_cv/widgets/custom_text_icon_button.dart';

class TransactionHistory extends StatefulWidget {
  const TransactionHistory({Key? key}) : super(key: key);

  @override
  State<TransactionHistory> createState() => _TransactionHistoryState();
}

class _TransactionHistoryState extends State<TransactionHistory> {
  @override
  Widget build(BuildContext context) {
    DashboardCRMProvider provider = Provider.of<DashboardCRMProvider>(context);
    return CustomCard(
      title: 'Transaction History',
      width: getWidth(1030, context),
      //height: getHeight(280, context),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
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
                        onTap: () => provider.stateManager!.setShowColumnFilter(
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
                  width: 500,
                  enabled: true,
                  controller: provider.searchController,
                  icon: Icons.search,
                  label: 'Search',
                  keyboardType: TextInputType.text,
                ),
                SizedBox(width: getWidth(56, context)),
              ],
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
                    if (column.field == 'ID') {
                      return resolver<PlutoFilterTypeContains>()
                          as PlutoFilterType;
                    } else if (column.field == 'CREATE_AT') {
                      return resolver<PlutoFilterTypeContains>()
                          as PlutoFilterType;
                    } else if (column.field == 'USER') {
                      return resolver<PlutoFilterTypeContains>()
                          as PlutoFilterType;
                    } else if (column.field == 'ACTION') {
                      return resolver<PlutoFilterTypeContains>()
                          as PlutoFilterType;
                    } else if (column.field == 'DESCRIPTION') {
                      return resolver<PlutoFilterTypeContains>()
                          as PlutoFilterType;
                    } else if (column.field == 'TABLE') {
                      return resolver<PlutoFilterTypeContains>()
                          as PlutoFilterType;
                    } else if (column.field == 'ID_TABLE') {
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
                            color: AppTheme.of(context).primaryBackground)),
                    const WidgetSpan(child: SizedBox(width: 10)),
                    TextSpan(
                        text: 'ID',
                        style: TextStyle(
                            color: AppTheme.of(context).primaryBackground))
                  ]),
                  backgroundColor: const Color(0XFF6491F7),
                  title: 'ID',
                  field: 'ID',
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
                      decoration: BoxDecoration(gradient: whiteGradient),
                      child: Center(
                        child: Text(
                          rendererContext.cell.value.toString(),
                          style: AppTheme.of(context).contenidoTablas.override(
                                fontFamily: 'Gotham-Regular',
                                useGoogleFonts: false,
                                color: AppTheme.of(context).primaryColor,
                              ),
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
                        child: Icon(Icons.calendar_month_outlined,
                            color: AppTheme.of(context).primaryBackground)),
                    const WidgetSpan(child: SizedBox(width: 10)),
                    TextSpan(
                        text: 'Create Date',
                        style: TextStyle(
                            color: AppTheme.of(context).primaryBackground))
                  ]),
                  backgroundColor: const Color(0XFF6491F7),
                  title: 'CREATE',
                  field: 'CREATE_AT',
                  width: 225,
                  titleTextAlign: PlutoColumnTextAlign.start,
                  textAlign: PlutoColumnTextAlign.center,
                  type: PlutoColumnType.date(
                      format: 'MMMM, MM-dd-yyyy', headerFormat: 'MM-dd-yyyy'),
                  enableEditingMode: false,
                  cellPadding: EdgeInsets.zero,
                  renderer: (rendererContext) {
                    return Container(
                      height: rowHeight,
                      // width: rendererContext.cell.column.width,
                      decoration: BoxDecoration(gradient: whiteGradient),
                      child: Center(
                          child: Text(rendererContext.cell.value ?? '-')),
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
                        child: Icon(Icons.person_outline,
                            color: AppTheme.of(context).primaryBackground)),
                    const WidgetSpan(child: SizedBox(width: 10)),
                    TextSpan(
                        text: 'Name',
                        style: TextStyle(
                            color: AppTheme.of(context).primaryBackground))
                  ]),
                  backgroundColor: const Color(0XFF6491F7),
                  title: 'Name',
                  field: 'NAME',
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
                          child: Text(rendererContext.cell.value ?? '-')),
                    );
                  },
                ),
                /* PlutoColumn(
                  titleSpan: TextSpan(children: [
                    WidgetSpan(
                        child: Icon(Icons.person_outline,
                            color: AppTheme.of(context).primaryBackground)),
                    const WidgetSpan(child: SizedBox(width: 10)),
                    TextSpan(
                        text: 'User',
                        style: TextStyle(
                            color: AppTheme.of(context).primaryBackground))
                  ]),
                  backgroundColor: const Color(0XFF6491F7),
                  title: 'User',
                  field: 'USER',
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
                          child: Text(rendererContext.cell.value ?? '-')),
                    );
                  },
                ), */
                PlutoColumn(
                  titleSpan: TextSpan(children: [
                    WidgetSpan(
                        child: Icon(Icons.history_edu,
                            color: AppTheme.of(context).primaryBackground)),
                    const WidgetSpan(child: SizedBox(width: 10)),
                    TextSpan(
                        text: 'Action',
                        style: TextStyle(
                            color: AppTheme.of(context).primaryBackground))
                  ]),
                  backgroundColor: const Color(0XFF6491F7),
                  title: 'Action',
                  field: 'ACTION',
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
                          child: Text(rendererContext.cell.value ?? '-')),
                    );
                  },
                ),
                PlutoColumn(
                  titleSpan: TextSpan(children: [
                    WidgetSpan(
                        child: Icon(Icons.description,
                            color: AppTheme.of(context).primaryBackground)),
                    const WidgetSpan(child: SizedBox(width: 10)),
                    TextSpan(
                        text: 'Description',
                        style: TextStyle(
                            color: AppTheme.of(context).primaryBackground))
                  ]),
                  backgroundColor: const Color(0XFF6491F7),
                  title: 'Description',
                  field: 'DESCRIPTION',
                  width: 1105,
                  //width: 225,
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
                          child: Text(rendererContext.cell.value ?? '-')),
                    );
                  },
                ),
                /*  PlutoColumn(
                  titleSpan: TextSpan(children: [
                    WidgetSpan(
                        child: Icon(Icons.table_chart,
                            color: AppTheme.of(context).primaryBackground)),
                    const WidgetSpan(child: SizedBox(width: 10)),
                    TextSpan(
                        text: 'Table',
                        style: TextStyle(
                            color: AppTheme.of(context).primaryBackground))
                  ]),
                  backgroundColor: const Color(0XFF6491F7),
                  title: 'Table',
                  field: 'TABLE',
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
                          child: Text(rendererContext.cell.value ?? '-')),
                    );
                  },
                ), */
                /* PlutoColumn(
                  titleSpan: TextSpan(children: [
                    WidgetSpan(
                        child: Icon(Icons.vpn_key_outlined,
                            color: AppTheme.of(context).primaryBackground)),
                    const WidgetSpan(child: SizedBox(width: 10)),
                    TextSpan(
                        text: 'Id Table',
                        style: TextStyle(
                            color: AppTheme.of(context).primaryBackground))
                  ]),
                  backgroundColor: const Color(0XFF6491F7),
                  title: 'Id Table',
                  field: 'ID_TABLE',
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
                      decoration: BoxDecoration(gradient: whiteGradient),
                      child: Center(
                          child: Text(rendererContext.cell.value ?? '-')),
                    );
                  },
                ), */
              ],
              rows: provider.rows,
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
