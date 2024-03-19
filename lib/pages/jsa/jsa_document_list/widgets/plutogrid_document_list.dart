// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:provider/provider.dart';
import 'package:rta_crm_cv/providers/jsa/jsa_document_list_provider.dart';

import '../../../../functions/sizes.dart';
import '../../../../helpers/constants.dart';
import '../../../../theme/theme.dart';
import '../../../../widgets/pluto_grid_cells/pluto_grid_cell_jsa_status_document_list.dart';
import 'pdf_popup_document_list.dart';

class PlutoGridDocumentList extends StatefulWidget {
  const PlutoGridDocumentList({required this.iDJSA, super.key});
  final int iDJSA;
  @override
  State<PlutoGridDocumentList> createState() => _PlutoGridDocumentListState();
}

class _PlutoGridDocumentListState extends State<PlutoGridDocumentList> {
  @override
  Widget build(BuildContext context) {
    JSADocumentListProvider provider =
        Provider.of<JSADocumentListProvider>(context);

    return Container(
      height: getHeight(300, context),
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: PlutoGrid(
        key: UniqueKey(),
        configuration: PlutoGridConfiguration(
          scrollbar: plutoGridScrollbarConfig(context),
          style: plutoGridStyleConfigJSA(context),
          columnFilter: PlutoGridColumnFilterConfig(
            filters: const [
              ...FilterHelper.defaultFilters,
            ],
            resolveDefaultColumnFilter: (column, resolver) {
              if (column.field == 'ID_Column') {
                return resolver<PlutoFilterTypeContains>() as PlutoFilterType;
              } else if (column.field == 'NAME_Column') {
                return resolver<PlutoFilterTypeContains>() as PlutoFilterType;
              } else if (column.field == 'ROLE_Column') {
                return resolver<PlutoFilterTypeContains>() as PlutoFilterType;
              } else if (column.field == 'STATUS_Column') {
                return resolver<PlutoFilterTypeContains>() as PlutoFilterType;
              } else if (column.field == 'DOCUMENT_Column') {
                return resolver<PlutoFilterTypeContains>() as PlutoFilterType;
              }
              return resolver<PlutoFilterTypeContains>() as PlutoFilterType;
            },
          ),
        ),
        columns: [
          PlutoColumn(
            titleSpan: const TextSpan(children: [
              TextSpan(
                  text: 'ID Employee',
                  style: TextStyle(
                      fontFamily: 'Inter', color: Colors.grey, fontSize: 14))
            ]),
            title: 'ID',
            field: 'ID_Column',
            titleTextAlign: PlutoColumnTextAlign.center,
            textAlign: PlutoColumnTextAlign.center,
            type: PlutoColumnType.text(),
            enableRowChecked: true,
            enableRowDrag: false,
            enableDropToResize: false,
            enableEditingMode: false,
            enableContextMenu: false,
            width: 300,
            cellPadding: EdgeInsets.zero,
            renderer: (rendererContext) {
              return Center(
                child: Text(
                  rendererContext.cell.value.toString(),
                  style: AppTheme.of(context).contenidoTablas.override(
                      fontFamily: 'Gotham-Regular',
                      useGoogleFonts: false,
                      color: AppTheme.of(context).primaryText),
                ),
              );
            },
          ),
          PlutoColumn(
            titleSpan: const TextSpan(children: [
              TextSpan(
                  text: 'Name',
                  style: TextStyle(
                      fontFamily: 'Inter', color: Colors.grey, fontSize: 14))
            ]),
            title: 'NAME',
            field: 'NAME_Column',
            titleTextAlign: PlutoColumnTextAlign.center,
            textAlign: PlutoColumnTextAlign.center,
            type: PlutoColumnType.text(),
            enableRowDrag: false,
            enableDropToResize: false,
            enableEditingMode: false,
            enableContextMenu: false,
            width: 300,
            cellPadding: EdgeInsets.zero,
            renderer: (rendererContext) {
              return Center(
                child: Text(
                  rendererContext.cell.value ?? "-",
                  style: AppTheme.of(context).contenidoTablas.override(
                      fontFamily: 'Gotham-Regular',
                      useGoogleFonts: false,
                      color: AppTheme.of(context).primaryText),
                ),
              );
            },
          ),
          PlutoColumn(
            titleSpan: const TextSpan(children: [
              TextSpan(
                  text: 'Role',
                  style: TextStyle(
                      fontFamily: 'Inter', color: Colors.grey, fontSize: 14))
            ]),
            title: 'ROLE',
            field: 'ROLE_Column',
            titleTextAlign: PlutoColumnTextAlign.center,
            textAlign: PlutoColumnTextAlign.center,
            type: PlutoColumnType.text(),
            enableRowDrag: false,
            enableDropToResize: false,
            enableEditingMode: false,
            enableContextMenu: false,
            width: 300,
            cellPadding: EdgeInsets.zero,
            renderer: (rendererContext) {
              return Center(
                child: Text(
                  rendererContext.cell.value ?? "-",
                  style: AppTheme.of(context).contenidoTablas.override(
                      fontFamily: 'Gotham-Regular',
                      useGoogleFonts: false,
                      color: AppTheme.of(context).primaryText),
                ),
              );
            },
          ),
          PlutoColumn(
            titleSpan: const TextSpan(children: [
              TextSpan(
                  text: 'Status',
                  style: TextStyle(
                      fontFamily: 'Inter', color: Colors.grey, fontSize: 14))
            ]),
            title: 'STATUS',
            field: 'STATUS_Column',
            titleTextAlign: PlutoColumnTextAlign.center,
            textAlign: PlutoColumnTextAlign.center,
            type: PlutoColumnType.text(),
            enableRowDrag: false,
            enableDropToResize: false,
            enableEditingMode: false,
            enableContextMenu: false,
            width: 300,
            cellPadding: EdgeInsets.zero,
            renderer: (rendererContext) {
              return PlutoGrdiJsaStatusDocumentList(
                  text: rendererContext.cell.value ?? "-");
            },
          ),
          PlutoColumn(
            titleSpan: const TextSpan(children: [
              TextSpan(
                  text: 'Document',
                  style: TextStyle(
                      fontFamily: 'Inter', color: Colors.grey, fontSize: 14))
            ]),
            title: 'DOCUMENT',
            field: 'DOCUMENT_Column',
            titleTextAlign: PlutoColumnTextAlign.center,
            textAlign: PlutoColumnTextAlign.center,
            type: PlutoColumnType.text(),
            enableRowDrag: false,
            enableDropToResize: false,
            enableEditingMode: false,
            enableContextMenu: false,
            width: 150,
            cellPadding: EdgeInsets.zero,
            renderer: (rendererContext) {
              return InkWell(
                onTap: () async {
                  await provider.pickDocument(rendererContext.cell.value);
                  await showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return const PdfPopupJSADocumentList();
                    },
                  );
                },
                child: Container(
                  height: rowHeightJSA,
                  // width: rendererContext.cell.column.width,
                  child: Center(
                      child: Icon(
                    Icons.remove_red_eye_outlined,
                    color: AppTheme.of(context).primaryColor,
                  )),
                ),
              );
            },
          ),
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
    );
  }
}
