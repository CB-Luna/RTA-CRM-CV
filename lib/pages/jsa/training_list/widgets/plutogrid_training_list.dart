// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:provider/provider.dart';
import 'package:rta_crm_cv/providers/jsa/jsa_training_list_provider.dart';
import 'package:rta_crm_cv/widgets/pluto_grid_cells/pluto_grid_cell_jsa_status_training.dart';

import '../../../../functions/sizes.dart';
import '../../../../helpers/constants.dart';
import '../../../../theme/theme.dart';
import 'image_popup_training.dart';
import 'pdf_popup_training.dart';

class PlutoGridTrainingList extends StatefulWidget {
  const PlutoGridTrainingList({required this.iDUser, super.key});
  final String iDUser;
  @override
  State<PlutoGridTrainingList> createState() => _PlutoGridTrainingListState();
}

class _PlutoGridTrainingListState extends State<PlutoGridTrainingList> {
  @override
  Widget build(BuildContext context) {
    JsaTrainingListProvider provider =
        Provider.of<JsaTrainingListProvider>(context);
    // provider.listJSA.sort((a, b) => b.createdAt!.compareTo(a.createdAt!));

    provider.userTrainingSelected?.trainings
        .sort((a, b) => b.idTraining.compareTo(a.idTraining));

    // for (var training in provider.userTrainingSelected!.trainings) {
    //   print("El id de los trainings son: ${training.idTraining}");
    // }
    // provider.trainingList.sort((a, b) => b.idTraining.compareTo(a.idTraining));

    return Container(
      height: getHeight(10, context),
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
                  text: 'ID Training',
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
            // footerRenderer: (context) {
            //   return SizedBox(
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.center,
            //       children: [
            //         CustomIconButton(
            //           icon: Icons.keyboard_arrow_down_outlined,
            //           toolTip: 'less',
            //           onTap: () {
            //             provider.setPageSize('less');
            //           },
            //         ),
            //         const SizedBox(width: 10),
            //         Text(
            //           provider.pageRowCount.toString(),
            //           style: const TextStyle(color: Colors.white),
            //         ),
            //         const SizedBox(width: 10),
            //         CustomIconButton(
            //           icon: Icons.keyboard_arrow_up_outlined,
            //           toolTip: 'more',
            //           onTap: () {
            //             provider.setPageSize('more');
            //           },
            //         ),
            //         const SizedBox(width: 10),
            //       ],
            //     ),
            //   );
            // },
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
                  text: 'Creation Date',
                  style: TextStyle(
                      fontFamily: 'Inter', color: Colors.grey, fontSize: 14))
            ]),
            title: 'CREATIONDATE',
            field: 'Creation_Column',
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
                  DateFormat('MMM/dd/yyyy').format(rendererContext.cell.value),
                  // DateFormat('dd/MM/yyyy').format(rendererContext.cell.value),
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
                  text: 'Expiration Date',
                  style: TextStyle(
                      fontFamily: 'Inter', color: Colors.grey, fontSize: 14))
            ]),
            title: 'EXPIRATIONDATE',
            field: 'Expiration_Column',
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
                  DateFormat('MMM/dd/yyyy').format(rendererContext.cell.value),
                  //  ?? "-",
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
              return PlutoGrdiJsaStatusTraining(
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
                  provider.documento != null
                      ? await showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return PdfPopupJSATraining(
                                name: rendererContext.cell.value);
                          },
                        )
                      : await showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return ImagePopupJSATraining(
                                name: rendererContext.cell.value);
                          },
                        );
                },
                child: SizedBox(
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
