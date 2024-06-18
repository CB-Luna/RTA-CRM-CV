// ignore_for_file: use_build_context_synchronously

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
import 'package:rta_crm_cv/widgets/pluto_grid_cells/pluto_grid_company_cell_towers.dart';
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

    // List<String> titulos = [
    //   "pccid",
    //   "rta_customers",
    //   "cktid",
    //   "street",
    //   "cktcity"
    // ];

    // final List<PlutoColumn> columns;
    // final List<PlutoRow> rows;
    // columns = titulos.map((title) {
    //   return PlutoColumn(
    //     title: title,
    //     field: title,
    //     type: PlutoColumnType.text(),
    //   );
    // }).toList();
    // rows = List.generate(provider.listCircuits.length, (index) {
    //   print("Lista circuit: ${provider.listCircuits.length}");
    //   return PlutoRow(
    //     cells: {
    //       // "pccid": PlutoCell(value: 'pccid $index'),
    //       // "rta_customers": PlutoCell(value: 'rta_customers $index'),
    //       // "cktid": PlutoCell(value: 'cktid $index'),
    //       // "street": PlutoCell(value: 'street $index'),
    //       // "cktcity": PlutoCell(value: 'cktcity $index'),
    //       "pccid": PlutoCell(value: provider.listCircuits[index].pccid),
    //       "rta_customers":
    //           PlutoCell(value: provider.listCircuits[index].rtaCustomer),
    //       "cktid": PlutoCell(value: provider.listCircuits[index].cktid),
    //       "street": PlutoCell(value: provider.listCircuits[index].street),
    //       "cktcity": PlutoCell(value: provider.listCircuits[index].city),
    //     },
    //   );
    // });
    // final List<PlutoColumn> columns = List.generate(4, (index) {
    //   return PlutoColumn(
    //     // title: 'Column $index',
    //     // field: 'column$index',
    //     title: titulos[index],
    //     field: titulos[index],
    //     type: PlutoColumnType.text(),
    //   );
    // });

    // // final List<Map<String, dynamic>> data = List.generate(100, (index) {
    // final List<Map<String, dynamic>> data =
    //     List.generate(provider.listCircuits.length, (index) {
    //   return Map.fromIterable(
    //     List.generate(4, (i) => i),
    //     // key: (i) => 'column$i',
    //     key: (i) => '${titulos[i]}',
    //     value: (i) => 'Row $index Column $i',
    //   );
    // });

    // final List<PlutoRow> rows = [];

    // for (var item in data) {
    //   rows.add(
    //     PlutoRow(
    //       cells:
    //           item.map((key, value) => MapEntry(key, PlutoCell(value: value))),
    //     ),
    //   );
    // }
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
                  DefaultTabController(
                    length: 3,
                    initialIndex: 0,
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            gradient: whiteGradient,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(40),
                              topRight: Radius.circular(15),
                              bottomRight: Radius.circular(40),
                              bottomLeft: Radius.circular(15),
                            ),
                            border: Border.all(
                                color: AppTheme.of(context).primaryColor,
                                width: 2),
                          ),
                          child: TabBar(
                            onTap: (value) {
                              switch (value) {
                                case 0:
                                  provider.setIndex(0); // Circuits
                                  break;
                                case 1:
                                  provider.setIndex(1); // Torres
                                  break;
                                case 2:
                                  provider.setIndex(2); // Others
                                  break;
                                default:
                              }
                            },
                            indicator: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(40),
                                topRight: Radius.circular(15),
                                bottomRight: Radius.circular(40),
                                bottomLeft: Radius.circular(15),
                              ),
                              color: provider.indexSelected[0]
                                  ? AppTheme.of(context).primaryColor
                                  : provider.indexSelected[1]
                                      ? Colors.orangeAccent
                                      : provider.indexSelected[2]
                                          ? Colors.deepPurpleAccent
                                          : Colors.black,
                            ),
                            splashBorderRadius: BorderRadius.circular(40),
                            labelStyle: const TextStyle(
                              fontFamily: 'UniNeue',
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                            ),
                            unselectedLabelColor:
                                AppTheme.of(context).primaryColor,
                            unselectedLabelStyle: const TextStyle(
                              fontFamily: 'UniNeue',
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                            tabs: const [
                              Tab(text: 'Circuits'),
                              Tab(text: 'Towers'),
                              Tab(text: 'Connection'),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: SizedBox(
                            height: getHeight(0, context),
                            child: const TabBarView(
                              children: [
                                SizedBox.shrink(),
                                SizedBox.shrink(),
                                SizedBox.shrink(),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  CustomCard(
                    width: MediaQuery.of(context).size.width - 198,
                    height: MediaQuery.of(context).size.height,
                    title: provider.indexSelected[0]
                        ? "RTA Circuits"
                        : provider.indexSelected[1]
                            ? "RTA Towers"
                            : provider.indexSelected[2]
                                ? "RTA Fiber"
                                : "",
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              // vertical: 0, horizontal: 30),
                              vertical: 0,
                              horizontal: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(0.0),
                                child: CustomTextField(
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
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 0, horizontal: 30),
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
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 0, horizontal: 30),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CustomTextIconButton(
                                        isLoading: false,
                                        icon: Icon(Icons.save_outlined,
                                            color: AppTheme.of(context)
                                                .primaryBackground),
                                        text: 'Export xlsx',
                                        onTap: () async {
                                          // if (context.canPop()) context.pop();

                                          await provider.excelActivityReports();
                                        }),
                                  ],
                                ),
                              ),
                              // Padding(
                              //   padding: const EdgeInsets.symmetric(
                              //       vertical: 0, horizontal: 30),
                              //   child: Row(
                              //     mainAxisAlignment: MainAxisAlignment.center,
                              //     children: [
                              //       CustomTextIconButton(
                              //           isLoading: false,
                              //           icon: Icon(Icons.save_outlined,
                              //               color: AppTheme.of(context)
                              //                   .primaryBackground),
                              //           text: 'Export PDF',
                              //           onTap: () async {
                              //             // if (context.canPop()) context.pop();
                              //             provider.exportToPDF();
                              //             // await provider.clientPDF(
                              //             //     context, columns, rows);
                              //           }),
                              //     ],
                              //   ),
                              // ),
                              // Padding(
                              //   padding: const EdgeInsets.symmetric(
                              //       vertical: 0, horizontal: 30),
                              //   child: Row(
                              //     mainAxisAlignment: MainAxisAlignment.center,
                              //     children: [
                              //       CustomTextIconButton(
                              //           isLoading: false,
                              //           icon: Icon(Icons.save_outlined,
                              //               color: AppTheme.of(context)
                              //                   .primaryBackground),
                              //           text: 'Add Circuit',
                              //           onTap: () async {
                              //             provider.clearAll();
                              //             context.pushReplacement(
                              //                 routeAddedCircuit);

                              //             // if (!mounted) return;
                              //             // await showDialog(
                              //             //     context: context,
                              //             //     builder: (BuildContext context) {
                              //             //       return const AddCircuitPopUp();
                              //             //     });

                              //             provider.updateState();
                              //           }),
                              //     ],
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                        // Padding(
                        //   padding: const EdgeInsets.all(20),
                        //   child: IconButton(
                        //       icon: Icon(Icons.fullscreen,
                        //           color: AppTheme.of(context).primaryColor),
                        //       tooltip: 'Full Screen',
                        //       color: AppTheme.of(context).primaryColor,
                        //       onPressed: () async {
                        //         await showDialog(
                        //           context: context,
                        //           builder: (BuildContext context) {
                        //             return AlertDialog(
                        //                 backgroundColor: Colors.transparent,
                        //                 shadowColor: Colors.transparent,
                        //                 content: SizedBox(
                        //                   width: 1000,
                        //                   height: 1000,
                        //                   child: PdfView(
                        //                     backgroundDecoration:
                        //                         const BoxDecoration(
                        //                       color: Colors.transparent,
                        //                       borderRadius: BorderRadius.all(
                        //                         Radius.circular(21),
                        //                       ),
                        //                     ),
                        //                     controller:
                        //                         provider.finalPdfController!,
                        //                   ),
                        //                 ));
                        //           },
                        //         );
                        //       }),
                        // ),
                        // ------------------- CIRCUIT ------------------------
                        if (provider.indexSelected[0])
                          provider.listCircuits.isEmpty
                              ? const CircularProgressIndicator()
                              : Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10.0, horizontal: 4.0),
                                  child: SizedBox(
                                    height: getHeight(850, context),
                                    // width: getWidth(2450, context),
                                    width: getWidth(2460, context),
                                    child: PlutoGrid(
                                      key: UniqueKey(),
                                      configuration: PlutoGridConfiguration(
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
                                            if (column.field ==
                                                'pccid_Column') {
                                              return resolver<
                                                      PlutoFilterTypeContains>()
                                                  as PlutoFilterType;
                                            } else if (column.field ==
                                                'rta_customers_Column') {
                                              return resolver<
                                                      PlutoFilterTypeContains>()
                                                  as PlutoFilterType;
                                            } else if (column.field ==
                                                'CKTSTATUS_Column') {
                                              return resolver<
                                                      PlutoFilterTypeContains>()
                                                  as PlutoFilterType;
                                            } else if (column.field ==
                                                'CktID_Column') {
                                              return resolver<
                                                      PlutoFilterTypeContains>()
                                                  as PlutoFilterType;
                                            } else if (column.field ==
                                                'street_Column') {
                                              return resolver<
                                                      PlutoFilterTypeContains>()
                                                  as PlutoFilterType;
                                            } else if (column.field ==
                                                'state_Column') {
                                              return resolver<
                                                      PlutoFilterTypeContains>()
                                                  as PlutoFilterType;
                                            } else if (column.field ==
                                                'CKTType_Column') {
                                              return resolver<
                                                      PlutoFilterTypeContains>()
                                                  as PlutoFilterType;
                                            } else if (column.field ==
                                                'cktuse_Column') {
                                              return resolver<
                                                      PlutoFilterTypeContains>()
                                                  as PlutoFilterType;
                                            } else if (column.field ==
                                                'actions') {
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
                                          title: 'PCCID',
                                          field: 'pccid_Column',
                                          backgroundColor:
                                              const Color(0XFF6491F7),
                                          titleSpan: TextSpan(children: [
                                            WidgetSpan(
                                                child: Icon(
                                                    Icons.cable_outlined,
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
                                              // MediaQuery.of(context).size.width * 0.10,
                                              MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.08,
                                          cellPadding: EdgeInsets.zero,
                                          titleTextAlign:
                                              PlutoColumnTextAlign.center,
                                          textAlign:
                                              PlutoColumnTextAlign.center,
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
                                                  rendererContext.cell.value
                                                      .toString(),
                                                  style: AppTheme.of(context)
                                                      .contenidoTablas
                                                      .override(
                                                          fontFamily:
                                                              'Gotham-Regular',
                                                          useGoogleFonts: false,
                                                          color: AppTheme.of(
                                                                  context)
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
                                                      provider
                                                          .setPageSize('less');
                                                    },
                                                  ),
                                                  const SizedBox(width: 10),
                                                  Text(
                                                    provider.pageRowCount
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
                                                      provider
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
                                          title: 'RTA Customers',
                                          field: 'rta_customers_Column',
                                          backgroundColor:
                                              const Color(0XFF6491F7),
                                          titleSpan: TextSpan(children: [
                                            WidgetSpan(
                                                child: Icon(
                                                    Icons
                                                        .account_circle_outlined,
                                                    color: AppTheme.of(context)
                                                        .primaryBackground)),
                                            const WidgetSpan(
                                                child: SizedBox(width: 10)),
                                            TextSpan(
                                                text: 'RTA Customers',
                                                style: AppTheme.of(context)
                                                    .encabezadoTablas)
                                          ]),
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
                                          renderer: (rendererContext) {
                                            return Container(
                                              height: rowHeight,
                                              // width: rendererContext
                                              //.cell.column.width,                                                    .cell.column.width,
                                              decoration: BoxDecoration(
                                                  gradient: whiteGradient),
                                              child: Center(
                                                  child: Text(
                                                rendererContext.cell.value ??
                                                    "-",
                                                style: AppTheme.of(context)
                                                    .contenidoTablas
                                                    .override(
                                                        fontFamily:
                                                            'Gotham-Regular',
                                                        useGoogleFonts: false,
                                                        color:
                                                            AppTheme.of(context)
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
                                                      provider
                                                          .setPage('previous');
                                                    },
                                                  ),
                                                  const SizedBox(width: 5),
                                                  SizedBox(
                                                    width: 30,
                                                    child: Center(
                                                      child: Text(
                                                        provider.page
                                                            .toString(),
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
                                          field: 'CKTSTATUS_Column',
                                          backgroundColor:
                                              const Color(0XFF6491F7),
                                          titleSpan: TextSpan(children: [
                                            WidgetSpan(
                                                child: Icon(
                                                    Icons
                                                        .settings_input_component_outlined,
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
                                              // MediaQuery.of(context).size.width * 0.095,
                                              MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.082,
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
                                                  child: Text(
                                                rendererContext.cell.value ??
                                                    "-",
                                                style: AppTheme.of(context)
                                                    .contenidoTablas
                                                    .override(
                                                        fontFamily:
                                                            'Gotham-Regular',
                                                        useGoogleFonts: false,
                                                        color:
                                                            AppTheme.of(context)
                                                                .primaryColor),
                                              )),
                                            );
                                          },
                                        ),
                                        PlutoColumn(
                                          title: 'ID',
                                          field: 'CktID_Column',
                                          titleSpan: TextSpan(children: [
                                            WidgetSpan(
                                                child: Icon(
                                                    Icons
                                                        .confirmation_number_outlined,
                                                    color: AppTheme.of(context)
                                                        .primaryBackground)),
                                            const WidgetSpan(
                                                child: SizedBox(width: 10)),
                                            TextSpan(
                                                text: 'ID',
                                                style: AppTheme.of(context)
                                                    .encabezadoTablas)
                                          ]),
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.1,
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
                                                  gradient: whiteGradient),
                                              child: Center(
                                                  child: Text(
                                                rendererContext.cell.value ??
                                                    "-",
                                                style: AppTheme.of(context)
                                                    .contenidoTablas
                                                    .override(
                                                        fontFamily:
                                                            'Gotham-Regular',
                                                        useGoogleFonts: false,
                                                        color:
                                                            AppTheme.of(context)
                                                                .primaryColor),
                                              )),
                                            );
                                          },
                                        ),
                                        PlutoColumn(
                                          title: 'Street',
                                          field: 'street_Column',
                                          backgroundColor:
                                              const Color(0XFF6491F7),
                                          titleSpan: TextSpan(children: [
                                            WidgetSpan(
                                                child: Icon(
                                                    Icons.signpost_outlined,
                                                    color: AppTheme.of(context)
                                                        .primaryBackground)),
                                            const WidgetSpan(
                                                child: SizedBox(width: 10)),
                                            TextSpan(
                                                text: 'Street',
                                                style: AppTheme.of(context)
                                                    .encabezadoTablas)
                                          ]),
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
                                                  child: Text(
                                                rendererContext.cell.value ??
                                                    "-",
                                                style: AppTheme.of(context)
                                                    .contenidoTablas
                                                    .override(
                                                        fontFamily:
                                                            'Gotham-Regular',
                                                        useGoogleFonts: false,
                                                        color:
                                                            AppTheme.of(context)
                                                                .primaryColor),
                                              )),
                                            );
                                          },
                                        ),
                                        PlutoColumn(
                                          title: 'State',
                                          field: 'state_Column',
                                          backgroundColor:
                                              const Color(0XFF6491F7),
                                          titleSpan: TextSpan(children: [
                                            WidgetSpan(
                                                child: Icon(
                                                    Icons.domain_outlined,
                                                    color: AppTheme.of(context)
                                                        .primaryBackground)),
                                            const WidgetSpan(
                                                child: SizedBox(width: 10)),
                                            TextSpan(
                                                text: 'State',
                                                style: AppTheme.of(context)
                                                    .encabezadoTablas)
                                          ]),
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.075,
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
                                                  child: Text(
                                                rendererContext.cell.value ??
                                                    "-",
                                                style: AppTheme.of(context)
                                                    .contenidoTablas
                                                    .override(
                                                        fontFamily:
                                                            'Gotham-Regular',
                                                        useGoogleFonts: false,
                                                        color:
                                                            AppTheme.of(context)
                                                                .primaryColor),
                                              )),
                                            );
                                          },
                                        ),
                                        PlutoColumn(
                                          title: 'Type',
                                          field: 'CKTType_Column',
                                          backgroundColor:
                                              const Color(0XFF6491F7),
                                          titleSpan: TextSpan(children: [
                                            WidgetSpan(
                                                child: Icon(
                                                    Icons
                                                        .settings_input_hdmi_outlined,
                                                    color: AppTheme.of(context)
                                                        .primaryBackground)),
                                            const WidgetSpan(
                                                child: SizedBox(width: 5)),
                                            TextSpan(
                                                text: 'Type',
                                                style: AppTheme.of(context)
                                                    .encabezadoTablas)
                                          ]),
                                          width:
                                              // MediaQuery.of(context).size.width * 0.10,
                                              MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.068,
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
                                                  child: Text(
                                                rendererContext.cell.value ??
                                                    "-",
                                                style: AppTheme.of(context)
                                                    .contenidoTablas
                                                    .override(
                                                        fontFamily:
                                                            'Gotham-Regular',
                                                        useGoogleFonts: false,
                                                        color:
                                                            AppTheme.of(context)
                                                                .primaryColor),
                                              )),
                                            );
                                          },
                                        ),
                                        PlutoColumn(
                                          title: 'USE',
                                          field: 'cktuse_Column',
                                          backgroundColor:
                                              const Color(0XFF6491F7),
                                          titleSpan: TextSpan(children: [
                                            WidgetSpan(
                                                child: Icon(
                                                    Icons.router_outlined,
                                                    color: AppTheme.of(context)
                                                        .primaryBackground)),
                                            const WidgetSpan(
                                                child: SizedBox(width: 5)),
                                            TextSpan(
                                                text: 'USE',
                                                style: AppTheme.of(context)
                                                    .encabezadoTablas)
                                          ]),
                                          width:
                                              // MediaQuery.of(context).size.width * 0.09,
                                              MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.063,
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
                                                  child: Text(
                                                rendererContext.cell.value ??
                                                    "-",
                                                style: AppTheme.of(context)
                                                    .contenidoTablas
                                                    .override(
                                                        fontFamily:
                                                            'Gotham-Regular',
                                                        useGoogleFonts: false,
                                                        color:
                                                            AppTheme.of(context)
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
                                                    color: AppTheme.of(context)
                                                        .primaryBackground)),
                                            const WidgetSpan(
                                                child: SizedBox(width: 5)),
                                            TextSpan(
                                                text: 'Actions',
                                                style: AppTheme.of(context)
                                                    .encabezadoTablas)
                                          ]),
                                          width:
                                              // MediaQuery.of(context).size.width * 0.17,
                                              MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.19,
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
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  // More Info
                                                  Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 4),
                                                    child: CustomTextIconButton(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              // 0.08,
                                                              0.06,
                                                      isLoading: false,
                                                      icon: Icon(
                                                          Icons
                                                              .remove_red_eye_outlined,
                                                          color: AppTheme.of(
                                                                  context)
                                                              .primaryBackground),
                                                      // text: 'More Info',
                                                      text: 'More',

                                                      style:
                                                          AppTheme.of(context)
                                                              .contenidoTablas
                                                              .override(
                                                                fontFamily:
                                                                    'Gotham-Regular',
                                                                useGoogleFonts:
                                                                    false,
                                                                color: AppTheme.of(
                                                                        context)
                                                                    .primaryBackground,
                                                              ),
                                                      color:
                                                          AppTheme.of(context)
                                                              .primaryColor,
                                                      onTap: () async {
                                                        await provider
                                                            .getInformationCircuit(
                                                                rendererContext
                                                                    .cell
                                                                    .value);
                                                        provider.getComments();
                                                        if (!context.mounted)
                                                          return;
                                                        context.pushReplacement(
                                                            routeCircuitSelected,
                                                            extra:
                                                                rendererContext
                                                                    .cell
                                                                    .value);
                                                      },
                                                    ),
                                                  ),
                                                  Padding(
                                                    // padding: const EdgeInsets.only(
                                                    //     left: 8.0, right: 8.0),
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 0),
                                                    child: CustomTextIconButton(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              // 0.08,
                                                              0.045,
                                                      isLoading: false,
                                                      icon: Icon(
                                                          Icons.edit_square,
                                                          color: AppTheme.of(
                                                                  context)
                                                              .primaryBackground),
                                                      text: 'Edit',
                                                      style:
                                                          AppTheme.of(context)
                                                              .contenidoTablas
                                                              .override(
                                                                fontFamily:
                                                                    'Gotham-Regular',
                                                                useGoogleFonts:
                                                                    false,
                                                                color: AppTheme.of(
                                                                        context)
                                                                    .primaryBackground,
                                                              ),
                                                      color:
                                                          AppTheme.of(context)
                                                              .primaryColor,
                                                      onTap: () async {
                                                        // provider.editCircuit(
                                                        //     rendererContext.cell.value);
                                                        provider
                                                            .getInformationCircuit(
                                                                rendererContext
                                                                    .cell
                                                                    .value);
                                                        provider.getCatalog();
                                                        context.pushReplacement(
                                                            routeEditingCircuit);

                                                        // if (!mounted) return;
                                                        // await showDialog(
                                                        //     context: context,
                                                        //     builder:
                                                        //         (BuildContext context) {
                                                        //       return const EditCircuitPopUp();
                                                        //     });
                                                        // provider.updateState();
                                                      },
                                                    ),
                                                  ),
                                                  // Padding(
                                                  //   padding: const EdgeInsets.symmetric(
                                                  //       horizontal: 4),
                                                  //   child: CustomTextIconButton(
                                                  //     mainAxisAlignment:
                                                  //         MainAxisAlignment.center,
                                                  //     width: MediaQuery.of(context)
                                                  //             .size
                                                  //             .width *
                                                  //         // 0.08,
                                                  //         0.06,
                                                  //     isLoading: false,
                                                  //     icon: Icon(Icons.delete_outlined,
                                                  //         color: AppTheme.of(context)
                                                  //             .primaryBackground),
                                                  //     text: 'Delete',
                                                  //     style: AppTheme.of(context)
                                                  //         .contenidoTablas
                                                  //         .override(
                                                  //           fontFamily:
                                                  //               'Gotham-Regular',
                                                  //           useGoogleFonts: false,
                                                  //           color: AppTheme.of(context)
                                                  //               .primaryBackground,
                                                  //         ),
                                                  //     color: AppTheme.of(context)
                                                  //         .odePrimary,
                                                  //     onTap: () async {
                                                  //       await provider.selectCircuit(
                                                  //           rendererContext.cell.value);
                                                  //       // if (!mounted) return;
                                                  //       await showDialog(
                                                  //           context: context,
                                                  //           builder:
                                                  //               (BuildContext context) {
                                                  //             return const DeleteCIrcuitPopUp();
                                                  //           });
                                                  //     },
                                                  //   ),
                                                  // ),
                                                ],
                                              ),
                                            );
                                          },
                                        ),
                                      ],
                                      rows: provider.rows,
                                      onLoaded: (event) async {
                                        provider.stateManager =
                                            event.stateManager;
                                      },
                                      createFooter: (stateManager) {
                                        stateManager
                                            .setPageSize(provider.pageRowCount);
                                        stateManager.setPage(provider.page);
                                        return const SizedBox(
                                            height: 0, width: 0);
                                      },
                                    ),
                                  ),
                                ),
                        if (provider.indexSelected[1])
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 4.0),
                            child: SizedBox(
                              height: getHeight(850, context),
                              // width: getWidth(2450, context),
                              width: getWidth(2460, context),
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
                                      if (column.field == 'pccid_Column') {
                                        return resolver<
                                                PlutoFilterTypeContains>()
                                            as PlutoFilterType;
                                      } else if (column.field ==
                                          'rta_customers_Column') {
                                        return resolver<
                                                PlutoFilterTypeContains>()
                                            as PlutoFilterType;
                                      } else if (column.field ==
                                          'CKTSTATUS_Column') {
                                        return resolver<
                                                PlutoFilterTypeContains>()
                                            as PlutoFilterType;
                                      } else if (column.field ==
                                          'CktID_Column') {
                                        return resolver<
                                                PlutoFilterTypeContains>()
                                            as PlutoFilterType;
                                      } else if (column.field ==
                                          'street_Column') {
                                        return resolver<
                                                PlutoFilterTypeContains>()
                                            as PlutoFilterType;
                                      } else if (column.field ==
                                          'state_Column') {
                                        return resolver<
                                                PlutoFilterTypeContains>()
                                            as PlutoFilterType;
                                      } else if (column.field ==
                                          'CKTType_Column') {
                                        return resolver<
                                                PlutoFilterTypeContains>()
                                            as PlutoFilterType;
                                      } else if (column.field ==
                                          'cktuse_Column') {
                                        return resolver<
                                                PlutoFilterTypeContains>()
                                            as PlutoFilterType;
                                      } else if (column.field == 'actions') {
                                        return resolver<
                                                PlutoFilterTypeContains>()
                                            as PlutoFilterType;
                                      }
                                      return resolver<PlutoFilterTypeContains>()
                                          as PlutoFilterType;
                                    },
                                  ),
                                ),
                                columns: [
                                  // -------------------------- TOWERS ----------
                                  PlutoColumn(
                                    title: 'Company',
                                    field: 'company_id_Column',
                                    backgroundColor: const Color(0XFF6491F7),
                                    titleSpan: TextSpan(children: [
                                      WidgetSpan(
                                          child: Icon(Icons.router_outlined,
                                              color: AppTheme.of(context)
                                                  .primaryBackground)),
                                      const WidgetSpan(
                                          child: SizedBox(width: 5)),
                                      TextSpan(
                                          text: 'Company',
                                          style: AppTheme.of(context)
                                              .encabezadoTablas)
                                    ]),
                                    width:
                                        // MediaQuery.of(context).size.width * 0.09,
                                        MediaQuery.of(context).size.width * 0.1,
                                    cellPadding: EdgeInsets.zero,
                                    titleTextAlign: PlutoColumnTextAlign.center,
                                    textAlign: PlutoColumnTextAlign.center,
                                    type: PlutoColumnType.text(),
                                    enableEditingMode: false,
                                    renderer: (rendererContext) {
                                      return PlutoGridCompanyCellTowers(
                                          text: rendererContext.cell.value
                                                  .toString() ??
                                              "-");
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
                                    title: 'Name',
                                    field: 'name_Column',
                                    backgroundColor: const Color(0XFF6491F7),
                                    titleSpan: TextSpan(children: [
                                      WidgetSpan(
                                          child: Icon(Icons.router_outlined,
                                              color: AppTheme.of(context)
                                                  .primaryBackground)),
                                      const WidgetSpan(
                                          child: SizedBox(width: 5)),
                                      TextSpan(
                                          text: 'Name',
                                          style: AppTheme.of(context)
                                              .encabezadoTablas)
                                    ]),
                                    width:
                                        // MediaQuery.of(context).size.width * 0.09,
                                        MediaQuery.of(context).size.width *
                                            0.10,
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
                                          rendererContext.cell.value ?? "-",
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
                                    title: 'Type',
                                    field: 'type_Column',
                                    backgroundColor: const Color(0XFF6491F7),
                                    titleSpan: TextSpan(children: [
                                      WidgetSpan(
                                          child: Icon(Icons.router_outlined,
                                              color: AppTheme.of(context)
                                                  .primaryBackground)),
                                      const WidgetSpan(
                                          child: SizedBox(width: 5)),
                                      TextSpan(
                                          text: 'Type',
                                          style: AppTheme.of(context)
                                              .encabezadoTablas)
                                    ]),
                                    width:
                                        // MediaQuery.of(context).size.width * 0.09,
                                        MediaQuery.of(context).size.width *
                                            0.066, // 0.063
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
                                          rendererContext.cell.value ?? "-",
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
                                    title: 'Address',
                                    field: 'address_Column',
                                    backgroundColor: const Color(0XFF6491F7),
                                    titleSpan: TextSpan(children: [
                                      WidgetSpan(
                                          child: Icon(Icons.router_outlined,
                                              color: AppTheme.of(context)
                                                  .primaryBackground)),
                                      const WidgetSpan(
                                          child: SizedBox(width: 5)),
                                      TextSpan(
                                          text: 'Address',
                                          style: AppTheme.of(context)
                                              .encabezadoTablas)
                                    ]),
                                    width:
                                        // MediaQuery.of(context).size.width * 0.09,
                                        MediaQuery.of(context).size.width *
                                            // 0.063,
                                            0.09,
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
                                          rendererContext.cell.value ?? "-",
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
                                    title: 'Make',
                                    field: 'make_Column',
                                    backgroundColor: const Color(0XFF6491F7),
                                    titleSpan: TextSpan(children: [
                                      WidgetSpan(
                                          child: Icon(Icons.router_outlined,
                                              color: AppTheme.of(context)
                                                  .primaryBackground)),
                                      const WidgetSpan(
                                          child: SizedBox(width: 5)),
                                      TextSpan(
                                          text: 'Make',
                                          style: AppTheme.of(context)
                                              .encabezadoTablas)
                                    ]),
                                    width:
                                        // MediaQuery.of(context).size.width * 0.09,
                                        MediaQuery.of(context).size.width *
                                            // 0.063,
                                            0.075,
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
                                          rendererContext.cell.value ?? "-",
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
                                    field: 'model_Column',
                                    backgroundColor: const Color(0XFF6491F7),
                                    titleSpan: TextSpan(children: [
                                      WidgetSpan(
                                          child: Icon(Icons.router_outlined,
                                              color: AppTheme.of(context)
                                                  .primaryBackground)),
                                      const WidgetSpan(
                                          child: SizedBox(width: 5)),
                                      TextSpan(
                                          text: 'Model',
                                          style: AppTheme.of(context)
                                              .encabezadoTablas)
                                    ]),
                                    width: MediaQuery.of(context).size.width *
                                        0.12,
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
                                          rendererContext.cell.value ?? "-",
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
                                    title: 'Use',
                                    field: 'use_Column',
                                    backgroundColor: const Color(0XFF6491F7),
                                    titleSpan: TextSpan(children: [
                                      WidgetSpan(
                                          child: Icon(Icons.router_outlined,
                                              color: AppTheme.of(context)
                                                  .primaryBackground)),
                                      const WidgetSpan(
                                          child: SizedBox(width: 5)),
                                      TextSpan(
                                          text: 'Use',
                                          style: AppTheme.of(context)
                                              .encabezadoTablas)
                                    ]),
                                    width:
                                        // MediaQuery.of(context).size.width * 0.09,
                                        MediaQuery.of(context).size.width *
                                            0.063,
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
                                          rendererContext.cell.value ?? "-",
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
                                    title: '#_customer_serv',
                                    field: 'users_Column',
                                    backgroundColor: const Color(0XFF6491F7),
                                    titleSpan: TextSpan(children: [
                                      WidgetSpan(
                                          child: Icon(Icons.router_outlined,
                                              color: AppTheme.of(context)
                                                  .primaryBackground)),
                                      const WidgetSpan(
                                          child: SizedBox(width: 5)),
                                      TextSpan(
                                          text: '#_customer_serv',
                                          style: AppTheme.of(context)
                                              .encabezadoTablas)
                                    ]),
                                    width:
                                        // MediaQuery.of(context).size.width * 0.09,
                                        MediaQuery.of(context).size.width *
                                            0.14, //0.12
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
                                          rendererContext.cell.value
                                                  .toString() ??
                                              "-",
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
                                          child: SizedBox(width: 5)),
                                      TextSpan(
                                          text: 'Actions',
                                          style: AppTheme.of(context)
                                              .encabezadoTablas)
                                    ]),
                                    width:
                                        // MediaQuery.of(context).size.width * 0.19,
                                        MediaQuery.of(context).size.width *
                                            0.12,
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
                                            // More Info
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 4),
                                              child: CustomTextIconButton(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    // 0.08,
                                                    0.06,
                                                isLoading: false,
                                                icon: Icon(
                                                    Icons
                                                        .remove_red_eye_outlined,
                                                    color: AppTheme.of(context)
                                                        .primaryBackground),
                                                // text: 'More Info',
                                                text: 'More',

                                                style: AppTheme.of(context)
                                                    .contenidoTablas
                                                    .override(
                                                      fontFamily:
                                                          'Gotham-Regular',
                                                      useGoogleFonts: false,
                                                      color: AppTheme.of(
                                                              context)
                                                          .primaryBackground,
                                                    ),
                                                color: AppTheme.of(context)
                                                    .primaryColor,
                                                onTap: () async {
                                                  await provider
                                                      .getInformationCircuit(
                                                          rendererContext
                                                              .cell.value);
                                                  provider.getComments();
                                                  if (!context.mounted) return;
                                                  context.pushReplacement(
                                                      routeCircuitSelected,
                                                      extra: rendererContext
                                                          .cell.value);
                                                },
                                              ),
                                            ),
                                            Padding(
                                              // padding: const EdgeInsets.only(
                                              //     left: 8.0, right: 8.0),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 0),
                                              child: CustomTextIconButton(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    // 0.08,
                                                    0.045,
                                                isLoading: false,
                                                icon: Icon(Icons.edit_square,
                                                    color: AppTheme.of(context)
                                                        .primaryBackground),
                                                text: 'Edit',
                                                style: AppTheme.of(context)
                                                    .contenidoTablas
                                                    .override(
                                                      fontFamily:
                                                          'Gotham-Regular',
                                                      useGoogleFonts: false,
                                                      color: AppTheme.of(
                                                              context)
                                                          .primaryBackground,
                                                    ),
                                                color: AppTheme.of(context)
                                                    .primaryColor,
                                                onTap: () async {
                                                  // provider.editCircuit(
                                                  //     rendererContext.cell.value);
                                                  provider
                                                      .getInformationCircuit(
                                                          rendererContext
                                                              .cell.value);
                                                  provider.getCatalog();
                                                  context.pushReplacement(
                                                      routeEditingCircuit);

                                                  // if (!mounted) return;
                                                  // await showDialog(
                                                  //     context: context,
                                                  //     builder:
                                                  //         (BuildContext context) {
                                                  //       return const EditCircuitPopUp();
                                                  //     });
                                                  // provider.updateState();
                                                },
                                              ),
                                            ),
                                            // Padding(
                                            //   padding: const EdgeInsets.symmetric(
                                            //       horizontal: 4),
                                            //   child: CustomTextIconButton(
                                            //     mainAxisAlignment:
                                            //         MainAxisAlignment.center,
                                            //     width: MediaQuery.of(context)
                                            //             .size
                                            //             .width *
                                            //         // 0.08,
                                            //         0.06,
                                            //     isLoading: false,
                                            //     icon: Icon(Icons.delete_outlined,
                                            //         color: AppTheme.of(context)
                                            //             .primaryBackground),
                                            //     text: 'Delete',
                                            //     style: AppTheme.of(context)
                                            //         .contenidoTablas
                                            //         .override(
                                            //           fontFamily:
                                            //               'Gotham-Regular',
                                            //           useGoogleFonts: false,
                                            //           color: AppTheme.of(context)
                                            //               .primaryBackground,
                                            //         ),
                                            //     color: AppTheme.of(context)
                                            //         .odePrimary,
                                            //     onTap: () async {
                                            //       await provider.selectCircuit(
                                            //           rendererContext.cell.value);
                                            //       // if (!mounted) return;
                                            //       await showDialog(
                                            //           context: context,
                                            //           builder:
                                            //               (BuildContext context) {
                                            //             return const DeleteCIrcuitPopUp();
                                            //           });
                                            //     },
                                            //   ),
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
                                  stateManager
                                      .setPageSize(provider.pageRowCount);
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
