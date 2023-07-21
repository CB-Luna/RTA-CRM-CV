// ignore_for_file: unrelated_type_equality_checks

import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rta_crm_cv/pages/ctrlv/monitory_page/widgets/custom_agenda.dart';
import 'package:rta_crm_cv/pages/ctrlv/monitory_page/widgets/monitory_filters.dart';
import 'package:rta_crm_cv/pages/ctrlv/monitory_page/widgets/monitory_page_header.dart';
import 'package:rta_crm_cv/pages/ctrlv/monitory_page/widgets/calendar.dart';
import 'package:rta_crm_cv/providers/ctrlv/monitory_provider.dart';
import 'package:rta_crm_cv/widgets/card_header.dart';
import 'package:rta_crm_cv/widgets/custom_card.dart';

//import 'widgets/carga_de_ticket_popup.dart';
import '../../../helpers/constants.dart';
import '../../../providers/side_menu_provider.dart';
import '../../../public/colors.dart';
import '../../../widgets/side_menu/sidemenu.dart';
import 'Popup/details_pop_up.dart';

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
    SideMenuProvider sideM = Provider.of<SideMenuProvider>(context);
    MonitoryProvider monitoryProvider = Provider.of<MonitoryProvider>(context);

    sideM.setIndex(8);

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
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(20, 0, 10, 0),
                        child: CustomCard(
                          width: MediaQuery.of(context).size.width - 200,
                          height: MediaQuery.of(context).size.height,
                          title: "Vehicle Status",
                          child: Column(
                            children: [
                              //HEADER
                              const SizedBox(
                                height: 20,
                              ),
                        
                              const MonitoryFiltersWidget(),
                        
                              const SizedBox(
                                height: 20,
                              ),
                               Container(
                                padding:
                                    const EdgeInsets.only(top: 10, bottom: 40,right: 10),
                                //color: Colors.red,
                                height: MediaQuery.of(context).size.height * 0.5,
                                child: const Calendario(),
                              ),
                               Container(
                                padding:
                                    const EdgeInsets.only(top: 10, bottom: 40,right: 10),
                                //color: Colors.red,
                                height: MediaQuery.of(context).size.height * 0.4,
                                child:  CustomAgenda(width: MediaQuery.of(context).size.width - 300),
                              ),
                        
                              // Titulo de la tabla
                              Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: MonitoryPageHeader() ),
                        
                              widget.provider.monitory.isEmpty
                                  ? const CircularProgressIndicator()
                                  : Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Container(
                                        padding: const EdgeInsets.only(bottom: 40),
                                        height: 800,
                                        child: Material(
                                          shadowColor: const Color(0xff9ABEFF),
                                          borderRadius:
                                                BorderRadius.circular(15),
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
                                                        text: 'License Plates',
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 22)),
                                                  ],
                                                ),
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.16,
                                                cellPadding: EdgeInsets.zero,
                                                titleTextAlign:
                                                    PlutoColumnTextAlign.center,
                                                textAlign:
                                                    PlutoColumnTextAlign.center,
                                                type: PlutoColumnType.text(),
                                                enableEditingMode: false,
                                                backgroundColor:
                                                    const Color(0XFF6491F7),
                                                renderer: (rendererContext) {
                                                  return Container(
                                                    height: rowHeight,
                                                    // width: rendererContext.cell.column.width,
                                                    decoration: BoxDecoration(
                                                        gradient: whiteGradient),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceAround,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment.center,
                                                      children: [
                                                        Text(rendererContext
                                                            .cell.value),
                                                      ],
                                                    ),
                                                  );
                                                },
                                              ),
                                              PlutoColumn(
                                                title: 'Status',
                                                field: 'status',
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
                                                    TextSpan(
                                                        text: 'Status',
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 22)),
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
                                                enableEditingMode: false,
                                                backgroundColor:
                                                    const Color(0XFF6491F7),
                                                renderer: (rendererContext) {
                                                  return Container(
                                                    height: rowHeight,
                                                    // width: rendererContext.cell.column.width,
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
                                                    TextSpan(
                                                        text: 'Employee',
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 22)),
                                                  ],
                                                ),
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.1,
                                                cellPadding: EdgeInsets.zero,
                                                titleTextAlign:
                                                    PlutoColumnTextAlign.center,
                                                textAlign:
                                                    PlutoColumnTextAlign.center,
                                                type: PlutoColumnType.text(),
                                                enableEditingMode: false,
                                                backgroundColor:
                                                    const Color(0XFF6491F7),
                                                renderer: (rendererContext) {
                                                  return Container(
                                                    height: rowHeight,
                                                    //// width: rendererContext.cell.column.width,Context.cell.column.width,
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
                                                    TextSpan(
                                                        text: 'VIN',
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 22)),
                                                  ],
                                                ),
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
                                                backgroundColor:
                                                    const Color(0XFF6491F7),
                                                renderer: (rendererContext) {
                                                  return Container(
                                                    height: rowHeight,
                                                    // width: rendererContext.cell.column.width,
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
                                                    TextSpan(
                                                        text: 'Company',
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 22)),
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
                                                backgroundColor:
                                                    const Color(0XFF6491F7),
                                                renderer: (rendererContext) {
                                                  return Container(
                                                    height: rowHeight,
                                                    // width: rendererContext.cell.column.width,
                                                    decoration: BoxDecoration(
                                                        gradient: whiteGradient),
                                                    child: Center(
                                                        child: Text(rendererContext
                                                            .cell.value)),
                                                  );
                                                },
                                              ),
                                              PlutoColumn(
                                                title: 'Check_Out',
                                                field: 'check_out',
                                                titleSpan: const TextSpan(
                                                  children: [
                                                    WidgetSpan(
                                                      child: Icon(
                                                        Icons
                                                            .hourglass_bottom_outlined,
                                                        color: Color(0xffF3F7F9),
                                                        size: 30,
                                                      ),
                                                    ),
                                                    WidgetSpan(
                                                        child: SizedBox(
                                                      width: 10,
                                                    )),
                                                    TextSpan(
                                                        text: 'Check Out',
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 22)),
                                                  ],
                                                ),
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.13,
                                                cellPadding: EdgeInsets.zero,
                                                titleTextAlign:
                                                    PlutoColumnTextAlign.center,
                                                textAlign:
                                                    PlutoColumnTextAlign.center,
                                                type: PlutoColumnType.text(),
                                                enableEditingMode: false,
                                                backgroundColor:
                                                    const Color(0XFF6491F7),
                                                renderer: (rendererContext) {
                                                  return Container(
                                                    height: rowHeight,
                                                    // width: rendererContext.cell.column.width,
                                                    decoration: BoxDecoration(
                                                        gradient: whiteGradient),
                                                    child: Center(
                                                        child: Text(rendererContext
                                                            .cell.value)),
                                                  );
                                                },
                                              ),
                                              PlutoColumn(
                                                title: 'Check_In',
                                                field: 'check_in',
                                                titleSpan: const TextSpan(
                                                  children: [
                                                    WidgetSpan(
                                                      child: Icon(
                                                        Icons
                                                            .hourglass_empty_outlined,
                                                        color: Color(0xffF3F7F9),
                                                        size: 30,
                                                      ),
                                                    ),
                                                    WidgetSpan(
                                                        child: SizedBox(
                                                      width: 10,
                                                    )),
                                                    TextSpan(
                                                        text: 'Check In',
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 22)),
                                                  ],
                                                ),
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.1,
                                                cellPadding: EdgeInsets.zero,
                                                titleTextAlign:
                                                    PlutoColumnTextAlign.center,
                                                textAlign:
                                                    PlutoColumnTextAlign.center,
                                                type: PlutoColumnType.text(),
                                                enableEditingMode: false,
                                                backgroundColor:
                                                    const Color(0XFF6491F7),
                                                renderer: (rendererContext) {
                                                  return Container(
                                                    height: rowHeight,
                                                    // width: rendererContext.cell.column.width,
                                                    decoration: BoxDecoration(
                                                        gradient: whiteGradient),
                                                    child: Center(
                                                        child: Text(rendererContext
                                                            .cell.value)),
                                                  );
                                                },
                                              ),
                                              PlutoColumn(
                                                title: 'Details',
                                                field: 'details',
                                                backgroundColor:
                                                    const Color(0XFF6491F7),
                                                titleSpan: const TextSpan(
                                                  children: [
                                                    WidgetSpan(
                                                      child: Icon(
                                                        Icons
                                                            .remove_red_eye_outlined,
                                                        color: Color(0xffF3F7F9),
                                                        size: 30,
                                                      ),
                                                    ),
                                                    WidgetSpan(
                                                        child: SizedBox(
                                                      width: 10,
                                                    )),
                                                    TextSpan(
                                                        text: 'Details',
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 22)),
                                                  ],
                                                ),
                                                width: 200,
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
                                                        gradient: whiteGradient),
                                                    child: Center(
                                                        child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.center,
                                                      children: [
                                                        ElevatedButton(
                                                            onPressed: () async {
                                                              if (await monitoryProvider
                                                                  .getIssues(
                                                                      rendererContext
                                                                          .cell
                                                                          .value) == true) {
                                                              monitoryProvider
                                                                  .initializeViewPopup();
                                                                
                                                                await showDialog(
                                                                    context:
                                                                        context,
                                                                    builder:
                                                                       (context){
                                                                      return DetailsPop(
                                                                        vehicle: rendererContext
                                                                            .cell
                                                                            .value,
                                                                      );
                                                                    });
                                                              } else {
                                                                
                                                                await showDialog(
                                                                    context:
                                                                        context,
                                                                    builder:
                                                                        (context) {
                                                                      return Container(
                                                                        height:
                                                                            200,
                                                                        width:
                                                                            200,
                                                                        child:
                                                                            const Center(
                                                                          child:
                                                                              Text("No issues found"),
                                                                        ),
                                                                      
                                                                      );
                                                                    });
                                                              }
                                                            },
                                                            child: const Icon(Icons
                                                                .remove_red_eye_outlined)),
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
                          ),
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
