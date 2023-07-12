import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:rta_crm_cv/pages/ctrlv/inventory_page/vehicle_cards/cry_card.dart';
import 'package:rta_crm_cv/pages/ctrlv/inventory_page/pop_up/details_pop_up.dart';
import 'package:rta_crm_cv/pages/ctrlv/inventory_page/vehicle_cards/odi_card.dart';
import 'package:rta_crm_cv/pages/ctrlv/inventory_page/vehicle_cards/smi_card.dart';
import 'package:rta_crm_cv/providers/ctrlv/inventory_provider.dart';
import 'package:rta_crm_cv/widgets/side_menu/sidemenu.dart';

import '../../../helpers/constants.dart';
import '../../../providers/ctrlv/issue_reported_provider.dart';
import '../../../providers/side_menu_provider.dart';

import '../../../public/colors.dart';
import '../../../theme/theme.dart';
import '../../../widgets/custom_card.dart';
import '../../../widgets/custom_text_icon_button.dart';
import 'actions/add_services_pop_up.dart';
import 'pop_up/verify_to_eliminate_pop_up.dart';
import 'widgets/header_inventory.dart';
import 'actions/update_vehicle_pop_up.dart';

class InventoryPageDesktop extends StatefulWidget {
  const InventoryPageDesktop(
      {Key? key,
      required this.drawerController,
      required this.scaffoldKey,
      required this.provider})
      : super(key: key);
  final AdvancedDrawerController drawerController;
  final GlobalKey<ScaffoldState> scaffoldKey;

  final InventoryProvider provider;

  @override
  State<InventoryPageDesktop> createState() => _InventoryPageDesktopState();
}

class _InventoryPageDesktopState extends State<InventoryPageDesktop> {
  TextEditingController searchController = TextEditingController();

  late PlutoGridStateManager stateManager;
  @override
  Widget build(BuildContext context) {
    SideMenuProvider sideM = Provider.of<SideMenuProvider>(context);
    InventoryProvider provider = Provider.of<InventoryProvider>(context);
    IssueReportedProvider isssueReportedProvider =
        Provider.of<IssueReportedProvider>(context);
    sideM.setIndex(7);

    return Scaffold(
      key: widget.scaffoldKey,
      // backgroundColor: AppTheme.of(context).primaryBackground,
      backgroundColor: const Color(0xffE0EDF9),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          // Container de toda la pantalla
          child: Container(
            decoration: BoxDecoration(gradient: whiteGradient),
            height: 1500,
            // Row para el sideMenu y el Container principal
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SideMenu(),
                Expanded(
                  child: ListView(
                    children: [
                      // Container de las tarjetas y la tabla pluto
                      SizedBox(
                        height: 1300,
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(bottom: 10),
                              height: 500,
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    // Carta de CRY
                                    Container(
                                      margin: const EdgeInsets.all(20),
                                      height: 425,
                                      width: 339,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Column(
                                        children: [
                                          const SizedBox(
                                            height: 25,
                                          ),
                                          CryCard(
                                            totalVehicleCRY:
                                                widget.provider.totalVehicleCRY,
                                            totalAssignedCRY: widget
                                                .provider.totalAssignedCRY,
                                            totalRepairCRY:
                                                widget.provider.totalRepairCRY,
                                            totalAvailableCRY: widget
                                                .provider.totalAvailableCRY,
                                          ),
                                        ],
                                      ),
                                    ),
                                    // Carta de ODE
                                    Container(
                                      margin: const EdgeInsets.all(20),
                                      height: 425,
                                      width: 339,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Column(
                                        children: [
                                          Container(
                                            height: 25,
                                          ),
                                          OdiCard(
                                            totalVehicleODE:
                                                widget.provider.totalVehicleODE,
                                            totalRepairODE:
                                                widget.provider.totalRepairODE,
                                            totalAssignedODE: widget
                                                .provider.totalAssignedODE,
                                            totalAvailableODE: widget
                                                .provider.totalAvailableODE,
                                          )
                                        ],
                                      ),
                                    ),
                                    // Carta de SMI
                                    Container(
                                      margin: const EdgeInsets.all(20),
                                      height: 425,
                                      width: 339,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Column(
                                        children: [
                                          const SizedBox(
                                            height: 25,
                                          ),
                                          SmiCard(
                                            totalVehicleSMI:
                                                widget.provider.totalVehicleSMI,
                                            totalAssignedSMI: widget
                                                .provider.totalAssignedSMI,
                                            totalRepairSMI:
                                                widget.provider.totalRepairSMI,
                                            totalAvailableSMI: widget
                                                .provider.totalAvailableSMI,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ]),
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
                                      child: Container(
                                        height:
                                            MediaQuery.of(context).size.height -
                                                200,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: Material(
                                          shadowColor: const Color(0xff9ABEFF),
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          elevation: 10,
                                          child: PlutoGrid(
                                            key: UniqueKey(),
                                            configuration:
                                                PlutoGridConfiguration(
                                              scrollbar:
                                                  plutoGridScrollbarConfig(
                                                      context),
                                              style:
                                                  plutoGridStyleConfig(context),
                                              columnFilter:
                                                  PlutoGridColumnFilterConfig(
                                                filters: const [
                                                  ...FilterHelper
                                                      .defaultFilters,
                                                ],
                                                resolveDefaultColumnFilter:
                                                    (column, resolver) {
                                                  if (column.field ==
                                                      'license_plates') {
                                                    return resolver<
                                                            PlutoFilterTypeContains>()
                                                        as PlutoFilterType;
                                                  } else if (column.field ==
                                                      'VIN') {
                                                    return resolver<
                                                            PlutoFilterTypeContains>()
                                                        as PlutoFilterType;
                                                  } else if (column.field ==
                                                      'Make') {
                                                    return resolver<
                                                            PlutoFilterTypeContains>()
                                                        as PlutoFilterType;
                                                  } else if (column.field ==
                                                      'Model') {
                                                    return resolver<
                                                            PlutoFilterTypeContains>()
                                                        as PlutoFilterType;
                                                  } else if (column.field ==
                                                      'Status') {
                                                    return resolver<
                                                            PlutoFilterTypeContains>()
                                                        as PlutoFilterType;
                                                  } else if (column.field ==
                                                      'Company') {
                                                    return resolver<
                                                            PlutoFilterTypeContains>()
                                                        as PlutoFilterType;
                                                  } else if (column.field ==
                                                      'Mileage') {
                                                    return resolver<
                                                            PlutoFilterTypeContains>()
                                                        as PlutoFilterType;
                                                  } else if (column.field ==
                                                      'Actions') {
                                                    return resolver<
                                                            PlutoFilterTypeContains>()
                                                        as PlutoFilterType;
                                                  }
                                                  return resolver<
                                                          PlutoFilterTypeContains>()
                                                      as PlutoFilterType;
                                                },
                                              ),
                                            ),
                                            columns: [
                                              PlutoColumn(
                                                title: 'License Plates',
                                                field: 'license_plates',
                                                backgroundColor:
                                                    const Color(0XFF6491F7),
                                                titleSpan: TextSpan(children: [
                                                  WidgetSpan(
                                                      child: Icon(
                                                          Icons
                                                              .credit_card_outlined,
                                                          color: AppTheme.of(
                                                                  context)
                                                              .primaryBackground)),
                                                  const WidgetSpan(
                                                      child:
                                                          SizedBox(width: 10)),
                                                  TextSpan(
                                                      text: 'License Plates',
                                                      style:
                                                          AppTheme.of(context)
                                                              .encabezadoTablas)
                                                ]),
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.12,
                                                cellPadding: EdgeInsets.zero,
                                                titleTextAlign:
                                                    PlutoColumnTextAlign.center,
                                                textAlign:
                                                    PlutoColumnTextAlign.center,
                                                type: PlutoColumnType.text(),
                                                enableEditingMode: false,
                                                renderer: (rendererContext) {
                                                  return Container(
                                                    height: rowHeight,
                                                    // width: rendererContext.cell.column.width,
                                                    decoration: BoxDecoration(
                                                        gradient:
                                                            whiteGradient),
                                                    child: Center(
                                                      child: Text(
                                                        rendererContext
                                                            .cell.value,
                                                        style: AppTheme.of(
                                                                context)
                                                            .contenidoTablas
                                                            .override(
                                                                fontFamily:
                                                                    'Gotham-Regular',
                                                                useGoogleFonts:
                                                                    false,
                                                                color: AppTheme.of(
                                                                        context)
                                                                    .primaryColor),
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ),
                                              PlutoColumn(
                                                title: 'Vin',
                                                field: 'vin',
                                                backgroundColor:
                                                    const Color(0XFF6491F7),
                                                titleSpan: TextSpan(children: [
                                                  WidgetSpan(
                                                      child: Icon(
                                                          Icons
                                                              .dialpad_outlined,
                                                          color: AppTheme.of(
                                                                  context)
                                                              .primaryBackground)),
                                                  const WidgetSpan(
                                                      child:
                                                          SizedBox(width: 10)),
                                                  TextSpan(
                                                      text: 'VIN',
                                                      style:
                                                          AppTheme.of(context)
                                                              .encabezadoTablas)
                                                ]),
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.12,
                                                cellPadding: EdgeInsets.zero,
                                                titleTextAlign:
                                                    PlutoColumnTextAlign.center,
                                                textAlign:
                                                    PlutoColumnTextAlign.center,
                                                type: PlutoColumnType.text(),
                                                enableEditingMode: false,
                                                renderer: (rendererContext) {
                                                  return Container(
                                                    height: rowHeight,
                                                    // width: rendererContext
                                                    //.cell.column.width,                                                    .cell.column.width,
                                                    decoration: BoxDecoration(
                                                        gradient:
                                                            whiteGradient),
                                                    child: Center(
                                                        child: Text(
                                                      rendererContext
                                                          .cell.value,
                                                      style: AppTheme.of(
                                                              context)
                                                          .contenidoTablas
                                                          .override(
                                                              fontFamily:
                                                                  'Gotham-Regular',
                                                              useGoogleFonts:
                                                                  false,
                                                              color: AppTheme.of(
                                                                      context)
                                                                  .primaryColor),
                                                    )),
                                                  );
                                                },
                                              ),
                                              PlutoColumn(
                                                title: 'Make',
                                                field: 'make',
                                                titleSpan: TextSpan(children: [
                                                  WidgetSpan(
                                                      child: Icon(
                                                          Icons
                                                              .label_important_outline,
                                                          color: AppTheme.of(
                                                                  context)
                                                              .primaryBackground)),
                                                  const WidgetSpan(
                                                      child:
                                                          SizedBox(width: 10)),
                                                  TextSpan(
                                                      text: 'Make',
                                                      style:
                                                          AppTheme.of(context)
                                                              .encabezadoTablas)
                                                ]),
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.10,
                                                backgroundColor:
                                                    const Color(0XFF6491F7),
                                                cellPadding: EdgeInsets.zero,
                                                titleTextAlign:
                                                    PlutoColumnTextAlign.center,
                                                textAlign:
                                                    PlutoColumnTextAlign.center,
                                                type: PlutoColumnType.text(),
                                                enableEditingMode: false,
                                                renderer: (rendererContext) {
                                                  return Container(
                                                    height: rowHeight,
                                                    decoration: BoxDecoration(
                                                        gradient:
                                                            whiteGradient),
                                                    child: Center(
                                                        child: Text(
                                                      rendererContext
                                                          .cell.value,
                                                      style: AppTheme.of(
                                                              context)
                                                          .contenidoTablas
                                                          .override(
                                                              fontFamily:
                                                                  'Gotham-Regular',
                                                              useGoogleFonts:
                                                                  false,
                                                              color: AppTheme.of(
                                                                      context)
                                                                  .primaryColor),
                                                    )),
                                                  );
                                                },
                                              ),
                                              PlutoColumn(
                                                title: 'Model',
                                                field: 'model',
                                                backgroundColor:
                                                    const Color(0XFF6491F7),
                                                titleSpan: TextSpan(children: [
                                                  WidgetSpan(
                                                      child: Icon(
                                                          Icons
                                                              .local_shipping_outlined,
                                                          color: AppTheme.of(
                                                                  context)
                                                              .primaryBackground)),
                                                  const WidgetSpan(
                                                      child:
                                                          SizedBox(width: 10)),
                                                  TextSpan(
                                                      text: 'Model',
                                                      style:
                                                          AppTheme.of(context)
                                                              .encabezadoTablas)
                                                ]),
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.10,
                                                cellPadding: EdgeInsets.zero,
                                                titleTextAlign:
                                                    PlutoColumnTextAlign.center,
                                                textAlign:
                                                    PlutoColumnTextAlign.center,
                                                type: PlutoColumnType.text(),
                                                enableEditingMode: false,
                                                renderer: (rendererContext) {
                                                  return Container(
                                                    height: rowHeight,
                                                    // width: rendererContext
                                                    //.cell.column.width,                                                    .cell.column.width,
                                                    decoration: BoxDecoration(
                                                        gradient:
                                                            whiteGradient),
                                                    child: Center(
                                                        child: Text(
                                                      rendererContext
                                                          .cell.value,
                                                      style: AppTheme.of(
                                                              context)
                                                          .contenidoTablas
                                                          .override(
                                                              fontFamily:
                                                                  'Gotham-Regular',
                                                              useGoogleFonts:
                                                                  false,
                                                              color: AppTheme.of(
                                                                      context)
                                                                  .primaryColor),
                                                    )),
                                                  );
                                                },
                                              ),
                                              PlutoColumn(
                                                title: 'Status',
                                                field: 'status',
                                                backgroundColor:
                                                    const Color(0XFF6491F7),
                                                titleSpan: TextSpan(children: [
                                                  WidgetSpan(
                                                      child: Icon(
                                                          Icons
                                                              .car_repair_outlined,
                                                          color: AppTheme.of(
                                                                  context)
                                                              .primaryBackground)),
                                                  const WidgetSpan(
                                                      child:
                                                          SizedBox(width: 10)),
                                                  TextSpan(
                                                      text: 'Status',
                                                      style:
                                                          AppTheme.of(context)
                                                              .encabezadoTablas)
                                                ]),
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.11,
                                                cellPadding: EdgeInsets.zero,
                                                titleTextAlign:
                                                    PlutoColumnTextAlign.center,
                                                textAlign:
                                                    PlutoColumnTextAlign.center,
                                                type: PlutoColumnType.text(),
                                                enableEditingMode: false,
                                                renderer: (rendererContext) {
                                                  return Container(
                                                    height: rowHeight,
                                                    // width: rendererContext
                                                    //.cell.column.width,.cell.column.width,
                                                    decoration: BoxDecoration(
                                                        gradient:
                                                            whiteGradient),
                                                    child: Center(
                                                        child: Text(
                                                      rendererContext
                                                          .cell.value,
                                                      style: AppTheme.of(
                                                              context)
                                                          .contenidoTablas
                                                          .override(
                                                              fontFamily:
                                                                  'Gotham-Regular',
                                                              useGoogleFonts:
                                                                  false,
                                                              color: AppTheme.of(
                                                                      context)
                                                                  .primaryColor),
                                                    )),
                                                  );
                                                },
                                              ),
                                              PlutoColumn(
                                                title: 'Company',
                                                field: 'company',
                                                backgroundColor:
                                                    const Color(0XFF6491F7),
                                                titleSpan: TextSpan(children: [
                                                  WidgetSpan(
                                                      child: Icon(
                                                          Icons
                                                              .warehouse_outlined,
                                                          color: AppTheme.of(
                                                                  context)
                                                              .primaryBackground)),
                                                  const WidgetSpan(
                                                      child:
                                                          SizedBox(width: 10)),
                                                  TextSpan(
                                                      text: 'Company',
                                                      style:
                                                          AppTheme.of(context)
                                                              .encabezadoTablas)
                                                ]),
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.10,
                                                cellPadding: EdgeInsets.zero,
                                                titleTextAlign:
                                                    PlutoColumnTextAlign.center,
                                                textAlign:
                                                    PlutoColumnTextAlign.center,
                                                type: PlutoColumnType.text(),
                                                enableEditingMode: false,
                                                renderer: (rendererContext) {
                                                  return Container(
                                                    height: rowHeight,
                                                    // width: rendererContext
                                                    //.cell.column.width,                                                    .cell.column.width,
                                                    decoration: BoxDecoration(
                                                        gradient:
                                                            whiteGradient),
                                                    child: Center(
                                                        child: Text(
                                                      rendererContext
                                                          .cell.value,
                                                      style: AppTheme.of(
                                                              context)
                                                          .contenidoTablas
                                                          .override(
                                                              fontFamily:
                                                                  'Gotham-Regular',
                                                              useGoogleFonts:
                                                                  false,
                                                              color: AppTheme.of(
                                                                      context)
                                                                  .primaryColor),
                                                    )),
                                                  );
                                                },
                                              ),
                                              PlutoColumn(
                                                title: 'mileage',
                                                field: 'mileage',
                                                backgroundColor:
                                                    const Color(0XFF6491F7),
                                                titleSpan: TextSpan(children: [
                                                  WidgetSpan(
                                                      child: Icon(
                                                          Icons
                                                              .warehouse_outlined,
                                                          color: AppTheme.of(
                                                                  context)
                                                              .primaryBackground)),
                                                  const WidgetSpan(
                                                      child:
                                                          SizedBox(width: 10)),
                                                  TextSpan(
                                                      text: 'Mileage',
                                                      style:
                                                          AppTheme.of(context)
                                                              .encabezadoTablas)
                                                ]),
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.11,
                                                cellPadding: EdgeInsets.zero,
                                                titleTextAlign:
                                                    PlutoColumnTextAlign.center,
                                                textAlign:
                                                    PlutoColumnTextAlign.center,
                                                type: PlutoColumnType.text(),
                                                enableEditingMode: false,
                                                renderer: (rendererContext) {
                                                  return Container(
                                                    height: rowHeight,
                                                    // width: rendererContext
                                                    //.cell.column.width,                                                    .cell.column.width,
                                                    decoration: BoxDecoration(
                                                        gradient:
                                                            whiteGradient),
                                                    child: Center(
                                                        child: Text(
                                                      rendererContext
                                                          .cell.value,
                                                      style: AppTheme.of(
                                                              context)
                                                          .contenidoTablas
                                                          .override(
                                                              fontFamily:
                                                                  'Gotham-Regular',
                                                              useGoogleFonts:
                                                                  false,
                                                              color: AppTheme.of(
                                                                      context)
                                                                  .primaryColor),
                                                    )),
                                                  );
                                                },
                                              ),
                                              PlutoColumn(
                                                title: 'actions',
                                                field: 'actions',
                                                backgroundColor:
                                                    const Color(0XFF6491F7),
                                                titleSpan: TextSpan(children: [
                                                  WidgetSpan(
                                                      child: Icon(
                                                          Icons
                                                              .call_to_action_outlined,
                                                          color: AppTheme.of(
                                                                  context)
                                                              .primaryBackground)),
                                                  const WidgetSpan(
                                                      child:
                                                          SizedBox(width: 10)),
                                                  TextSpan(
                                                      text: 'Actions',
                                                      style:
                                                          AppTheme.of(context)
                                                              .encabezadoTablas)
                                                ]),
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.30,
                                                cellPadding: EdgeInsets.zero,
                                                titleTextAlign:
                                                    PlutoColumnTextAlign.center,
                                                textAlign:
                                                    PlutoColumnTextAlign.center,
                                                type: PlutoColumnType.text(),
                                                enableEditingMode: false,
                                                renderer: (rendererContext) {
                                                  return Container(
                                                    height: rowHeight,
                                                    width: rendererContext
                                                        .cell.column.width,
                                                    decoration: BoxDecoration(
                                                        gradient:
                                                            whiteGradient),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceAround,
                                                      children: [
                                                        // Details
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 8.0,
                                                                  right: 8.0),
                                                          child:
                                                              CustomTextIconButton(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            width: 92,
                                                            isLoading: false,
                                                            icon: Icon(
                                                                Icons
                                                                    .remove_red_eye_outlined,
                                                                color: AppTheme.of(
                                                                        context)
                                                                    .primaryBackground),
                                                            text: 'Details',
                                                            color: AppTheme.of(
                                                                    context)
                                                                .primaryColor,
                                                            onTap: () async {
                                                              isssueReportedProvider
                                                                  .getIssuesxUsers(
                                                                      rendererContext
                                                                          .cell
                                                                          .value);
                                                              provider.selectVehicle(
                                                                  rendererContext
                                                                      .cell
                                                                      .value);
                                                              isssueReportedProvider
                                                                  .selectVehicle(
                                                                      rendererContext
                                                                          .cell
                                                                          .value);
                                                              provider
                                                                  .getServicesPage();
                                                              showDialog(
                                                                  context:
                                                                      context,
                                                                  builder:
                                                                      (BuildContext
                                                                          context) {
                                                                    return StatefulBuilder(builder:
                                                                        (context,
                                                                            setState) {
                                                                      return DetailsPopUp(
                                                                        vehicle: rendererContext
                                                                            .cell
                                                                            .value,
                                                                      );
                                                                    });
                                                                  });
                                                            },
                                                          ),
                                                        ),
                                                        CustomTextIconButton(
                                                          isLoading: false,
                                                          icon: Icon(
                                                            Icons
                                                                .fact_check_outlined,
                                                            color: AppTheme.of(
                                                                    context)
                                                                .primaryBackground,
                                                          ),
                                                          text: 'Edit',
                                                          onTap: () async {
                                                            //provider.clearControllers();
                                                            await provider
                                                                .getCompanies(
                                                                    notify:
                                                                        false);
                                                            await provider
                                                                .getStatus(
                                                                    notify:
                                                                        false);
                                                            provider
                                                                .inicializeColor(
                                                                    rendererContext
                                                                        .cell
                                                                        .value);

                                                            provider
                                                                .inicializeImage(
                                                                    rendererContext
                                                                        .cell
                                                                        .value);
                                                            provider
                                                                .updateInventoryControllers(
                                                                    rendererContext
                                                                        .cell
                                                                        .value);
                                                            // ignore: use_build_context_synchronously
                                                            await showDialog(
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (BuildContext
                                                                        context) {
                                                                  return StatefulBuilder(
                                                                      builder:
                                                                          (context,
                                                                              setState) {
                                                                    return UpdateVehiclePopUp(
                                                                      vehicle: rendererContext
                                                                          .cell
                                                                          .value,
                                                                    );
                                                                  });
                                                                });
                                                          },
                                                        ),
                                                        CustomTextIconButton(
                                                          isLoading: false,
                                                          icon: Icon(
                                                            Icons
                                                                .shopping_basket_outlined,
                                                            color: AppTheme.of(
                                                                    context)
                                                                .primaryBackground,
                                                          ),
                                                          color: secondaryColor,
                                                          text: 'Delete',
                                                          onTap: () async {
                                                            await showDialog(
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (BuildContext
                                                                        context) {
                                                                  return StatefulBuilder(
                                                                      builder:
                                                                          (context,
                                                                              setState) {
                                                                    return DeletePopUp(
                                                                      vehicle: rendererContext
                                                                          .cell
                                                                          .value,
                                                                    );
                                                                  });
                                                                });
                                                            await provider
                                                                .getInventory();
                                                          },
                                                        ),
                                                        CustomTextIconButton(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          width: 120,
                                                          isLoading: false,
                                                          icon: Icon(
                                                              Icons
                                                                  .list_alt_outlined,
                                                              color: AppTheme.of(
                                                                      context)
                                                                  .primaryBackground),
                                                          text: 'Services',
                                                          color: AppTheme.of(
                                                                  context)
                                                              .primaryColor,
                                                          onTap: () async {
                                                            await provider
                                                                .getServices(
                                                                    notify:
                                                                        false);
                                                            provider.selectVehicle(
                                                                rendererContext
                                                                    .cell
                                                                    .value);

                                                            // ignore: use_build_context_synchronously
                                                            showDialog(
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (BuildContext
                                                                        context) {
                                                                  return const AddServicePopUp();
                                                                });
                                                          },
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                },
                                              ),
                                            ],
                                            rows: widget.provider.rows,
                                            createFooter: (stateManager) {
                                              stateManager.setPageSize(
                                                10,
                                                notify: false,
                                              );

                                              return PlutoPagination(
                                                  stateManager);
                                            },
                                            onLoaded: (event) {
                                              widget.provider.stateManager =
                                                  event.stateManager;

                                              stateManager = event.stateManager;

                                              stateManager
                                                  .setShowColumnFilter(true);
                                              stateManager.setSelectingMode(
                                                PlutoGridSelectingMode.row,
                                              );
                                              stateManager.sortAscending(
                                                  PlutoColumn(
                                                      title: '#',
                                                      field: 'id_vehicle',
                                                      type: PlutoColumnType
                                                          .number()));
                                            },
                                            onRowChecked: (event) {},
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                )),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
