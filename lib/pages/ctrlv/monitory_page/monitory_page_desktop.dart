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
import 'package:rta_crm_cv/widgets/custom_card.dart';

//import 'widgets/carga_de_ticket_popup.dart';
import '../../../helpers/constants.dart';
import '../../../providers/side_menu_provider.dart';
import '../../../public/colors.dart';
import '../../../theme/theme.dart';
import '../../../widgets/custom_icon_button.dart';
import '../../../widgets/custom_text_icon_button.dart';
import '../../../widgets/pluto_grid_cells/pluto_grid_company_cell.dart';
import '../../../widgets/pluto_grid_cells/pluto_grid_license_cell.dart';
import '../../../widgets/pluto_grid_cells/pluto_grid_status_cellCV.dart';
import '../../../widgets/side_menu/sidemenu.dart';
import 'Popup/details_pop_up.dart';

class MonitoryPageDesktop extends StatefulWidget {
  const MonitoryPageDesktop(
      {Key? key})
      : super(key: key);
  // final AdvancedDrawerController drawerController;
  // final GlobalKey<ScaffoldState> scaffoldKey;

  // final MonitoryProvider provider;

  @override
  State<MonitoryPageDesktop> createState() => _MonitoryPageDesktopState();
}

class _MonitoryPageDesktopState extends State<MonitoryPageDesktop> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final MonitoryProvider provider = Provider.of<MonitoryProvider>(
        context,
        listen: false,
      );
      await provider.updateState();
    });
  }

 // TextEditingController searchController = TextEditingController();

  // late PlutoGridStateManager stateManager;

  @override
  Widget build(BuildContext context) {
    SideMenuProvider sideM = Provider.of<SideMenuProvider>(context);
    MonitoryProvider monitoryProvider = Provider.of<MonitoryProvider>(context);

    sideM.setIndex(8);

    return Material(
        child:Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(gradient: whiteGradient),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SideMenu(),
          Flexible(
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 10, 0),
              child: CustomCard(
                width: MediaQuery.of(context).size.width - 50,
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
                      padding: const EdgeInsets.only(
                          top: 10, bottom: 40, right: 10),
                      //color: Colors.red,
                      height: MediaQuery.of(context).size.height * 0.5,
                      child: const Calendario(),
                    ),
                    Container(
                      padding: const EdgeInsets.only(
                          top: 10, bottom: 40, right: 10),
                      //color: Colors.red,
                      height: MediaQuery.of(context).size.height * 0.4,
                      child: CustomAgenda(
                          width: MediaQuery.of(context).size.width - 300),
                    ),

                    // Titulo de la tabla
                    Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: MonitoryPageHeader()),

                    monitoryProvider.monitory.isEmpty
                        ? const CircularProgressIndicator()
                        : Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              padding: const EdgeInsets.only(bottom: 40),
                              height: 800,
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
                                    width:
                                        MediaQuery.of(context).size.width *
                                            0.16,
                                    cellPadding: EdgeInsets.zero,
                                    titleTextAlign:
                                        PlutoColumnTextAlign.center,
                                    textAlign: PlutoColumnTextAlign.center,
                                    type: PlutoColumnType.text(),
                                    enableEditingMode: false,
                                    backgroundColor:
                                        const Color(0XFF6491F7),
                                    renderer: (rendererContext) {
                                      return PlutoGridLicenseCellCV(
                                        text: rendererContext.cell.value,
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
                                                monitoryProvider
                                                    .setPageSize('less');
                                              },
                                            ),
                                            const SizedBox(width: 10),
                                            Text(
                                              monitoryProvider.pageRowCount
                                                  .toString(),
                                              style: const TextStyle(
                                                  color: Colors.white),
                                            ),
                                            const SizedBox(width: 10),
                                            CustomIconButton(
                                              icon: Icons
                                                  .keyboard_arrow_up_outlined,
                                              toolTip: 'more',
                                              onTap: () {
                                                monitoryProvider
                                                    .setPageSize('more');
                                              },
                                            ),
                                            const SizedBox(width: 10),
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
                                    width:
                                        MediaQuery.of(context).size.width *
                                            0.1,
                                    cellPadding: EdgeInsets.zero,
                                    titleTextAlign:
                                        PlutoColumnTextAlign.center,
                                    textAlign: PlutoColumnTextAlign.center,
                                    type: PlutoColumnType.text(),
                                    enableEditingMode: false,
                                    backgroundColor:
                                        const Color(0XFF6491F7),
                                    renderer: (rendererContext) {
                                      return PlutoGridStatusCellCV(text: rendererContext
                                                .cell.value); 
                                      
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
                                              monitoryProvider.setPage('start');
                                            },
                                          ),
                                          const SizedBox(width: 2),
                                          CustomIconButton(
                                            icon: Icons
                                                .keyboard_arrow_left_outlined,
                                            toolTip: 'previous',
                                            onTap: () {
                                              monitoryProvider.setPage('previous');
                                            },
                                          ),
                                          const SizedBox(width: 5),
                                          SizedBox(
                                            width: 30,
                                            child: Center(
                                              child: Text(
                                                monitoryProvider.page.toString(),
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
                                              monitoryProvider.setPage('next');
                                            },
                                          ),
                                          const SizedBox(width: 2),
                                          CustomIconButton(
                                            icon: Icons
                                                .keyboard_double_arrow_right,
                                            toolTip: 'end',
                                            onTap: () {
                                              monitoryProvider.setPage('end');
                                            },
                                          ),
                                        ],
                                      ),
                                    );
                                    //PlutoPagination(context.stateManager);
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
                                    width:
                                        MediaQuery.of(context).size.width *
                                            0.1,
                                    cellPadding: EdgeInsets.zero,
                                    titleTextAlign:
                                        PlutoColumnTextAlign.center,
                                    textAlign: PlutoColumnTextAlign.center,
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
                                    width:
                                        MediaQuery.of(context).size.width *
                                            0.12,
                                    cellPadding: EdgeInsets.zero,
                                    titleTextAlign:
                                        PlutoColumnTextAlign.center,
                                    textAlign: PlutoColumnTextAlign.center,
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
                                    width:
                                        MediaQuery.of(context).size.width *
                                            0.11,
                                    cellPadding: EdgeInsets.zero,
                                    titleTextAlign:
                                        PlutoColumnTextAlign.center,
                                    textAlign: PlutoColumnTextAlign.center,
                                    type: PlutoColumnType.text(),
                                    enableEditingMode: false,
                                    backgroundColor:
                                        const Color(0XFF6491F7),
                                    renderer: (rendererContext) {
                                      return PlutoGridCompanyCellCV(
                                        text: rendererContext.cell.value,
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
                                            Icons.hourglass_bottom_outlined,
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
                                    width:
                                        MediaQuery.of(context).size.width *
                                            0.13,
                                    cellPadding: EdgeInsets.zero,
                                    titleTextAlign:
                                        PlutoColumnTextAlign.center,
                                    textAlign: PlutoColumnTextAlign.center,
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
                                            Icons.hourglass_empty_outlined,
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
                                    width:
                                        MediaQuery.of(context).size.width *
                                            0.1,
                                    cellPadding: EdgeInsets.zero,
                                    titleTextAlign:
                                        PlutoColumnTextAlign.center,
                                    textAlign: PlutoColumnTextAlign.center,
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
                                          Icons.call_to_action_outlined,
                                          color: Colors.white,
                                        )),
                                        WidgetSpan(
                                            child: SizedBox(
                                          width: 10,
                                        )),
                                        TextSpan(
                                            text: 'Actions',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 22)),
                                      ],
                                    ),
                                    width: 200,
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
                                            CustomTextIconButton(
                                              isLoading: false,
                                              icon: Icon(
                                                  Icons
                                                      .remove_red_eye_outlined,
                                                  color: AppTheme.of(
                                                          context)
                                                      .primaryBackground),
                                              text: "Details",
                                              onTap: () async {
                                                if (await monitoryProvider
                                                        .getIssues(
                                                            rendererContext
                                                                .cell
                                                                .value) ==
                                                    true) {
                                                  monitoryProvider
                                                      .getMonitoryVehicle(
                                                          rendererContext
                                                              .cell.value);
                                                  monitoryProvider
                                                      .initializeViewPopup();

                                                  await showDialog(
                                                      context: context,
                                                      builder: (context) {
                                                        return DetailsPop(
                                                          vehicle:
                                                              rendererContext
                                                                  .cell
                                                                  .value,
                                                        );
                                                      });
                                                } else {
                                                  await showDialog(
                                                      context: context,
                                                      builder: (context) {
                                                        return Container(
                                                          height: 200,
                                                          width: 200,
                                                          child:
                                                              const Center(
                                                            child: Text(
                                                                "No issues found"),
                                                          ),
                                                        );
                                                      });
                                                }
                                              },
                                            ),
                                          ],
                                        )),
                                      );
                                    },
                                  ),
                                ],
                                rows: monitoryProvider.rows,
                                createFooter: (stateManager) {
                                  stateManager.setPageSize(
                                      monitoryProvider.pageRowCount);
                                  stateManager
                                      .setPage(monitoryProvider.page);
                                  return const SizedBox(
                                      height: 0, width: 0);
                                },
                                onLoaded: (event) async {
                                  monitoryProvider.stateManager =
                                      event.stateManager;
                                },
                                // onRowChecked: (event) {},
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
    ));
  }
}
