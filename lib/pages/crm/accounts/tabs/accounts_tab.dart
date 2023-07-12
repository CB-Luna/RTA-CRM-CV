import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:provider/provider.dart';
import 'package:rta_crm_cv/functions/money_format.dart';

import 'package:rta_crm_cv/functions/sizes.dart';
import 'package:rta_crm_cv/helpers/constants.dart';
import 'package:rta_crm_cv/helpers/globals.dart';
import 'package:rta_crm_cv/providers/crm/accounts/tabs/accounts_provider.dart';
import 'package:rta_crm_cv/public/colors.dart';
import 'package:rta_crm_cv/theme/theme.dart';
import 'package:rta_crm_cv/widgets/custom_card.dart';
import 'package:rta_crm_cv/widgets/custom_icon_button.dart';
import 'package:rta_crm_cv/widgets/captura/custom_text_field.dart';
import 'package:rta_crm_cv/widgets/custom_text_icon_button.dart';
import 'package:rta_crm_cv/widgets/pluto_grid_cells/pluto_grid_status_cell.dart';

class AccountsTab extends StatefulWidget {
  const AccountsTab({super.key});

  @override
  State<AccountsTab> createState() => _AccountsTabState();
}

class _AccountsTabState extends State<AccountsTab> {
  @override
  Widget build(BuildContext context) {
    AccountsProvider provider = Provider.of<AccountsProvider>(context);
    return CustomCard(
      title: 'Accounts',
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
                  width: 250,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      if (currentUser!.isSales)
                        CustomTextIconButton(
                          //width: 131,
                          isLoading: false,
                          icon: Icon(Icons.add, color: AppTheme.of(context).primaryBackground),
                          text: 'Create Account',
                          color: AppTheme.of(context).tertiaryColor,
                          onTap: () async {
                            // context.pushReplacement(routeQuoteCreation);
                          },
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
                    } else if (column.field == 'NAME_Column') {
                      return resolver<PlutoFilterTypeContains>() as PlutoFilterType;
                    } else if (column.field == 'TYPE_Column') {
                      return resolver<PlutoFilterTypeContains>() as PlutoFilterType;
                    } else if (column.field == 'REVENUE_Column') {
                      return resolver<PlutoFilterTypeContains>() as PlutoFilterType;
                    } else if (column.field == 'PHONE_Column') {
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
                      // width: rendererContext.cell.column.width,
                      decoration: BoxDecoration(gradient: whiteGradient),
                      child: Center(
                        child: Text(
                          rendererContext.cell.value.toString(),
                          style: AppTheme.of(context).contenidoTablas.override(fontFamily: 'Gotham-Regular', useGoogleFonts: false, color: AppTheme.of(context).primaryColor),
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
                    WidgetSpan(child: Icon(Icons.person_outline, color: AppTheme.of(context).primaryBackground)),
                    const WidgetSpan(child: SizedBox(width: 10)),
                    TextSpan(text: 'Name', style: AppTheme.of(context).encabezadoTablas)
                  ]),
                  backgroundColor: const Color(0XFF6491F7),
                  title: 'NAME',
                  field: 'NAME_Column',
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
                    WidgetSpan(child: Icon(Icons.local_offer_outlined, color: AppTheme.of(context).primaryBackground)),
                    const WidgetSpan(child: SizedBox(width: 10)),
                    TextSpan(text: 'Type', style: AppTheme.of(context).encabezadoTablas)
                  ]),
                  backgroundColor: const Color(0XFF6491F7),
                  title: 'TYPE',
                  field: 'TYPE_Column',
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
                        rendererContext.cell.value ?? '-',
                        style: AppTheme.of(context).contenidoTablas.override(fontFamily: 'Gotham-Regular', useGoogleFonts: false),
                      )),
                    );
                  },
                ),
                PlutoColumn(
                  titleSpan: TextSpan(children: [
                    WidgetSpan(child: Icon(Icons.attach_money, color: AppTheme.of(context).primaryBackground)),
                    const WidgetSpan(child: SizedBox(width: 10)),
                    TextSpan(text: 'Revenue', style: AppTheme.of(context).encabezadoTablas)
                  ]),
                  backgroundColor: const Color(0XFF6491F7),
                  title: 'REVENUE',
                  field: 'REVENUE_Column',
                  width: 225,
                  titleTextAlign: PlutoColumnTextAlign.start,
                  textAlign: PlutoColumnTextAlign.center,
                  type: PlutoColumnType.number(),
                  enableEditingMode: false,
                  cellPadding: EdgeInsets.zero,
                  renderer: (rendererContext) {
                    return Container(
                      height: rowHeight,
                      // width: rendererContext.cell.column.width,
                      decoration: BoxDecoration(gradient: whiteGradient),
                      child: Center(
                          child: Text(
                        '\$ ${moneyFormat(rendererContext.cell.value)}% USD',
                        style: AppTheme.of(context).contenidoTablas.override(fontFamily: 'Gotham-Regular', useGoogleFonts: false),
                      )),
                    );
                  },
                ),
                PlutoColumn(
                  titleSpan: TextSpan(children: [
                    WidgetSpan(child: Icon(Icons.phone_outlined, color: AppTheme.of(context).primaryBackground)),
                    const WidgetSpan(child: SizedBox(width: 10)),
                    TextSpan(text: 'Phone', style: AppTheme.of(context).encabezadoTablas)
                  ]),
                  backgroundColor: const Color(0XFF6491F7),
                  title: 'PHONE',
                  field: 'PHONE_Column',
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
                        rendererContext.cell.value,
                        style: AppTheme.of(context).contenidoTablas.override(fontFamily: 'Gotham-Regular', useGoogleFonts: false),
                      )),
                    );
                  },
                ),
                PlutoColumn(
                  titleSpan: TextSpan(children: [
                    WidgetSpan(child: Icon(Icons.watch_later_outlined, color: AppTheme.of(context).primaryBackground)),
                    const WidgetSpan(child: SizedBox(width: 10)),
                    TextSpan(text: 'Last Updated', style: AppTheme.of(context).encabezadoTablas)
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
                      // width: rendererContext.cell.column.width,
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
                      // width: rendererContext.cell.column.width,
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
                    return PlutoGridStatusCell(text: rendererContext.cell.value, id: 1); //TODO: Change
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
                  width: 280,
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
                      // width: rendererContext.cell.column.width,
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
                            onTap: () {},
                          ),
                          if (currentUser!.isSales)
                            CustomTextIconButton(
                              isLoading: false,
                              icon: Icon(
                                Icons.fact_check_outlined,
                                color: AppTheme.of(context).primaryBackground,
                              ),
                              text: 'Edit',
                              onTap: () {},
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
                              onTap: () {},
                            ),
                        ],
                      ),
                    );
                  },
                ),
              ],
              rows: /* provider.rows */
                  [
                PlutoRow(
                  cells: {
                    'ID_Column': PlutoCell(value: 1),
                    'NAME_Column': PlutoCell(value: 'Denbury, INC'),
                    'TYPE_Column': PlutoCell(value: null),
                    'REVENUE_Column': PlutoCell(value: 0),
                    'PHONE_Column': PlutoCell(value: '(979) 421-3794'),
                    'LAST_Column': PlutoCell(value: DateTime(2023, 4, 4)),
                    'ASSIGNED_Column': PlutoCell(value: 'Frank Befera'),
                    'STATUS_Column': PlutoCell(value: null),
                    'ACTIONS_Column': PlutoCell(value: null),
                  },
                ),
                PlutoRow(
                  cells: {
                    'ID_Column': PlutoCell(value: 2),
                    'NAME_Column': PlutoCell(value: 'Grand Pines RV'),
                    'TYPE_Column': PlutoCell(value: null),
                    'REVENUE_Column': PlutoCell(value: 0),
                    'PHONE_Column': PlutoCell(value: '(979) 421-3794'),
                    'LAST_Column': PlutoCell(value: DateTime(2023, 4, 4)),
                    'ASSIGNED_Column': PlutoCell(value: 'Frank Befera'),
                    'STATUS_Column': PlutoCell(value: null),
                    'ACTIONS_Column': PlutoCell(value: null),
                  },
                ),
                PlutoRow(
                  cells: {
                    'ID_Column': PlutoCell(value: 3),
                    'NAME_Column': PlutoCell(value: 'Camp QYB'),
                    'TYPE_Column': PlutoCell(value: null),
                    'REVENUE_Column': PlutoCell(value: 0),
                    'PHONE_Column': PlutoCell(value: '(979) 421-3794'),
                    'LAST_Column': PlutoCell(value: DateTime(2023, 4, 4)),
                    'ASSIGNED_Column': PlutoCell(value: 'Frank Befera'),
                    'STATUS_Column': PlutoCell(value: null),
                    'ACTIONS_Column': PlutoCell(value: null),
                  },
                ),
                PlutoRow(
                  cells: {
                    'ID_Column': PlutoCell(value: 4),
                    'NAME_Column': PlutoCell(value: 'Hakuna Matata Investments'),
                    'TYPE_Column': PlutoCell(value: null),
                    'REVENUE_Column': PlutoCell(value: 0),
                    'PHONE_Column': PlutoCell(value: '(979) 421-3794'),
                    'LAST_Column': PlutoCell(value: DateTime(2023, 4, 4)),
                    'ASSIGNED_Column': PlutoCell(value: 'Frank Befera'),
                    'STATUS_Column': PlutoCell(value: null),
                    'ACTIONS_Column': PlutoCell(value: null),
                  },
                ),
                PlutoRow(
                  cells: {
                    'ID_Column': PlutoCell(value: 5),
                    'NAME_Column': PlutoCell(value: 'Unified Communications-Zochnet'),
                    'TYPE_Column': PlutoCell(value: null),
                    'REVENUE_Column': PlutoCell(value: 0),
                    'PHONE_Column': PlutoCell(value: '(979) 421-3794'),
                    'LAST_Column': PlutoCell(value: DateTime(2023, 4, 4)),
                    'ASSIGNED_Column': PlutoCell(value: 'Frank Befera'),
                    'STATUS_Column': PlutoCell(value: null),
                    'ACTIONS_Column': PlutoCell(value: null),
                  },
                ),
                PlutoRow(
                  cells: {
                    'ID_Column': PlutoCell(value: 6),
                    'NAME_Column': PlutoCell(value: 'AM Racing'),
                    'TYPE_Column': PlutoCell(value: null),
                    'REVENUE_Column': PlutoCell(value: 0),
                    'PHONE_Column': PlutoCell(value: '(979) 421-3794'),
                    'LAST_Column': PlutoCell(value: DateTime(2023, 4, 4)),
                    'ASSIGNED_Column': PlutoCell(value: 'Frank Befera'),
                    'STATUS_Column': PlutoCell(value: null),
                    'ACTIONS_Column': PlutoCell(value: null),
                  },
                ),
                PlutoRow(
                  cells: {
                    'ID_Column': PlutoCell(value: 7),
                    'NAME_Column': PlutoCell(value: 'Pulk & Co'),
                    'TYPE_Column': PlutoCell(value: null),
                    'REVENUE_Column': PlutoCell(value: 0),
                    'PHONE_Column': PlutoCell(value: '(979) 421-3794'),
                    'LAST_Column': PlutoCell(value: DateTime(2023, 4, 4)),
                    'ASSIGNED_Column': PlutoCell(value: 'Frank Befera'),
                    'STATUS_Column': PlutoCell(value: null),
                    'ACTIONS_Column': PlutoCell(value: null),
                  },
                ),
                PlutoRow(
                  cells: {
                    'ID_Column': PlutoCell(value: 8),
                    'NAME_Column': PlutoCell(value: 'Fiber Stream LLC'),
                    'TYPE_Column': PlutoCell(value: null),
                    'REVENUE_Column': PlutoCell(value: 0),
                    'PHONE_Column': PlutoCell(value: '(979) 421-3794'),
                    'LAST_Column': PlutoCell(value: DateTime(2023, 4, 4)),
                    'ASSIGNED_Column': PlutoCell(value: 'Frank Befera'),
                    'STATUS_Column': PlutoCell(value: null),
                    'ACTIONS_Column': PlutoCell(value: null),
                  },
                ),
                PlutoRow(
                  cells: {
                    'ID_Column': PlutoCell(value: 9),
                    'NAME_Column': PlutoCell(value: 'LCR Wirreless'),
                    'TYPE_Column': PlutoCell(value: null),
                    'REVENUE_Column': PlutoCell(value: 0),
                    'PHONE_Column': PlutoCell(value: '(979) 421-3794'),
                    'LAST_Column': PlutoCell(value: DateTime(2023, 4, 4)),
                    'ASSIGNED_Column': PlutoCell(value: 'Frank Befera'),
                    'STATUS_Column': PlutoCell(value: null),
                    'ACTIONS_Column': PlutoCell(value: null),
                  },
                ),
                PlutoRow(
                  cells: {
                    'ID_Column': PlutoCell(value: 10),
                    'NAME_Column': PlutoCell(value: 'High Island ISD'),
                    'TYPE_Column': PlutoCell(value: null),
                    'REVENUE_Column': PlutoCell(value: 0),
                    'PHONE_Column': PlutoCell(value: '(979) 421-3794'),
                    'LAST_Column': PlutoCell(value: DateTime(2023, 4, 4)),
                    'ASSIGNED_Column': PlutoCell(value: 'Frank Befera'),
                    'STATUS_Column': PlutoCell(value: null),
                    'ACTIONS_Column': PlutoCell(value: null),
                  },
                ),
                PlutoRow(
                  cells: {
                    'ID_Column': PlutoCell(value: 11),
                    'NAME_Column': PlutoCell(value: 'Conterra'),
                    'TYPE_Column': PlutoCell(value: null),
                    'REVENUE_Column': PlutoCell(value: 0),
                    'PHONE_Column': PlutoCell(value: '(979) 421-3794'),
                    'LAST_Column': PlutoCell(value: DateTime(2023, 4, 4)),
                    'ASSIGNED_Column': PlutoCell(value: 'Frank Befera'),
                    'STATUS_Column': PlutoCell(value: null),
                    'ACTIONS_Column': PlutoCell(value: null),
                  },
                ),
                PlutoRow(
                  cells: {
                    'ID_Column': PlutoCell(value: 12),
                    'NAME_Column': PlutoCell(value: 'Blather Company'),
                    'TYPE_Column': PlutoCell(value: null),
                    'REVENUE_Column': PlutoCell(value: 0),
                    'PHONE_Column': PlutoCell(value: '(979) 421-3794'),
                    'LAST_Column': PlutoCell(value: DateTime(2023, 4, 4)),
                    'ASSIGNED_Column': PlutoCell(value: 'Frank Befera'),
                    'STATUS_Column': PlutoCell(value: null),
                    'ACTIONS_Column': PlutoCell(value: null),
                  },
                ),
                PlutoRow(
                  cells: {
                    'ID_Column': PlutoCell(value: 13),
                    'NAME_Column': PlutoCell(value: 'Aruqe Capitual'),
                    'TYPE_Column': PlutoCell(value: null),
                    'REVENUE_Column': PlutoCell(value: 0),
                    'PHONE_Column': PlutoCell(value: '(979) 421-3794'),
                    'LAST_Column': PlutoCell(value: DateTime(2023, 4, 4)),
                    'ASSIGNED_Column': PlutoCell(value: 'Frank Befera'),
                    'STATUS_Column': PlutoCell(value: null),
                    'ACTIONS_Column': PlutoCell(value: null),
                  },
                ),
                PlutoRow(
                  cells: {
                    'ID_Column': PlutoCell(value: 14),
                    'NAME_Column': PlutoCell(value: 'Construct Edge'),
                    'TYPE_Column': PlutoCell(value: null),
                    'REVENUE_Column': PlutoCell(value: 0),
                    'PHONE_Column': PlutoCell(value: '(979) 421-3794'),
                    'LAST_Column': PlutoCell(value: DateTime(2023, 4, 4)),
                    'ASSIGNED_Column': PlutoCell(value: 'Frank Befera'),
                    'STATUS_Column': PlutoCell(value: null),
                    'ACTIONS_Column': PlutoCell(value: null),
                  },
                ),
                PlutoRow(
                  cells: {
                    'ID_Column': PlutoCell(value: 16),
                    'NAME_Column': PlutoCell(value: 'NASCAR'),
                    'TYPE_Column': PlutoCell(value: null),
                    'REVENUE_Column': PlutoCell(value: 0),
                    'PHONE_Column': PlutoCell(value: '(979) 421-3794'),
                    'LAST_Column': PlutoCell(value: DateTime(2023, 4, 4)),
                    'ASSIGNED_Column': PlutoCell(value: 'Frank Befera'),
                    'STATUS_Column': PlutoCell(value: null),
                    'ACTIONS_Column': PlutoCell(value: null),
                  },
                ),
                PlutoRow(
                  cells: {
                    'ID_Column': PlutoCell(value: 17),
                    'NAME_Column': PlutoCell(value: 'Vistabean'),
                    'TYPE_Column': PlutoCell(value: null),
                    'REVENUE_Column': PlutoCell(value: 0),
                    'PHONE_Column': PlutoCell(value: '(979) 421-3794'),
                    'LAST_Column': PlutoCell(value: DateTime(2023, 4, 4)),
                    'ASSIGNED_Column': PlutoCell(value: 'Frank Befera'),
                    'STATUS_Column': PlutoCell(value: null),
                    'ACTIONS_Column': PlutoCell(value: null),
                  },
                ),
                PlutoRow(
                  cells: {
                    'ID_Column': PlutoCell(value: 18),
                    'NAME_Column': PlutoCell(value: 'Grand Traverse Band of Ottawa'),
                    'TYPE_Column': PlutoCell(value: null),
                    'REVENUE_Column': PlutoCell(value: 0),
                    'PHONE_Column': PlutoCell(value: '(979) 421-3794'),
                    'LAST_Column': PlutoCell(value: DateTime(2023, 4, 4)),
                    'ASSIGNED_Column': PlutoCell(value: 'Frank Befera'),
                    'STATUS_Column': PlutoCell(value: null),
                    'ACTIONS_Column': PlutoCell(value: null),
                  },
                ),
                PlutoRow(
                  cells: {
                    'ID_Column': PlutoCell(value: 19),
                    'NAME_Column': PlutoCell(value: 'City of Jasper'),
                    'TYPE_Column': PlutoCell(value: null),
                    'REVENUE_Column': PlutoCell(value: 0),
                    'PHONE_Column': PlutoCell(value: '(979) 421-3794'),
                    'LAST_Column': PlutoCell(value: DateTime(2023, 4, 4)),
                    'ASSIGNED_Column': PlutoCell(value: 'Frank Befera'),
                    'STATUS_Column': PlutoCell(value: null),
                    'ACTIONS_Column': PlutoCell(value: null),
                  },
                ),
                PlutoRow(
                  cells: {
                    'ID_Column': PlutoCell(value: 20),
                    'NAME_Column': PlutoCell(value: 'Seguin ISD'),
                    'TYPE_Column': PlutoCell(value: null),
                    'REVENUE_Column': PlutoCell(value: 0),
                    'PHONE_Column': PlutoCell(value: '(979) 421-3794'),
                    'LAST_Column': PlutoCell(value: DateTime(2023, 4, 4)),
                    'ASSIGNED_Column': PlutoCell(value: 'Frank Befera'),
                    'STATUS_Column': PlutoCell(value: null),
                    'ACTIONS_Column': PlutoCell(value: null),
                  },
                ),
                PlutoRow(
                  cells: {
                    'ID_Column': PlutoCell(value: 21),
                    'NAME_Column': PlutoCell(value: 'Education Pathers Solutions,Inc.'),
                    'TYPE_Column': PlutoCell(value: null),
                    'REVENUE_Column': PlutoCell(value: 0),
                    'PHONE_Column': PlutoCell(value: '(979) 421-3794'),
                    'LAST_Column': PlutoCell(value: DateTime(2023, 4, 4)),
                    'ASSIGNED_Column': PlutoCell(value: 'Frank Befera'),
                    'STATUS_Column': PlutoCell(value: null),
                    'ACTIONS_Column': PlutoCell(value: null),
                  },
                ),
              ],
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
