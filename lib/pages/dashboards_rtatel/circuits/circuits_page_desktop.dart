import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:provider/provider.dart';
import 'package:rta_crm_cv/functions/sizes.dart';
import 'package:rta_crm_cv/providers/dashboard_rta/circuits_provider.dart';
import 'package:rta_crm_cv/theme/theme.dart';
import 'package:rta_crm_cv/widgets/captura/custom_text_field.dart';
import 'package:rta_crm_cv/widgets/custom_card.dart';
import 'package:rta_crm_cv/widgets/custom_icon_button.dart';
import 'package:rta_crm_cv/widgets/custom_scrollbar.dart';
import 'package:rta_crm_cv/widgets/custom_text_icon_button.dart';
import 'package:rta_crm_cv/widgets/side_menu/sidemenu.dart';

import '../../../helpers/constants.dart';
import '../../../public/colors.dart';

class CircuitsPageDesktop extends StatefulWidget {
  const CircuitsPageDesktop({super.key});

  @override
  State<CircuitsPageDesktop> createState() => _CircuitsPageDesktopState();
}

class _CircuitsPageDesktopState extends State<CircuitsPageDesktop> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final CircuitsProvider provider = Provider.of<CircuitsProvider>(
        context,
        listen: false,
      );
      await provider.updateState();
    });
  }

  @override
  Widget build(BuildContext context) {
    // SideMenuProvider provider = Provider.of<SideMenuProvider>(context);
    CircuitsProvider provider = Provider.of<CircuitsProvider>(context);

    return Material(
        child: SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Row(children: [
        const SideMenu(),
        Flexible(
          child: Container(
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(gradient: whiteGradient),
            child: CustomScrollBar(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 10, top: 10, right: 10, bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: SizedBox(
                                height: 40,
                                width: 40,
                                child: Icon(
                                  Icons.cable_outlined,
                                  color: AppTheme.of(context).cryPrimary,
                                ))),
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: SizedBox(
                            height: 40,
                            child: Text('Circuits',
                                style: AppTheme.of(context).title1),
                          ),
                        ),
                      ],
                    ),
                  ),
                  CustomCard(
                    width: MediaQuery.of(context).size.width - 200,
                    height: MediaQuery.of(context).size.height,
                    title: "RTA Circuits",
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 0, horizontal: 30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                child: CustomTextIconButton(
                                  isLoading: false,
                                  icon: Icon(Icons.filter_alt_outlined,
                                      color: AppTheme.of(context)
                                          .primaryBackground),
                                  text: 'Filter',
                                  style: AppTheme.of(context)
                                      .contenidoTablas
                                      .override(
                                        fontFamily: 'Gotham-Regular',
                                        useGoogleFonts: false,
                                        color: AppTheme.of(context)
                                            .primaryBackground,
                                      ),
                                  onTap: () => provider.stateManager!
                                      .setShowColumnFilter(!provider
                                          .stateManager!.showColumnFilter),
                                ),
                              ),

                              // Padding(
                              //   padding:
                              //       const EdgeInsets.only(left: 10, top: 10),
                              //   child: CustomTextIconButton(
                              //     mainAxisAlignment: MainAxisAlignment.center,
                              //     width:
                              //         MediaQuery.of(context).size.width * 0.10,
                              //     isLoading: false,
                              //     icon: Icon(
                              //         Icons.download_for_offline_outlined,
                              //         color: AppTheme.of(context)
                              //             .primaryBackground),
                              //     text: 'Export Data',
                              //     style: AppTheme.of(context)
                              //         .contenidoTablas
                              //         .override(
                              //           fontFamily: 'Gotham-Regular',
                              //           useGoogleFonts: false,
                              //           color: AppTheme.of(context)
                              //               .primaryBackground,
                              //         ),
                              //     color: AppTheme.of(context).primaryColor,
                              //     onTap: () async {
                              //       provider.clearControllerExportData(
                              //           notify: false);
                              //       if (!mounted) return;
                              //       await showDialog(
                              //           context: context,
                              //           builder: (BuildContext context) {
                              //             return const ExportUsers();
                              //           });
                              //     },
                              //   ),
                              // ),
                              CustomTextField(
                                width: 500,
                                enabled: true,
                                controller: provider.searchController,
                                icon: Icons.search,
                                label: 'Search',
                                keyboardType: TextInputType.text,
                                onChanged: (p0) {
                                  setState(() {
                                    provider.updateState();
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: SizedBox(
                            height: getHeight(850, context),
                            width: getWidth(2450, context),
                            child: PlutoGrid(
                              key: UniqueKey(),
                              configuration: PlutoGridConfiguration(
                                scrollbar: plutoGridScrollbarConfig(context),
                                style: plutoGridStyleConfig(context),
                                columnFilter: PlutoGridColumnFilterConfig(
                                  filters: const [
                                    ...FilterHelper.defaultFilters,
                                  ],
                                  resolveDefaultColumnFilter:
                                      (column, resolver) {
                                    if (column.field == 'license_plates') {
                                      return resolver<PlutoFilterTypeContains>()
                                          as PlutoFilterType;
                                    } else if (column.field == 'VIN') {
                                      return resolver<PlutoFilterTypeContains>()
                                          as PlutoFilterType;
                                    } else if (column.field == 'Make') {
                                      return resolver<PlutoFilterTypeContains>()
                                          as PlutoFilterType;
                                    } else if (column.field == 'Model') {
                                      return resolver<PlutoFilterTypeContains>()
                                          as PlutoFilterType;
                                    } else if (column.field == 'Status') {
                                      return resolver<PlutoFilterTypeContains>()
                                          as PlutoFilterType;
                                    } else if (column.field == 'Company') {
                                      return resolver<PlutoFilterTypeContains>()
                                          as PlutoFilterType;
                                    } else if (column.field == 'Mileage') {
                                      return resolver<PlutoFilterTypeContains>()
                                          as PlutoFilterType;
                                    } else if (column.field == 'Actions') {
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
                                  title: 'PCCID',
                                  field: 'pccid_Column',
                                  backgroundColor: const Color(0XFF6491F7),
                                  titleSpan: TextSpan(children: [
                                    WidgetSpan(
                                        child: Icon(Icons.credit_card_outlined,
                                            color: AppTheme.of(context)
                                                .primaryBackground)),
                                    const WidgetSpan(
                                        child: SizedBox(width: 10)),
                                    TextSpan(
                                        text: 'PCCID',
                                        style: AppTheme.of(context)
                                            .encabezadoTablas)
                                  ]),
                                  width:
                                      MediaQuery.of(context).size.width * 0.10,
                                  cellPadding: EdgeInsets.zero,
                                  titleTextAlign: PlutoColumnTextAlign.center,
                                  textAlign: PlutoColumnTextAlign.center,
                                  type: PlutoColumnType.text(),
                                  enableRowDrag: false,
                                  enableDropToResize: false,
                                  enableEditingMode: false,
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
                                        ],
                                      ),
                                    );
                                  },
                                ),
                                PlutoColumn(
                                  title: 'RTA Customers',
                                  field: 'rta_customers_Column',
                                  backgroundColor: const Color(0XFF6491F7),
                                  titleSpan: TextSpan(children: [
                                    WidgetSpan(
                                        child: Icon(Icons.dialpad_outlined,
                                            color: AppTheme.of(context)
                                                .primaryBackground)),
                                    const WidgetSpan(
                                        child: SizedBox(width: 10)),
                                    TextSpan(
                                        text: 'RTA Customers',
                                        style: AppTheme.of(context)
                                            .encabezadoTablas)
                                  ]),
                                  width:
                                      MediaQuery.of(context).size.width * 0.13,
                                  cellPadding: EdgeInsets.zero,
                                  titleTextAlign: PlutoColumnTextAlign.center,
                                  textAlign: PlutoColumnTextAlign.center,
                                  type: PlutoColumnType.text(),
                                  enableEditingMode: false,
                                  renderer: (rendererContext) {
                                    return Container(
                                      height: rowHeight,
                                      // width: rendererContext
                                      //.cell.column.width,                                                    .cell.column.width,
                                      decoration: BoxDecoration(
                                          gradient: whiteGradient),
                                      child: Center(
                                          child: Text(
                                        rendererContext.cell.value,
                                        style: AppTheme.of(context)
                                            .contenidoTablas
                                            .override(
                                                fontFamily: 'Gotham-Regular',
                                                useGoogleFonts: false,
                                                color: AppTheme.of(context)
                                                    .primaryColor),
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
                                  title: 'CKTSTATUS',
                                  field: 'CKTSTATUS_Column',
                                  backgroundColor: const Color(0XFF6491F7),
                                  titleSpan: TextSpan(children: [
                                    WidgetSpan(
                                        child: Icon(Icons.car_repair_outlined,
                                            color: AppTheme.of(context)
                                                .primaryBackground)),
                                    const WidgetSpan(
                                        child: SizedBox(width: 10)),
                                    TextSpan(
                                        text: 'CKTSTATUS',
                                        style: AppTheme.of(context)
                                            .encabezadoTablas)
                                  ]),
                                  width:
                                      MediaQuery.of(context).size.width * 0.11,
                                  cellPadding: EdgeInsets.zero,
                                  titleTextAlign: PlutoColumnTextAlign.center,
                                  textAlign: PlutoColumnTextAlign.center,
                                  type: PlutoColumnType.text(),
                                  enableEditingMode: false,
                                  renderer: (rendererContext) {
                                    return Container(
                                      height: rowHeight,
                                      // width: rendererContext
                                      //.cell.column.width,                                                    .cell.column.width,
                                      decoration: BoxDecoration(
                                          gradient: whiteGradient),
                                      child: Center(
                                          child: Text(
                                        rendererContext.cell.value,
                                        style: AppTheme.of(context)
                                            .contenidoTablas
                                            .override(
                                                fontFamily: 'Gotham-Regular',
                                                useGoogleFonts: false,
                                                color: AppTheme.of(context)
                                                    .primaryColor),
                                      )),
                                    );
                                  },
                                ),
                                PlutoColumn(
                                  title: 'CktID',
                                  field: 'CktID_Column',
                                  titleSpan: TextSpan(children: [
                                    WidgetSpan(
                                        child: Icon(
                                            Icons.label_important_outline,
                                            color: AppTheme.of(context)
                                                .primaryBackground)),
                                    const WidgetSpan(
                                        child: SizedBox(width: 10)),
                                    TextSpan(
                                        text: 'CKTID',
                                        style: AppTheme.of(context)
                                            .encabezadoTablas)
                                  ]),
                                  width:
                                      MediaQuery.of(context).size.width * 0.1,
                                  backgroundColor: const Color(0XFF6491F7),
                                  cellPadding: EdgeInsets.zero,
                                  titleTextAlign: PlutoColumnTextAlign.center,
                                  textAlign: PlutoColumnTextAlign.center,
                                  type: PlutoColumnType.text(),
                                  enableEditingMode: false,
                                  renderer: (rendererContext) {
                                    return Container(
                                      height: rowHeight,
                                      decoration: BoxDecoration(
                                          gradient: whiteGradient),
                                      child: Center(
                                          child: Text(
                                        rendererContext.cell.value,
                                        style: AppTheme.of(context)
                                            .contenidoTablas
                                            .override(
                                                fontFamily: 'Gotham-Regular',
                                                useGoogleFonts: false,
                                                color: AppTheme.of(context)
                                                    .primaryColor),
                                      )),
                                    );
                                  },
                                ),
                                PlutoColumn(
                                  title: 'Street',
                                  field: 'street_Column',
                                  backgroundColor: const Color(0XFF6491F7),
                                  titleSpan: TextSpan(children: [
                                    WidgetSpan(
                                        child: Icon(
                                            Icons.local_shipping_outlined,
                                            color: AppTheme.of(context)
                                                .primaryBackground)),
                                    const WidgetSpan(
                                        child: SizedBox(width: 10)),
                                    TextSpan(
                                        text: 'Street',
                                        style: AppTheme.of(context)
                                            .encabezadoTablas)
                                  ]),
                                  width:
                                      MediaQuery.of(context).size.width * 0.08,
                                  cellPadding: EdgeInsets.zero,
                                  titleTextAlign: PlutoColumnTextAlign.center,
                                  textAlign: PlutoColumnTextAlign.center,
                                  type: PlutoColumnType.text(),
                                  enableEditingMode: false,
                                  renderer: (rendererContext) {
                                    return Container(
                                      height: rowHeight,
                                      // width: rendererContext
                                      //.cell.column.width,                                                    .cell.column.width,
                                      decoration: BoxDecoration(
                                          gradient: whiteGradient),
                                      child: Center(
                                          child: Text(
                                        rendererContext.cell.value,
                                        style: AppTheme.of(context)
                                            .contenidoTablas
                                            .override(
                                                fontFamily: 'Gotham-Regular',
                                                useGoogleFonts: false,
                                                color: AppTheme.of(context)
                                                    .primaryColor),
                                      )),
                                    );
                                  },
                                ),
                                PlutoColumn(
                                  title: 'State',
                                  field: 'state_Column',
                                  backgroundColor: const Color(0XFF6491F7),
                                  titleSpan: TextSpan(children: [
                                    WidgetSpan(
                                        child: Icon(
                                            Icons.local_shipping_outlined,
                                            color: AppTheme.of(context)
                                                .primaryBackground)),
                                    const WidgetSpan(
                                        child: SizedBox(width: 10)),
                                    TextSpan(
                                        text: 'State',
                                        style: AppTheme.of(context)
                                            .encabezadoTablas)
                                  ]),
                                  width:
                                      MediaQuery.of(context).size.width * 0.10,
                                  cellPadding: EdgeInsets.zero,
                                  titleTextAlign: PlutoColumnTextAlign.center,
                                  textAlign: PlutoColumnTextAlign.center,
                                  type: PlutoColumnType.text(),
                                  enableEditingMode: false,
                                  renderer: (rendererContext) {
                                    return Container(
                                      height: rowHeight,
                                      // width: rendererContext
                                      //.cell.column.width,                                                    .cell.column.width,
                                      decoration: BoxDecoration(
                                          gradient: whiteGradient),
                                      child: Center(
                                          child: Text(
                                        rendererContext.cell.value,
                                        style: AppTheme.of(context)
                                            .contenidoTablas
                                            .override(
                                                fontFamily: 'Gotham-Regular',
                                                useGoogleFonts: false,
                                                color: AppTheme.of(context)
                                                    .primaryColor),
                                      )),
                                    );
                                  },
                                ),
                                PlutoColumn(
                                  title: 'CKTType',
                                  field: 'CKTType_Column',
                                  backgroundColor: const Color(0XFF6491F7),
                                  titleSpan: TextSpan(children: [
                                    WidgetSpan(
                                        child: Icon(Icons.warehouse_outlined,
                                            color: AppTheme.of(context)
                                                .primaryBackground)),
                                    const WidgetSpan(
                                        child: SizedBox(width: 10)),
                                    TextSpan(
                                        text: 'CKTType',
                                        style: AppTheme.of(context)
                                            .encabezadoTablas)
                                  ]),
                                  width:
                                      MediaQuery.of(context).size.width * 0.10,
                                  cellPadding: EdgeInsets.zero,
                                  titleTextAlign: PlutoColumnTextAlign.center,
                                  textAlign: PlutoColumnTextAlign.center,
                                  type: PlutoColumnType.text(),
                                  enableEditingMode: false,
                                  renderer: (rendererContext) {
                                    return Container(
                                      height: rowHeight,
                                      // width: rendererContext
                                      //.cell.column.width,                                                    .cell.column.width,
                                      decoration: BoxDecoration(
                                          gradient: whiteGradient),
                                      child: Center(
                                          child: Text(
                                        rendererContext.cell.value,
                                        style: AppTheme.of(context)
                                            .contenidoTablas
                                            .override(
                                                fontFamily: 'Gotham-Regular',
                                                useGoogleFonts: false,
                                                color: AppTheme.of(context)
                                                    .primaryColor),
                                      )),
                                    );
                                  },
                                ),
                                PlutoColumn(
                                  title: 'CKTUSE',
                                  field: 'cktuse_Column',
                                  backgroundColor: const Color(0XFF6491F7),
                                  titleSpan: TextSpan(children: [
                                    WidgetSpan(
                                        child: Icon(Icons.warehouse_outlined,
                                            color: AppTheme.of(context)
                                                .primaryBackground)),
                                    const WidgetSpan(
                                        child: SizedBox(width: 10)),
                                    TextSpan(
                                        text: 'CKTUSE',
                                        style: AppTheme.of(context)
                                            .encabezadoTablas)
                                  ]),
                                  width:
                                      MediaQuery.of(context).size.width * 0.09,
                                  cellPadding: EdgeInsets.zero,
                                  titleTextAlign: PlutoColumnTextAlign.center,
                                  textAlign: PlutoColumnTextAlign.center,
                                  type: PlutoColumnType.text(),
                                  enableEditingMode: false,
                                  renderer: (rendererContext) {
                                    return Container(
                                      height: rowHeight,
                                      // width: rendererContext
                                      //.cell.column.width,                                                    .cell.column.width,
                                      decoration: BoxDecoration(
                                          gradient: whiteGradient),
                                      child: Center(
                                          child: Text(
                                        rendererContext.cell.value,
                                        style: AppTheme.of(context)
                                            .contenidoTablas
                                            .override(
                                                fontFamily: 'Gotham-Regular',
                                                useGoogleFonts: false,
                                                color: AppTheme.of(context)
                                                    .primaryColor),
                                      )),
                                    );
                                  },
                                ),
                                PlutoColumn(
                                  title: 'actions',
                                  field: 'actions',
                                  backgroundColor: const Color(0XFF6491F7),
                                  titleSpan: TextSpan(children: [
                                    WidgetSpan(
                                        child: Icon(
                                            Icons.call_to_action_outlined,
                                            color: AppTheme.of(context)
                                                .primaryBackground)),
                                    const WidgetSpan(
                                        child: SizedBox(width: 10)),
                                    TextSpan(
                                        text: 'Actions',
                                        style: AppTheme.of(context)
                                            .encabezadoTablas)
                                  ]),
                                  width:
                                      MediaQuery.of(context).size.width * 0.09,
                                  cellPadding: EdgeInsets.zero,
                                  titleTextAlign: PlutoColumnTextAlign.center,
                                  textAlign: PlutoColumnTextAlign.center,
                                  type: PlutoColumnType.text(),
                                  enableEditingMode: false,
                                  renderer: (rendererContext) {
                                    return Container(
                                      height: rowHeight,
                                      decoration: BoxDecoration(
                                          gradient: whiteGradient),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          // Issue
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0, right: 8.0),
                                            child: CustomTextIconButton(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.08,
                                              isLoading: false,
                                              icon: Icon(
                                                  Icons.remove_red_eye_outlined,
                                                  color: AppTheme.of(context)
                                                      .primaryBackground),
                                              text: 'Preview',
                                              style: AppTheme.of(context)
                                                  .contenidoTablas
                                                  .override(
                                                    fontFamily:
                                                        'Gotham-Regular',
                                                    useGoogleFonts: false,
                                                    color: AppTheme.of(context)
                                                        .primaryBackground,
                                                  ),
                                              color: AppTheme.of(context)
                                                  .primaryColor,
                                              onTap: () async {
                                                provider.getInformationCircuit(
                                                    rendererContext.cell.value);

                                                context.pushReplacement(
                                                    routeCircuitSelected,
                                                    extra: rendererContext
                                                        .cell.value);
                                              },
                                            ),
                                          ),
                                          // CustomTextIconButton(
                                          //   mainAxisAlignment:
                                          //       MainAxisAlignment.center,
                                          //   width: MediaQuery.of(context)
                                          //           .size
                                          //           .width *
                                          //       0.06,
                                          //   isLoading: false,
                                          //   icon: Icon(
                                          //     Icons.fact_check_outlined,
                                          //     color: AppTheme.of(context)
                                          //         .primaryBackground,
                                          //   ),
                                          //   text: 'Edit',
                                          //   style: AppTheme.of(context)
                                          //       .contenidoTablas
                                          //       .override(
                                          //         fontFamily: 'Gotham-Regular',
                                          //         useGoogleFonts: false,
                                          //         color: AppTheme.of(context)
                                          //             .primaryBackground,
                                          //       ),
                                          //   onTap: () async {
                                          //     //provider.clearControllers();
                                          //     await provider.getCompanies(
                                          //         notify: false);
                                          //     await provider.getStatus(
                                          //         notify: false);
                                          //     await provider.getOwnerShip(
                                          //         notify: false);
                                          //     provider.inicializeColor(
                                          //         rendererContext.cell.value);

                                          //     provider.inicializeImage(
                                          //         rendererContext.cell.value);
                                          //     provider
                                          //         .updateInventoryControllers(
                                          //             rendererContext
                                          //                 .cell.value);
                                          //     // provider
                                          //     //     .serviceDateControllerAvailable
                                          //     //     .clear();
                                          //     // provider.problemControllerUpdate
                                          //     //     .text = "";
                                          //     provider.getProblemVehicle(
                                          //         rendererContext.cell.value);
                                          //     provider.problemControllerUpdate
                                          //         .clear();
                                          //     provider.visibilty = false;
                                          //     // ignore: use_build_context_synchronously
                                          //     await showDialog(
                                          //         context: context,
                                          //         builder:
                                          //             (BuildContext context) {
                                          //           return StatefulBuilder(
                                          //               builder: (context,
                                          //                   setState) {
                                          //             return UpdateVehiclePopUp(
                                          //               vehicle: rendererContext
                                          //                   .cell.value,
                                          //             );
                                          //           });
                                          //         });
                                          //     await provider.updateState();
                                          //   },
                                          // ),
                                          // CustomTextIconButton(
                                          //   mainAxisAlignment:
                                          //       MainAxisAlignment.center,
                                          //   width: MediaQuery.of(context)
                                          //           .size
                                          //           .width *
                                          //       0.07,
                                          //   isLoading: false,
                                          //   icon: Icon(
                                          //     Icons.shopping_basket_outlined,
                                          //     color: AppTheme.of(context)
                                          //         .primaryBackground,
                                          //   ),
                                          //   color: secondaryColor,
                                          //   text: 'Delete',
                                          //   style: AppTheme.of(context)
                                          //       .contenidoTablas
                                          //       .override(
                                          //         fontFamily: 'Gotham-Regular',
                                          //         useGoogleFonts: false,
                                          //         color: AppTheme.of(context)
                                          //             .primaryBackground,
                                          //       ),
                                          //   onTap: () async {
                                          //     await showDialog(
                                          //         context: context,
                                          //         builder:
                                          //             (BuildContext context) {
                                          //           return StatefulBuilder(
                                          //               builder: (context,
                                          //                   setState) {
                                          //             return DeletePopUp(
                                          //               vehicle: rendererContext
                                          //                   .cell.value,
                                          //             );
                                          //           });
                                          //         });
                                          //   },
                                          // ),
                                          // CustomTextIconButton(
                                          //   mainAxisAlignment:
                                          //       MainAxisAlignment.center,
                                          //   width: MediaQuery.of(context)
                                          //           .size
                                          //           .width *
                                          //       0.08,
                                          //   isLoading: false,
                                          //   icon: Icon(Icons.list_alt_outlined,
                                          //       color: AppTheme.of(context)
                                          //           .primaryBackground),
                                          //   text: 'Services',
                                          //   style: AppTheme.of(context)
                                          //       .contenidoTablas
                                          //       .override(
                                          //         fontFamily: 'Gotham-Regular',
                                          //         useGoogleFonts: false,
                                          //         color: AppTheme.of(context)
                                          //             .primaryBackground,
                                          //       ),
                                          //   color: AppTheme.of(context)
                                          //       .primaryColor,
                                          //   onTap: () async {
                                          //     isssueReportedProvider
                                          //         .selectVehicle(
                                          //       rendererContext.cell.value,
                                          //       notify: false,
                                          //     );
                                          //     provider.clearControllerService();
                                          //     await provider.getServices(
                                          //         notify: false);
                                          //     provider.selectVehicle(
                                          //         rendererContext.cell.value);

                                          //     await provider.getServicesPage();
                                          //     // // ignore: use_build_context_synchronously
                                          //     // showDialog(
                                          //     //     context: context,
                                          //     //     builder:
                                          //     //         (BuildContext context) {
                                          //     //       return const AddServicePopUp();
                                          //     //     });
                                          //     if (!mounted) return;
                                          //     context.pushReplacement(
                                          //         routeService,
                                          //         extra: rendererContext
                                          //             .cell.value);
                                          //   },
                                          // ),
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
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
      ]),
    ));
  }
}
