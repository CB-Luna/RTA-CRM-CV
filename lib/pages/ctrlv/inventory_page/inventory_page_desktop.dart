import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:rta_crm_cv/pages/ctrlv/inventory_page/pop_up/issues_pop_up.dart';
import 'package:rta_crm_cv/pages/ctrlv/inventory_page/vehicle_cards/cry_card.dart';
import 'package:rta_crm_cv/pages/ctrlv/inventory_page/pop_up/details_pop_up.dart';
import 'package:rta_crm_cv/pages/ctrlv/inventory_page/vehicle_cards/odi_card.dart';
import 'package:rta_crm_cv/pages/ctrlv/inventory_page/vehicle_cards/smi_card.dart';
import 'package:rta_crm_cv/providers/ctrlv/inventory_provider.dart';
import 'package:rta_crm_cv/widgets/card_header.dart';
import 'package:rta_crm_cv/widgets/side_menu/sidemenu.dart';

//import 'widgets/carga_de_ticket_popup.dart';
import '../../../helpers/constants.dart';
import '../../../providers/side_menu_provider.dart';

import '../../../public/colors.dart';
import '../../../theme/theme.dart';
import '../../../widgets/custom_text_icon_button.dart';
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
    sideM.setIndex(7);
    // final VisualStateProvider visualState =
    //     Provider.of<VisualStateProvider>(context);
    // visualState.setTapedOption(1);

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
                        height: 1500,
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
                                          color: Colors.white,
                                          //gradient: gradients[0],
                                          boxShadow: const [
                                            BoxShadow(
                                                blurRadius: 4,
                                                color: Colors.grey,
                                                offset: Offset(10, 10))
                                          ],
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
                                          color: Colors.white,
                                          //gradient: gradients[0],
                                          boxShadow: const [
                                            BoxShadow(
                                                blurRadius: 4,
                                                color: Colors.grey,
                                                offset: Offset(10, 10))
                                          ],
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
                                          color: Colors.white,
                                          //gradient: gradients[0],
                                          boxShadow: const [
                                            BoxShadow(
                                                blurRadius: 4,
                                                color: Colors.grey,
                                                offset: Offset(10, 10))
                                          ],
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
                            InventoryPageHeader(),
                            //ESTATUS STEPPER
                            const SizedBox(
                              height: 20,
                            ),
                            // Titulo de la tabla
                            const Padding(
                                padding: EdgeInsets.only(bottom: 10),
                                child: CardHeader(text: "Vehicle Inventory")),

                            // PLUTO GRID
                            // widget.provider.vehicles.isEmpty
                            //     ? const CircularProgressIndicator()
                            Flexible(
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Material(
                                  shadowColor: const Color(0xff9ABEFF),
                                  elevation: 10,
                                  child: PlutoGrid(
                                    key: UniqueKey(),
                                    configuration: PlutoGridConfiguration(
                                      localeText: const PlutoGridLocaleText(),
                                      scrollbar:
                                          plutoGridScrollbarConfig(context),
                                      style: plutoGridStyleConfig(context),
                                      columnFilter: PlutoGridColumnFilterConfig(
                                        filters: const [
                                          ...FilterHelper.defaultFilters,
                                        ],
                                        resolveDefaultColumnFilter:
                                            (column, resolver) {
                                          return resolver<
                                                  PlutoFilterTypeContains>()
                                              as PlutoFilterType;
                                        },
                                      ),
                                    ),
                                    columns: [
                                      // PlutoColumn(
                                      //   title: '#',
                                      //   field: 'id_vehicle',
                                      //   backgroundColor:
                                      //       Color(0XFF6491F7),
                                      //   titleSpan: const TextSpan(
                                      //     children: [
                                      //       WidgetSpan(
                                      //         child: Icon(
                                      //           Icons.key_outlined,
                                      //           color: Color(0xffF3F7F9),
                                      //           size: 30,
                                      //         ),
                                      //       ),
                                      //       WidgetSpan(
                                      //           child: SizedBox(
                                      //         width: 10,
                                      //       )),
                                      //       TextSpan(
                                      //           text: 'ID',
                                      //           style: TextStyle(
                                      //               color: Colors.white)),
                                      //     ],
                                      //   ),
                                      //   width: MediaQuery.of(context)
                                      //           .size
                                      //           .width *
                                      //       0.08,
                                      //   cellPadding: EdgeInsets.zero,
                                      //   titleTextAlign:
                                      //       PlutoColumnTextAlign.center,
                                      //   textAlign:
                                      //       PlutoColumnTextAlign.center,
                                      //   type: PlutoColumnType.number(),
                                      //   enableEditingMode: false,
                                      //   renderer: (rendererContext) {
                                      //     return Container(
                                      //       height: rowHeight,
                                      //       //width: rendererContext.cell.column.width,
                                      //       decoration: BoxDecoration(
                                      //           gradient: whiteGradient),
                                      //       child: Center(
                                      //           child: Text(
                                      //               rendererContext
                                      //                   .cell.value
                                      //                   .toString())),
                                      //     );
                                      //   },
                                      // ),
                                      // PlutoColumn(
                                      //   backgroundColor:
                                      //       Color(0XFF6491F7),
                                      //   title: 'Image',
                                      //   field: 'image',
                                      //   width: MediaQuery.of(context)
                                      //           .size
                                      //           .width *
                                      //       0.1,
                                      //   titleSpan: const TextSpan(
                                      //     children: [
                                      //       WidgetSpan(
                                      //         child: Icon(
                                      //           Icons.image_outlined,
                                      //           color: Color(0xffF3F7F9),
                                      //           size: 30,
                                      //         ),
                                      //       ),
                                      //       WidgetSpan(
                                      //           child: SizedBox(
                                      //         width: 10,
                                      //       )),
                                      //       TextSpan(
                                      //           text: 'Image',
                                      //           style: TextStyle(
                                      //               color: Colors.white)),
                                      //     ],
                                      //   ),
                                      //   cellPadding: EdgeInsets.zero,
                                      //   titleTextAlign:
                                      //       PlutoColumnTextAlign.center,
                                      //   textAlign:
                                      //       PlutoColumnTextAlign.center,
                                      //   type: PlutoColumnType.text(),
                                      //   enableEditingMode: false,
                                      //   renderer: (rendererContext) {
                                      //     return Container(
                                      //       height: rowHeight,
                                      //       // width: rendererContext
                                      //       //.cell.column.width,                                                    .cell.column.width,
                                      //       decoration: BoxDecoration(
                                      //           gradient: whiteGradient),
                                      //       child: Center(
                                      //           child: Container(
                                      //               width: 50,
                                      //               height: 50,
                                      //               clipBehavior:
                                      //                   Clip.antiAlias,
                                      //               decoration:
                                      //                   const BoxDecoration(
                                      //                 shape:
                                      //                     BoxShape.circle,
                                      //               ),
                                      //               child: rendererContext
                                      //                           .cell
                                      //                           .value ==
                                      //                       null
                                      //                   ? Image.asset(
                                      //                       'assets/images/default-user-profile-picture.png',
                                      //                       fit: BoxFit
                                      //                           .contain,
                                      //                     )
                                      //                   : Image.network(
                                      //                       rendererContext
                                      //                           .cell
                                      //                           .value,
                                      //                       fit: BoxFit
                                      //                           .contain,
                                      //                     ))),
                                      //     );
                                      //   },
                                      // ),
                                      PlutoColumn(
                                        title: 'License Plates',
                                        field: 'license_plates',
                                        backgroundColor:
                                            const Color(0XFF6491F7),
                                        titleSpan: const TextSpan(
                                          children: [
                                            WidgetSpan(
                                              child: Icon(
                                                Icons.credit_card_outlined,
                                                color: Color(0xffF3F7F9),
                                                size: 20,
                                              ),
                                            ),
                                            WidgetSpan(
                                                child: SizedBox(
                                              width: 10,
                                            )),
                                            TextSpan(
                                                text: 'License Plates',
                                                style: TextStyle(
                                                    color: Colors.white)),
                                          ],
                                        ),
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.13,
                                        cellPadding: EdgeInsets.zero,
                                        titleTextAlign:
                                            PlutoColumnTextAlign.center,
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
                                                child: Text(rendererContext
                                                    .cell.value)),
                                          );
                                        },
                                      ),

                                      PlutoColumn(
                                        title: 'Vin',
                                        field: 'vin',
                                        backgroundColor:
                                            const Color(0XFF6491F7),
                                        titleSpan: const TextSpan(
                                          children: [
                                            WidgetSpan(
                                              child: Icon(
                                                Icons.dialpad_outlined,
                                                color: Color(0xffF3F7F9),
                                                size: 20,
                                              ),
                                            ),
                                            WidgetSpan(
                                                child: SizedBox(
                                              width: 10,
                                            )),
                                            TextSpan(
                                                text: 'VIN',
                                                style: TextStyle(
                                                    color: Colors.white)),
                                          ],
                                        ),
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.10,
                                        cellPadding: EdgeInsets.zero,
                                        titleTextAlign:
                                            PlutoColumnTextAlign.center,
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
                                                child: Text(rendererContext
                                                    .cell.value)),
                                          );
                                        },
                                      ),

                                      PlutoColumn(
                                        title: 'Year',
                                        field: 'year',
                                        backgroundColor:
                                            const Color(0XFF6491F7),
                                        titleSpan: const TextSpan(
                                          children: [
                                            WidgetSpan(
                                              child: Icon(
                                                Icons.calendar_today_outlined,
                                                color: Color(0xffF3F7F9),
                                                size: 20,
                                              ),
                                            ),
                                            WidgetSpan(
                                                child: SizedBox(
                                              width: 10,
                                            )),
                                            TextSpan(
                                                text: 'Year',
                                                style: TextStyle(
                                                    color: Colors.white)),
                                          ],
                                        ),
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.09,
                                        cellPadding: EdgeInsets.zero,
                                        titleTextAlign:
                                            PlutoColumnTextAlign.center,
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
                                                child: Text(rendererContext
                                                    .cell.value)),
                                          );
                                        },
                                      ),
                                      PlutoColumn(
                                        title: 'Make',
                                        field: 'make',
                                        titleSpan: const TextSpan(
                                          children: [
                                            WidgetSpan(
                                              child: Icon(
                                                Icons.label_important_outline,
                                                color: Color(0xffF3F7F9),
                                                size: 20,
                                              ),
                                            ),
                                            WidgetSpan(
                                                child: SizedBox(
                                              width: 10,
                                            )),
                                            TextSpan(
                                                text: 'Make',
                                                style: TextStyle(
                                                    color: Colors.white)),
                                          ],
                                        ),
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.09,
                                        backgroundColor:
                                            const Color(0XFF6491F7),
                                        cellPadding: EdgeInsets.zero,
                                        titleTextAlign:
                                            PlutoColumnTextAlign.center,
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
                                                child: Text(rendererContext
                                                    .cell.value)),
                                          );
                                        },
                                      ),
                                      PlutoColumn(
                                        title: 'Model',
                                        field: 'model',
                                        backgroundColor:
                                            const Color(0XFF6491F7),
                                        titleSpan: const TextSpan(
                                          children: [
                                            WidgetSpan(
                                              child: Icon(
                                                Icons.local_shipping_outlined,
                                                color: Color(0xffF3F7F9),
                                                size: 20,
                                              ),
                                            ),
                                            WidgetSpan(
                                                child: SizedBox(
                                              width: 10,
                                            )),
                                            TextSpan(
                                                text: 'Model',
                                                style: TextStyle(
                                                    color: Colors.white)),
                                          ],
                                        ),
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.10,
                                        cellPadding: EdgeInsets.zero,
                                        titleTextAlign:
                                            PlutoColumnTextAlign.center,
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
                                                child: Text(rendererContext
                                                    .cell.value)),
                                          );
                                        },
                                      ),
                                      // PlutoColumn(
                                      //   title: 'Motor',
                                      //   field: 'motor',
                                      //   backgroundColor:
                                      //       const Color(0XFF6491F7),
                                      //   titleSpan: const TextSpan(
                                      //     children: [
                                      //       WidgetSpan(
                                      //         child: Icon(
                                      //           Icons.view_day_outlined,
                                      //           color: Color(0xffF3F7F9),
                                      //           size: 30,
                                      //         ),
                                      //       ),
                                      //       WidgetSpan(
                                      //           child: SizedBox(
                                      //         width: 10,
                                      //       )),
                                      //       TextSpan(
                                      //           text: 'Motor',
                                      //           style: TextStyle(
                                      //               color: Colors.white)),
                                      //     ],
                                      //   ),
                                      //   width: MediaQuery.of(context)
                                      //           .size
                                      //           .width *
                                      //       0.10,
                                      //   cellPadding: EdgeInsets.zero,
                                      //   titleTextAlign:
                                      //       PlutoColumnTextAlign.center,
                                      //   textAlign:
                                      //       PlutoColumnTextAlign.center,
                                      //   type: PlutoColumnType.text(),
                                      //   enableEditingMode: false,
                                      //   renderer: (rendererContext) {
                                      //     return Container(
                                      //       height: rowHeight,
                                      //       // width: rendererContext
                                      //       //.cell.column.width,                                                    .cell.column.width,
                                      //       decoration: BoxDecoration(
                                      //           gradient: whiteGradient),
                                      //       child: Center(
                                      //           child: Text(
                                      //               rendererContext
                                      //                   .cell.value)),
                                      //     );
                                      //   },
                                      // ),
                                      // PlutoColumn(
                                      //   title: 'Color',
                                      //   field: 'color',
                                      //   backgroundColor:
                                      //       const Color(0XFF6491F7),
                                      //   titleSpan: const TextSpan(
                                      //     children: [
                                      //       WidgetSpan(
                                      //         child: Icon(
                                      //           Icons.color_lens_outlined,
                                      //           color: Color(0xffF3F7F9),
                                      //           size: 30,
                                      //         ),
                                      //       ),
                                      //       WidgetSpan(
                                      //           child: SizedBox(
                                      //         width: 10,
                                      //       )),
                                      //       TextSpan(
                                      //           text: 'Color',
                                      //           style: TextStyle(
                                      //               color: Colors.white)),
                                      //     ],
                                      //   ),
                                      //   width: MediaQuery.of(context)
                                      //           .size
                                      //           .width *
                                      //       0.10,
                                      //   cellPadding: EdgeInsets.zero,
                                      //   titleTextAlign:
                                      //       PlutoColumnTextAlign.center,
                                      //   textAlign:
                                      //       PlutoColumnTextAlign.center,
                                      //   type: PlutoColumnType.text(),
                                      //   renderer: (rendererContext) {
                                      //     return Container(
                                      //       height: rowHeight,
                                      //       // width: rendererContext
                                      //       //.cell.column.width,                                                    .cell.column.width,
                                      //       decoration: BoxDecoration(
                                      //           gradient: whiteGradient),
                                      //       child: Center(
                                      //           child: Icon(Icons.circle,
                                      //               color: Color(int.parse(
                                      //                   rendererContext
                                      //                       .cell
                                      //                       .value)))),
                                      //     );
                                      //   },
                                      //   enableEditingMode: false,
                                      // ),
                                      PlutoColumn(
                                        title: 'Status',
                                        field: 'status',
                                        backgroundColor:
                                            const Color(0XFF6491F7),
                                        titleSpan: const TextSpan(
                                          children: [
                                            WidgetSpan(
                                              child: Icon(
                                                Icons.car_repair_outlined,
                                                color: Color(0xffF3F7F9),
                                                size: 20,
                                              ),
                                            ),
                                            WidgetSpan(
                                                child: SizedBox(
                                              width: 5,
                                            )),
                                            TextSpan(
                                                text: 'Status',
                                                style: TextStyle(
                                                    color: Colors.white)),
                                          ],
                                        ),
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.09,
                                        cellPadding: EdgeInsets.zero,
                                        titleTextAlign:
                                            PlutoColumnTextAlign.center,
                                        textAlign: PlutoColumnTextAlign.center,
                                        type: PlutoColumnType.text(),
                                        enableEditingMode: false,
                                        renderer: (rendererContext) {
                                          return Container(
                                            height: rowHeight,
                                            // width: rendererContext
                                            //.cell.column.width,.cell.column.width,
                                            decoration: BoxDecoration(
                                                gradient: whiteGradient),
                                            child: Center(
                                                child: Text(rendererContext
                                                    .cell.value)),
                                          );
                                        },
                                      ),
                                      PlutoColumn(
                                        title: 'Company',
                                        field: 'company',
                                        backgroundColor:
                                            const Color(0XFF6491F7),
                                        titleSpan: const TextSpan(
                                          children: [
                                            WidgetSpan(
                                              child: Icon(
                                                Icons.warehouse_outlined,
                                                color: Color(0xffF3F7F9),
                                                size: 20,
                                              ),
                                            ),
                                            WidgetSpan(
                                                child: SizedBox(
                                              width: 10,
                                            )),
                                            TextSpan(
                                                text: 'Company',
                                                style: TextStyle(
                                                    color: Colors.white)),
                                          ],
                                        ),
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.11,
                                        cellPadding: EdgeInsets.zero,
                                        titleTextAlign:
                                            PlutoColumnTextAlign.center,
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
                                                child: Text(rendererContext
                                                    .cell.value)),
                                          );
                                        },
                                      ),
                                      // PlutoColumn(
                                      //   title: 'Date Added',
                                      //   field: 'date_added',
                                      //   backgroundColor:
                                      //       const Color(0XFF6491F7),
                                      //   titleSpan: const TextSpan(
                                      //     children: [
                                      //       WidgetSpan(
                                      //         child: Icon(
                                      //           Icons
                                      //               .calendar_view_week_outlined,
                                      //           color: Color(0xffF3F7F9),
                                      //           size: 30,
                                      //         ),
                                      //       ),
                                      //       WidgetSpan(
                                      //           child: SizedBox(
                                      //         width: 10,
                                      //       )),
                                      //       TextSpan(
                                      //           text: 'Date Added',
                                      //           style: TextStyle(
                                      //               color: Colors.white)),
                                      //     ],
                                      //   ),
                                      //   width: MediaQuery.of(context)
                                      //           .size
                                      //           .width *
                                      //       0.13,
                                      //   cellPadding: EdgeInsets.zero,
                                      //   titleTextAlign:
                                      //       PlutoColumnTextAlign.center,
                                      //   textAlign:
                                      //       PlutoColumnTextAlign.center,
                                      //   type: PlutoColumnType.text(),
                                      //   enableEditingMode: false,
                                      //   renderer: (rendererContext) {
                                      //     return Container(
                                      //       height: rowHeight,
                                      //       // width: rendererContext
                                      //       //.cell.column.width,                                                    .cell.column.width,
                                      //       decoration: BoxDecoration(
                                      //           gradient: whiteGradient),
                                      //       child: Center(
                                      //           child: Text(
                                      //               rendererContext
                                      //                   .cell.value
                                      //                   .toString())),
                                      //     );
                                      //   },
                                      // ),
                                      PlutoColumn(
                                        title: 'details',
                                        field: 'details',
                                        backgroundColor:
                                            const Color(0XFF6491F7),
                                        titleSpan: const TextSpan(
                                          children: [
                                            WidgetSpan(
                                              child: Icon(
                                                Icons
                                                    .calendar_view_week_outlined,
                                                color: Color(0xffF3F7F9),
                                                size: 20,
                                              ),
                                            ),
                                            WidgetSpan(
                                                child: SizedBox(
                                              width: 10,
                                            )),
                                            TextSpan(
                                                text: 'Details',
                                                style: TextStyle(
                                                    color: Colors.white)),
                                          ],
                                        ),
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.10,
                                        cellPadding: EdgeInsets.zero,
                                        titleTextAlign:
                                            PlutoColumnTextAlign.center,
                                        textAlign: PlutoColumnTextAlign.center,
                                        type: PlutoColumnType.text(),
                                        enableEditingMode: false,
                                        renderer: (rendererContext) {
                                          return Container(
                                            height: rowHeight,
                                            decoration: BoxDecoration(
                                                gradient: whiteGradient),
                                            child: Center(
                                                child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                ElevatedButton(
                                                    onPressed: () {
                                                      showDialog(
                                                          context: context,
                                                          builder: (BuildContext
                                                              context) {
                                                            return StatefulBuilder(
                                                                builder: (context,
                                                                    setState) {
                                                              return DetailsPopUp(
                                                                vehicle:
                                                                    rendererContext
                                                                        .cell
                                                                        .value,
                                                              );
                                                            });
                                                          });
                                                    },
                                                    child: const Icon(
                                                      Icons
                                                          .remove_red_eye_outlined,
                                                    ))
                                              ],
                                            )),
                                          );
                                        },
                                      ),
                                      PlutoColumn(
                                        title: 'actions',
                                        field: 'actions',
                                        backgroundColor:
                                            const Color(0XFF6491F7),
                                        titleSpan: const TextSpan(
                                          children: [
                                            WidgetSpan(
                                              child: Icon(
                                                Icons.call_to_action_outlined,
                                                color: Color(0xffF3F7F9),
                                                size: 20,
                                              ),
                                            ),
                                            WidgetSpan(
                                                child: SizedBox(
                                              width: 10,
                                            )),
                                            TextSpan(
                                                text: 'Actions',
                                                style: TextStyle(
                                                    color: Colors.white)),
                                          ],
                                        ),
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.14,
                                        cellPadding: EdgeInsets.zero,
                                        titleTextAlign:
                                            PlutoColumnTextAlign.center,
                                        textAlign: PlutoColumnTextAlign.center,
                                        type: PlutoColumnType.text(),
                                        enableEditingMode: false,
                                        renderer: (rendererContext) {
                                          return Container(
                                            height: rowHeight,
                                            width: rendererContext
                                                .cell.column.width,
                                            decoration: BoxDecoration(
                                                gradient: whiteGradient),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                CustomTextIconButton(
                                                  isLoading: false,
                                                  icon: Icon(
                                                    Icons.fact_check_outlined,
                                                    color: AppTheme.of(context)
                                                        .primaryBackground,
                                                  ),
                                                  text: 'Edit',
                                                  onTap: () async {
                                                    //provider.clearControllers();
                                                    await provider.getCompanies(
                                                        notify: false);
                                                    await provider.getStatus(
                                                        notify: false);
                                                    provider.inicializeColor(
                                                        rendererContext
                                                            .cell.value);

                                                    provider.inicializeImage(
                                                        rendererContext
                                                            .cell.value);
                                                    provider
                                                        .updateInventoryControllers(
                                                            rendererContext
                                                                .cell.value);
                                                    // ignore: use_build_context_synchronously
                                                    await showDialog(
                                                        context: context,
                                                        builder: (BuildContext
                                                            context) {
                                                          return StatefulBuilder(
                                                              builder: (context,
                                                                  setState) {
                                                            return UpdateVehiclePopUp(
                                                              vehicle:
                                                                  rendererContext
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
                                                    color: AppTheme.of(context)
                                                        .primaryBackground,
                                                  ),
                                                  color: secondaryColor,
                                                  text: 'Delete',
                                                  onTap: () async {
                                                    await showDialog(
                                                        context: context,
                                                        builder: (BuildContext
                                                            context) {
                                                          return StatefulBuilder(
                                                              builder: (context,
                                                                  setState) {
                                                            return DeletePopUp(
                                                              vehicle:
                                                                  rendererContext
                                                                      .cell
                                                                      .value,
                                                            );
                                                          });
                                                        });
                                                    await provider
                                                        .getInventory();
                                                    //   await provider
                                                    //       .deleteVehicle(
                                                    //     rendererContext
                                                    //         .cell.value,
                                                    //   );
                                                    //   await provider
                                                    //       .getInventory();
                                                  },
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                      PlutoColumn(
                                        title: 'issues',
                                        field: 'issues',
                                        backgroundColor:
                                            const Color(0XFF6491F7),
                                        titleSpan: const TextSpan(
                                          children: [
                                            WidgetSpan(
                                              child: Icon(
                                                Icons.warning_outlined,
                                                color: Color(0xffF3F7F9),
                                                size: 20,
                                              ),
                                            ),
                                            WidgetSpan(
                                                child: SizedBox(
                                              width: 10,
                                            )),
                                            TextSpan(
                                                text: 'Issues',
                                                style: TextStyle(
                                                    color: Colors.white)),
                                          ],
                                        ),
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.10,
                                        cellPadding: EdgeInsets.zero,
                                        titleTextAlign:
                                            PlutoColumnTextAlign.center,
                                        textAlign: PlutoColumnTextAlign.center,
                                        type: PlutoColumnType.text(),
                                        enableEditingMode: false,
                                        renderer: (rendererContext) {
                                          return Container(
                                            height: rowHeight,
                                            decoration: BoxDecoration(
                                                gradient: whiteGradient),
                                            child: Center(
                                                child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                ElevatedButton(
                                                    onPressed: () {
                                                      provider.vistaIssues =
                                                          true;
                                                      // provider.getIssues(
                                                      //     rendererContext
                                                      //         .cell.value);
                                                      showDialog(
                                                          context: context,
                                                          builder: (BuildContext
                                                              context) {
                                                            return StatefulBuilder(
                                                                builder: (context,
                                                                    setState) {
                                                              return IssuesPopUp(
                                                                vehicle:
                                                                    rendererContext
                                                                        .cell
                                                                        .value,
                                                              );
                                                            });
                                                          });
                                                    },
                                                    child: const Icon(
                                                      Icons
                                                          .remove_red_eye_outlined,
                                                    ))
                                              ],
                                            )),
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

                                      return PlutoPagination(stateManager);
                                    },
                                    onLoaded: (event) {
                                      widget.provider.stateManager =
                                          event.stateManager;

                                      stateManager = event.stateManager;

                                      stateManager.setShowColumnFilter(true);
                                      stateManager.setSelectingMode(
                                        PlutoGridSelectingMode.row,
                                      );
                                      stateManager.sortAscending(PlutoColumn(
                                          title: '#',
                                          field: 'id_vehicle',
                                          type: PlutoColumnType.number()));
                                    },
                                    onRowChecked: (event) {},
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
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
