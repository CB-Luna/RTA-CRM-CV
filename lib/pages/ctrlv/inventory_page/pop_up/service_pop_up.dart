import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:provider/provider.dart';
import 'package:rta_crm_cv/providers/ctrlv/inventory_provider.dart';
import 'package:rta_crm_cv/widgets/side_menu/sidemenu.dart';

import '../../../../helpers/constants.dart';
import '../../../../public/colors.dart';
import '../../../../theme/theme.dart';
import '../../../../widgets/custom_card.dart';
import '../../../../widgets/custom_icon_button.dart';
import '../../../../widgets/custom_text_icon_button.dart';
import '../actions/add_services_pop_up.dart';
import '../vehicle_cards/generalinformation_card.dart';

class ServicePopUp extends StatefulWidget {
  const ServicePopUp({super.key});

  @override
  State<ServicePopUp> createState() => _ServicePopUpState();
}

class _ServicePopUpState extends State<ServicePopUp> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final InventoryProvider provider = Provider.of<InventoryProvider>(
        context,
        listen: false,
      );
      await provider.updateStateService();
    });
  }

  @override
  Widget build(BuildContext context) {
    InventoryProvider provider = Provider.of<InventoryProvider>(context);

    return Material(
      child: Row(
        children: [
          const SideMenu(),
          CustomCard(
              title: 'Service',
              width: MediaQuery.of(context).size.width * 0.93,
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  const GeneralInformationCard(),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: CustomTextIconButton(
                      mainAxisAlignment: MainAxisAlignment.center,
                      width: MediaQuery.of(context).size.width * 0.08,
                      isLoading: false,
                      icon: Icon(Icons.list_alt_outlined,
                          color: AppTheme.of(context).primaryBackground),
                      text: 'Services',
                      style: AppTheme.of(context).contenidoTablas.override(
                            fontFamily: 'Gotham-Regular',
                            useGoogleFonts: false,
                            color: AppTheme.of(context).primaryBackground,
                          ),
                      color: AppTheme.of(context).primaryColor,
                      onTap: () async {
                        // // ignore: use_build_context_synchronously
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return const AddServicePopUp();
                            });
                      },
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.45,
                        height: MediaQuery.of(context).size.height * 0.55,
                        child: PlutoGrid(
                          key: UniqueKey(),
                          configuration: PlutoGridConfiguration(
                            scrollbar: plutoGridScrollbarConfig(context),
                            style: plutoGridStyleConfig(context),
                            columnFilter: PlutoGridColumnFilterConfig(
                              filters: const [
                                ...FilterHelper.defaultFilters,
                              ],
                              resolveDefaultColumnFilter: (column, resolver) {
                                if (column.field == 'LicensePlates') {
                                  return resolver<PlutoFilterTypeContains>()
                                      as PlutoFilterType;
                                } else if (column.field == 'service') {
                                  return resolver<PlutoFilterTypeContains>()
                                      as PlutoFilterType;
                                } else if (column.field == 'serviceDate') {
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
                              title: 'LicensePlates',
                              field: 'LicensePlates',
                              backgroundColor: const Color(0XFF6491F7),
                              titleSpan: TextSpan(children: [
                                WidgetSpan(
                                    child: Icon(Icons.dialpad_outlined,
                                        color: AppTheme.of(context)
                                            .primaryBackground)),
                                const WidgetSpan(child: SizedBox(width: 10)),
                                TextSpan(
                                    text: 'LicensePlates',
                                    style:
                                        AppTheme.of(context).encabezadoTablas)
                              ]),
                              width: MediaQuery.of(context).size.width * 0.15,
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
                                  decoration:
                                      BoxDecoration(gradient: whiteGradient),
                                  child: Center(
                                      child: Text(
                                    rendererContext.cell.value ?? '-',
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
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CustomIconButton(
                                        icon:
                                            Icons.keyboard_arrow_down_outlined,
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
                                        icon: Icons.keyboard_arrow_up_outlined,
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
                              title: 'service',
                              field: 'service',
                              backgroundColor: const Color(0XFF6491F7),
                              titleSpan: TextSpan(children: [
                                WidgetSpan(
                                    child: Icon(Icons.car_repair_outlined,
                                        color: AppTheme.of(context)
                                            .primaryBackground)),
                                const WidgetSpan(child: SizedBox(width: 10)),
                                TextSpan(
                                    text: 'service',
                                    style:
                                        AppTheme.of(context).encabezadoTablas)
                              ]),
                              width: MediaQuery.of(context).size.width * 0.15,
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
                                  decoration:
                                      BoxDecoration(gradient: whiteGradient),
                                  child: Center(
                                      child: Text(
                                    rendererContext.cell.value ?? '-',
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
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CustomIconButton(
                                        icon: Icons.keyboard_double_arrow_left,
                                        toolTip: 'start',
                                        onTap: () {
                                          provider.setPage('start');
                                        },
                                      ),
                                      const SizedBox(width: 2),
                                      CustomIconButton(
                                        icon:
                                            Icons.keyboard_arrow_left_outlined,
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
                                        icon:
                                            Icons.keyboard_arrow_right_outlined,
                                        toolTip: 'next',
                                        onTap: () {
                                          provider.setPage('next');
                                        },
                                      ),
                                      const SizedBox(width: 2),
                                      CustomIconButton(
                                        icon: Icons.keyboard_double_arrow_right,
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
                              title: 'serviceDate',
                              field: 'serviceDate',
                              backgroundColor: const Color(0XFF6491F7),
                              titleSpan: TextSpan(children: [
                                WidgetSpan(
                                    child: Icon(Icons.dialpad_outlined,
                                        color: AppTheme.of(context)
                                            .primaryBackground)),
                                const WidgetSpan(child: SizedBox(width: 10)),
                                TextSpan(
                                    text: 'serviceDate',
                                    style:
                                        AppTheme.of(context).encabezadoTablas)
                              ]),
                              width: MediaQuery.of(context).size.width * 0.15,
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
                                  decoration:
                                      BoxDecoration(gradient: whiteGradient),
                                  child: Center(
                                      child: Text(
                                    rendererContext.cell.value ?? '-',
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
                          ],
                          rows: provider.rowsService,
                          onLoaded: (event) async {
                            provider.stateManager = event.stateManager;
                          },
                          createFooter: (stateManager) {
                            stateManager.setPageSize(provider.pageRowCount);
                            stateManager.setPage(provider.page);
                            return const SizedBox(height: 0, width: 0);
                          },
                        ),
                      ))
                ],
              )),
        ],
      ),
    );
  }
}
