import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:provider/provider.dart';
import 'package:rta_crm_cv/pages/ctrlv/inventory_page/pop_up/Issue_pop_up_total.dart';
import 'package:rta_crm_cv/pages/ctrlv/inventory_page/pop_up/tabbarIssues_pop_up.dart';
import 'package:rta_crm_cv/widgets/custom_card.dart';

import '../../../../functions/sizes.dart';
import '../../../../helpers/constants.dart';
import '../../../../models/issues_open_close.dart';
import '../../../../providers/ctrlv/inventory_provider.dart';
import '../../../../providers/ctrlv/issue_reported_provider.dart';
import '../../../../public/colors.dart';
import '../../../../theme/theme.dart';
import '../../../../widgets/custom_icon_button.dart';
import '../../../../widgets/custom_text_icon_button.dart';
import '../../../../widgets/side_menu/sidemenu.dart';
import '../vehicle_cards/generalinformation_card.dart';
import 'history_issues_pop_up.dart';

class ReportedIssues extends StatefulWidget {
  const ReportedIssues({super.key});

  @override
  State<ReportedIssues> createState() => _ReportedIssuesState();
}

class _ReportedIssuesState extends State<ReportedIssues> {
  FToast fToast = FToast();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final IssueReportedProvider provider = Provider.of<IssueReportedProvider>(
        context,
        listen: false,
      );
      await provider.updateState();
    });
  }

  @override
  Widget build(BuildContext context) {
    InventoryProvider provider = Provider.of<InventoryProvider>(context);
    IssueReportedProvider issueReportedProvider =
        Provider.of<IssueReportedProvider>(context);
    return Material(
      child: Row(
        children: [
          const SideMenu(),
          CustomCard(
            width: MediaQuery.of(context).size.width * 0.93,
            height: MediaQuery.of(context).size.height,
            title: "Issues",
            child: Column(children: [
              const GeneralInformationCard(),
              Row(
                children: [
                  const TabbarIssuePopUp(),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: CustomTextIconButton(
                        mainAxisAlignment: MainAxisAlignment.center,
                        width: MediaQuery.of(context).size.width * 0.10,
                        isLoading: false,
                        icon: Icon(Icons.calendar_today_outlined,
                            color: AppTheme.of(context).primaryBackground),
                        text: 'Issues Closed',
                        style: AppTheme.of(context).contenidoTablas.override(
                              fontFamily: 'Gotham-Regular',
                              useGoogleFonts: false,
                              color: AppTheme.of(context).primaryBackground,
                            ),
                        color: AppTheme.of(context).primaryColor,
                        onTap: () async {
                          issueReportedProvider.listTotalClosedIssue.clear();
                          await showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return StatefulBuilder(
                                    builder: (context, setState) {
                                  return const HistoryIssuePopUp();
                                });
                              });
                        }),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: SizedBox(
                  height: getHeight(850, context),
                  width: getWidth(2450, context),
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
                          if (column.field == 'Status') {
                            return resolver<PlutoFilterTypeContains>()
                                as PlutoFilterType;
                          } else if (column.field == 'FluidsCheck') {
                            return resolver<PlutoFilterTypeContains>()
                                as PlutoFilterType;
                          } else if (column.field == 'Lights') {
                            return resolver<PlutoFilterTypeContains>()
                                as PlutoFilterType;
                          } else if (column.field == 'CarBodyWork') {
                            return resolver<PlutoFilterTypeContains>()
                                as PlutoFilterType;
                          } else if (column.field == 'Security') {
                            return resolver<PlutoFilterTypeContains>()
                                as PlutoFilterType;
                          } else if (column.field == 'Extra') {
                            return resolver<PlutoFilterTypeContains>()
                                as PlutoFilterType;
                          } else if (column.field == 'Equipment') {
                            return resolver<PlutoFilterTypeContains>()
                                as PlutoFilterType;
                          } else if (column.field == 'BucketInspection') {
                            return resolver<PlutoFilterTypeContains>()
                                as PlutoFilterType;
                          } else if (column.field == 'Measures') {
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
                          title: 'idIssues',
                          field: 'idIssues',
                          titleSpan: TextSpan(children: [
                            WidgetSpan(
                                child: Icon(Icons.label_important_outline,
                                    color: AppTheme.of(context)
                                        .primaryBackground)),
                            const WidgetSpan(child: SizedBox(width: 10)),
                            TextSpan(
                                text: 'idIssues',
                                style: AppTheme.of(context).encabezadoTablas)
                          ]),
                          width: MediaQuery.of(context).size.width * 0.08,
                          backgroundColor: const Color(0XFF6491F7),
                          cellPadding: EdgeInsets.zero,
                          titleTextAlign: PlutoColumnTextAlign.center,
                          textAlign: PlutoColumnTextAlign.center,
                          type: PlutoColumnType.text(),
                          enableEditingMode: false,
                          renderer: (rendererContext) {
                            return Container(
                              height: rowHeight,
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
                                        color:
                                            AppTheme.of(context).primaryColor),
                              )),
                            );
                          }),
                      PlutoColumn(
                        title: 'Status',
                        field: 'Status',
                        backgroundColor: const Color(0XFF6491F7),
                        titleSpan: TextSpan(children: [
                          WidgetSpan(
                              child: Icon(Icons.dialpad_outlined,
                                  color:
                                      AppTheme.of(context).primaryBackground)),
                          const WidgetSpan(child: SizedBox(width: 10)),
                          TextSpan(
                              text: 'Status',
                              style: AppTheme.of(context).encabezadoTablas)
                        ]),
                        width: MediaQuery.of(context).size.width * 0.10,
                        cellPadding: EdgeInsets.zero,
                        titleTextAlign: PlutoColumnTextAlign.center,
                        textAlign: PlutoColumnTextAlign.center,
                        type: PlutoColumnType.text(),
                        enableEditingMode: false,
                        renderer: (rendererContext) {
                          return Container(
                            height: rowHeight,
                            decoration: BoxDecoration(gradient: whiteGradient),
                            child: Center(
                                child: Text(
                              rendererContext.cell.value ?? '-',
                              style: AppTheme.of(context)
                                  .contenidoTablas
                                  .override(
                                      fontFamily: 'Gotham-Regular',
                                      useGoogleFonts: false,
                                      color: AppTheme.of(context).primaryColor),
                            )),
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
                                const SizedBox(width: 10),
                              ],
                            ),
                          );
                        },
                      ),
                      PlutoColumn(
                        title: 'FluidsCheck',
                        field: 'FluidsCheck',
                        backgroundColor: const Color(0XFF6491F7),
                        titleSpan: TextSpan(children: [
                          WidgetSpan(
                              child: Icon(Icons.car_repair_outlined,
                                  color:
                                      AppTheme.of(context).primaryBackground)),
                          const WidgetSpan(child: SizedBox(width: 10)),
                          TextSpan(
                              text: 'FluidsCheck',
                              style: AppTheme.of(context).encabezadoTablas)
                        ]),
                        width: MediaQuery.of(context).size.width * 0.13,
                        cellPadding: EdgeInsets.zero,
                        titleTextAlign: PlutoColumnTextAlign.center,
                        textAlign: PlutoColumnTextAlign.center,
                        type: PlutoColumnType.text(),
                        enableEditingMode: false,
                        renderer: (rendererContext) {
                          List<IssueOpenclose> listaCeldaActual =
                              rendererContext.cell.value
                                  as List<IssueOpenclose>;
                          return Container(
                              height: rowHeight,
                              decoration:
                                  BoxDecoration(gradient: whiteGradient),
                              child: listaCeldaActual.isNotEmpty
                                  ? Tooltip(
                                      message: "${listaCeldaActual.length}",
                                      child: InkWell(
                                          onTap: () => showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return IssuesPopUpTotal(
                                                    text: "FluidsCheck",
                                                    contador: 1,
                                                    issueComments:
                                                        rendererContext
                                                            .cell.value);
                                              }),
                                          child: const Icon(
                                              Icons.cancel_outlined,
                                              color: Color.fromARGB(
                                                  200, 210, 0, 48))),
                                    )

                                  // si esta vacio entonces que haga esto.
                                  : const Icon(
                                      Icons.check_circle_outline_outlined,
                                      color: Color.fromARGB(200, 65, 155, 23)));
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
                          //PlutoPagination(context.stateManager);
                        },
                      ),
                      PlutoColumn(
                          title: 'Lights',
                          field: 'Lights',
                          titleSpan: TextSpan(children: [
                            WidgetSpan(
                                child: Icon(Icons.label_important_outline,
                                    color: AppTheme.of(context)
                                        .primaryBackground)),
                            const WidgetSpan(child: SizedBox(width: 10)),
                            TextSpan(
                                text: 'Lights',
                                style: AppTheme.of(context).encabezadoTablas)
                          ]),
                          width: MediaQuery.of(context).size.width * 0.08,
                          backgroundColor: const Color(0XFF6491F7),
                          cellPadding: EdgeInsets.zero,
                          titleTextAlign: PlutoColumnTextAlign.center,
                          textAlign: PlutoColumnTextAlign.center,
                          type: PlutoColumnType.text(),
                          enableEditingMode: false,
                          renderer: (rendererContext) {
                            List<IssueOpenclose> listaCeldaActual =
                                rendererContext.cell.value
                                    as List<IssueOpenclose>;
                            return Container(
                                height: rowHeight,
                                decoration:
                                    BoxDecoration(gradient: whiteGradient),
                                child: listaCeldaActual.isNotEmpty
                                    ? Tooltip(
                                        message: "${listaCeldaActual.length}",
                                        child: InkWell(
                                            onTap: () => showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return IssuesPopUpTotal(
                                                      text: "Lights",
                                                      contador: 2,
                                                      issueComments:
                                                          rendererContext
                                                              .cell.value);
                                                }),
                                            child: const Icon(
                                                Icons.cancel_outlined,
                                                color: Color.fromARGB(
                                                    200, 210, 0, 48))),
                                      )

                                    // si esta vacio entonces que haga esto.
                                    : const Icon(
                                        Icons.check_circle_outline_outlined,
                                        color:
                                            Color.fromARGB(200, 65, 155, 23)));
                          }),
                      PlutoColumn(
                          title: 'CarBodyWork',
                          field: 'CarBodyWork',
                          backgroundColor: const Color(0XFF6491F7),
                          titleSpan: TextSpan(children: [
                            WidgetSpan(
                                child: Icon(Icons.local_shipping_outlined,
                                    color: AppTheme.of(context)
                                        .primaryBackground)),
                            const WidgetSpan(child: SizedBox(width: 10)),
                            TextSpan(
                                text: 'CarBodyWork',
                                style: AppTheme.of(context).encabezadoTablas)
                          ]),
                          width: MediaQuery.of(context).size.width * 0.10,
                          cellPadding: EdgeInsets.zero,
                          titleTextAlign: PlutoColumnTextAlign.center,
                          textAlign: PlutoColumnTextAlign.center,
                          type: PlutoColumnType.text(),
                          enableEditingMode: false,
                          renderer: (rendererContext) {
                            List<IssueOpenclose> listaCeldaActual =
                                rendererContext.cell.value
                                    as List<IssueOpenclose>;
                            return Container(
                                height: rowHeight,
                                decoration:
                                    BoxDecoration(gradient: whiteGradient),
                                // Preguntamos si esta vacio
                                child: listaCeldaActual.isNotEmpty
                                    ? Tooltip(
                                        message: "${listaCeldaActual.length}",
                                        child: InkWell(
                                            onTap: () => showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return StatefulBuilder(
                                                      builder:
                                                          (context, setState) {
                                                    return IssuesPopUpTotal(
                                                      text: "CarBodyWork",
                                                      contador: 3,
                                                      issueComments:
                                                          rendererContext
                                                              .cell.value,
                                                    );
                                                  });
                                                }),
                                            child: const Icon(
                                                Icons.cancel_outlined,
                                                color: Color.fromARGB(
                                                    200, 210, 0, 48))),
                                      )

                                    // si esta vacio entonces que haga esto.
                                    : const Icon(
                                        Icons.check_circle_outline_outlined,
                                        color:
                                            Color.fromARGB(200, 65, 155, 23)));
                          }),
                      PlutoColumn(
                          title: 'Security',
                          field: 'Security',
                          backgroundColor: const Color(0XFF6491F7),
                          titleSpan: TextSpan(children: [
                            WidgetSpan(
                                child: Icon(Icons.warehouse_outlined,
                                    color: AppTheme.of(context)
                                        .primaryBackground)),
                            const WidgetSpan(child: SizedBox(width: 10)),
                            TextSpan(
                                text: 'Security',
                                style: AppTheme.of(context).encabezadoTablas)
                          ]),
                          width: MediaQuery.of(context).size.width * 0.10,
                          cellPadding: EdgeInsets.zero,
                          titleTextAlign: PlutoColumnTextAlign.center,
                          textAlign: PlutoColumnTextAlign.center,
                          type: PlutoColumnType.text(),
                          enableEditingMode: false,
                          renderer: (rendererContext) {
                            List<IssueOpenclose> listaCeldaActual =
                                rendererContext.cell.value
                                    as List<IssueOpenclose>;
                            return Container(
                                height: rowHeight,
                                decoration:
                                    BoxDecoration(gradient: whiteGradient),
                                child: listaCeldaActual.isNotEmpty
                                    ? Tooltip(
                                        message: "${listaCeldaActual.length}",
                                        child: InkWell(
                                            onTap: () => showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return IssuesPopUpTotal(
                                                      text: "Security",
                                                      contador: 4,
                                                      issueComments:
                                                          rendererContext
                                                              .cell.value);
                                                }),
                                            child: const Icon(
                                                Icons.cancel_outlined,
                                                color: Color.fromARGB(
                                                    200, 210, 0, 48))),
                                      )

                                    // si esta vacio entonces que haga esto.
                                    : const Icon(
                                        Icons.check_circle_outline_outlined,
                                        color:
                                            Color.fromARGB(200, 65, 155, 23)));
                          }),
                      PlutoColumn(
                          title: 'Extra',
                          field: 'Extra',
                          backgroundColor: const Color(0XFF6491F7),
                          titleSpan: TextSpan(children: [
                            WidgetSpan(
                                child: Icon(Icons.warehouse_outlined,
                                    color: AppTheme.of(context)
                                        .primaryBackground)),
                            const WidgetSpan(child: SizedBox(width: 10)),
                            TextSpan(
                                text: 'Extra',
                                style: AppTheme.of(context).encabezadoTablas)
                          ]),
                          width: MediaQuery.of(context).size.width * 0.07,
                          cellPadding: EdgeInsets.zero,
                          titleTextAlign: PlutoColumnTextAlign.center,
                          textAlign: PlutoColumnTextAlign.center,
                          type: PlutoColumnType.text(),
                          enableEditingMode: false,
                          renderer: (rendererContext) {
                            List<IssueOpenclose> listaCeldaActual =
                                rendererContext.cell.value
                                    as List<IssueOpenclose>;
                            return Container(
                                height: rowHeight,
                                decoration:
                                    BoxDecoration(gradient: whiteGradient),
                                child: listaCeldaActual.isNotEmpty
                                    ? Tooltip(
                                        message: "${listaCeldaActual.length}",
                                        child: InkWell(
                                            onTap: () => showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return IssuesPopUpTotal(
                                                      text: "Extra",
                                                      contador: 5,
                                                      issueComments:
                                                          rendererContext
                                                              .cell.value);
                                                }),
                                            child: const Icon(
                                                Icons.cancel_outlined,
                                                color: Color.fromARGB(
                                                    200, 210, 0, 48))),
                                      )

                                    // si esta vacio entonces que haga esto.
                                    : const Icon(
                                        Icons.check_circle_outline_outlined,
                                        color:
                                            Color.fromARGB(200, 65, 155, 23)));
                          }),
                      PlutoColumn(
                          title: 'Equipment',
                          field: 'Equipment',
                          backgroundColor: const Color(0XFF6491F7),
                          titleSpan: TextSpan(children: [
                            WidgetSpan(
                                child: Icon(Icons.call_to_action_outlined,
                                    color: AppTheme.of(context)
                                        .primaryBackground)),
                            const WidgetSpan(child: SizedBox(width: 10)),
                            TextSpan(
                                text: 'Equipment',
                                style: AppTheme.of(context).encabezadoTablas)
                          ]),
                          width: MediaQuery.of(context).size.width * 0.10,
                          cellPadding: EdgeInsets.zero,
                          titleTextAlign: PlutoColumnTextAlign.center,
                          textAlign: PlutoColumnTextAlign.center,
                          type: PlutoColumnType.text(),
                          enableEditingMode: false,
                          renderer: (rendererContext) {
                            List<IssueOpenclose> listaCeldaActual =
                                rendererContext.cell.value
                                    as List<IssueOpenclose>;
                            return Container(
                                height: rowHeight,
                                decoration:
                                    BoxDecoration(gradient: whiteGradient),
                                child: listaCeldaActual.isNotEmpty
                                    ? Tooltip(
                                        child: InkWell(
                                            onTap: () => showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return IssuesPopUpTotal(
                                                      text: "Equipment",
                                                      contador: 6,
                                                      issueComments:
                                                          rendererContext
                                                              .cell.value);
                                                }),
                                            child: const Icon(
                                                Icons.cancel_outlined,
                                                color: Color.fromARGB(
                                                    200, 210, 0, 48))),
                                      )

                                    // si esta vacio entonces que haga esto.
                                    : const Icon(
                                        Icons.check_circle_outline_outlined,
                                        color:
                                            Color.fromARGB(200, 65, 155, 23)));
                          }),
                      PlutoColumn(
                          title: 'BucketInspection',
                          field: 'BucketInspection',
                          backgroundColor: const Color(0XFF6491F7),
                          titleSpan: TextSpan(children: [
                            WidgetSpan(
                                child: Icon(Icons.call_to_action_outlined,
                                    color: AppTheme.of(context)
                                        .primaryBackground)),
                            const WidgetSpan(child: SizedBox(width: 10)),
                            TextSpan(
                                text: 'BucketInspection',
                                style: AppTheme.of(context).encabezadoTablas)
                          ]),
                          width: MediaQuery.of(context).size.width * 0.10,
                          cellPadding: EdgeInsets.zero,
                          titleTextAlign: PlutoColumnTextAlign.center,
                          textAlign: PlutoColumnTextAlign.center,
                          type: PlutoColumnType.text(),
                          enableEditingMode: false,
                          renderer: (rendererContext) {
                            List<IssueOpenclose> listaCeldaActual =
                                rendererContext.cell.value
                                    as List<IssueOpenclose>;
                            return Container(
                                height: rowHeight,
                                decoration:
                                    BoxDecoration(gradient: whiteGradient),
                                child: listaCeldaActual.isNotEmpty
                                    ? Tooltip(
                                        message: "${listaCeldaActual.length}",
                                        child: InkWell(
                                            onTap: () => showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return IssuesPopUpTotal(
                                                      text: "BucketInspection",
                                                      contador: 7,
                                                      issueComments:
                                                          rendererContext
                                                              .cell.value);
                                                }),
                                            child: const Icon(
                                                Icons.cancel_outlined,
                                                color: Color.fromARGB(
                                                    200, 210, 0, 48))),
                                      )

                                    // si esta vacio entonces que haga esto.
                                    : const Icon(
                                        Icons.check_circle_outline_outlined,
                                        color:
                                            Color.fromARGB(200, 65, 155, 23)));
                          }),
                      PlutoColumn(
                          title: 'Measures',
                          field: 'Measures',
                          backgroundColor: const Color(0XFF6491F7),
                          titleSpan: TextSpan(children: [
                            WidgetSpan(
                                child: Icon(Icons.call_to_action_outlined,
                                    color: AppTheme.of(context)
                                        .primaryBackground)),
                            const WidgetSpan(child: SizedBox(width: 10)),
                            TextSpan(
                                text: 'Measures',
                                style: AppTheme.of(context).encabezadoTablas)
                          ]),
                          width: MediaQuery.of(context).size.width * 0.10,
                          cellPadding: EdgeInsets.zero,
                          titleTextAlign: PlutoColumnTextAlign.center,
                          textAlign: PlutoColumnTextAlign.center,
                          type: PlutoColumnType.text(),
                          enableEditingMode: false,
                          renderer: (rendererContext) {
                            List<IssueOpenclose> listaCeldaActual =
                                rendererContext.cell.value
                                    as List<IssueOpenclose>;
                            return Container(
                                height: rowHeight,
                                decoration:
                                    BoxDecoration(gradient: whiteGradient),
                                child: listaCeldaActual.isNotEmpty
                                    ? Tooltip(
                                        message: "${listaCeldaActual.length}",
                                        child: InkWell(
                                            onTap: () => showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return IssuesPopUpTotal(
                                                      text: "Measures",
                                                      contador: 8,
                                                      issueComments:
                                                          rendererContext
                                                              .cell.value);
                                                }),
                                            child: const Icon(
                                                Icons.cancel_outlined,
                                                color: Color.fromARGB(
                                                    200, 210, 0, 48))),
                                      )

                                    // si esta vacio entonces que haga esto.
                                    : const Icon(
                                        Icons.check_circle_outline_outlined,
                                        color:
                                            Color.fromARGB(200, 65, 155, 23)));
                          }),
                    ],
                    rows: issueReportedProvider.rows,
                    onLoaded: (event) async {
                      provider.stateManager = event.stateManager;
                    },
                    createFooter: (stateManager) {
                      stateManager.setPageSize(provider.pageRowCount);
                      stateManager.setPage(provider.page);
                      return const SizedBox(height: 0, width: 0);
                    },
                  ),
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
