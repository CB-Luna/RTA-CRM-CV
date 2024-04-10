import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:provider/provider.dart';
import 'package:rta_crm_cv/functions/money_format.dart';

import 'package:rta_crm_cv/functions/sizes.dart';
import 'package:rta_crm_cv/helpers/constants.dart';
import 'package:rta_crm_cv/helpers/globals.dart';
import 'package:rta_crm_cv/pages/crm/quotes/create_order.dart';
import 'package:rta_crm_cv/providers/crm/accounts/tabs/order_provider.dart';
import 'package:rta_crm_cv/providers/crm/quote/quotes_provider.dart';
import 'package:rta_crm_cv/providers/crm/quote/create_quote_provider.dart';
import 'package:rta_crm_cv/providers/crm/quote/detail_quote_provider.dart';
import 'package:rta_crm_cv/providers/crm/quote/validate_quote_provider.dart';
import 'package:rta_crm_cv/public/colors.dart';
import 'package:rta_crm_cv/theme/theme.dart';
import 'package:rta_crm_cv/widgets/custom_card.dart';
import 'package:rta_crm_cv/widgets/custom_icon_button.dart';
import 'package:rta_crm_cv/widgets/captura/custom_text_field.dart';
import 'package:rta_crm_cv/widgets/custom_scrollbar.dart';
import 'package:rta_crm_cv/widgets/custom_text_icon_button.dart';
import 'package:rta_crm_cv/widgets/loading_toast.dart';
import 'package:rta_crm_cv/widgets/pluto_grid_cells/custom_textcell.dart';
import 'package:rta_crm_cv/widgets/pluto_grid_cells/pluto_grid_status_cell.dart';

class QuotesTab extends StatefulWidget {
  const QuotesTab({super.key, int? index});

  @override
  State<QuotesTab> createState() => _QuotesTabState();
}

late int index;

class _QuotesTabState extends State<QuotesTab> {
  @override
  void initState() {
    super.initState();

    /*  WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final QuotesProvider provider = Provider.of<QuotesProvider>(
        context,
        listen: false,
      );
      await provider.updateState();
    }); */
  }

  FToast fToast = FToast();

  @override
  Widget build(BuildContext context) {
    fToast.init(context);

    QuotesProvider provider = Provider.of<QuotesProvider>(context);
    DetailQuoteProvider detailProvider = Provider.of<DetailQuoteProvider>(context);
    CreateQuoteProvider providerCreate = Provider.of<CreateQuoteProvider>(context);
    ValidateQuoteProvider providerValidate = Provider.of<ValidateQuoteProvider>(context);
    OrdersProvider ordersProvider = Provider.of<OrdersProvider>(context);

    return CustomCard(
      title: 'Order List',
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(
                  width: 250,
                  child: Row(
                    children: [
                      CustomTextIconButton(
                        isLoading: false,
                        icon: Icon(Icons.filter_alt_outlined, color: AppTheme.of(context).primaryBackground),
                        text: 'Filter',
                        onTap: () => provider.stateManager!.setShowColumnFilter(!provider.stateManager!.showColumnFilter),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: CustomTextIconButton(
                          isLoading: false,
                          icon: Icon(Icons.view_column_outlined, color: AppTheme.of(context).primaryBackground),
                          text: 'Set Columns',
                          onTap: () => provider.stateManager!.showSetColumnsPopup(context),
                        ),
                      ),
                    ],
                  ),
                ),
                CustomTextField(
                  width: 500,
                  enabled: true,
                  controller: provider.searchController,
                  icon: Icons.search,
                  label: 'Search',
                  keyboardType: TextInputType.text,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20, left: 20),
                  child: SizedBox(
                    width: getWidth(580, context),
                    child: CustomScrollBar(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          //filtros validate
                          if (provider.indexSelected[13] || provider.indexSelected[2] || provider.indexSelected[3] || provider.indexSelected[4] && currentUser!.isSales)
                            Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: CustomTextIconButton(
                                      width: 100,
                                      isLoading: false,
                                      icon: Icon(provider.indexSelected[13] ? Icons.filter_alt : Icons.filter_alt_outlined, color: AppTheme.of(context).primaryBackground),
                                      text: 'All',
                                      color: AppTheme.of(context).primaryColor,
                                      onTap: () async {
                                        provider.setIndex(13);
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: CustomTextIconButton(
                                      width: 165,
                                      isLoading: false,
                                      icon: Icon(provider.indexSelected[2] ? Icons.filter_alt : Icons.filter_alt_outlined, color: AppTheme.of(context).primaryBackground),
                                      text: 'Sen. Exec. Validate',
                                      color: Colors.orangeAccent,
                                      onTap: () async {
                                        provider.setIndex(2);
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: CustomTextIconButton(
                                      width: 150,
                                      isLoading: false,
                                      icon: Icon(provider.indexSelected[3] ? Icons.filter_alt : Icons.filter_alt_outlined, color: AppTheme.of(context).primaryBackground),
                                      text: 'Finance Validate',
                                      color: Colors.orangeAccent,
                                      onTap: () async {
                                        provider.setIndex(3);
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: CustomTextIconButton(
                                      width: 160,
                                      isLoading: false,
                                      icon: Icon(provider.indexSelected[4] ? Icons.filter_alt : Icons.filter_alt_outlined, color: AppTheme.of(context).primaryBackground),
                                      text: 'Engineer Validate',
                                      color: Colors.orangeAccent,
                                      onTap: () async {
                                        provider.setIndex(4);
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          //filtros canceled y rejected
                          if (provider.indexSelected[14] || provider.indexSelected[5] || provider.indexSelected[12])
                            Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: CustomTextIconButton(
                                      width: 100,
                                      isLoading: false,
                                      icon: Icon(provider.indexSelected[14] ? Icons.filter_alt : Icons.filter_alt_outlined, color: AppTheme.of(context).primaryBackground),
                                      text: 'All',
                                      color: AppTheme.of(context).primaryColor,
                                      onTap: () async {
                                        provider.setIndex(14);
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: CustomTextIconButton(
                                      width: 150,
                                      isLoading: false,
                                      icon: Icon(provider.indexSelected[12] ? Icons.filter_alt : Icons.filter_alt_outlined, color: AppTheme.of(context).primaryBackground),
                                      text: 'Canceled',
                                      color: Colors.red,
                                      onTap: () async {
                                        provider.setIndex(12);
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: CustomTextIconButton(
                                      width: 165,
                                      isLoading: false,
                                      icon: Icon(provider.indexSelected[5] ? Icons.filter_alt : Icons.filter_alt_outlined, color: AppTheme.of(context).primaryBackground),
                                      text: 'Rejected',
                                      color: Colors.red,
                                      onTap: () async {
                                        provider.setIndex(5);
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          if (provider.indexSelected[15] || provider.indexSelected[9] || provider.indexSelected[10])
                            Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: CustomTextIconButton(
                                      width: 100,
                                      isLoading: false,
                                      icon: Icon(provider.indexSelected[15] ? Icons.filter_alt : Icons.filter_alt_outlined, color: AppTheme.of(context).primaryBackground),
                                      text: 'All',
                                      color: AppTheme.of(context).primaryColor,
                                      onTap: () async {
                                        provider.setIndex(15);
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: CustomTextIconButton(
                                      width: 210,
                                      isLoading: false,
                                      icon: Icon(provider.indexSelected[9] ? Icons.filter_alt : Icons.filter_alt_outlined, color: AppTheme.of(context).primaryBackground),
                                      text: 'Network Cross-Connected',
                                      color: Colors.black,
                                      onTap: () async {
                                        provider.setIndex(9);
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: CustomTextIconButton(
                                      width: 150,
                                      isLoading: false,
                                      icon: Icon(provider.indexSelected[10] ? Icons.filter_alt : Icons.filter_alt_outlined, color: AppTheme.of(context).primaryBackground),
                                      text: 'Network Issues',
                                      color: Colors.black,
                                      onTap: () async {
                                        provider.setIndex(10);
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),

                          CustomTextIconButton(
                            width: 90,
                            isLoading: false,
                            icon: Icon(Icons.file_download_outlined, color: AppTheme.of(context).primaryBackground),
                            text: 'Export',
                            color: AppTheme.of(context).primaryColor,
                            onTap: () async {
                              await provider.exportData();
                            },
                          ),

                          /* if (currentUser!.isSales)
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: CustomTextIconButton(
                                width: 131,
                                isLoading: false,
                                icon: Icon(Icons.add, color: AppTheme.of(context).primaryBackground),
                                text: 'Create Order',
                                color: AppTheme.of(context).tertiaryColor,
                                onTap: () async {
                                  await providerCreate.clearAll();
                                  providerCreate.idLead = null;
                                  // ignore: use_build_context_synchronously
                                  context.pushReplacement(routeQuoteCreation);
                                },
                              ),
                            ), */
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: getHeight(700, context),
            //width: getWidth(2450, context),
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
                    if (column.field == 'ID_Column') {
                      return resolver<PlutoFilterTypeContains>() as PlutoFilterType;
                    } else if (column.field == 'ACCOUNT_Column') {
                      return resolver<PlutoFilterTypeContains>() as PlutoFilterType;
                    } else if (column.field == 'NAME_Column') {
                      return resolver<PlutoFilterTypeContains>() as PlutoFilterType;
                    } else if (column.field == 'TOTAL_Column') {
                      return resolver<PlutoFilterTypeContains>() as PlutoFilterType;
                    } else if (column.field == 'MARGIN_Column') {
                      return resolver<PlutoFilterTypeContains>() as PlutoFilterType;
                    } else if (column.field == 'VENDOR_Column') {
                      return resolver<PlutoFilterTypeContains>() as PlutoFilterType;
                    } else if (column.field == 'DATACENTER_Column') {
                      return resolver<PlutoFilterTypeContains>() as PlutoFilterType;
                    } else if (column.field == 'ORDER_Column') {
                      return resolver<PlutoFilterTypeContains>() as PlutoFilterType;
                    } else if (column.field == 'DESCRIPTION_Column') {
                      return resolver<PlutoFilterTypeContains>() as PlutoFilterType;
                    } else if (column.field == 'PROBABILITY_Column') {
                      return resolver<PlutoFilterTypeContains>() as PlutoFilterType;
                    } else if (column.field == 'CLOSED_Column') {
                      return resolver<PlutoFilterTypeContains>() as PlutoFilterType;
                    } else if (column.field == 'ASSIGNED_Column') {
                      return resolver<PlutoFilterTypeContains>() as PlutoFilterType;
                    } else if (column.field == 'LAST_Column') {
                      return resolver<PlutoFilterTypeContains>() as PlutoFilterType;
                    } else if (column.field == 'STATUS_Column') {
                      return resolver<PlutoFilterTypeContains>() as PlutoFilterType;
                    }
                    return resolver<PlutoFilterTypeContains>() as PlutoFilterType;
                  },
                ),
              ),
              columns: [
                PlutoColumn(
                  titleSpan: TextSpan(children: [
                    WidgetSpan(child: Icon(Icons.vpn_key_outlined, color: AppTheme.of(context).primaryBackground)),
                    const WidgetSpan(child: SizedBox(width: 10)),
                    TextSpan(text: 'ID', style: AppTheme.of(context).encabezadoTablas)
                  ]),
                  backgroundColor: const Color(0XFF6491F7),
                  title: 'ID',
                  field: 'ID_Column',
                  titleTextAlign: PlutoColumnTextAlign.start,
                  textAlign: PlutoColumnTextAlign.center,
                  type: PlutoColumnType.text(),
                  enableRowDrag: false,
                  enableDropToResize: false,
                  enableEditingMode: false,
                  width: 175,
                  cellPadding: EdgeInsets.zero,
                  renderer: (rendererContext) {
                    return Container(
                      height: rowHeight,
                      // width: rendererContext.cell.column.width,
                      decoration: BoxDecoration(gradient: whiteGradient),
                      child: Center(
                        child: Text(
                          rendererContext.cell.value.toString(),
                          style: AppTheme.of(context).contenidoTablas.override(fontFamily: 'Gotham-Regular', useGoogleFonts: false, color: AppTheme.of(context).primaryColor),
                        ),
                      ),
                    );
                  },
                  footerRenderer: (context) {
                    return SizedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(width: 10),
                          Text(
                            provider.rows.length.toString(),
                            style: const TextStyle(color: Colors.white),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            provider.rows.length == 1 ? 'Row' : 'Rows',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                if (currentUser!.isSales || currentUser!.isOpperations)
                  PlutoColumn(
                    titleSpan: TextSpan(children: [
                      WidgetSpan(child: Icon(Icons.traffic_outlined, color: AppTheme.of(context).primaryBackground)),
                      const WidgetSpan(child: SizedBox(width: 10)),
                      TextSpan(text: 'Status', style: AppTheme.of(context).encabezadoTablas)
                    ]),
                    backgroundColor: const Color(0XFF6491F7),
                    title: 'STATUS',
                    field: 'STATUS_Column',
                    width: 175,
                    titleTextAlign: PlutoColumnTextAlign.start,
                    textAlign: PlutoColumnTextAlign.center,
                    type: PlutoColumnType.text(),
                    enableEditingMode: false,
                    cellPadding: EdgeInsets.zero,
                    renderer: (rendererContext) {
                      return PlutoGridStatusCell(
                        text: rendererContext.row.cells["STATUS_Column"]!.value,
                        id: rendererContext.row.cells["ID_STATUS_Column"]!.value,
                      );
                    },
                    footerRenderer: (context) {
                      return SizedBox(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomIconButton(
                              icon: Icons.keyboard_arrow_down_outlined,
                              toolTip: 'less',
                              onTap: () {
                                provider.setPageSize('less');
                              },
                            ),
                            const SizedBox(width: 10),
                            Text(
                              provider.pageRowCount.toString(),
                              style: const TextStyle(color: Colors.white),
                            ),
                            const SizedBox(width: 10),
                            CustomIconButton(
                              icon: Icons.keyboard_arrow_up_outlined,
                              toolTip: 'more',
                              onTap: () {
                                provider.setPageSize('more');
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                PlutoColumn(
                  titleSpan: TextSpan(children: [
                    WidgetSpan(child: Icon(Icons.list, color: AppTheme.of(context).primaryBackground)),
                    const WidgetSpan(child: SizedBox(width: 10)),
                    TextSpan(text: 'Actions', style: AppTheme.of(context).encabezadoTablas)
                  ]),
                  backgroundColor: const Color(0XFF6491F7),
                  title: 'ACTIONS',
                  field: 'ACTIONS_Column',
                  width: 250,
                  titleTextAlign: PlutoColumnTextAlign.start,
                  textAlign: PlutoColumnTextAlign.center,
                  type: PlutoColumnType.text(),
                  enableEditingMode: false,
                  enableSorting: false,
                  enableContextMenu: false,
                  enableDropToResize: false,
                  cellPadding: EdgeInsets.zero,
                  renderer: (rendererContext) {
                    return Container(
                      height: rowHeight,
                      // width: rendererContext.cell.column.width,
                      decoration: BoxDecoration(gradient: whiteGradient),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          //if (rendererContext.row.cells["STATUS_Column"]!.value != 'Rejected')
                          if (currentUser!.isSales && rendererContext.row.cells["ID_STATUS_Column"]!.value == 1) //Draft
                            CustomTextIconButton(
                              isLoading: false,
                              icon: Icon(
                                Icons.assignment,
                                color: AppTheme.of(context).tertiaryColor,
                              ),
                              text: 'Fill Form',
                              color: AppTheme.of(context).primaryBackground,
                              style: TextStyle(
                                color: AppTheme.of(context).tertiaryColor,
                              ),
                              border: Border.all(color: AppTheme.of(context).tertiaryColor),
                              onTap: () async {
                                if (!provider.loadingGrid) {
                                  provider.loadingGrid = true;
                                  provider.stateManager!.setShowLoading(provider.loadingGrid);
                                  await providerCreate.getRowData(rendererContext.row.cells["ID_Column"]!.value);
                                  // ignore: use_build_context_synchronously
                                  context.pushReplacement(routeQuoteCreation);
                                  provider.loadingGrid = false;
                                  provider.stateManager!.setShowLoading(provider.loadingGrid);
                                } else {
                                  fToast.showToast(
                                    child: const LoadingToast(
                                      message: 'Loading',
                                    ),
                                    gravity: ToastGravity.BOTTOM,
                                    toastDuration: const Duration(seconds: 1),
                                  );
                                }
                              },
                            ),
                          if (rendererContext.row.cells["ID_STATUS_Column"]!.value != 1) //Sales Form
                            CustomTextIconButton(
                              isLoading: false,
                              icon: Icon(
                                Icons.remove_red_eye_outlined,
                                color: AppTheme.of(context).primaryBackground,
                              ),
                              text: 'Details',
                              onTap: () async {
                                if (!provider.loadingGrid) {
                                  provider.loadingGrid = true;
                                  provider.stateManager!.setShowLoading(provider.loadingGrid);
                                  await detailProvider.getDataV2(rendererContext.row.cells['ID_Column']!.value);
                                  // ignore: use_build_context_synchronously
                                  context.pushReplacement(routeQuoteDetail);
                                  provider.loadingGrid = false;
                                  provider.stateManager!.setShowLoading(provider.loadingGrid);
                                } else {
                                  fToast.showToast(
                                    child: const LoadingToast(
                                      message: 'Loading',
                                    ),
                                    gravity: ToastGravity.BOTTOM,
                                    toastDuration: const Duration(seconds: 1),
                                  );
                                }
                              },
                            ),
                          if (currentUser!.isSales && rendererContext.row.cells["ID_STATUS_Column"]!.value == 5) //Rejected
                            CustomTextIconButton(
                              isLoading: false,
                              icon: Icon(
                                Icons.assignment,
                                color: AppTheme.of(context).tertiaryColor,
                              ),
                              text: 'Fill Form',
                              color: AppTheme.of(context).primaryBackground,
                              style: TextStyle(
                                color: AppTheme.of(context).tertiaryColor,
                              ),
                              border: Border.all(color: AppTheme.of(context).tertiaryColor),
                              onTap: () async {
                                if (!provider.loadingGrid) {
                                  provider.loadingGrid = true;
                                  provider.stateManager!.setShowLoading(provider.loadingGrid);
                                  await providerCreate.getRowData(rendererContext.row.cells["ID_Column"]!.value);
                                  // ignore: use_build_context_synchronously
                                  context.pushReplacement(routeQuoteCreation);
                                  provider.loadingGrid = false;
                                  provider.stateManager!.setShowLoading(provider.loadingGrid);
                                } else {
                                  fToast.showToast(
                                    child: const LoadingToast(
                                      message: 'Loading',
                                    ),
                                    gravity: ToastGravity.BOTTOM,
                                    toastDuration: const Duration(seconds: 1),
                                  );
                                }
                              },
                            ),
                          if (currentUser!.isSales && rendererContext.row.cells["ID_STATUS_Column"]!.value == 7) //Approved
                            CustomTextIconButton(
                              isLoading: false,
                              icon: Icon(
                                Icons.add,
                                color: AppTheme.of(context).tertiaryColor,
                              ),
                              style: TextStyle(color: AppTheme.of(context).tertiaryColor),
                              border: Border.all(color: AppTheme.of(context).tertiaryColor),
                              color: AppTheme.of(context).primaryBackground,
                              text: 'Create Order',
                              onTap: () async {
                                if (!provider.loadingGrid) {
                                  provider.loadingGrid = true;
                                  provider.stateManager!.setShowLoading(provider.loadingGrid);

                                  //Change to status 'Order Created'
                                  await ordersProvider.getData(rendererContext.row.cells['ID_Column']!.value);

                                  provider.loadingGrid = false;
                                  provider.stateManager!.setShowLoading(provider.loadingGrid);

                                  // ignore: use_build_context_synchronously
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return CreateOrder(id: rendererContext.row.cells["ID_Column"]!.value);
                                    },
                                  );
                                } else {
                                  fToast.showToast(
                                    child: const LoadingToast(
                                      message: 'Loading',
                                    ),
                                    gravity: ToastGravity.BOTTOM,
                                    toastDuration: const Duration(seconds: 1),
                                  );
                                }
                              },
                            ),
                          if (currentUser!.isSales && rendererContext.row.cells["ID_STATUS_Column"]!.value == 8) //Order Created
                            CustomTextIconButton(
                              isLoading: false,
                              icon: Icon(
                                Icons.add,
                                color: AppTheme.of(context).tertiaryColor,
                              ),
                              text: 'Cross Connect',
                              color: AppTheme.of(context).primaryBackground,
                              style: TextStyle(
                                color: AppTheme.of(context).tertiaryColor,
                              ),
                              border: Border.all(color: AppTheme.of(context).tertiaryColor),
                              onTap: () async {
                                if (!provider.loadingGrid) {
                                  provider.loadingGrid = true;
                                  provider.stateManager!.setShowLoading(provider.loadingGrid);

                                  //Change to status 'Order Created'
                                  await supabaseCRM.rpc(
                                    'update_quote_status',
                                    params: {"id_status": 9, "id": rendererContext.row.cells["ID_Column"]!.value, "user_uuid": currentUser!.id}, //Network Cross Connected
                                  );
                                  await provider.getX2Quotes(null);

                                  provider.loadingGrid = false;
                                  provider.stateManager!.setShowLoading(provider.loadingGrid);
                                } else {
                                  fToast.showToast(
                                    child: const LoadingToast(
                                      message: 'Loading',
                                    ),
                                    gravity: ToastGravity.BOTTOM,
                                    toastDuration: const Duration(seconds: 1),
                                  );
                                }
                              },
                            ),
                          if (currentUser!.isSenExec && rendererContext.row.cells["ID_STATUS_Column"]!.value == 2) //Sen. Exec. Validate
                            CustomTextIconButton(
                              isLoading: false,
                              icon: Icon(
                                Icons.fact_check_outlined,
                                color: AppTheme.of(context).primaryBackground,
                              ),
                              text: 'Validate',
                              onTap: () async {
                                if (!provider.loadingGrid) {
                                  provider.loadingGrid = true;
                                  provider.stateManager!.setShowLoading(provider.loadingGrid);
                                  await providerValidate.getDataV2(rendererContext.row.cells['ID_Column']!.value);
                                  // ignore: use_build_context_synchronously
                                  context.pushReplacement(routeQuoteValidation);
                                  provider.loadingGrid = false;
                                  provider.stateManager!.setShowLoading(provider.loadingGrid);
                                } else {
                                  fToast.showToast(
                                    child: const LoadingToast(
                                      message: 'Loading',
                                    ),
                                    gravity: ToastGravity.BOTTOM,
                                    toastDuration: const Duration(seconds: 1),
                                  );
                                }
                              },
                            ),
                          if (currentUser!.isFinance && rendererContext.row.cells["ID_STATUS_Column"]!.value == 3) //Finance Validate
                            CustomTextIconButton(
                              isLoading: false,
                              icon: Icon(
                                Icons.search,
                                color: AppTheme.of(context).primaryBackground,
                              ),
                              text: 'Validate',
                              onTap: () async {
                                if (!provider.loadingGrid) {
                                  provider.loadingGrid = true;
                                  provider.stateManager!.setShowLoading(provider.loadingGrid);
                                  await providerValidate.getDataV2(rendererContext.row.cells['ID_Column']!.value);
                                  // ignore: use_build_context_synchronously
                                  context.pushReplacement(routeQuoteValidation);
                                  provider.loadingGrid = false;
                                  provider.stateManager!.setShowLoading(provider.loadingGrid);
                                } else {
                                  fToast.showToast(
                                    child: const LoadingToast(
                                      message: 'Loading',
                                    ),
                                    gravity: ToastGravity.BOTTOM,
                                    toastDuration: const Duration(seconds: 1),
                                  );
                                }
                              },
                            ),
                          if (currentUser!.isOpperations && rendererContext.row.cells["ID_STATUS_Column"]!.value == 4) //Engineer Validate
                            CustomTextIconButton(
                              isLoading: false,
                              icon: Icon(
                                Icons.search,
                                color: AppTheme.of(context).primaryBackground,
                              ),
                              text: 'Validate',
                              onTap: () async {
                                if (!provider.loadingGrid) {
                                  provider.loadingGrid = true;
                                  provider.stateManager!.setShowLoading(provider.loadingGrid);
                                  await providerValidate.getDataV2(rendererContext.row.cells['ID_Column']!.value);
                                  // ignore: use_build_context_synchronously
                                  context.pushReplacement(routeQuoteValidation);
                                  provider.loadingGrid = false;
                                  provider.stateManager!.setShowLoading(provider.loadingGrid);
                                } else {
                                  fToast.showToast(
                                    child: const LoadingToast(
                                      message: 'Loading',
                                    ),
                                    gravity: ToastGravity.BOTTOM,
                                    toastDuration: const Duration(seconds: 1),
                                  );
                                }
                              },
                            ),
                          /* CustomTextIconButton(isLoading: false,
                            icon: Icon(
                              Icons.shopping_basket_outlined,
                              color: AppTheme.of(context).primaryBackground,
                            ),
                            color: secondaryColor,
                            text: 'Delete',
                            onTap: () {},
                          ), */
                          /* InkWell(
                                              hoverColor: Colors.transparent,
                                              child: Icon(
                                                Icons.fact_check_outlined,
                                                size: 25,
                                                color: textColor,
                                              ),
                                              onTap: () {},
                                            ),
                                            InkWell(
                                              hoverColor: Colors.transparent,
                                              child: Icon(
                                                Icons.shopping_basket_outlined,
                                                size: 25,
                                                color: textColor,
                                              ),
                                              onTap: () {},
                                            ) */
                        ],
                      ),
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
                            icon: Icons.keyboard_arrow_left_outlined,
                            toolTip: 'previous',
                            onTap: () {
                              provider.setPage('previous');
                            },
                          ),
                          const SizedBox(width: 5),
                          SizedBox(width: 30, child: Center(child: Text(provider.page.toString(), style: const TextStyle(color: Colors.white)))),
                          const SizedBox(width: 5),
                          CustomIconButton(
                            icon: Icons.keyboard_arrow_right_outlined,
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
                  },
                ),
                PlutoColumn(
                  titleSpan: TextSpan(children: [
                    WidgetSpan(child: Icon(Icons.location_city_outlined, color: AppTheme.of(context).primaryBackground)),
                    const WidgetSpan(child: SizedBox(width: 10)),
                    TextSpan(text: 'Account', style: AppTheme.of(context).encabezadoTablas)
                  ]),
                  backgroundColor: const Color(0XFF6491F7),
                  title: 'ACCOUNT',
                  field: 'ACCOUNT_Column',
                  width: 225,
                  titleTextAlign: PlutoColumnTextAlign.start,
                  textAlign: PlutoColumnTextAlign.start,
                  type: PlutoColumnType.text(),
                  enableEditingMode: false,
                  cellPadding: EdgeInsets.zero,
                  renderer: (rendererContext) {
                    return Container(
                      height: rowHeight,
                      // width: rendererContext.cell.column.width,
                      decoration: BoxDecoration(gradient: whiteGradient),
                      child: CustomTextCell(
                        text: rendererContext.cell.value,
                        textAlign: TextAlign.start,
                      ),
                    );
                  },
                ),
                PlutoColumn(
                  titleSpan: TextSpan(children: [
                    WidgetSpan(child: Icon(Icons.person_outline, color: AppTheme.of(context).primaryBackground)),
                    const WidgetSpan(child: SizedBox(width: 10)),
                    TextSpan(text: 'Name', style: AppTheme.of(context).encabezadoTablas)
                  ]),
                  backgroundColor: const Color(0XFF6491F7),
                  title: 'NAME',
                  field: 'NAME_Column',
                  width: 225,
                  titleTextAlign: PlutoColumnTextAlign.start,
                  textAlign: PlutoColumnTextAlign.center,
                  type: PlutoColumnType.text(),
                  enableEditingMode: false,
                  cellPadding: EdgeInsets.zero,
                  renderer: (rendererContext) {
                    return Container(
                      height: rowHeight,
                      // width: rendererContext.cell.column.width,
                      decoration: BoxDecoration(gradient: whiteGradient),
                      child: CustomTextCell(
                        text: rendererContext.cell.value,
                        textAlign: TextAlign.start,
                      ),
                    );
                  },
                ),
                PlutoColumn(
                  titleSpan: TextSpan(children: [
                    WidgetSpan(child: Icon(Icons.attach_money, color: AppTheme.of(context).primaryBackground)),
                    const WidgetSpan(child: SizedBox(width: 10)),
                    TextSpan(text: 'Total', style: AppTheme.of(context).encabezadoTablas)
                  ]),
                  backgroundColor: const Color(0XFF6491F7),
                  title: 'TOTAL',
                  field: 'TOTAL_Column',
                  width: 225,
                  titleTextAlign: PlutoColumnTextAlign.start,
                  textAlign: PlutoColumnTextAlign.end,
                  type: PlutoColumnType.number(),
                  enableEditingMode: false,
                  cellPadding: EdgeInsets.zero,
                  renderer: (rendererContext) {
                    return Container(
                      height: rowHeight,
                      // width: rendererContext.cell.column.width,
                      decoration: BoxDecoration(gradient: whiteGradient),
                      child: CustomTextCell(
                        text: '\$ ${moneyFormat(rendererContext.cell.value)} USD',
                        textAlign: TextAlign.end,
                      ),
                    );
                  },
                ),
                PlutoColumn(
                  titleSpan: TextSpan(children: [
                    WidgetSpan(child: Icon(Icons.percent_outlined, color: AppTheme.of(context).primaryBackground)),
                    const WidgetSpan(child: SizedBox(width: 10)),
                    TextSpan(text: 'Margin', style: AppTheme.of(context).encabezadoTablas)
                  ]),
                  backgroundColor: const Color(0XFF6491F7),
                  title: 'MARGIN',
                  field: 'MARGIN_Column',
                  width: 150,
                  titleTextAlign: PlutoColumnTextAlign.start,
                  textAlign: PlutoColumnTextAlign.center,
                  type: PlutoColumnType.text(),
                  enableEditingMode: false,
                  cellPadding: EdgeInsets.zero,
                  renderer: (rendererContext) {
                    return Container(
                      height: rowHeight,
                      // width: rendererContext.cell.column.width,
                      decoration: BoxDecoration(gradient: whiteGradient),
                      child: CustomTextCell(
                        text: rendererContext.cell.value != null ? '${moneyFormat(rendererContext.cell.value)}%' : '-',
                        textAlign: TextAlign.end,
                      ),
                    );
                  },
                ),
                PlutoColumn(
                  titleSpan: TextSpan(children: [
                    WidgetSpan(child: Icon(Icons.person_outline, color: AppTheme.of(context).primaryBackground)),
                    const WidgetSpan(child: SizedBox(width: 10)),
                    TextSpan(text: 'Vendor', style: AppTheme.of(context).encabezadoTablas)
                  ]),
                  backgroundColor: const Color(0XFF6491F7),
                  title: 'VENDOR',
                  field: 'VENDOR_Column',
                  width: 150,
                  titleTextAlign: PlutoColumnTextAlign.start,
                  textAlign: PlutoColumnTextAlign.center,
                  type: PlutoColumnType.text(),
                  enableEditingMode: false,
                  cellPadding: EdgeInsets.zero,
                  renderer: (rendererContext) {
                    return Container(
                      height: rowHeight,
                      // width: rendererContext.cell.column.width,
                      decoration: BoxDecoration(gradient: whiteGradient),
                      child: CustomTextCell(
                        text: rendererContext.cell.value,
                        textAlign: TextAlign.start,
                      ),
                    );
                  },
                ),
                PlutoColumn(
                  titleSpan: TextSpan(children: [
                    WidgetSpan(child: Icon(Icons.person_outline, color: AppTheme.of(context).primaryBackground)),
                    const WidgetSpan(child: SizedBox(width: 10)),
                    TextSpan(text: 'Datacenter', style: AppTheme.of(context).encabezadoTablas)
                  ]),
                  backgroundColor: const Color(0XFF6491F7),
                  title: 'DATACENTER',
                  field: 'DATACENTER_Column',
                  width: 180,
                  titleTextAlign: PlutoColumnTextAlign.start,
                  textAlign: PlutoColumnTextAlign.center,
                  type: PlutoColumnType.text(),
                  enableEditingMode: false,
                  cellPadding: EdgeInsets.zero,
                  renderer: (rendererContext) {
                    return Container(
                      height: rowHeight,
                      // width: rendererContext.cell.column.width,
                      decoration: BoxDecoration(gradient: whiteGradient),
                      child: CustomTextCell(
                        text: rendererContext.cell.value,
                        textAlign: TextAlign.start,
                      ),
                    );
                  },
                ),
                PlutoColumn(
                  titleSpan: TextSpan(children: [
                    WidgetSpan(child: Icon(Icons.person_outline, color: AppTheme.of(context).primaryBackground)),
                    const WidgetSpan(child: SizedBox(width: 10)),
                    TextSpan(text: 'Order', style: AppTheme.of(context).encabezadoTablas)
                  ]),
                  backgroundColor: const Color(0XFF6491F7),
                  title: 'ORDER',
                  field: 'ORDER_Column',
                  width: 225,
                  titleTextAlign: PlutoColumnTextAlign.start,
                  textAlign: PlutoColumnTextAlign.center,
                  type: PlutoColumnType.text(),
                  enableEditingMode: false,
                  cellPadding: EdgeInsets.zero,
                  renderer: (rendererContext) {
                    return Container(
                      height: rowHeight,
                      // width: rendererContext.cell.column.width,
                      decoration: BoxDecoration(gradient: whiteGradient),
                      child: CustomTextCell(
                        text: rendererContext.cell.value,
                        textAlign: TextAlign.start,
                      ),
                    );
                  },
                ),
                PlutoColumn(
                  titleSpan: TextSpan(children: [
                    WidgetSpan(child: Icon(Icons.person_outline, color: AppTheme.of(context).primaryBackground)),
                    const WidgetSpan(child: SizedBox(width: 10)),
                    TextSpan(text: 'Description', style: AppTheme.of(context).encabezadoTablas)
                  ]),
                  backgroundColor: const Color(0XFF6491F7),
                  title: 'DESCRIPTION',
                  field: 'DESCRIPTION_Column',
                  width: 225,
                  titleTextAlign: PlutoColumnTextAlign.start,
                  textAlign: PlutoColumnTextAlign.center,
                  type: PlutoColumnType.text(),
                  enableEditingMode: false,
                  cellPadding: EdgeInsets.zero,
                  renderer: (rendererContext) {
                    return Container(
                      height: rowHeight,
                      // width: rendererContext.cell.column.width,
                      decoration: BoxDecoration(gradient: whiteGradient),
                      child: CustomTextCell(
                        text: rendererContext.cell.value,
                        textAlign: TextAlign.start,
                      ),
                    );
                  },
                ),
                PlutoColumn(
                  titleSpan: TextSpan(children: [
                    WidgetSpan(child: Icon(Icons.percent_outlined, color: AppTheme.of(context).primaryBackground)),
                    const WidgetSpan(child: SizedBox(width: 10)),
                    TextSpan(text: 'Probability', style: AppTheme.of(context).encabezadoTablas)
                  ]),
                  backgroundColor: const Color(0XFF6491F7),
                  title: 'PROBABILITY',
                  field: 'PROBABILITY_Column',
                  width: 180,
                  titleTextAlign: PlutoColumnTextAlign.start,
                  textAlign: PlutoColumnTextAlign.center,
                  type: PlutoColumnType.text(),
                  enableEditingMode: false,
                  cellPadding: EdgeInsets.zero,
                  renderer: (rendererContext) {
                    return Container(
                      height: rowHeight,
                      // width: rendererContext.cell.column.width,
                      decoration: BoxDecoration(gradient: whiteGradient),
                      child: CustomTextCell(
                        text: rendererContext.cell.value != null ? '${moneyFormat(rendererContext.cell.value)}%' : '-',
                        textAlign: TextAlign.end,
                      ),
                    );
                  },
                ),
                PlutoColumn(
                  titleSpan: TextSpan(children: [
                    WidgetSpan(child: Icon(Icons.calendar_month_outlined, color: AppTheme.of(context).primaryBackground)),
                    const WidgetSpan(child: SizedBox(width: 10)),
                    TextSpan(text: 'Expected Close', style: AppTheme.of(context).encabezadoTablas)
                  ]),
                  backgroundColor: const Color(0XFF6491F7),
                  title: 'CLOSED',
                  field: 'CLOSED_Column',
                  width: 225,
                  titleTextAlign: PlutoColumnTextAlign.start,
                  textAlign: PlutoColumnTextAlign.center,
                  type: PlutoColumnType.date(format: 'MMMM, MM-dd-yyyy', headerFormat: 'MM-dd-yyyy'),
                  enableEditingMode: false,
                  cellPadding: EdgeInsets.zero,
                  renderer: (rendererContext) {
                    return Container(
                      height: rowHeight,
                      // width: rendererContext.cell.column.width,
                      decoration: BoxDecoration(gradient: whiteGradient),
                      child: CustomTextCell(
                        text: rendererContext.cell.value,
                        textAlign: TextAlign.start,
                      ),
                    );
                  },
                ),
                PlutoColumn(
                  titleSpan: TextSpan(children: [
                    WidgetSpan(child: Icon(Icons.local_offer_outlined, color: AppTheme.of(context).primaryBackground)),
                    const WidgetSpan(child: SizedBox(width: 10)),
                    TextSpan(text: 'Assigned To', style: AppTheme.of(context).encabezadoTablas)
                  ]),
                  backgroundColor: const Color(0XFF6491F7),
                  title: 'ASSIGNED',
                  field: 'ASSIGNED_Column',
                  width: 200,
                  titleTextAlign: PlutoColumnTextAlign.start,
                  textAlign: PlutoColumnTextAlign.center,
                  type: PlutoColumnType.text(),
                  enableEditingMode: false,
                  cellPadding: EdgeInsets.zero,
                  renderer: (rendererContext) {
                    return Container(
                      height: rowHeight,
                      // width: rendererContext.cell.column.width,
                      decoration: BoxDecoration(gradient: whiteGradient),
                      child: CustomTextCell(
                        text: rendererContext.cell.value,
                        textAlign: TextAlign.start,
                      ),
                    );
                  },
                ),
                PlutoColumn(
                  titleSpan: TextSpan(children: [
                    WidgetSpan(child: Icon(Icons.watch_later_outlined, color: AppTheme.of(context).primaryBackground)),
                    const WidgetSpan(child: SizedBox(width: 10)),
                    TextSpan(text: 'Last Activity', style: AppTheme.of(context).encabezadoTablas)
                  ]),
                  backgroundColor: const Color(0XFF6491F7),
                  title: 'LAST',
                  field: 'LAST_Column',
                  width: 200,
                  titleTextAlign: PlutoColumnTextAlign.start,
                  textAlign: PlutoColumnTextAlign.center,
                  type: PlutoColumnType.date(format: 'MMMM, MM-dd-yyyy', headerFormat: 'MM-dd-yyyy'),
                  enableEditingMode: false,
                  cellPadding: EdgeInsets.zero,
                  renderer: (rendererContext) {
                    return Container(
                      height: rowHeight,
                      // width: rendererContext.cell.column.width,
                      decoration: BoxDecoration(gradient: whiteGradient),
                      child: CustomTextCell(
                        text: rendererContext.cell.value,
                        textAlign: TextAlign.start,
                      ),
                    );
                  },
                ),
                PlutoColumn(
                  titleSpan: TextSpan(children: [
                    WidgetSpan(child: Icon(Icons.watch_later_outlined, color: AppTheme.of(context).primaryBackground)),
                    const WidgetSpan(child: SizedBox(width: 10)),
                    TextSpan(text: 'Actions', style: AppTheme.of(context).encabezadoTablas)
                  ]),
                  backgroundColor: const Color(0XFF6491F7),
                  title: 'ACTIONS',
                  field: 'ACTIONS',
                  width: 200,
                  titleTextAlign: PlutoColumnTextAlign.start,
                  textAlign: PlutoColumnTextAlign.center,
                  type: PlutoColumnType.text(),
                  enableEditingMode: false,
                  cellPadding: EdgeInsets.zero,
                  renderer: (rendererContext) {
                    return rendererContext.row.cells["ID_STATUS_Column"]!.value == 1
                        ? Container(
                            height: rowHeight,
                            // width: rendererContext.cell.column.width,
                            decoration: BoxDecoration(gradient: whiteGradient),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                CustomTextIconButton(
                                  isLoading: false,
                                  icon: Icon(
                                    Icons.shopping_basket_outlined,
                                    color: AppTheme.of(context).primaryBackground,
                                  ),
                                  color: secondaryColor,
                                  text: 'Delete',
                                  onTap: () async {
                                    provider.deleteDraft(rendererContext.row.cells['ID_Column']!.value);
                                  },
                                ),
                              ],
                            ),
                          )
                        : Container(
                            height: rowHeight,
                            decoration: BoxDecoration(gradient: whiteGradient),
                          );
                  },
                )
              ],
              rows: provider.rows,
              onLoaded: (event) async {
                event.stateManager.setShowLoading(provider.loadingGrid);
                provider.stateManager = event.stateManager;
              },
              createFooter: (stateManager) {
                stateManager.setPageSize(provider.pageRowCount);
                stateManager.setPage(provider.page);
                return const SizedBox(height: 0, width: 0);
              },
            ),
          ),
        ],
      ),
    );
  }
}
