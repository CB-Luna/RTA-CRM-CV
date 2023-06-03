// ignore_for_file: unrelated_type_equality_checks

import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter/material.dart';
import 'package:rta_crm_cv/pages/monitory_page/widgets/Search_bar_monitory.dart';
import 'package:rta_crm_cv/pages/monitory_page/widgets/calendar.dart';
import 'package:rta_crm_cv/widgets/card_header.dart';

//import 'widgets/carga_de_ticket_popup.dart';
import '../../helpers/constants.dart';
import '../../providers/monitory_provider.dart';
import '../../public/colors.dart';
import '../../widgets/side_menu/sidemenu.dart';

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
  const LinearGradient(colors: [
    Color(0xffE0EDF9),
    Color(0xffFFFFFF),
  ])
];

class MonitoryPageDesktop extends StatefulWidget {
  const MonitoryPageDesktop({Key? key, required this.drawerController, required this.scaffoldKey, required this.provider}) : super(key: key);
  final AdvancedDrawerController drawerController;
  final GlobalKey<ScaffoldState> scaffoldKey;

  final MonitoryProvider provider;

  @override
  State<MonitoryPageDesktop> createState() => _MonitoryPageDesktopState();
}

class _MonitoryPageDesktopState extends State<MonitoryPageDesktop> {
  TextEditingController searchController = TextEditingController();

  late PlutoGridStateManager stateManager;
  @override
  Widget build(BuildContext context) {
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
          child: Column(
            children: [
              // ROW que abarca desde el sideMenuWidget y el gran container de toda la información
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SideMenu(),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                        child: ListView(
                          children: [
                            //HEADER
                            const SizedBox(
                              height: 20,
                            ),

                            MonitoryPageHeader(),
                            const SizedBox(
                              height: 20,
                            ),
                            // Titulo de la tabla
                            const Padding(padding: EdgeInsets.only(bottom: 10), child: CardHeader(text: "Vehicle Monitory")),

                            widget.provider.monitory.isEmpty
                                ? const CircularProgressIndicator()
                                : Container(
                                    padding: const EdgeInsets.only(bottom: 40),
                                    height: 400,
                                    child: Material(
                                      shadowColor: const Color(0xff9ABEFF),
                                      elevation: 10,
                                      child: PlutoGrid(
                                        key: UniqueKey(),
                                        configuration: PlutoGridConfiguration(
                                          localeText: const PlutoGridLocaleText(),
                                          scrollbar: plutoGridScrollbarConfig(context),
                                          style: plutoGridStyleConfig(context),
                                          columnFilter: PlutoGridColumnFilterConfig(
                                            filters: const [
                                              ...FilterHelper.defaultFilters,
                                            ],
                                            resolveDefaultColumnFilter: (column, resolver) {
                                              return resolver<PlutoFilterTypeContains>() as PlutoFilterType;
                                            },
                                          ),
                                        ),
                                        columns: [
                                          PlutoColumn(
                                            title: 'id_Control_Form',
                                            field: 'id_control_form',
                                            titleSpan: const TextSpan(
                                              children: [
                                                WidgetSpan(
                                                  child: Icon(
                                                    Icons.view_agenda_outlined,
                                                    color: Color(0xffF3F7F9),
                                                    size: 30,
                                                  ),
                                                ),
                                                WidgetSpan(
                                                    child: SizedBox(
                                                  width: 10,
                                                )),
                                                TextSpan(text: 'idControlForm', style: TextStyle(color: Colors.white, fontSize: 22)),
                                              ],
                                            ),
                                            width: MediaQuery.of(context).size.width * 0.16,
                                            cellPadding: EdgeInsets.zero,
                                            titleTextAlign: PlutoColumnTextAlign.center,
                                            textAlign: PlutoColumnTextAlign.center,
                                            type: PlutoColumnType.number(),
                                            enableEditingMode: false,
                                            backgroundColor: const Color(0XFF6491F7),
                                            renderer: (rendererContext) {
                                              return Container(
                                                height: rowHeight,
                                                // width: rendererContext.cell.column.width,
                                                decoration: BoxDecoration(gradient: whiteGradient),
                                                child: Center(child: Text(rendererContext.cell.value.toString())),
                                              );
                                            },
                                          ),
                                          PlutoColumn(
                                            title: 'id_Vehicle',
                                            field: 'id_vehicle',
                                            width: MediaQuery.of(context).size.width * 0.14,
                                            titleSpan: const TextSpan(
                                              children: [
                                                WidgetSpan(
                                                  child: Icon(
                                                    Icons.view_agenda_outlined,
                                                    color: Color(0xffF3F7F9),
                                                    size: 30,
                                                  ),
                                                ),
                                                WidgetSpan(
                                                    child: SizedBox(
                                                  width: 10,
                                                )),
                                                TextSpan(text: 'id_Vehicle', style: TextStyle(color: Colors.white, fontSize: 22)),
                                              ],
                                            ),
                                            backgroundColor: const Color(0XFF6491F7),
                                            cellPadding: EdgeInsets.zero,
                                            titleTextAlign: PlutoColumnTextAlign.center,
                                            textAlign: PlutoColumnTextAlign.center,
                                            type: PlutoColumnType.number(),
                                            enableEditingMode: false,
                                            renderer: (rendererContext) {
                                              return Container(
                                                height: rowHeight,
                                                // width: rendererContext.cell.column.width,
                                                decoration: BoxDecoration(gradient: whiteGradient),
                                                child: Center(child: Text(rendererContext.cell.value.toString())),
                                              );
                                            },
                                          ),
                                          PlutoColumn(
                                            title: 'employee',
                                            field: 'employee',
                                            titleSpan: const TextSpan(
                                              children: [
                                                WidgetSpan(
                                                  child: Icon(
                                                    Icons.supervised_user_circle_outlined,
                                                    color: Color(0xffF3F7F9),
                                                    size: 30,
                                                  ),
                                                ),
                                                WidgetSpan(
                                                    child: SizedBox(
                                                  width: 10,
                                                )),
                                                TextSpan(text: 'Employee', style: TextStyle(color: Colors.white, fontSize: 22)),
                                              ],
                                            ),
                                            width: MediaQuery.of(context).size.width * 0.14,
                                            cellPadding: EdgeInsets.zero,
                                            titleTextAlign: PlutoColumnTextAlign.center,
                                            textAlign: PlutoColumnTextAlign.center,
                                            type: PlutoColumnType.text(),
                                            enableEditingMode: false,
                                            backgroundColor: const Color(0XFF6491F7),
                                            renderer: (rendererContext) {
                                              return Container(
                                                height: rowHeight,
                                                //// width: rendererContext.cell.column.width,Context.cell.column.width,
                                                decoration: BoxDecoration(gradient: whiteGradient),
                                                child: Center(child: Text(rendererContext.cell.value)),
                                              );
                                            },
                                          ),
                                          PlutoColumn(
                                            title: 'typeForm',
                                            field: 'typeForm',
                                            titleSpan: const TextSpan(
                                              children: [
                                                WidgetSpan(
                                                  child: Icon(
                                                    Icons.description_outlined,
                                                    color: Color(0xffF3F7F9),
                                                    size: 30,
                                                  ),
                                                ),
                                                WidgetSpan(
                                                    child: SizedBox(
                                                  width: 10,
                                                )),
                                                TextSpan(text: 'TypeForm', style: TextStyle(color: Colors.white, fontSize: 22)),
                                              ],
                                            ),
                                            width: MediaQuery.of(context).size.width * 0.13,
                                            cellPadding: EdgeInsets.zero,
                                            titleTextAlign: PlutoColumnTextAlign.center,
                                            textAlign: PlutoColumnTextAlign.center,
                                            type: PlutoColumnType.text(),
                                            enableEditingMode: false,
                                            backgroundColor: const Color(0XFF6491F7),
                                            renderer: (rendererContext) {
                                              return Container(
                                                height: rowHeight,
                                                // // width: rendererContext.cell.column.width,Context.cell.column.width,
                                                decoration: BoxDecoration(gradient: whiteGradient),
                                                child: Center(child: Text(rendererContext.cell.value == true ? "Received" : "Delivered")),
                                              );
                                            },
                                          ),
                                          PlutoColumn(
                                            title: 'Vin',
                                            field: 'vin',
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
                                                TextSpan(text: 'VIN', style: TextStyle(color: Colors.white, fontSize: 22)),
                                              ],
                                            ),
                                            width: MediaQuery.of(context).size.width * 0.14,
                                            cellPadding: EdgeInsets.zero,
                                            titleTextAlign: PlutoColumnTextAlign.center,
                                            textAlign: PlutoColumnTextAlign.center,
                                            type: PlutoColumnType.text(),
                                            enableEditingMode: false,
                                            backgroundColor: const Color(0XFF6491F7),
                                            renderer: (rendererContext) {
                                              return Container(
                                                height: rowHeight,
                                                // width: rendererContext.cell.column.width,
                                                decoration: BoxDecoration(gradient: whiteGradient),
                                                child: Center(child: Text(rendererContext.cell.value)),
                                              );
                                            },
                                          ),
                                          PlutoColumn(
                                            title: 'License Plates',
                                            field: 'license_plates',
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
                                                TextSpan(text: 'License Plates', style: TextStyle(color: Colors.white, fontSize: 22)),
                                              ],
                                            ),
                                            width: MediaQuery.of(context).size.width * 0.16,
                                            cellPadding: EdgeInsets.zero,
                                            titleTextAlign: PlutoColumnTextAlign.center,
                                            textAlign: PlutoColumnTextAlign.center,
                                            type: PlutoColumnType.text(),
                                            enableEditingMode: false,
                                            backgroundColor: const Color(0XFF6491F7),
                                            renderer: (rendererContext) {
                                              return Container(
                                                height: rowHeight,
                                                // width: rendererContext.cell.column.width,
                                                decoration: BoxDecoration(gradient: whiteGradient),
                                                child: Center(child: Text(rendererContext.cell.value)),
                                              );
                                            },
                                          ),

                                          PlutoColumn(
                                            title: 'Company',
                                            field: 'company',
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
                                                TextSpan(text: 'Company', style: TextStyle(color: Colors.white, fontSize: 22)),
                                              ],
                                            ),
                                            width: MediaQuery.of(context).size.width * 0.13,
                                            cellPadding: EdgeInsets.zero,
                                            titleTextAlign: PlutoColumnTextAlign.center,
                                            textAlign: PlutoColumnTextAlign.center,
                                            type: PlutoColumnType.text(),
                                            enableEditingMode: false,
                                            backgroundColor: const Color(0XFF6491F7),
                                            renderer: (rendererContext) {
                                              return Container(
                                                height: rowHeight,
                                                // width: rendererContext.cell.column.width,
                                                decoration: BoxDecoration(gradient: whiteGradient),
                                                child: Center(child: Text(rendererContext.cell.value)),
                                              );
                                            },
                                          ),
                                          PlutoColumn(
                                            title: 'gas',
                                            field: 'gas',
                                            titleSpan: const TextSpan(
                                              children: [
                                                WidgetSpan(
                                                  child: Icon(
                                                    Icons.gas_meter_outlined,
                                                    color: Color(0xffF3F7F9),
                                                    size: 30,
                                                  ),
                                                ),
                                                WidgetSpan(
                                                    child: SizedBox(
                                                  width: 10,
                                                )),
                                                TextSpan(text: 'gas', style: TextStyle(color: Colors.white, fontSize: 22)),
                                              ],
                                            ),
                                            width: MediaQuery.of(context).size.width * 0.10,
                                            cellPadding: EdgeInsets.zero,
                                            titleTextAlign: PlutoColumnTextAlign.center,
                                            textAlign: PlutoColumnTextAlign.center,
                                            type: PlutoColumnType.text(),
                                            enableEditingMode: false,
                                            backgroundColor: const Color(0XFF6491F7),
                                            renderer: (rendererContext) {
                                              return Container(
                                                height: rowHeight,
                                                // width: rendererContext.cell.column.width,
                                                decoration: BoxDecoration(gradient: whiteGradient),
                                                child: Center(child: Text(rendererContext.cell.value)),
                                              );
                                            },
                                          ),
                                          PlutoColumn(
                                            title: 'mileage',
                                            field: 'mileage',
                                            titleSpan: const TextSpan(
                                              children: [
                                                WidgetSpan(
                                                  child: Icon(
                                                    Icons.directions_car_outlined,
                                                    color: Color(0xffF3F7F9),
                                                    size: 30,
                                                  ),
                                                ),
                                                WidgetSpan(
                                                    child: SizedBox(
                                                  width: 10,
                                                )),
                                                TextSpan(text: 'mileage', style: TextStyle(color: Colors.white, fontSize: 22)),
                                              ],
                                            ),
                                            width: MediaQuery.of(context).size.width * 0.12,
                                            cellPadding: EdgeInsets.zero,
                                            titleTextAlign: PlutoColumnTextAlign.center,
                                            textAlign: PlutoColumnTextAlign.center,
                                            type: PlutoColumnType.number(),
                                            enableEditingMode: false,
                                            backgroundColor: const Color(0XFF6491F7),
                                            renderer: (rendererContext) {
                                              return Container(
                                                height: rowHeight,
                                                // width: rendererContext.cell.column.width,
                                                decoration: BoxDecoration(gradient: whiteGradient),
                                                child: Center(child: Text(rendererContext.cell.value.toString())),
                                              );
                                            },
                                          ),
                                          PlutoColumn(
                                            title: 'Date Added',
                                            field: 'date_added',
                                            titleSpan: const TextSpan(
                                              children: [
                                                WidgetSpan(
                                                  child: Icon(
                                                    Icons.calendar_view_week_outlined,
                                                    color: Color(0xffF3F7F9),
                                                    size: 30,
                                                  ),
                                                ),
                                                WidgetSpan(
                                                    child: SizedBox(
                                                  width: 10,
                                                )),
                                                TextSpan(text: 'Date Added', style: TextStyle(color: Colors.white, fontSize: 22)),
                                              ],
                                            ),
                                            width: 300,
                                            cellPadding: EdgeInsets.zero,
                                            titleTextAlign: PlutoColumnTextAlign.center,
                                            textAlign: PlutoColumnTextAlign.center,
                                            type: PlutoColumnType.date(format: 'MMMM, MM-dd-yyyy', headerFormat: 'MM-dd-yyyy'),
                                            enableEditingMode: false,
                                            backgroundColor: const Color(0XFF6491F7),
                                            renderer: (rendererContext) {
                                              return Container(
                                                height: rowHeight,
                                                // width: rendererContext.cell.column.width,
                                                decoration: BoxDecoration(gradient: whiteGradient),
                                                child: Center(child: Text(rendererContext.cell.value.toString())),
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
                                          widget.provider.stateManager = event.stateManager;

                                          stateManager = event.stateManager;

                                          stateManager.setShowColumnFilter(true);
                                          stateManager.setSelectingMode(
                                            PlutoGridSelectingMode.row,
                                          );
                                          stateManager.sortAscending(PlutoColumn(title: '#', field: 'id_vehicle', type: PlutoColumnType.number()));
                                        },
                                        onRowChecked: (event) {},
                                      ),
                                    ),
                                  ),
                            Container(
                              padding: const EdgeInsets.only(top: 40, bottom: 40),
                              //color: Colors.red,
                              height: 905,
                              child: const Calendario(),
                            )
                          ],
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
    );
  }
}
