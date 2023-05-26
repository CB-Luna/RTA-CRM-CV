import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:rta_crm_cv/pages/inventory_page/widgets/cry_card.dart';
import 'package:rta_crm_cv/pages/inventory_page/widgets/odi_card.dart';
import 'package:rta_crm_cv/pages/inventory_page/widgets/smi_card.dart';
import 'package:rta_crm_cv/widgets/header.dart';
import 'package:rta_crm_cv/widgets/side_menu/sidemenu.dart';

//import 'widgets/carga_de_ticket_popup.dart';
import '../../helpers/constants.dart';
import '../../providers/inventory_provider.dart';
import '../../providers/side_menu_provider.dart';

import '../../public/colors.dart';
import 'widgets/header_inventory.dart';

final List<LinearGradient> gradients = [
  const LinearGradient(colors: [
    Color(0xff2F6EDC),
    Color(0xff397CE0),
    Color(0xff3D82E4),
    Color(0xff4284DC),
    Color(0xff3A7BD8),
    Color(0xff275DBD),
    Color(0xff295EBF),
    Color(0xff2F66BE),
    Color(0xff336ABE),
    Color(0xff386DBA),
    Color(0xff3166B7),
    Color(0xff2C5EAE),
    Color(0Xff234FA1)
  ]),
  const LinearGradient(
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
      colors: [
        Color(0xffE0EDF9),
        Color(0xffFFFFFF),
      ])
];

class inventoryPageDesktop extends StatefulWidget {
  inventoryPageDesktop(
      {Key? key,
      required this.drawerController,
      required this.scaffoldKey,
      required this.provider})
      : super(key: key);
  final AdvancedDrawerController drawerController;
  final GlobalKey<ScaffoldState> scaffoldKey;

  final InventoryProvider provider;

  @override
  State<inventoryPageDesktop> createState() => _inventoryPageDesktopState();
}

class _inventoryPageDesktopState extends State<inventoryPageDesktop> {
  TextEditingController searchController = TextEditingController();

  late PlutoGridStateManager stateManager;
  @override
  Widget build(BuildContext context) {
    SideMenuProvider sideM = Provider.of<SideMenuProvider>(context);
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
            decoration: BoxDecoration(gradient: gradients[1]),
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
                      Container(
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
                            Padding(
                                padding: EdgeInsets.only(bottom: 10),
                                child: Header(text: "Vehicle Inventory")),
                            // Container(
                            //     height: 60,
                            //     margin: const EdgeInsets.only(bottom: 10),
                            //     width: MediaQuery.of(context).size.width,
                            //     decoration: BoxDecoration(
                            //       gradient: gradients[0],
                            //       borderRadius: const BorderRadius.only(
                            //         topLeft: Radius.circular(30),
                            //         topRight: Radius.circular(4),
                            //         bottomLeft: Radius.circular(4),
                            //         bottomRight: Radius.circular(30),
                            //       ),
                            //       border: Border.all(
                            //           color: const Color(0xff9ABEFF),
                            //           width: 10,
                            //           style: BorderStyle.solid),
                            //     ),
                            //     child: Container(
                            //       alignment: Alignment.center,
                            //       child: const Text(
                            //         'Vehicle Inventory',
                            //         style: TextStyle(
                            //             color: Colors.white, fontSize: 30),
                            //       ),
                            //     )),
                            // PLUTO GRID
                            widget.provider.vehicles.isEmpty
                                ? const CircularProgressIndicator()
                                : Flexible(
                                    child: Material(
                                      shadowColor: const Color(0xff9ABEFF),
                                      elevation: 10,
                                      child: PlutoGrid(
                                        key: UniqueKey(),
                                        configuration: PlutoGridConfiguration(
                                          localeText:
                                              const PlutoGridLocaleText(),
                                          scrollbar:
                                              plutoGridScrollbarConfig(context),
                                          style: plutoGridStyleConfig(context),
                                          columnFilter:
                                              PlutoGridColumnFilterConfig(
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
                                          PlutoColumn(
                                            title: '#',
                                            field: 'id_vehicle',
                                            backgroundColor: Color(0XFF6491F7),
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.08,
                                            cellPadding: EdgeInsets.zero,
                                            titleTextAlign:
                                                PlutoColumnTextAlign.center,
                                            textAlign:
                                                PlutoColumnTextAlign.center,
                                            type: PlutoColumnType.number(),
                                            enableEditingMode: false,
                                            renderer: (rendererContext) {
                                              return Container(
                                                height: rowHeight,
                                                //width: rendererContext.cell.column.width,
                                                decoration: BoxDecoration(
                                                    gradient: whiteGradient),
                                                child: Center(
                                                    child: Text(rendererContext
                                                        .cell.value
                                                        .toString())),
                                              );
                                            },
                                          ),

                                          PlutoColumn(
                                            backgroundColor: Color(0XFF6491F7),
                                            title: 'Image',
                                            field: 'image',
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.1,
                                            titleSpan: const TextSpan(
                                              children: [
                                                WidgetSpan(
                                                  child: Icon(
                                                    Icons.image_outlined,
                                                    color: Color(0xffF3F7F9),
                                                    size: 30,
                                                  ),
                                                ),
                                                WidgetSpan(
                                                    child: SizedBox(
                                                  width: 10,
                                                )),
                                                TextSpan(text: 'Image'),
                                              ],
                                            ),
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
                                                    gradient: whiteGradient),
                                                child: Center(
                                                    child: Container(
                                                        width: 50,
                                                        height: 50,
                                                        clipBehavior:
                                                            Clip.antiAlias,
                                                        decoration:
                                                            const BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                        ),
                                                        child: rendererContext
                                                                    .cell
                                                                    .value ==
                                                                null
                                                            ? Image.asset(
                                                                'assets/images/default-user-profile-picture.png',
                                                                fit: BoxFit
                                                                    .contain,
                                                              )
                                                            : Image.network(
                                                                rendererContext
                                                                    .cell.value,
                                                                fit: BoxFit
                                                                    .contain,
                                                              ))),
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
                                                    Icons
                                                        .label_important_outline,
                                                    color: Color(0xffF3F7F9),
                                                    size: 30,
                                                  ),
                                                ),
                                                WidgetSpan(
                                                    child: SizedBox(
                                                  width: 10,
                                                )),
                                                TextSpan(text: 'Make'),
                                              ],
                                            ),
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.09,
                                            backgroundColor: Color(0XFF6491F7),
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
                                            backgroundColor: Color(0XFF6491F7),
                                            titleSpan: const TextSpan(
                                              children: [
                                                WidgetSpan(
                                                  child: Icon(
                                                    Icons
                                                        .local_shipping_outlined,
                                                    color: Color(0xffF3F7F9),
                                                    size: 30,
                                                  ),
                                                ),
                                                WidgetSpan(
                                                    child: SizedBox(
                                                  width: 10,
                                                )),
                                                TextSpan(text: 'Model'),
                                              ],
                                            ),
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
                                            backgroundColor: Color(0XFF6491F7),
                                            titleSpan: const TextSpan(
                                              children: [
                                                WidgetSpan(
                                                  child: Icon(
                                                    Icons
                                                        .calendar_today_outlined,
                                                    color: Color(0xffF3F7F9),
                                                    size: 30,
                                                  ),
                                                ),
                                                WidgetSpan(
                                                    child: SizedBox(
                                                  width: 10,
                                                )),
                                                TextSpan(text: 'Year'),
                                              ],
                                            ),
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.09,
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
                                            backgroundColor: Color(0XFF6491F7),
                                            titleSpan: const TextSpan(
                                              children: [
                                                WidgetSpan(
                                                  child: Icon(
                                                    Icons.dialpad_outlined,
                                                    color: Color(0xffF3F7F9),
                                                    size: 30,
                                                  ),
                                                ),
                                                WidgetSpan(
                                                    child: SizedBox(
                                                  width: 10,
                                                )),
                                                TextSpan(text: 'VIN'),
                                              ],
                                            ),
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.14,
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
                                                    gradient: whiteGradient),
                                                child: Center(
                                                    child: Text(rendererContext
                                                        .cell.value)),
                                              );
                                            },
                                          ),
                                          PlutoColumn(
                                            title: 'License Plates',
                                            field: 'license_plates',
                                            backgroundColor: Color(0XFF6491F7),
                                            titleSpan: const TextSpan(
                                              children: [
                                                WidgetSpan(
                                                  child: Icon(
                                                    Icons.credit_card_outlined,
                                                    color: Color(0xffF3F7F9),
                                                    size: 30,
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
                                            width: 225,
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
                                                    gradient: whiteGradient),
                                                child: Center(
                                                    child: Text(rendererContext
                                                        .cell.value)),
                                              );
                                            },
                                          ),

                                          PlutoColumn(
                                            title: 'Motor',
                                            field: 'motor',
                                            backgroundColor:
                                                const Color(0XFF6491F7),
                                            titleSpan: const TextSpan(
                                              children: [
                                                WidgetSpan(
                                                  child: Icon(
                                                    Icons.view_day_outlined,
                                                    color: Color(0xffF3F7F9),
                                                    size: 30,
                                                  ),
                                                ),
                                                WidgetSpan(
                                                    child: SizedBox(
                                                  width: 10,
                                                )),
                                                TextSpan(text: 'Motor'),
                                              ],
                                            ),
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
                                                    gradient: whiteGradient),
                                                child: Center(
                                                    child: Text(rendererContext
                                                        .cell.value)),
                                              );
                                            },
                                          ),
                                          PlutoColumn(
                                            title: 'Color',
                                            field: 'color',
                                            backgroundColor:
                                                const Color(0XFF6491F7),
                                            titleSpan: const TextSpan(
                                              children: [
                                                WidgetSpan(
                                                  child: Icon(
                                                    Icons.color_lens_outlined,
                                                    color: Color(0xffF3F7F9),
                                                    size: 30,
                                                  ),
                                                ),
                                                WidgetSpan(
                                                    child: SizedBox(
                                                  width: 10,
                                                )),
                                                TextSpan(text: 'Color'),
                                              ],
                                            ),
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.08,
                                            cellPadding: EdgeInsets.zero,
                                            titleTextAlign:
                                                PlutoColumnTextAlign.center,
                                            textAlign:
                                                PlutoColumnTextAlign.center,
                                            type: PlutoColumnType.text(),
                                            renderer: (rendererContext) {
                                              return Container(
                                                height: rowHeight,
                                                // width: rendererContext
                                                //.cell.column.width,                                                    .cell.column.width,
                                                decoration: BoxDecoration(
                                                    gradient: whiteGradient),
                                                child: Center(
                                                    child: Icon(Icons.circle,
                                                        color: Color(int.parse(
                                                            rendererContext
                                                                .cell.value)))),
                                              );
                                            },
                                            enableEditingMode: false,
                                          ),
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
                                                    size: 30,
                                                  ),
                                                ),
                                                WidgetSpan(
                                                    child: SizedBox(
                                                  width: 10,
                                                )),
                                                TextSpan(text: 'Status'),
                                              ],
                                            ),
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.09,
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
                                                    size: 30,
                                                  ),
                                                ),
                                                WidgetSpan(
                                                    child: SizedBox(
                                                  width: 10,
                                                )),
                                                TextSpan(text: 'Company'),
                                              ],
                                            ),
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
                                                    gradient: whiteGradient),
                                                child: Center(
                                                    child: Text(rendererContext
                                                        .cell.value)),
                                              );
                                            },
                                          ),
                                          PlutoColumn(
                                            title: 'Date Added',
                                            field: 'date_added',
                                            backgroundColor:
                                                const Color(0XFF6491F7),
                                            titleSpan: const TextSpan(
                                              children: [
                                                WidgetSpan(
                                                  child: Icon(
                                                    Icons
                                                        .calendar_view_week_outlined,
                                                    color: Color(0xffF3F7F9),
                                                    size: 30,
                                                  ),
                                                ),
                                                WidgetSpan(
                                                    child: SizedBox(
                                                  width: 10,
                                                )),
                                                TextSpan(text: 'Date Added'),
                                              ],
                                            ),
                                            width: 300,
                                            cellPadding: EdgeInsets.zero,
                                            titleTextAlign:
                                                PlutoColumnTextAlign.center,
                                            textAlign:
                                                PlutoColumnTextAlign.center,
                                            type: PlutoColumnType.date(),
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
                                                        .cell.value
                                                        .toString())),
                                              );
                                            },
                                          ),
                                          // PlutoColumn(
                                          //     title: 'Acciones',
                                          //     field: 'acciones',
                                          //     width: 300,
                                          //     titleTextAlign:
                                          //         PlutoColumnTextAlign.center,
                                          //     textAlign:
                                          //         PlutoColumnTextAlign.center,
                                          //     type: PlutoColumnType.number(),
                                          //     enableEditingMode: false,
                                          //     renderer: (rendererContext) {
                                          //       final int id =
                                          //           rendererContext.cell.value;
                                          //       Empleados? usuario;
                                          //       try {
                                          //         usuario = widget
                                          //             .provider.usuarios
                                          //             .firstWhere((element) =>
                                          //                 element.idSecuencial ==
                                          //                 id);
                                          //       } catch (e) {
                                          //         usuario = null;
                                          //       }

                                          //       return Row(
                                          //         mainAxisAlignment:
                                          //             MainAxisAlignment
                                          //                 .spaceBetween,
                                          //         children: [
                                          //           Container(
                                          //             alignment: Alignment.center,
                                          //             child: Visibility(
                                          //               visible: currentUser!
                                          //                           .rol.rolId ==
                                          //                       3
                                          //                   ? true
                                          //                   : false,
                                          //               child:
                                          //                   AnimatedHoverButton(
                                          //                 icon: Icons.money,
                                          //                 tooltip:
                                          //                     'Cargar ticket de puntos',
                                          //                 primaryColor:
                                          //                     AppTheme.of(context)
                                          //                         .primaryColor,
                                          //                 secondaryColor: AppTheme
                                          //                         .of(context)
                                          //                     .primaryBackground,
                                          //                 onTap: () async {
                                          //                   showDialog(
                                          //                     context: context,
                                          //                     builder:
                                          //                         (BuildContext
                                          //                             context) {
                                          //                       return AlertDialog(
                                          //                         backgroundColor:
                                          //                             const Color(
                                          //                                 0xffd1d0d0),
                                          //                         shape:
                                          //                             RoundedRectangleBorder(
                                          //                           borderRadius:
                                          //                               BorderRadius
                                          //                                   .circular(
                                          //                                       20),
                                          //                         ),
                                          //                         // content:
                                          //                         //     CargarTicketPopup(
                                          //                         //   key:
                                          //                         //       UniqueKey(),
                                          //                         //   drawerController:
                                          //                         //       widget
                                          //                         //           .drawerController,
                                          //                         //   scaffoldKey:
                                          //                         //       widget
                                          //                         //           .scaffoldKey,
                                          //                         //   idRegistro: 5,
                                          //                         //   topMenuTittle:
                                          //                         //       "Editar encargado de Área",
                                          //                         //   usuarioId:
                                          //                         //       rendererContext
                                          //                         //           .row
                                          //                         //           .cells[
                                          //                         //               'perfil_usuario_id']!
                                          //                         //           .value,
                                          //                         //   usuarioNombre:
                                          //                         //       rendererContext
                                          //                         //           .row
                                          //                         //           .cells[
                                          //                         //               'nombre']!
                                          //                         //           .value,
                                          //                         // ), // Widget personalizado
                                          //                       );
                                          //                     },
                                          //                   );
                                          //                 },
                                          //               ),
                                          //             ),
                                          //           ),
                                          //           Container(
                                          //             alignment: Alignment.center,
                                          //             child: AnimatedHoverButton(
                                          //               icon: Icons.edit,
                                          //               tooltip:
                                          //                   'Editar perfil empleado',
                                          //               primaryColor:
                                          //                   AppTheme.of(context)
                                          //                       .primaryColor,
                                          //               secondaryColor: AppTheme
                                          //                       .of(context)
                                          //                   .primaryBackground,
                                          //               onTap: () async {},
                                          //             ),
                                          //           ),
                                          //           AnimatedHoverButton(
                                          //             icon: Icons.person_remove,
                                          //             tooltip: 'Eliminar',
                                          //             primaryColor: Colors.red,
                                          //             secondaryColor:
                                          //                 AppTheme.of(context)
                                          //                     .primaryBackground,
                                          //             onTap: () async {},
                                          //           ),
                                          //         ],
                                          //       );
                                          //     }),
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
