import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:provider/provider.dart';
import 'package:rta_crm_cv/functions/sizes.dart';
import 'package:rta_crm_cv/helpers/constants.dart';
import 'package:rta_crm_cv/providers/cotizador_provider.dart';
import 'package:rta_crm_cv/public/colors.dart';
import 'package:rta_crm_cv/theme/theme.dart';
import 'package:rta_crm_cv/widgets/custom_card.dart';
import 'package:rta_crm_cv/widgets/custom_ddown_menu/custom_dropdown.dart';
import 'package:rta_crm_cv/widgets/custom_icon_button.dart';
import 'package:rta_crm_cv/widgets/custom_tab_button.dart';
import 'package:rta_crm_cv/widgets/custom_text_field.dart';
import 'package:rta_crm_cv/widgets/custom_text_icon_button.dart';
import 'package:rta_crm_cv/widgets/side_menu/sidemenu.dart';

class Cotizador extends StatefulWidget {
  const Cotizador({super.key});

  @override
  State<Cotizador> createState() => _CotizadorState();
}

class _CotizadorState extends State<Cotizador> {
  @override
  Widget build(BuildContext context) {
    double txfFieldWidth = (MediaQuery.of(context).size.width / 7);
    // double txfFieldPadding = 10;

    CotizadorProvider provider = Provider.of<CotizadorProvider>(context);

    return Material(
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SideMenu(),
            Expanded(
              child: Container(
                decoration: BoxDecoration(gradient: whiteGradient),
                child: CustomCard(
                  title: 'Quote Creation',
                  height: MediaQuery.of(context).size.height - 20,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomCard(
                            height: MediaQuery.of(context).size.height / 3,
                            width: MediaQuery.of(context).size.width / 5,
                            title: 'Order Info',
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomTabButton(
                                  on: provider.orderTypesSelectedValue ==
                                      'Internal Circuit',
                                  label: 'Order Type',
                                  option1: 'Internal Circuit',
                                  option2: 'External Customer',
                                  onTap: () => provider.selectOT(),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: CustomDropDown(
                                    list: provider.typesList,
                                    dropdownValue: provider.typesSelectedValue,
                                    onChanged: (p0) {
                                      if (p0 != null) provider.selectType(p0);
                                    },
                                    icon: Icons.file_copy_outlined,
                                    label: 'Type',
                                    width: txfFieldWidth,
                                  ),
                                ),
                                if (provider.typesSelectedValue ==
                                        'Disconnect' ||
                                    provider.typesSelectedValue == 'Upgrade')
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    child: CustomTextField(
                                      enabled: true,
                                      width: txfFieldWidth,
                                      controller:
                                          provider.existingCircuitIDController,
                                      label: 'Existing Circuit ID',
                                      icon: Icons.cable_outlined,
                                      keyboardType: TextInputType.text,
                                    ),
                                  ),
                                if (provider.typesSelectedValue == 'Upgrade')
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    child: CustomTextField(
                                      enabled: true,
                                      width: txfFieldWidth,
                                      controller:
                                          provider.newCircuitIDController,
                                      label: 'New Circuit ID',
                                      icon: Icons.cable_outlined,
                                      keyboardType: TextInputType.text,
                                    ),
                                  ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: CustomDropDown(
                                    list: provider.dataCentersList,
                                    dropdownValue:
                                        provider.dataCenterSelectedValue,
                                    onChanged: (p0) {
                                      if (p0 != null)
                                        provider.selectDataCenter(p0);
                                    },
                                    icon: Icons.location_on_outlined,
                                    label: 'Data Center Location',
                                    width: txfFieldWidth,
                                  ),
                                ),
                                if (provider.dataCenterSelectedValue == 'New')
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    child: CustomTextField(
                                      enabled: true,
                                      width: txfFieldWidth,
                                      controller:
                                          provider.newDataCenterController,
                                      label: 'New Data Center',
                                      icon: Icons.location_on_outlined,
                                      keyboardType: TextInputType.text,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          CustomCard(
                            height: MediaQuery.of(context).size.height / 3,
                            width: MediaQuery.of(context).size.width / 5,
                            title: 'Circuit Type',
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomDropDown(
                                  list: provider.circuitInfosList,
                                  dropdownValue:
                                      provider.circuitInfoSelectedValue,
                                  onChanged: (p0) {
                                    if (p0 != null)
                                      provider.selectCircuitInfo(p0);
                                  },
                                  icon: Icons.info_outline,
                                  label: 'Circuit Info',
                                  width: txfFieldWidth,
                                ),
                                if (provider.circuitInfoSelectedValue ==
                                    'EVCoD')
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    child: CustomDropDown(
                                      list: provider.evcodList,
                                      dropdownValue:
                                          provider.evcodSelectedValue,
                                      onChanged: (p0) {
                                        if (p0 != null)
                                          provider.selectEVCOD(p0);
                                      },
                                      icon: Icons.electrical_services,
                                      label: 'EVCoD',
                                      width: txfFieldWidth,
                                    ),
                                  ),
                                if (provider.evcodSelectedValue ==
                                    'Existing EVC')
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    child: CustomTextField(
                                      enabled: true,
                                      width: txfFieldWidth,
                                      controller:
                                          provider.existingEVCController,
                                      label: 'Circuit ID',
                                      icon: Icons.electrical_services,
                                      keyboardType: TextInputType.text,
                                    ),
                                  ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: CustomTabButton(
                                    on: provider.ddosSelectedValue,
                                    //icon: Icons.security_outlined,
                                    label: 'DDoS Migration',
                                    option1: 'Yes',
                                    option2: 'No',
                                    onTap: () => provider.selectDDOS(),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: CustomDropDown(
                                    list: provider.bgpList,
                                    dropdownValue: provider.bgpSelectedValue,
                                    onChanged: (p0) {
                                      if (p0 != null) provider.selectBGP(p0);
                                    },
                                    icon: Icons.bug_report_outlined,
                                    label: 'BGP Peering',
                                    width: txfFieldWidth,
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: CustomTabButton(
                                    on: provider.ipAdressSelectedValue,
                                    label: 'IP Adresses',
                                    option1: 'Interface',
                                    option2: 'IP Subnet',
                                    onTap: () => provider.selectIPAdress(),
                                  ),
                                ),
                                if (provider.ipAdressSelectedValue)
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    child: CustomTabButton(
                                      on: provider.ipSelectedValue == 'IPv4',
                                      label: 'IP Interface',
                                      option1: 'IPv4',
                                      option2: 'IPv6',
                                      onTap: () => provider.selectIPInterface(),
                                    ),
                                  ),
                                if (!provider.ipAdressSelectedValue)
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    child: CustomDropDown(
                                      list: provider.subnetList,
                                      dropdownValue:
                                          provider.subnetSelectedValue,
                                      onChanged: (p0) {
                                        if (p0 != null)
                                          provider.selectSubnet(p0);
                                      },
                                      icon: Icons.signal_cellular_alt,
                                      label: 'IP Subnet',
                                      width: txfFieldWidth,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          CustomCard(
                            height: MediaQuery.of(context).size.height / 3,
                            width: MediaQuery.of(context).size.width / 2.1,
                            title: 'Totals',
                            child: const Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [],
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 35,
                        width: MediaQuery.of(context).size.width - 20,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: CustomTextField(
                                enabled: true,
                                width: txfFieldWidth,
                                controller: provider.lineItemCenterController,
                                label: 'Line Item',
                                icon: Icons.local_offer_outlined,
                                keyboardType: TextInputType.text,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: CustomTextField(
                                enabled: true,
                                width: txfFieldWidth,
                                controller: provider.unitPriceController,
                                label: 'Unit Price',
                                icon: Icons.attach_money_outlined,
                                keyboardType: TextInputType.text,
                                /* inputFormatters: <TextInputFormatter>[
                                            FilteringTextInputFormatter.digitsOnly,
                                          ], */
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: CustomTextField(
                                enabled: true,
                                width: txfFieldWidth,
                                controller: provider.unitCostController,
                                label: 'Unit Cost',
                                icon: Icons.price_check_outlined,
                                keyboardType: TextInputType.text,
                                /* inputFormatters: <TextInputFormatter>[
                                            FilteringTextInputFormatter.digitsOnly,
                                          ], */
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: CustomTextField(
                                enabled: true,
                                width: txfFieldWidth,
                                controller: provider.quantityController,
                                label: 'Quantity',
                                icon: Icons.shopping_cart_outlined,
                                keyboardType: TextInputType.number,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: CustomTextIconButton(
                                icon: Icon(Icons.add,
                                    color:
                                        AppTheme.of(context).primaryBackground),
                                text: 'Add',
                                onTap: () => provider.addRow(),
                              ),
                            ),
                            CustomTextIconButton(
                              icon: Icon(Icons.remove,
                                  color:
                                      AppTheme.of(context).primaryBackground),
                              text: 'Reset',
                              onTap: () => provider.resetForm(),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 2,
                        width: MediaQuery.of(context).size.width - 20,
                        child: PlutoGrid(
                          key: UniqueKey(),
                          configuration: PlutoGridConfiguration(
                            localeText: const PlutoGridLocaleText.spanish(),
                            scrollbar: plutoGridScrollbarConfig(context),
                            style: plutoGridStyleConfig(context),
                            columnFilter: PlutoGridColumnFilterConfig(
                              filters: const [
                                ...FilterHelper.defaultFilters,
                              ],
                              resolveDefaultColumnFilter: (column, resolver) {
                                if (column.field == 'ORDER_TYPE_Column') {
                                  return resolver<PlutoFilterTypeContains>()
                                      as PlutoFilterType;
                                } else if (column.field ==
                                    'CIRCUIT_INFO_Column') {
                                  return resolver<PlutoFilterTypeContains>()
                                      as PlutoFilterType;
                                } else if (column.field ==
                                    'DATA_CENTER_Column') {
                                  return resolver<PlutoFilterTypeContains>()
                                      as PlutoFilterType;
                                } else if (column.field == 'DDOS_Column') {
                                  return resolver<PlutoFilterTypeContains>()
                                      as PlutoFilterType;
                                } else if (column.field == 'BGM_Column') {
                                  return resolver<PlutoFilterTypeContains>()
                                      as PlutoFilterType;
                                } else if (column.field == 'IP_Column') {
                                  return resolver<PlutoFilterTypeContains>()
                                      as PlutoFilterType;
                                } else if (column.field == 'LINE_ITEM_Column') {
                                  return resolver<PlutoFilterTypeContains>()
                                      as PlutoFilterType;
                                } else if (column.field ==
                                    'UNIT_PRICE_Column') {
                                  return resolver<PlutoFilterTypeContains>()
                                      as PlutoFilterType;
                                } else if (column.field == 'UNIT_COST_Column') {
                                  return resolver<PlutoFilterTypeContains>()
                                      as PlutoFilterType;
                                } else if (column.field == 'QUANTITY_Column') {
                                  return resolver<PlutoFilterTypeContains>()
                                      as PlutoFilterType;
                                }
                                return resolver<PlutoFilterTypeContains>()
                                    as PlutoFilterType;
                              },
                            ),
                          ),
                          columns: [
                            /* PlutoColumn(
                              titleSpan: TextSpan(children: [
                                WidgetSpan(child: Icon(Icons.file_copy_outlined, color: AppTheme.of(context).primaryBackground)),
                                const WidgetSpan(child: SizedBox(width: 10)),
                                TextSpan(text: 'Order Type', style: TextStyle(color: AppTheme.of(context).primaryBackground))
                              ]),
                              backgroundColor: const Color(0XFF6491F7),
                              title: 'ORDER Info',
                              field: 'ORDER_TYPE_Column',
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
                                  child: Center(child: Text(rendererContext.cell.value, style: TextStyle(color: AppTheme.of(context).primaryText))),
                                );
                              },
                              footerRenderer: (rendererContext) {
                                return PlutoAggregateColumnFooter(
                                  rendererContext: rendererContext,
                                  type: PlutoAggregateColumnType.count,
                                  alignment: Alignment.center,
                                  titleSpanBuilder: (text) {
                                    return [
                                      TextSpan(
                                        text: 'Rows: ',
                                        style: AppTheme.of(context).contenidoTablas.override(fontFamily: 'Gotham-Regular', useGoogleFonts: false, color: AppTheme.of(context).primaryBackground),
                                      ),
                                      TextSpan(
                                        text: provider.rows.length.toString(),
                                        style: TextStyle(color: AppTheme.of(context).primaryBackground),
                                      ),
                                    ];
                                  },
                                );
                              },
                            ),
                            PlutoColumn(
                              titleSpan: TextSpan(children: [
                                WidgetSpan(child: Icon(Icons.location_on_outlined, color: AppTheme.of(context).primaryBackground)),
                                const WidgetSpan(child: SizedBox(width: 10)),
                                TextSpan(text: 'Data Center', style: TextStyle(color: AppTheme.of(context).primaryBackground))
                              ]),
                              backgroundColor: const Color(0XFF6491F7),
                              title: 'DATA CENTER',
                              field: 'DATA_CENTER_Column',
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
                                  child: Center(child: Text(rendererContext.cell.value)),
                                );
                              },
                            ), */
                            /*  PlutoColumn(
                              titleSpan: TextSpan(children: [
                                WidgetSpan(child: Icon(Icons.cable_outlined, color: AppTheme.of(context).primaryBackground)),
                                const WidgetSpan(child: SizedBox(width: 10)),
                                TextSpan(text: 'Circuit Info', style: TextStyle(color: AppTheme.of(context).primaryBackground))
                              ]),
                              backgroundColor: const Color(0XFF6491F7),
                              title: 'CIRCUIT INFO',
                              field: 'CIRCUIT_INFO_Column',
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
                                  child: Center(child: Text(rendererContext.cell.value)),
                                );
                              },
                            ),
                            PlutoColumn(
                              titleSpan: TextSpan(children: [
                                WidgetSpan(child: Icon(Icons.security_outlined, color: AppTheme.of(context).primaryBackground)),
                                const WidgetSpan(child: SizedBox(width: 10)),
                                TextSpan(text: 'DDOS Migration', style: TextStyle(color: AppTheme.of(context).primaryBackground))
                              ]),
                              backgroundColor: const Color(0XFF6491F7),
                              title: 'DDOS',
                              field: 'DDOS_Column',
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
                                  child: Center(child: Text(rendererContext.cell.value)),
                                );
                              },
                            ),
                            PlutoColumn(
                              titleSpan: TextSpan(children: [
                                WidgetSpan(child: Icon(Icons.bug_report_outlined, color: AppTheme.of(context).primaryBackground)),
                                const WidgetSpan(child: SizedBox(width: 10)),
                                TextSpan(text: 'BGM Perring', style: TextStyle(color: AppTheme.of(context).primaryBackground))
                              ]),
                              backgroundColor: const Color(0XFF6491F7),
                              title: 'BGM',
                              field: 'BGM_Column',
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
                                  child: Center(child: Text(rendererContext.cell.value)),
                                );
                              },
                            ),
                            PlutoColumn(
                              titleSpan: TextSpan(children: [
                                WidgetSpan(child: Icon(Icons.share_location_outlined, color: AppTheme.of(context).primaryBackground)),
                                const WidgetSpan(child: SizedBox(width: 10)),
                                TextSpan(text: 'IP Address', style: TextStyle(color: AppTheme.of(context).primaryBackground))
                              ]),
                              backgroundColor: const Color(0XFF6491F7),
                              title: 'IP',
                              field: 'IP_Column',
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
                                  child: Center(child: Text(rendererContext.cell.value)),
                                );
                              },
                            ),
                             */
                            PlutoColumn(
                              titleSpan: TextSpan(children: [
                                WidgetSpan(
                                    child: Icon(Icons.file_copy_outlined,
                                        color: AppTheme.of(context)
                                            .primaryBackground)),
                                const WidgetSpan(child: SizedBox(width: 10)),
                                TextSpan(
                                    text: 'Order Info',
                                    style: TextStyle(
                                        color: AppTheme.of(context)
                                            .primaryBackground))
                              ]),
                              backgroundColor: const Color(0XFF6491F7),
                              title: 'Order Info',
                              field: 'ORDER_INFO_Column',
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
                                  decoration:
                                      BoxDecoration(gradient: whiteGradient),
                                  child: Center(
                                      child: Text(rendererContext.cell.value,
                                          style: TextStyle(
                                              color: AppTheme.of(context)
                                                  .primaryText))),
                                );
                              },
                              footerRenderer: (rendererContext) {
                                return PlutoAggregateColumnFooter(
                                  rendererContext: rendererContext,
                                  type: PlutoAggregateColumnType.count,
                                  alignment: Alignment.center,
                                  titleSpanBuilder: (text) {
                                    return [
                                      TextSpan(
                                        text: 'Rows: ',
                                        style: AppTheme.of(context)
                                            .contenidoTablas
                                            .override(
                                                fontFamily: 'Gotham-Regular',
                                                useGoogleFonts: false,
                                                color: AppTheme.of(context)
                                                    .primaryBackground),
                                      ),
                                      TextSpan(
                                        text: provider.rows.length.toString(),
                                        style: TextStyle(
                                            color: AppTheme.of(context)
                                                .primaryBackground),
                                      ),
                                    ];
                                  },
                                );
                              },
                            ),
                            PlutoColumn(
                              titleSpan: TextSpan(children: [
                                WidgetSpan(
                                    child: Icon(Icons.cable_outlined,
                                        color: AppTheme.of(context)
                                            .primaryBackground)),
                                const WidgetSpan(child: SizedBox(width: 10)),
                                TextSpan(
                                    text: 'Circuit Info',
                                    style: TextStyle(
                                        color: AppTheme.of(context)
                                            .primaryBackground))
                              ]),
                              backgroundColor: const Color(0XFF6491F7),
                              title: 'CIRCUIT INFO',
                              field: 'CIRCUIT_INFO_Column',
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
                                  decoration:
                                      BoxDecoration(gradient: whiteGradient),
                                  child: Center(
                                      child: Text(rendererContext.cell.value)),
                                );
                              },
                            ),
                            PlutoColumn(
                              titleSpan: TextSpan(children: [
                                WidgetSpan(
                                    child: Icon(Icons.local_offer_outlined,
                                        color: AppTheme.of(context)
                                            .primaryBackground)),
                                const WidgetSpan(child: SizedBox(width: 10)),
                                TextSpan(
                                    text: 'Line Item',
                                    style: TextStyle(
                                        color: AppTheme.of(context)
                                            .primaryBackground))
                              ]),
                              backgroundColor: const Color(0XFF6491F7),
                              title: 'LINE ITEM',
                              field: 'LINE_ITEM_Column',
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
                                  decoration:
                                      BoxDecoration(gradient: whiteGradient),
                                  child: Center(
                                      child: Text(rendererContext.cell.value)),
                                );
                              },
                            ),
                            PlutoColumn(
                              titleSpan: TextSpan(children: [
                                WidgetSpan(
                                    child: Icon(Icons.attach_money_outlined,
                                        color: AppTheme.of(context)
                                            .primaryBackground)),
                                const WidgetSpan(child: SizedBox(width: 10)),
                                TextSpan(
                                    text: 'Unit Price',
                                    style: TextStyle(
                                        color: AppTheme.of(context)
                                            .primaryBackground))
                              ]),
                              backgroundColor: const Color(0XFF6491F7),
                              title: 'UNIT PRICE',
                              field: 'UNIT_PRICE_Column',
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
                                  decoration:
                                      BoxDecoration(gradient: whiteGradient),
                                  child: Center(
                                      child: Text(rendererContext.cell.value
                                          .toString())),
                                );
                              },
                              footerRenderer: (rendererContext) {
                                return PlutoAggregateColumnFooter(
                                  rendererContext: rendererContext,
                                  type: PlutoAggregateColumnType.sum,
                                  format: '#,###.##',
                                  alignment: Alignment.center,
                                  titleSpanBuilder: (text) {
                                    return [
                                      TextSpan(
                                          text: ' \$ ',
                                          style: TextStyle(
                                              color: AppTheme.of(context)
                                                  .primaryBackground)),
                                      TextSpan(
                                        text: text,
                                        style: TextStyle(
                                            color: AppTheme.of(context)
                                                .primaryBackground),
                                      ),
                                      TextSpan(
                                          text: ' USD',
                                          style: TextStyle(
                                              color: AppTheme.of(context)
                                                  .primaryBackground)),
                                    ];
                                  },
                                );
                              },
                            ),
                            PlutoColumn(
                              titleSpan: TextSpan(children: [
                                WidgetSpan(
                                    child: Icon(Icons.price_check_outlined,
                                        color: AppTheme.of(context)
                                            .primaryBackground)),
                                const WidgetSpan(child: SizedBox(width: 10)),
                                TextSpan(
                                    text: 'Unit Cost',
                                    style: TextStyle(
                                        color: AppTheme.of(context)
                                            .primaryBackground))
                              ]),
                              backgroundColor: const Color(0XFF6491F7),
                              title: 'UNIT COST',
                              field: 'UNIT_COST_Column',
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
                                  decoration:
                                      BoxDecoration(gradient: whiteGradient),
                                  child: Center(
                                      child: Text(rendererContext.cell.value
                                          .toString())),
                                );
                              },
                              footerRenderer: (rendererContext) {
                                return PlutoAggregateColumnFooter(
                                  rendererContext: rendererContext,
                                  type: PlutoAggregateColumnType.sum,
                                  format: '#,###.##',
                                  alignment: Alignment.center,
                                  titleSpanBuilder: (text) {
                                    return [
                                      TextSpan(
                                          text: ' \$ ',
                                          style: TextStyle(
                                              color: AppTheme.of(context)
                                                  .primaryBackground)),
                                      TextSpan(
                                        text: text,
                                        style: TextStyle(
                                            color: AppTheme.of(context)
                                                .primaryBackground),
                                      ),
                                      TextSpan(
                                          text: ' USD',
                                          style: TextStyle(
                                              color: AppTheme.of(context)
                                                  .primaryBackground)),
                                    ];
                                  },
                                );
                              },
                            ),
                            PlutoColumn(
                              titleSpan: TextSpan(children: [
                                WidgetSpan(
                                    child: Icon(Icons.shopping_cart_outlined,
                                        color: AppTheme.of(context)
                                            .primaryBackground)),
                                const WidgetSpan(child: SizedBox(width: 10)),
                                TextSpan(
                                    text: 'Quantity',
                                    style: TextStyle(
                                        color: AppTheme.of(context)
                                            .primaryBackground))
                              ]),
                              backgroundColor: const Color(0XFF6491F7),
                              title: 'QUANTITY',
                              field: 'QUANTITY_Column',
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
                                  decoration:
                                      BoxDecoration(gradient: whiteGradient),
                                  child: Center(
                                      child: Text(rendererContext.cell.value
                                          .toString())),
                                );
                              },
                            ),
                            PlutoColumn(
                              titleSpan: TextSpan(children: [
                                WidgetSpan(
                                    child: Icon(Icons.settings,
                                        color: AppTheme.of(context)
                                            .primaryBackground)),
                                const WidgetSpan(child: SizedBox(width: 10)),
                                TextSpan(
                                    text: 'Actions',
                                    style: TextStyle(
                                        color: AppTheme.of(context)
                                            .primaryBackground))
                              ]),
                              backgroundColor: const Color(0XFF6491F7),
                              title: 'ACTIONS',
                              field: 'ACTIONS_Column',
                              width: 140,
                              titleTextAlign: PlutoColumnTextAlign.start,
                              textAlign: PlutoColumnTextAlign.center,
                              type: PlutoColumnType.text(),
                              enableEditingMode: false,
                              cellPadding: EdgeInsets.zero,
                              renderer: (rendererContext) {
                                return Container(
                                  height: rowHeight,
                                  width: rendererContext.cell.column.width,
                                  decoration:
                                      BoxDecoration(gradient: whiteGradient),
                                  child: Center(
                                      child: Text(rendererContext.cell.value
                                          .toString())),
                                );
                              },
                            ),
                          ],
                          rows: provider.rows,
                          onLoaded: (event) async {
                            provider.stateManager = event.stateManager;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
