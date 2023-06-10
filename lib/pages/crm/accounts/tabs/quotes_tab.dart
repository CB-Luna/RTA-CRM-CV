import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:provider/provider.dart';
import 'package:rta_crm_cv/functions/money_format.dart';

import 'package:rta_crm_cv/functions/sizes.dart';
import 'package:rta_crm_cv/helpers/constants.dart';
import 'package:rta_crm_cv/helpers/globals.dart';
import 'package:rta_crm_cv/providers/crm/accounts/tabs/quotes_provider.dart';
import 'package:rta_crm_cv/providers/crm/quote/create_quote_provider.dart';
import 'package:rta_crm_cv/providers/crm/quote/detail_quote_provider.dart';
import 'package:rta_crm_cv/providers/crm/quote/validate_quote_provider.dart';
import 'package:rta_crm_cv/public/colors.dart';
import 'package:rta_crm_cv/theme/theme.dart';
import 'package:rta_crm_cv/widgets/custom_card.dart';
import 'package:rta_crm_cv/widgets/custom_icon_button.dart';
import 'package:rta_crm_cv/widgets/captura/custom_text_field.dart';
import 'package:rta_crm_cv/widgets/custom_text_icon_button.dart';

class QuotesTab extends StatefulWidget {
  const QuotesTab({super.key});

  @override
  State<QuotesTab> createState() => _QuotesTabState();
}

class _QuotesTabState extends State<QuotesTab> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final QuotesProvider provider = Provider.of<QuotesProvider>(
        context,
        listen: false,
      );
      await provider.updateState();
    });
  }

  @override
  Widget build(BuildContext context) {
    QuotesProvider provider = Provider.of<QuotesProvider>(context);
    DetailQuoteProvider detailProvider = Provider.of<DetailQuoteProvider>(context);
    CreateQuoteProvider providerCreate = Provider.of<CreateQuoteProvider>(context);
    ValidateQuoteProvider providerValidate = Provider.of<ValidateQuoteProvider>(context);

    return CustomCard(
      title: 'Quotes',
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                CustomTextIconButton(
                  isLoading: false,
                  icon: Icon(Icons.filter_alt_outlined, color: AppTheme.of(context).primaryBackground),
                  text: 'Filter',
                  onTap: () => provider.stateManager!.setShowColumnFilter(!provider.stateManager!.showColumnFilter),
                ),
                CustomTextField(
                  width: 500,
                  enabled: true,
                  controller: provider.searchController,
                  icon: Icons.search,
                  label: 'Search',
                  keyboardType: TextInputType.text,
                ),
                Row(
                  children: [
                    if (!currentUser!.isSales) const SizedBox(width: 131),
                    if (currentUser!.isSales)
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: CustomTextIconButton(
                          width: 131,
                          isLoading: false,
                          icon: Icon(Icons.add, color: AppTheme.of(context).primaryBackground),
                          text: 'Create Quote',
                          color: AppTheme.of(context).tertiaryColor,
                          onTap: () async {
                            context.pushReplacement(routeQuoteCreation);
                            await providerCreate.clearAll();
                            providerCreate.idLead = null;
                          },
                        ),
                      ),
                    CustomTextIconButton(
                      width: 90,
                      isLoading: false,
                      icon: Icon(Icons.file_download_outlined, color: AppTheme.of(context).primaryBackground),
                      text: 'Export',
                      color: AppTheme.of(context).primaryColor,
                      onTap: () async {
                        await provider.exportData();
                      },
                    ),
                  ],
                ),
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
                    if (column.field == 'ID_Column') {
                      return resolver<PlutoFilterTypeContains>() as PlutoFilterType;
                    } else if (column.field == 'NAME_Column') {
                      return resolver<PlutoFilterTypeContains>() as PlutoFilterType;
                    } else if (column.field == 'PROBABILITY_Column') {
                      return resolver<PlutoFilterTypeContains>() as PlutoFilterType;
                    } else if (column.field == 'CLOSED_Column') {
                      return resolver<PlutoFilterTypeContains>() as PlutoFilterType;
                    } else if (column.field == 'ASSIGNED_Column') {
                      return resolver<PlutoFilterTypeContains>() as PlutoFilterType;
                    } else if (column.field == 'LAST_Column') {
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
                    WidgetSpan(child: Icon(Icons.attach_money, color: AppTheme.of(context).primaryBackground)),
                    const WidgetSpan(child: SizedBox(width: 10)),
                    TextSpan(text: 'Total', style: AppTheme.of(context).encabezadoTablas)
                  ]),
                  backgroundColor: const Color(0XFF6491F7),
                  title: 'TOTAL',
                  field: 'TOTAL_Column',
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
                    TextSpan(text: 'Margin', style: AppTheme.of(context).encabezadoTablas)
                  ]),
                  backgroundColor: const Color(0XFF6491F7),
                  title: 'MARGIN',
                  field: 'MARGIN_Column',
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
                          '${moneyFormat(rendererContext.cell.value)}%',
                          style: AppTheme.of(context).contenidoTablas.override(fontFamily: 'Gotham-Regular', useGoogleFonts: false),
                        ),
                      ),
                    );
                  },
                ),
                PlutoColumn(
                  titleSpan: TextSpan(children: [
                    WidgetSpan(child: Icon(Icons.person_outline, color: AppTheme.of(context).primaryBackground)),
                    const WidgetSpan(child: SizedBox(width: 10)),
                    TextSpan(text: 'Vendor', style: AppTheme.of(context).encabezadoTablas)
                  ]),
                  backgroundColor: const Color(0XFF6491F7),
                  title: 'VENDOR',
                  field: 'VENDOR_Column',
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
                        ),
                      ),
                    );
                  },
                ),
                PlutoColumn(
                  titleSpan: TextSpan(children: [
                    WidgetSpan(child: Icon(Icons.person_outline, color: AppTheme.of(context).primaryBackground)),
                    const WidgetSpan(child: SizedBox(width: 10)),
                    TextSpan(text: 'Datacenter', style: AppTheme.of(context).encabezadoTablas)
                  ]),
                  backgroundColor: const Color(0XFF6491F7),
                  title: 'DATACENTER',
                  field: 'DATACENTER_Column',
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
                        ),
                      ),
                    );
                  },
                ),
                PlutoColumn(
                  titleSpan: TextSpan(children: [
                    WidgetSpan(child: Icon(Icons.person_outline, color: AppTheme.of(context).primaryBackground)),
                    const WidgetSpan(child: SizedBox(width: 10)),
                    TextSpan(text: 'Order', style: AppTheme.of(context).encabezadoTablas)
                  ]),
                  backgroundColor: const Color(0XFF6491F7),
                  title: 'ORDER',
                  field: 'ORDER_Column',
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
                        ),
                      ),
                    );
                  },
                ),
                PlutoColumn(
                  titleSpan: TextSpan(children: [
                    WidgetSpan(child: Icon(Icons.person_outline, color: AppTheme.of(context).primaryBackground)),
                    const WidgetSpan(child: SizedBox(width: 10)),
                    TextSpan(text: 'Description', style: AppTheme.of(context).encabezadoTablas)
                  ]),
                  backgroundColor: const Color(0XFF6491F7),
                  title: 'DESCRIPTION',
                  field: 'DESCRIPTION_Column',
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
                        ),
                      ),
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
                          '${moneyFormat(rendererContext.cell.value)}%',
                          style: AppTheme.of(context).contenidoTablas.override(fontFamily: 'Gotham-Regular', useGoogleFonts: false),
                        ),
                      ),
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
                        ),
                      ),
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
                        ),
                      ),
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
                        ),
                      ),
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
                    return Container(
                      height: rowHeight,
                      width: rendererContext.cell.column.width,
                      decoration: BoxDecoration(gradient: whiteGradient),
                      child: Center(
                        child: Text(
                          rendererContext.cell.value ?? '-',
                          style: AppTheme.of(context).contenidoTablas.override(fontFamily: 'Gotham-Regular', useGoogleFonts: false),
                        ),
                      ),
                    );
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
                  width: 250,
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
                          //if (rendererContext.row.cells["STATUS_Column"]!.value != 'Rejected')
                          CustomTextIconButton(
                            isLoading: false,
                            icon: Icon(
                              Icons.fact_check_outlined,
                              color: AppTheme.of(context).primaryBackground,
                            ),
                            text: 'Detail',
                            onTap: () async {
                              context.pushReplacement(routeQuoteDetail);
                              detailProvider.id = rendererContext.row.cells['ID_Column']!.value;
                              await detailProvider.getData();
                            },
                          ),
                          if (currentUser!.isSales && rendererContext.row.cells["STATUS_Column"]!.value == 'Rejected')
                            CustomTextIconButton(
                              isLoading: false,
                              icon: Icon(
                                Icons.fact_check_outlined,
                                color: AppTheme.of(context).primaryBackground,
                              ),
                              text: 'Create New',
                              onTap: () async {
                                context.pushReplacement(routeQuoteCreation);
                                await providerCreate.clearAll();
                                await providerCreate.getData(rendererContext.row.cells["ACTIONS_Column"]!.value);
                                await providerCreate.getLead(rendererContext.row.cells["ID_LEAD_Column"]!.value, null);
                              },
                            ),
                          if (currentUser!.isSenExec && rendererContext.row.cells["STATUS_Column"]!.value == 'Opened')
                            CustomTextIconButton(
                              isLoading: false,
                              icon: Icon(
                                Icons.search,
                                color: AppTheme.of(context).primaryBackground,
                              ),
                              text: 'Validate',
                              onTap: () async {
                                context.pushReplacement(routeQuoteValidation);
                                await providerValidate.clearAll();
                                providerValidate.id = rendererContext.row.cells['ID_Column']!.value;
                                await providerValidate.getData();
                              },
                            ),
                          if (currentUser!.isFinance &&
                              (rendererContext.row.cells["STATUS_Column"]!.value == 'SenExec Validate' || rendererContext.row.cells["STATUS_Column"]!.value == 'Margin Positive'))
                            CustomTextIconButton(
                              isLoading: false,
                              icon: Icon(
                                Icons.search,
                                color: AppTheme.of(context).primaryBackground,
                              ),
                              text: 'Validate',
                              onTap: () async {
                                context.pushReplacement(routeQuoteValidation);
                                await providerValidate.clearAll();
                                providerValidate.id = rendererContext.row.cells['ID_Column']!.value;
                                await providerValidate.getData();
                              },
                            ),
                          if (currentUser!.isOpperations && rendererContext.row.cells["STATUS_Column"]!.value == 'Finance Validate')
                            CustomTextIconButton(
                              isLoading: false,
                              icon: Icon(
                                Icons.search,
                                color: AppTheme.of(context).primaryBackground,
                              ),
                              text: 'Validate',
                              onTap: () async {
                                context.pushReplacement(routeQuoteValidation);
                                await providerValidate.clearAll();
                                providerValidate.id = rendererContext.row.cells['ID_Column']!.value;
                                await providerValidate.getData();
                              },
                            ),
                          /* CustomTextIconButton(isLoading: false,
                            icon: Icon(
                              Icons.shopping_basket_outlined,
                              color: AppTheme.of(context).primaryBackground,
                            ),
                            color: secondaryColor,
                            text: 'Delete',
                            onTap: () {},
                          ), */
                          /* InkWell(
                                              hoverColor: Colors.transparent,
                                              child: Icon(
                                                Icons.fact_check_outlined,
                                                size: 25,
                                                color: textColor,
                                              ),
                                              onTap: () {},
                                            ),
                                            InkWell(
                                              hoverColor: Colors.transparent,
                                              child: Icon(
                                                Icons.shopping_basket_outlined,
                                                size: 25,
                                                color: textColor,
                                              ),
                                              onTap: () {},
                                            ) */
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