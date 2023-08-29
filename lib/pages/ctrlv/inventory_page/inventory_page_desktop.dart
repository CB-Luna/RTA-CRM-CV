import 'package:go_router/go_router.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import 'package:rta_crm_cv/pages/ctrlv/inventory_page/vehicle_cards/cry_card.dart';
import 'package:rta_crm_cv/pages/ctrlv/inventory_page/vehicle_cards/odi_card.dart';
import 'package:rta_crm_cv/pages/ctrlv/inventory_page/vehicle_cards/smi_card.dart';
import 'package:rta_crm_cv/providers/ctrlv/inventory_provider.dart';
import 'package:rta_crm_cv/widgets/side_menu/sidemenu.dart';

import '../../../functions/sizes.dart';
import '../../../helpers/constants.dart';
import '../../../providers/ctrlv/issue_reported_provider.dart';
import '../../../providers/side_menu_provider.dart';

import '../../../public/colors.dart';
import '../../../theme/theme.dart';
import '../../../widgets/custom_card.dart';
import '../../../widgets/custom_icon_button.dart';
import '../../../widgets/custom_text_icon_button.dart';
import '../../../widgets/pluto_grid_cells/pluto_grid_company_cell.dart';
import '../../../widgets/pluto_grid_cells/pluto_grid_status_cellCV.dart';

import 'pop_up/verify_to_eliminate_pop_up.dart';
import 'widgets/header_inventory.dart';
import 'actions/update_vehicle_pop_up.dart';

class InventoryPageDesktop extends StatefulWidget {
  const InventoryPageDesktop({
    Key? key,
  }) : super(key: key);
  // final AdvancedDrawerController drawerController;
  // final GlobalKey<ScaffoldState> scaffoldKey;

  // final InventoryProvider provider;

  @override
  State<InventoryPageDesktop> createState() => _InventoryPageDesktopState();
}

class _InventoryPageDesktopState extends State<InventoryPageDesktop> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final InventoryProvider provider = Provider.of<InventoryProvider>(
        context,
        listen: false,
      );
      await provider.updateState();
    });
  }

  @override
  Widget build(BuildContext context) {
    SideMenuProvider sideM = Provider.of<SideMenuProvider>(context);
    InventoryProvider provider = Provider.of<InventoryProvider>(context);
    IssueReportedProvider isssueReportedProvider =
        Provider.of<IssueReportedProvider>(context);
    sideM.setIndex(7);

    return Material(
      // Container de toda la pantalla

      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(gradient: whiteGradient),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SideMenu(),
            Flexible(
              child: ListView(
                children: [
                  // Container de las tarjetas y la tabla pluto
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.50,
                    width: MediaQuery.of(context).size.width,
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.50,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          // Carta de CRY
                          CryCard(
                            totalVehicleCRY: provider.totalVehicleCRY,
                            totalAssignedCRY: provider.totalAssignedCRY,
                            totalRepairCRY: provider.totalRepairCRY,
                            totalAvailableCRY: provider.totalAvailableCRY,
                          ),
                          // Carta de ODE
                          OdiCard(
                            totalVehicle: provider.totalVehicleODE,
                            totalRepair: provider.totalRepairODE,
                            totalAssigned: provider.totalAssignedODE,
                            totalAvailable: provider.totalAvailableODE,
                          ),

                          // Carta de SMI
                          SmiCard(
                            totalVehicleSMI: provider.totalVehicleSMI,
                            totalAssignedSMI: provider.totalAssignedSMI,
                            totalRepairSMI: provider.totalRepairSMI,
                            totalAvailableSMI: provider.totalAvailableSMI,
                          ),
                        ],
                      ),
                    ),
                  ),
                  CustomCard(
                    width: MediaQuery.of(context).size.width - 200,
                    height: MediaQuery.of(context).size.height,
                    title: "Vehicle Inventory",
                    child: Column(
                      children: [
                        InventoryPageHeader(),
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
                                  title: 'License Plates',
                                  field: 'license_plates',
                                  backgroundColor: const Color(0XFF6491F7),
                                  titleSpan: TextSpan(children: [
                                    WidgetSpan(
                                        child: Icon(Icons.credit_card_outlined,
                                            color: AppTheme.of(context)
                                                .primaryBackground)),
                                    const WidgetSpan(
                                        child: SizedBox(width: 10)),
                                    TextSpan(
                                        text: 'L. Plates',
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
                                          rendererContext.cell.value,
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
                                  title: 'Vin',
                                  field: 'vin',
                                  backgroundColor: const Color(0XFF6491F7),
                                  titleSpan: TextSpan(children: [
                                    WidgetSpan(
                                        child: Icon(Icons.dialpad_outlined,
                                            color: AppTheme.of(context)
                                                .primaryBackground)),
                                    const WidgetSpan(
                                        child: SizedBox(width: 10)),
                                    TextSpan(
                                        text: 'VIN',
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
                                  title: 'Status',
                                  field: 'status',
                                  backgroundColor: const Color(0XFF6491F7),
                                  titleSpan: TextSpan(children: [
                                    WidgetSpan(
                                        child: Icon(Icons.car_repair_outlined,
                                            color: AppTheme.of(context)
                                                .primaryBackground)),
                                    const WidgetSpan(
                                        child: SizedBox(width: 10)),
                                    TextSpan(
                                        text: 'Status',
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
                                    return PlutoGridStatusCellCV(
                                      text: rendererContext.cell.value,
                                    );
                                  },
                                ),
                                PlutoColumn(
                                  title: 'Make',
                                  field: 'make',
                                  titleSpan: TextSpan(children: [
                                    WidgetSpan(
                                        child: Icon(
                                            Icons.label_important_outline,
                                            color: AppTheme.of(context)
                                                .primaryBackground)),
                                    const WidgetSpan(
                                        child: SizedBox(width: 10)),
                                    TextSpan(
                                        text: 'Make',
                                        style: AppTheme.of(context)
                                            .encabezadoTablas)
                                  ]),
                                  width:
                                      MediaQuery.of(context).size.width * 0.08,
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
                                  title: 'Year',
                                  field: 'year',
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
                                        text: 'Year',
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
                                  title: 'Model',
                                  field: 'model',
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
                                        text: 'Model',
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
                                  title: 'Company',
                                  field: 'company',
                                  backgroundColor: const Color(0XFF6491F7),
                                  titleSpan: TextSpan(children: [
                                    WidgetSpan(
                                        child: Icon(Icons.warehouse_outlined,
                                            color: AppTheme.of(context)
                                                .primaryBackground)),
                                    const WidgetSpan(
                                        child: SizedBox(width: 10)),
                                    TextSpan(
                                        text: 'Company',
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
                                    return PlutoGridCompanyCellCV(
                                      text: rendererContext.cell.value,
                                    );
                                  },
                                ),
                                PlutoColumn(
                                  title: 'mileage',
                                  field: 'mileage',
                                  backgroundColor: const Color(0XFF6491F7),
                                  titleSpan: TextSpan(children: [
                                    WidgetSpan(
                                        child: Icon(Icons.warehouse_outlined,
                                            color: AppTheme.of(context)
                                                .primaryBackground)),
                                    const WidgetSpan(
                                        child: SizedBox(width: 10)),
                                    TextSpan(
                                        text: 'Mileage',
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
                                      MediaQuery.of(context).size.width * 0.35,
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
                                              text: 'Issue',
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
                                                await isssueReportedProvider
                                                    .getIssuesxUsers(
                                                  rendererContext.cell.value,
                                                  notify: false,
                                                );
                                                isssueReportedProvider
                                                    .selectVehicle(
                                                  rendererContext.cell.value,
                                                  notify: false,
                                                );

                                                if (!mounted) return;
                                                context.pushReplacement(
                                                    routeDetailsInventory,
                                                    extra: rendererContext
                                                        .cell.value);
                                              },
                                            ),
                                          ),
                                          CustomTextIconButton(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.06,
                                            isLoading: false,
                                            icon: Icon(
                                              Icons.fact_check_outlined,
                                              color: AppTheme.of(context)
                                                  .primaryBackground,
                                            ),
                                            text: 'Edit',
                                            style: AppTheme.of(context)
                                                .contenidoTablas
                                                .override(
                                                  fontFamily: 'Gotham-Regular',
                                                  useGoogleFonts: false,
                                                  color: AppTheme.of(context)
                                                      .primaryBackground,
                                                ),
                                            onTap: () async {
                                              //provider.clearControllers();
                                              await provider.getCompanies(
                                                  notify: false);
                                              await provider.getStatus(
                                                  notify: false);
                                              provider.inicializeColor(
                                                  rendererContext.cell.value);

                                              provider.inicializeImage(
                                                  rendererContext.cell.value);
                                              provider
                                                  .updateInventoryControllers(
                                                      rendererContext
                                                          .cell.value);
                                              // ignore: use_build_context_synchronously
                                              await showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return StatefulBuilder(
                                                        builder: (context,
                                                            setState) {
                                                      return UpdateVehiclePopUp(
                                                        vehicle: rendererContext
                                                            .cell.value,
                                                      );
                                                    });
                                                  });
                                              await provider.updateState();
                                            },
                                          ),
                                          CustomTextIconButton(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.07,
                                            isLoading: false,
                                            icon: Icon(
                                              Icons.shopping_basket_outlined,
                                              color: AppTheme.of(context)
                                                  .primaryBackground,
                                            ),
                                            color: secondaryColor,
                                            text: 'Delete',
                                            style: AppTheme.of(context)
                                                .contenidoTablas
                                                .override(
                                                  fontFamily: 'Gotham-Regular',
                                                  useGoogleFonts: false,
                                                  color: AppTheme.of(context)
                                                      .primaryBackground,
                                                ),
                                            onTap: () async {
                                              await showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return StatefulBuilder(
                                                        builder: (context,
                                                            setState) {
                                                      return DeletePopUp(
                                                        vehicle: rendererContext
                                                            .cell.value,
                                                      );
                                                    });
                                                  });
                                            },
                                          ),
                                          CustomTextIconButton(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.08,
                                            isLoading: false,
                                            icon: Icon(Icons.list_alt_outlined,
                                                color: AppTheme.of(context)
                                                    .primaryBackground),
                                            text: 'Services',
                                            style: AppTheme.of(context)
                                                .contenidoTablas
                                                .override(
                                                  fontFamily: 'Gotham-Regular',
                                                  useGoogleFonts: false,
                                                  color: AppTheme.of(context)
                                                      .primaryBackground,
                                                ),
                                            color: AppTheme.of(context)
                                                .primaryColor,
                                            onTap: () async {
                                              isssueReportedProvider
                                                  .selectVehicle(
                                                rendererContext.cell.value,
                                                notify: false,
                                              );
                                              provider.clearControllerService();
                                              await provider.getServices(
                                                  notify: false);
                                              provider.selectVehicle(
                                                  rendererContext.cell.value);

                                              await provider.getServicesPage();
                                              // // ignore: use_build_context_synchronously
                                              // showDialog(
                                              //     context: context,
                                              //     builder:
                                              //         (BuildContext context) {
                                              //       return const AddServicePopUp();
                                              //     });
                                              if (!mounted) return;
                                              context.pushReplacement(
                                                  routeService,
                                                  extra: rendererContext
                                                      .cell.value);
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
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
