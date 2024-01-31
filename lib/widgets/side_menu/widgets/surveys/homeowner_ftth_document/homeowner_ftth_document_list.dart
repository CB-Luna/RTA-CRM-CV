// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:provider/provider.dart';
import 'package:rta_crm_cv/helpers/constants.dart';
import 'package:rta_crm_cv/helpers/globals.dart';
import 'package:rta_crm_cv/providers/ctrlv/homeowner_ftth_document_provider.dart';
import 'package:rta_crm_cv/public/colors.dart';
import 'package:rta_crm_cv/theme/theme.dart';
import 'package:rta_crm_cv/widgets/captura/custom_text_field.dart';
import 'package:rta_crm_cv/widgets/custom_card.dart';
import 'package:rta_crm_cv/widgets/custom_icon_button.dart';
import 'package:rta_crm_cv/widgets/custom_scrollbar.dart';
import 'package:rta_crm_cv/widgets/custom_text_icon_button.dart';
import 'package:rta_crm_cv/widgets/side_menu/sidemenu.dart';
import 'package:rta_crm_cv/widgets/side_menu/widgets/surveys/homeowner_ftth_document/widgets/pdf_popup.dart';

class HomeOwnerFTTHDocumentList extends StatefulWidget {
  const HomeOwnerFTTHDocumentList({super.key});

  @override
  State<HomeOwnerFTTHDocumentList> createState() => _HomeOwnerFTTHDocumentListState();
}

class _HomeOwnerFTTHDocumentListState extends State<HomeOwnerFTTHDocumentList> {
  bool hover = false;
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final HomeownerFTTHDocumentProvider provider = Provider.of<HomeownerFTTHDocumentProvider>(
        context,
        listen: false,
      );
      await provider.getHomeowner();
      await provider.clearAll();
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width / 1440;
    double height = MediaQuery.of(context).size.height / 1024;
    HomeownerFTTHDocumentProvider provider = Provider.of<HomeownerFTTHDocumentProvider>(context);
    return Material(
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SideMenu(),
            Flexible(
              child: Container(
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(gradient: whiteGradient),
                child: CustomScrollBar(
                  scrollDirection: Axis.vertical,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: CustomCard(
                      width: width * 1400,
                      title: 'Document List',
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
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
                                  child: CustomTextIconButton(
                                    width: width * 150,
                                    isLoading: false,
                                    icon: Icon(Icons.add, color: AppTheme.of(context).primaryBackground),
                                    text: 'Create Document',
                                    color: AppTheme.of(context).primaryColor,
                                    onTap: () async {
                                      context.pushReplacement(homeownerFTTHDocument);
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          provider.rows.isEmpty
                              ? const CircularProgressIndicator()
                              : SizedBox(
                                  height: height * 762,
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
                                          } else if (column.field == 'Name_Column') {
                                            return resolver<PlutoFilterTypeContains>() as PlutoFilterType;
                                          } else if (column.field == 'Creation_Date_Column') {
                                            return resolver<PlutoFilterTypeContains>() as PlutoFilterType;
                                          } else if (column.field == 'Due_Date_Column') {
                                            return resolver<PlutoFilterTypeContains>() as PlutoFilterType;
                                          } else if (column.field == 'Status_Column') {
                                            return resolver<PlutoFilterTypeContains>() as PlutoFilterType;
                                          } else if (column.field == 'Document_Column') {
                                            return resolver<PlutoFilterTypeContains>() as PlutoFilterType;
                                          } else if (column.field == 'Actions_Column') {
                                            return resolver<PlutoFilterTypeContains>() as PlutoFilterType;
                                          }
                                          return resolver<PlutoFilterTypeContains>() as PlutoFilterType;
                                        },
                                      ),
                                    ),
                                    columns: [
                                      //ID
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
                                        width: width * 100,
                                        cellPadding: EdgeInsets.zero,
                                        renderer: (rendererContext) {
                                          return Container(
                                            height: rowHeight,
                                            // width: rendererContext.cell.column.width,
                                            decoration: BoxDecoration(gradient: whiteGradient),
                                            child: Center(
                                              child: Text(
                                                rendererContext.cell.value.toString(),
                                                style: AppTheme.of(context).contenidoTablas,
                                              ),
                                            ),
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
                                      //name
                                      PlutoColumn(
                                        titleSpan: TextSpan(children: [
                                          WidgetSpan(child: Icon(Icons.person, color: AppTheme.of(context).primaryBackground)),
                                          const WidgetSpan(child: SizedBox(width: 10)),
                                          TextSpan(text: 'Customer Name', style: AppTheme.of(context).encabezadoTablas)
                                        ]),
                                        backgroundColor: const Color(0XFF6491F7),
                                        title: 'Customer Name',
                                        field: 'Customer_Name',
                                        titleTextAlign: PlutoColumnTextAlign.start,
                                        textAlign: PlutoColumnTextAlign.center,
                                        type: PlutoColumnType.text(),
                                        enableRowDrag: false,
                                        enableDropToResize: false,
                                        enableEditingMode: false,
                                        width: width * 250,
                                        cellPadding: EdgeInsets.zero,
                                        renderer: (rendererContext) {
                                          return Container(
                                            height: rowHeight,
                                            // width: rendererContext.cell.column.width,
                                            decoration: BoxDecoration(gradient: whiteGradient),
                                            child: Center(
                                              child: Text(
                                                rendererContext.cell.value.toString(),
                                                style: AppTheme.of(context).contenidoTablas,
                                              ),
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
                                      //Acount Name
                                      PlutoColumn(
                                        titleSpan: TextSpan(children: [
                                          WidgetSpan(child: Icon(Icons.account_box, color: AppTheme.of(context).primaryBackground)),
                                          const WidgetSpan(child: SizedBox(width: 10)),
                                          TextSpan(text: 'Acount Number', style: AppTheme.of(context).encabezadoTablas)
                                        ]),
                                        backgroundColor: const Color(0XFF6491F7),
                                        title: 'Customer_ID',
                                        field: 'Customer_ID',
                                        titleTextAlign: PlutoColumnTextAlign.start,
                                        textAlign: PlutoColumnTextAlign.center,
                                        type: PlutoColumnType.text(),
                                        enableRowDrag: false,
                                        enableDropToResize: false,
                                        enableEditingMode: false,
                                        width: width * 220,
                                        cellPadding: EdgeInsets.zero,
                                        renderer: (rendererContext) {
                                          return Container(
                                            height: rowHeight,
                                            // width: rendererContext.cell.column.width,
                                            decoration: BoxDecoration(gradient: whiteGradient),
                                            child: Center(
                                              child: Text(
                                                rendererContext.cell.value.toString(),
                                                style: AppTheme.of(context).contenidoTablas,
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                      //email
                                      PlutoColumn(
                                        titleSpan: TextSpan(children: [
                                          WidgetSpan(child: Icon(Icons.email, color: AppTheme.of(context).primaryBackground)),
                                          const WidgetSpan(child: SizedBox(width: 10)),
                                          TextSpan(text: 'Email', style: AppTheme.of(context).encabezadoTablas)
                                        ]),
                                        backgroundColor: const Color(0XFF6491F7),
                                        title: 'email',
                                        field: 'email',
                                        titleTextAlign: PlutoColumnTextAlign.start,
                                        textAlign: PlutoColumnTextAlign.center,
                                        type: PlutoColumnType.text(),
                                        enableRowDrag: false,
                                        enableDropToResize: false,
                                        enableEditingMode: false,
                                        width: width * 250,
                                        cellPadding: EdgeInsets.zero,
                                        renderer: (rendererContext) {
                                          return Container(
                                            height: rowHeight,
                                            // width: rendererContext.cell.column.width,
                                            decoration: BoxDecoration(gradient: whiteGradient),
                                            child: Center(
                                              child: Text(
                                                rendererContext.cell.value.toString(),
                                                style: AppTheme.of(context).contenidoTablas,
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                      //file name
                                      /* PlutoColumn(
                                        titleSpan: TextSpan(children: [
                                          WidgetSpan(child: Icon(Icons.person, color: AppTheme.of(context).primaryBackground)),
                                          const WidgetSpan(child: SizedBox(width: 10)),
                                          TextSpan(text: 'File Name', style: AppTheme.of(context).encabezadoTablas)
                                        ]),
                                        backgroundColor: const Color(0XFF6491F7),
                                        title: 'Name',
                                        field: 'Name_Column',
                                        titleTextAlign: PlutoColumnTextAlign.start,
                                        textAlign: PlutoColumnTextAlign.center,
                                        type: PlutoColumnType.text(),
                                        enableRowDrag: false,
                                        enableDropToResize: false,
                                        enableEditingMode: false,
                                        width: width * 250,
                                        cellPadding: EdgeInsets.zero,
                                        renderer: (rendererContext) {
                                          return Container(
                                            height: rowHeight,
                                            // width: rendererContext.cell.column.width,
                                            decoration: BoxDecoration(gradient: whiteGradient),
                                            child: Center(
                                              child: Text(
                                                rendererContext.cell.value.toString(),
                                                style: AppTheme.of(context).contenidoTablas,
                                              ),
                                            ),
                                          );
                                        },
                                        
                                      ),
                                       */
                                      //Creation Name
                                      PlutoColumn(
                                        titleSpan: TextSpan(children: [
                                          WidgetSpan(child: Icon(Icons.calendar_month, color: AppTheme.of(context).primaryBackground)),
                                          const WidgetSpan(child: SizedBox(width: 10)),
                                          TextSpan(text: 'Creation Date', style: AppTheme.of(context).encabezadoTablas)
                                        ]),
                                        backgroundColor: const Color(0XFF6491F7),
                                        title: 'Creation Date',
                                        field: 'Creation_Date_Column',
                                        titleTextAlign: PlutoColumnTextAlign.start,
                                        textAlign: PlutoColumnTextAlign.center,
                                        type: PlutoColumnType.text(),
                                        enableRowDrag: false,
                                        enableDropToResize: false,
                                        enableEditingMode: false,
                                        width: width * 200,
                                        cellPadding: EdgeInsets.zero,
                                        renderer: (rendererContext) {
                                          return Container(
                                            height: rowHeight,
                                            // width: rendererContext.cell.column.width,
                                            decoration: BoxDecoration(gradient: whiteGradient),
                                            child: Center(
                                              child: Text(
                                                rendererContext.cell.value.toString(),
                                                style: AppTheme.of(context).contenidoTablas,
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                      //Due Date
                                      PlutoColumn(
                                        titleSpan: TextSpan(children: [
                                          WidgetSpan(child: Icon(Icons.calendar_month, color: AppTheme.of(context).primaryBackground)),
                                          const WidgetSpan(child: SizedBox(width: 10)),
                                          TextSpan(text: 'Due Date', style: AppTheme.of(context).encabezadoTablas)
                                        ]),
                                        backgroundColor: const Color(0XFF6491F7),
                                        title: 'Due Date',
                                        field: 'Due_Date_Column',
                                        titleTextAlign: PlutoColumnTextAlign.start,
                                        textAlign: PlutoColumnTextAlign.center,
                                        type: PlutoColumnType.text(),
                                        enableRowDrag: false,
                                        enableDropToResize: false,
                                        enableEditingMode: false,
                                        width: width * 200,
                                        cellPadding: EdgeInsets.zero,
                                        renderer: (rendererContext) {
                                          return Container(
                                            height: rowHeight,
                                            // width: rendererContext.cell.column.width,
                                            decoration: BoxDecoration(gradient: whiteGradient),
                                            child: Center(
                                              child: Text(
                                                rendererContext.cell.value.toString(),
                                                style: AppTheme.of(context).contenidoTablas,
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                      //Status
                                      PlutoColumn(
                                        titleSpan: TextSpan(children: [
                                          WidgetSpan(child: Icon(Icons.calendar_month, color: AppTheme.of(context).primaryBackground)),
                                          const WidgetSpan(child: SizedBox(width: 10)),
                                          TextSpan(text: 'Status', style: AppTheme.of(context).encabezadoTablas)
                                        ]),
                                        backgroundColor: const Color(0XFF6491F7),
                                        title: 'Status',
                                        field: 'Status_Column',
                                        titleTextAlign: PlutoColumnTextAlign.start,
                                        textAlign: PlutoColumnTextAlign.center,
                                        type: PlutoColumnType.text(),
                                        enableRowDrag: false,
                                        enableDropToResize: false,
                                        enableEditingMode: false,
                                        width: width * 150,
                                        cellPadding: EdgeInsets.zero,
                                        renderer: (rendererContext) {
                                          return Container(
                                            height: rowHeight,
                                            width: rendererContext.cell.column.width,
                                            decoration: BoxDecoration(gradient: whiteGradient),
                                            child: Center(
                                              child: Container(
                                                width: width * 120,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(22),
                                                  color: rendererContext.cell.value.toString() == '1'
                                                      ? Colors.green
                                                      : rendererContext.cell.value.toString() == '2'
                                                          ? Colors.amber
                                                          : Colors.red,
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(10),
                                                  child: Text(
                                                    rendererContext.cell.value.toString() == '1'
                                                        ? 'Signed'
                                                        : rendererContext.cell.value.toString() == '2'
                                                            ? 'Waiting'
                                                            : 'Expired',
                                                    style: AppTheme.of(context).contenidoTablas,
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                      //Document
                                      PlutoColumn(
                                        titleSpan: TextSpan(children: [
                                          WidgetSpan(child: Icon(Icons.calendar_month, color: AppTheme.of(context).primaryBackground)),
                                          const WidgetSpan(child: SizedBox(width: 10)),
                                          TextSpan(text: 'Document', style: AppTheme.of(context).encabezadoTablas)
                                        ]),
                                        backgroundColor: const Color(0XFF6491F7),
                                        title: 'Document',
                                        field: 'Document_Column',
                                        titleTextAlign: PlutoColumnTextAlign.start,
                                        textAlign: PlutoColumnTextAlign.center,
                                        type: PlutoColumnType.text(),
                                        enableRowDrag: false,
                                        enableDropToResize: false,
                                        enableEditingMode: false,
                                        width: width * 160,
                                        cellPadding: EdgeInsets.zero,
                                        renderer: (rendererContext) {
                                          return Container(
                                            height: rowHeight,
                                            // width: rendererContext.cell.column.width,
                                            decoration: BoxDecoration(gradient: whiteGradient),
                                            child: Center(
                                              child: IconButton(
                                                onPressed: () async {
                                                  await provider.pickDocument(rendererContext.row.cells["Name_Column"]!.value);
                                                  await showDialog(
                                                    context: context,
                                                    builder: (BuildContext context) {
                                                      return const PdfPopup();
                                                    },
                                                  );
                                                },
                                                tooltip: 'See File',
                                                icon: const Icon(Icons.picture_as_pdf),
                                                color: AppTheme.of(context).primaryColor,
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                      //Actions
                                      PlutoColumn(
                                        titleSpan: TextSpan(children: [
                                          WidgetSpan(child: Icon(Icons.calendar_month, color: AppTheme.of(context).primaryBackground)),
                                          const WidgetSpan(child: SizedBox(width: 10)),
                                          TextSpan(text: 'Actions', style: AppTheme.of(context).encabezadoTablas)
                                        ]),
                                        backgroundColor: const Color(0XFF6491F7),
                                        title: 'Actions',
                                        field: 'Actions_Column',
                                        titleTextAlign: PlutoColumnTextAlign.start,
                                        textAlign: PlutoColumnTextAlign.center,
                                        type: PlutoColumnType.text(),
                                        enableRowDrag: false,
                                        enableDropToResize: false,
                                        enableEditingMode: false,
                                        width: width * 150,
                                        cellPadding: EdgeInsets.zero,
                                        renderer: (rendererContext) {
                                          return Container(
                                              height: rowHeight,
                                              // width: rendererContext.cell.column.width,
                                              decoration: BoxDecoration(gradient: whiteGradient),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  IconButton(
                                                    onPressed: () async {
                                                      await provider.pickDocument(rendererContext.row.cells["Name_Column"]!.value);
                                                      await showDialog(
                                                        context: context,
                                                        builder: (BuildContext context) {
                                                          return const PdfPopup();
                                                        },
                                                      );
                                                    },
                                                    tooltip: 'Send Reminder',
                                                    icon: const Icon(Icons.email),
                                                    color: AppTheme.of(context).primaryColor,
                                                  ),
                                                  /*  Center(
                                                    child: IconButton(
                                                      onPressed: () async {
                                                        await provider.cancelDocument(rendererContext.row.cells["ID_Column"]!.value);
                                                      },
                                                      tooltip: 'Cancel',
                                                      icon: const Icon(Icons.cancel),
                                                      color: AppTheme.of(context).primaryColor,
                                                    ),
                                                  ),
                                                 */
                                                ],
                                              ));
                                        },
                                      ),
                                    ],
                                    rows: provider.rows,
                                    onLoaded: (event) async {
                                      event.stateManager.setShowLoading(provider.loadingGrid);
                                      provider.stateManager = event.stateManager;
                                      event.stateManager.sortDescending(PlutoColumn(title: 'ID', field: 'ID_Column', type: PlutoColumnType.number()));
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
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
