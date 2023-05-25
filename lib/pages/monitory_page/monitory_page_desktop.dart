import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter/material.dart';

//import 'widgets/carga_de_ticket_popup.dart';
import '../../helpers/constants.dart';
import '../../providers/monitory_provider.dart';

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
  const MonitoryPageDesktop(
      {Key? key,
      required this.drawerController,
      required this.scaffoldKey,
      required this.provider})
      : super(key: key);
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
              // TopMenuWidget(
              //     //title: currentUser!.rol.rolId == 3
              //     title: 'Inventory Vehicle'
              //     //: 'Inventory',
              //     ),
              // ROW que abarca desde el sideMenuWidget y el gran container de toda la información
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //const SideMenuWidget(),
                    Expanded(
                      child: Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                        child: Column(
                          children: [
                            //HEADER
                            const SizedBox(
                              height: 20,
                            ),

                            // InventoryPageHeader(),
                            //ESTATUS STEPPER
                            const SizedBox(
                              height: 20,
                            ),
                            // Titulo de la tabla
                            Container(
                                height: 60,
                                margin: const EdgeInsets.only(bottom: 10),
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  gradient: gradients[0],
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(30),
                                    topRight: Radius.circular(4),
                                    bottomLeft: Radius.circular(4),
                                    bottomRight: Radius.circular(30),
                                  ),
                                  border: Border.all(
                                      color: const Color(0xff9ABEFF),
                                      width: 10,
                                      style: BorderStyle.solid),
                                ),
                                child: Container(
                                  alignment: Alignment.center,
                                  child: const Text(
                                    'Vehicle Monitory',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 30),
                                  ),
                                )),
                            widget.provider.monitory.isEmpty
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
                                            title: 'id_Control_Form',
                                            field: 'id_control_form',
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.12,
                                            titleTextAlign:
                                                PlutoColumnTextAlign.center,
                                            textAlign:
                                                PlutoColumnTextAlign.center,
                                            type: PlutoColumnType.number(),
                                            enableEditingMode: false,
                                          ),
                                          PlutoColumn(
                                            title: 'id_Vehicle',
                                            field: 'id_vehicle',
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.12,
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
                                                TextSpan(text: 'id_Vehicle'),
                                              ],
                                            ),
                                            titleTextAlign:
                                                PlutoColumnTextAlign.center,
                                            textAlign:
                                                PlutoColumnTextAlign.center,
                                            type: PlutoColumnType.text(),
                                            enableEditingMode: false,
                                          ),
                                          PlutoColumn(
                                            title: 'employee',
                                            field: 'employee',
                                            titleSpan: const TextSpan(
                                              children: [
                                                WidgetSpan(
                                                  child: Icon(
                                                    Icons
                                                        .supervised_user_circle_outlined,
                                                    color: Color(0xffF3F7F9),
                                                    size: 30,
                                                  ),
                                                ),
                                                WidgetSpan(
                                                    child: SizedBox(
                                                  width: 10,
                                                )),
                                                TextSpan(text: 'employee'),
                                              ],
                                            ),
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.12,
                                            titleTextAlign:
                                                PlutoColumnTextAlign.center,
                                            textAlign:
                                                PlutoColumnTextAlign.center,
                                            type: PlutoColumnType.text(),
                                            enableEditingMode: false,
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
                                                TextSpan(text: 'typeForm'),
                                              ],
                                            ),
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.11,
                                            titleTextAlign:
                                                PlutoColumnTextAlign.center,
                                            textAlign:
                                                PlutoColumnTextAlign.center,
                                            type: PlutoColumnType.text(),
                                            enableEditingMode: false,
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
                                                TextSpan(text: 'VIN'),
                                              ],
                                            ),
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.14,
                                            titleTextAlign:
                                                PlutoColumnTextAlign.center,
                                            textAlign:
                                                PlutoColumnTextAlign.center,
                                            type: PlutoColumnType.text(),
                                            enableEditingMode: false,
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
                                                TextSpan(
                                                    text: 'License Plates'),
                                              ],
                                            ),
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.14,
                                            titleTextAlign:
                                                PlutoColumnTextAlign.center,
                                            textAlign:
                                                PlutoColumnTextAlign.center,
                                            type: PlutoColumnType.text(),
                                            enableEditingMode: false,
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
                                                TextSpan(text: 'Company'),
                                              ],
                                            ),
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.11,
                                            titleTextAlign:
                                                PlutoColumnTextAlign.center,
                                            textAlign:
                                                PlutoColumnTextAlign.center,
                                            type: PlutoColumnType.text(),
                                            enableEditingMode: false,
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
                                                TextSpan(text: 'gas'),
                                              ],
                                            ),
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.08,
                                            titleTextAlign:
                                                PlutoColumnTextAlign.center,
                                            textAlign:
                                                PlutoColumnTextAlign.center,
                                            type: PlutoColumnType.text(),
                                            enableEditingMode: false,
                                          ),
                                          PlutoColumn(
                                            title: 'mileage',
                                            field: 'mileage',
                                            titleSpan: const TextSpan(
                                              children: [
                                                WidgetSpan(
                                                  child: Icon(
                                                    Icons
                                                        .directions_car_outlined,
                                                    color: Color(0xffF3F7F9),
                                                    size: 30,
                                                  ),
                                                ),
                                                WidgetSpan(
                                                    child: SizedBox(
                                                  width: 10,
                                                )),
                                                TextSpan(text: 'mileage'),
                                              ],
                                            ),
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.12,
                                            titleTextAlign:
                                                PlutoColumnTextAlign.center,
                                            textAlign:
                                                PlutoColumnTextAlign.center,
                                            type: PlutoColumnType.number(),
                                            enableEditingMode: false,
                                          ),
                                          PlutoColumn(
                                            title: 'Date Added',
                                            field: 'date_added',
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
                                            titleTextAlign:
                                                PlutoColumnTextAlign.center,
                                            textAlign:
                                                PlutoColumnTextAlign.center,
                                            type: PlutoColumnType.text(),
                                            enableEditingMode: false,
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
                            Container(
                              color: Colors.white,
                              height: 400,
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
