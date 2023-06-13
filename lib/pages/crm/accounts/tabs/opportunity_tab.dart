// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:provider/provider.dart';
import 'package:rta_crm_cv/functions/money_format.dart';

import 'package:rta_crm_cv/functions/sizes.dart';
import 'package:rta_crm_cv/helpers/constants.dart';
import 'package:rta_crm_cv/helpers/globals.dart';
import 'package:rta_crm_cv/pages/crm/accounts/details/details_opportunity.dart';
import 'package:rta_crm_cv/pages/crm/accounts/popups%20tabs/create_opportunity.dart';
import 'package:rta_crm_cv/providers/crm/accounts/tabs/opportunity_provider.dart';
import 'package:rta_crm_cv/public/colors.dart';
import 'package:rta_crm_cv/theme/theme.dart';
import 'package:rta_crm_cv/widgets/custom_card.dart';
import 'package:rta_crm_cv/widgets/custom_icon_button.dart';
import 'package:rta_crm_cv/widgets/captura/custom_text_field.dart';
import 'package:rta_crm_cv/widgets/custom_text_icon_button.dart';
import 'package:rta_crm_cv/widgets/pluto_grid_cells/pluto_grid_status_cell.dart';

class OpportunitysTab extends StatefulWidget {
  const OpportunitysTab({super.key});

  @override
  State<OpportunitysTab> createState() => _OpportunitysTabState();
}

class _OpportunitysTabState extends State<OpportunitysTab> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final OpportunityProvider provider = Provider.of<OpportunityProvider>(
        context,
        listen: false,
      );
      await provider.updateState();
    });
  }

  @override
  Widget build(BuildContext context) {
    OpportunityProvider provider = Provider.of<OpportunityProvider>(context);
    return CustomCard(
      title: 'Opportunities',
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
                  width: 265,
                  child: Row(
                    children: [
                      CustomTextIconButton(
                        isLoading: false,
                        icon: Icon(Icons.filter_alt_outlined, color: AppTheme.of(context).primaryBackground),
                        text: 'Filter',
                        onTap: () => provider.stateManager!.setShowColumnFilter(!provider.stateManager!.showColumnFilter),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: CustomTextIconButton(
                          isLoading: false,
                          icon: Icon(Icons.view_column_outlined, color: AppTheme.of(context).primaryBackground),
                          text: 'Set Columns',
                          onTap: () => provider.stateManager!.showSetColumnsPopup(context),
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
                SizedBox(
                  //width: 265,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      if (currentUser!.isSales)
                        CustomTextIconButton(
                          // width: 165,
                          isLoading: false,
                          icon: Icon(Icons.add, color: AppTheme.of(context).primaryBackground),
                          text: 'Create Opportunity',
                          color: AppTheme.of(context).tertiaryColor,
                          onTap: () async {
                            provider.clearAll();
                            await showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return const CreateOpportunitysPage();
                              },
                            );
                            await provider.updateState();
                          },
                        ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: CustomTextIconButton(
                          // width: 90,
                          isLoading: false,
                          icon: Icon(Icons.file_download_outlined, color: AppTheme.of(context).primaryBackground),
                          text: 'Export',
                          color: AppTheme.of(context).primaryColor,
                          onTap: () async {
                            await provider.exportData();
                          },
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: getHeight(750, context),
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
                    if (column.field == 'ID_Column') {
                      return resolver<PlutoFilterTypeContains>() as PlutoFilterType;
                    } else if (column.field == 'ACCOUNT_Column') {
                      return resolver<PlutoFilterTypeContains>() as PlutoFilterType;
                    } else if (column.field == 'NAME_Column') {
                      return resolver<PlutoFilterTypeContains>() as PlutoFilterType;
                    } else if (column.field == 'AMOUNT_Column') {
                      return resolver<PlutoFilterTypeContains>() as PlutoFilterType;
                    } else if (column.field == 'PROBABILITY_Column') {
                      return resolver<PlutoFilterTypeContains>() as PlutoFilterType;
                    } else if (column.field == 'CLOSED_Column') {
                      return resolver<PlutoFilterTypeContains>() as PlutoFilterType;
                    } else if (column.field == 'CREATE_Column') {
                      return resolver<PlutoFilterTypeContains>() as PlutoFilterType;
                    } else if (column.field == 'LAST_Column') {
                      return resolver<PlutoFilterTypeContains>() as PlutoFilterType;
                    } else if (column.field == 'ASSIGNED_Column') {
                      return resolver<PlutoFilterTypeContains>() as PlutoFilterType;
                    } else if (column.field == 'STATUS_Column') {
                      return resolver<PlutoFilterTypeContains>() as PlutoFilterType;
                    }
                    return resolver<PlutoFilterTypeContains>() as PlutoFilterType;
                  },
                ),
              ),
              columns: [
                PlutoColumn(
                  titleSpan: TextSpan(children: [
                    WidgetSpan(child: Icon(Icons.vpn_key_outlined, color: AppTheme.of(context).primaryBackground)),
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
                  width: 120,
                  cellPadding: EdgeInsets.zero,
                  renderer: (rendererContext) {
                    return Container(
                      height: rowHeight,
                      width: rendererContext.cell.column.width,
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
                    WidgetSpan(child: Icon(Icons.location_city_outlined, color: AppTheme.of(context).primaryBackground)),
                    const WidgetSpan(child: SizedBox(width: 10)),
                    TextSpan(text: 'Account', style: AppTheme.of(context).encabezadoTablas)
                  ]),
                  backgroundColor: const Color(0XFF6491F7),
                  title: 'ACCOUNT',
                  field: 'ACCOUNT_Column',
                  width: 225,
                  titleTextAlign: PlutoColumnTextAlign.start,
                  textAlign: PlutoColumnTextAlign.center,
                  type: PlutoColumnType.text(),
                  enableEditingMode: false,
                  cellPadding: EdgeInsets.zero,
                  renderer: (rendererContext) {
                    return Container(
                      height: rowHeight,
                      width: rendererContext.cell.column.width,
                      decoration: BoxDecoration(gradient: whiteGradient),
                      child: Center(
                          child: Text(
                        rendererContext.cell.value ?? '-',
                        style: AppTheme.of(context).contenidoTablas.override(fontFamily: 'Gotham-Regular', useGoogleFonts: false),
                      )),
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
                          SizedBox(width: 30, child: Center(child: Text(provider.page.toString(), style: const TextStyle(color: Colors.white)))),
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
                    WidgetSpan(child: Icon(Icons.person_outline, color: AppTheme.of(context).primaryBackground)),
                    const WidgetSpan(child: SizedBox(width: 10)),
                    TextSpan(text: 'Name', style: AppTheme.of(context).encabezadoTablas)
                  ]),
                  backgroundColor: const Color(0XFF6491F7),
                  title: 'NAME',
                  field: 'NAME_Column',
                  width: 225,
                  titleTextAlign: PlutoColumnTextAlign.start,
                  textAlign: PlutoColumnTextAlign.center,
                  type: PlutoColumnType.text(),
                  enableEditingMode: false,
                  cellPadding: EdgeInsets.zero,
                  renderer: (rendererContext) {
                    return Container(
                      height: rowHeight,
                      width: rendererContext.cell.column.width,
                      decoration: BoxDecoration(gradient: whiteGradient),
                      child: Center(
                          child: Text(
                        rendererContext.cell.value ?? '-',
                        style: AppTheme.of(context).contenidoTablas.override(fontFamily: 'Gotham-Regular', useGoogleFonts: false),
                      )),
                    );
                  },
                ),
                PlutoColumn(
                  titleSpan: TextSpan(children: [
                    WidgetSpan(child: Icon(Icons.attach_money_outlined, color: AppTheme.of(context).primaryBackground)),
                    const WidgetSpan(child: SizedBox(width: 10)),
                    TextSpan(text: 'Quote Amount', style: AppTheme.of(context).encabezadoTablas)
                  ]),
                  backgroundColor: const Color(0XFF6491F7),
                  title: 'AMOUNT',
                  field: 'AMOUNT_Column',
                  width: 225,
                  titleTextAlign: PlutoColumnTextAlign.start,
                  textAlign: PlutoColumnTextAlign.center,
                  type: PlutoColumnType.number(),
                  enableEditingMode: false,
                  cellPadding: EdgeInsets.zero,
                  renderer: (rendererContext) {
                    return Container(
                      height: rowHeight,
                      width: rendererContext.cell.column.width,
                      decoration: BoxDecoration(gradient: whiteGradient),
                      child: Center(
                          child: Text(
                        '\$ ${moneyFormat(rendererContext.cell.value)} USD',
                        style: AppTheme.of(context).contenidoTablas.override(fontFamily: 'Gotham-Regular', useGoogleFonts: false),
                      )),
                    );
                  },
                ),
                PlutoColumn(
                  titleSpan: TextSpan(children: [
                    WidgetSpan(child: Icon(Icons.percent_outlined, color: AppTheme.of(context).primaryBackground)),
                    const WidgetSpan(child: SizedBox(width: 10)),
                    TextSpan(text: 'Probability', style: AppTheme.of(context).encabezadoTablas)
                  ]),
                  backgroundColor: const Color(0XFF6491F7),
                  title: 'PROBABILITY',
                  field: 'PROBABILITY_Column',
                  width: 225,
                  titleTextAlign: PlutoColumnTextAlign.start,
                  textAlign: PlutoColumnTextAlign.center,
                  type: PlutoColumnType.number(),
                  enableEditingMode: false,
                  cellPadding: EdgeInsets.zero,
                  renderer: (rendererContext) {
                    return Container(
                      height: rowHeight,
                      width: rendererContext.cell.column.width,
                      decoration: BoxDecoration(gradient: whiteGradient),
                      child: Center(
                          child: Text(
                        '${moneyFormat(rendererContext.cell.value)}%',
                        style: AppTheme.of(context).contenidoTablas.override(fontFamily: 'Gotham-Regular', useGoogleFonts: false),
                      )),
                    );
                  },
                ),
                PlutoColumn(
                  titleSpan: TextSpan(children: [
                    WidgetSpan(child: Icon(Icons.calendar_month_outlined, color: AppTheme.of(context).primaryBackground)),
                    const WidgetSpan(child: SizedBox(width: 10)),
                    TextSpan(text: 'Create Date', style: AppTheme.of(context).encabezadoTablas)
                  ]),
                  backgroundColor: const Color(0XFF6491F7),
                  title: 'CREATE',
                  field: 'CREATE_Column',
                  width: 225,
                  titleTextAlign: PlutoColumnTextAlign.start,
                  textAlign: PlutoColumnTextAlign.center,
                  type: PlutoColumnType.date(format: 'MMMM, MM-dd-yyyy', headerFormat: 'MM-dd-yyyy'),
                  enableEditingMode: false,
                  cellPadding: EdgeInsets.zero,
                  renderer: (rendererContext) {
                    return Container(
                      height: rowHeight,
                      width: rendererContext.cell.column.width,
                      decoration: BoxDecoration(gradient: whiteGradient),
                      child: Center(
                          child: Text(
                        rendererContext.cell.value ?? '-',
                        style: AppTheme.of(context).contenidoTablas.override(fontFamily: 'Gotham-Regular', useGoogleFonts: false),
                      )),
                    );
                  },
                ),
                PlutoColumn(
                  titleSpan: TextSpan(children: [
                    WidgetSpan(child: Icon(Icons.watch_later_outlined, color: AppTheme.of(context).primaryBackground)),
                    const WidgetSpan(child: SizedBox(width: 10)),
                    TextSpan(text: 'Last Activity', style: AppTheme.of(context).encabezadoTablas)
                  ]),
                  backgroundColor: const Color(0XFF6491F7),
                  title: 'LAST',
                  field: 'LAST_Column',
                  width: 225,
                  titleTextAlign: PlutoColumnTextAlign.start,
                  textAlign: PlutoColumnTextAlign.center,
                  type: PlutoColumnType.date(format: 'MMMM, MM-dd-yyyy', headerFormat: 'MM-dd-yyyy'),
                  enableEditingMode: false,
                  cellPadding: EdgeInsets.zero,
                  renderer: (rendererContext) {
                    return Container(
                      height: rowHeight,
                      width: rendererContext.cell.column.width,
                      decoration: BoxDecoration(gradient: whiteGradient),
                      child: Center(
                          child: Text(
                        rendererContext.cell.value ?? '-',
                        style: AppTheme.of(context).contenidoTablas.override(fontFamily: 'Gotham-Regular', useGoogleFonts: false),
                      )),
                    );
                  },
                ),
                PlutoColumn(
                  titleSpan: TextSpan(children: [
                    WidgetSpan(child: Icon(Icons.calendar_month_outlined, color: AppTheme.of(context).primaryBackground)),
                    const WidgetSpan(child: SizedBox(width: 10)),
                    TextSpan(text: 'Expected Close', style: AppTheme.of(context).encabezadoTablas)
                  ]),
                  backgroundColor: const Color(0XFF6491F7),
                  title: 'CLOSED',
                  field: 'CLOSED_Column',
                  width: 225,
                  titleTextAlign: PlutoColumnTextAlign.start,
                  textAlign: PlutoColumnTextAlign.center,
                  type: PlutoColumnType.date(format: 'MMMM, MM-dd-yyyy', headerFormat: 'MM-dd-yyyy'),
                  enableEditingMode: false,
                  cellPadding: EdgeInsets.zero,
                  renderer: (rendererContext) {
                    return Container(
                      height: rowHeight,
                      width: rendererContext.cell.column.width,
                      decoration: BoxDecoration(gradient: whiteGradient),
                      child: Center(
                          child: Text(
                        rendererContext.cell.value ?? '-',
                        style: AppTheme.of(context).contenidoTablas.override(fontFamily: 'Gotham-Regular', useGoogleFonts: false),
                      )),
                    );
                  },
                ),
                PlutoColumn(
                  titleSpan: TextSpan(children: [
                    WidgetSpan(child: Icon(Icons.local_offer_outlined, color: AppTheme.of(context).primaryBackground)),
                    const WidgetSpan(child: SizedBox(width: 10)),
                    TextSpan(text: 'Assigned To', style: AppTheme.of(context).encabezadoTablas)
                  ]),
                  backgroundColor: const Color(0XFF6491F7),
                  title: 'ASSIGNED',
                  field: 'ASSIGNED_Column',
                  width: 225,
                  titleTextAlign: PlutoColumnTextAlign.start,
                  textAlign: PlutoColumnTextAlign.center,
                  type: PlutoColumnType.text(),
                  enableEditingMode: false,
                  cellPadding: EdgeInsets.zero,
                  renderer: (rendererContext) {
                    return Container(
                      height: rowHeight,
                      width: rendererContext.cell.column.width,
                      decoration: BoxDecoration(gradient: whiteGradient),
                      child: Center(
                          child: Text(
                        rendererContext.cell.value ?? '-',
                        style: AppTheme.of(context).contenidoTablas.override(fontFamily: 'Gotham-Regular', useGoogleFonts: false),
                      )),
                    );
                  },
                ),
                PlutoColumn(
                  titleSpan: TextSpan(children: [
                    WidgetSpan(child: Icon(Icons.traffic_outlined, color: AppTheme.of(context).primaryBackground)),
                    const WidgetSpan(child: SizedBox(width: 10)),
                    TextSpan(text: 'Status', style: AppTheme.of(context).encabezadoTablas)
                  ]),
                  backgroundColor: const Color(0XFF6491F7),
                  title: 'STATUS',
                  field: 'STATUS_Column',
                  width: 175,
                  titleTextAlign: PlutoColumnTextAlign.start,
                  textAlign: PlutoColumnTextAlign.center,
                  type: PlutoColumnType.text(),
                  enableEditingMode: false,
                  cellPadding: EdgeInsets.zero,
                  renderer: (rendererContext) {
                    return PlutoGridStatusCell(text: rendererContext.cell.value);
                  },
                ),
                PlutoColumn(
                  titleSpan: TextSpan(children: [
                    WidgetSpan(child: Icon(Icons.list, color: AppTheme.of(context).primaryBackground)),
                    const WidgetSpan(child: SizedBox(width: 10)),
                    TextSpan(text: 'Actions', style: AppTheme.of(context).encabezadoTablas)
                  ]),
                  backgroundColor: const Color(0XFF6491F7),
                  title: 'ACTIONS',
                  field: 'ACTIONS_Column',
                  width: 190,
                  titleTextAlign: PlutoColumnTextAlign.start,
                  textAlign: PlutoColumnTextAlign.center,
                  type: PlutoColumnType.text(),
                  enableEditingMode: false,
                  enableSorting: false,
                  enableContextMenu: false,
                  enableDropToResize: false,
                  cellPadding: EdgeInsets.zero,
                  renderer: (rendererContext) {
                    return Container(
                      height: rowHeight,
                      width: rendererContext.cell.column.width,
                      decoration: BoxDecoration(gradient: whiteGradient),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          CustomTextIconButton(
                            isLoading: false,
                            icon: Icon(
                              Icons.remove_red_eye_outlined,
                              color: AppTheme.of(context).primaryBackground,
                            ),
                            text: 'Details',
                            onTap: () async {
                              provider.id = rendererContext.row.cells['ID_Column']!.value;
                              provider.slydervalue = rendererContext.row.cells['PROBABILITY_Column']!.value;
                              await provider.getData();
                              await showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return const DetailsOpportunity();
                                },
                              );
                              //await provider.updateState();
                              provider.editmode = false;
                            },
                          ),
                          if (currentUser!.isSales)
                            CustomTextIconButton(
                              isLoading: false,
                              icon: Icon(
                                Icons.shopping_basket_outlined,
                                color: AppTheme.of(context).primaryBackground,
                              ),
                              color: secondaryColor,
                              text: 'Delete',
                              onTap: () async {
                                provider.id = rendererContext.row.cells['ID_Column']!.value;
                                await provider.deleteOpportunity();
                                await provider.updateState();
                              },
                            ),
                        ],
                      ),
                    );
                  },
                ),
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
