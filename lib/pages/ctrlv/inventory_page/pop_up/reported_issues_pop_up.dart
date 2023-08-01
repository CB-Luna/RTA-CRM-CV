import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:provider/provider.dart';
import 'package:rta_crm_cv/pages/ctrlv/inventory_page/pop_up/Issue_pop_up_total.dart';
import 'package:rta_crm_cv/pages/ctrlv/inventory_page/pop_up/tabbarIssues_pop_up.dart';
import 'package:rta_crm_cv/widgets/custom_card.dart';

import '../../../../functions/sizes.dart';
import '../../../../helpers/constants.dart';
import '../../../../models/issues.dart';
import '../../../../providers/ctrlv/inventory_provider.dart';
import '../../../../providers/ctrlv/issue_reported_provider.dart';
import '../../../../public/colors.dart';
import '../../../../theme/theme.dart';
import '../../../../widgets/custom_icon_button.dart';
import '../../../../widgets/side_menu/sidemenu.dart';
import '../../../../widgets/success_toast.dart';
import '../vehicle_cards/generalinformation_card.dart';

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
              const TabbarIssuePopUp(),
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
                        width: MediaQuery.of(context).size.width * 0.13,
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
                        width: MediaQuery.of(context).size.width * 0.15,
                        cellPadding: EdgeInsets.zero,
                        titleTextAlign: PlutoColumnTextAlign.center,
                        textAlign: PlutoColumnTextAlign.center,
                        type: PlutoColumnType.text(),
                        enableEditingMode: false,
                        renderer: (rendererContext) {
                          bool state = issueReportedProvider.fluidCheckInspectR;
                          FluidCheck fluidCheckState =
                              rendererContext.cell.value;

                          return Container(
                            height: rowHeight,
                            decoration: BoxDecoration(gradient: whiteGradient),
                            child: InkWell(
                                onTap: () => showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return StatefulBuilder(
                                          builder: (context, setState) {
                                        if (state) {
                                          return Text("");
                                        } else {
                                          if (fluidCheckState.state!) {
                                            return IssuesPopUpTotal(
                                              text: "FluidsCheck",
                                              contador: 1,
                                              issueComments:
                                                  issueReportedProvider
                                                      .fluidCheckR,
                                            );
                                          } else {
                                            return IssuesPopUpTotal(
                                              text: "FluidsCheck",
                                              contador: 1,
                                              issueComments:
                                                  issueReportedProvider
                                                      .fluidCheckD,
                                            );
                                          }
                                        }
                                      });
                                    }),
                                child: state
                                    ? const Icon(
                                        Icons.check_circle_outline_outlined,
                                        color: Color.fromARGB(200, 65, 155, 23))
                                    : const Icon(Icons.cancel_outlined,
                                        color:
                                            Color.fromARGB(200, 210, 0, 48))),
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
                            bool state = issueReportedProvider.ligthsInspectR;
                            Lights lightsState = rendererContext.cell.value;

                            return Container(
                              height: rowHeight,
                              decoration:
                                  BoxDecoration(gradient: whiteGradient),
                              child: InkWell(
                                  onTap: () => showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return StatefulBuilder(
                                            builder: (context, setState) {
                                          if (state) {
                                            return Text("");
                                          } else {
                                            if (lightsState.state!) {
                                              return IssuesPopUpTotal(
                                                text: "Lights",
                                                contador: 2,
                                                issueComments:
                                                    issueReportedProvider
                                                        .lightsR,
                                              );
                                            } else {
                                              return IssuesPopUpTotal(
                                                text: "Lights",
                                                contador: 2,
                                                issueComments:
                                                    issueReportedProvider
                                                        .lightsD,
                                              );
                                            }
                                          }
                                        });
                                      }),
                                  child: state
                                      ? const Icon(
                                          Icons.check_circle_outline_outlined,
                                          color:
                                              Color.fromARGB(200, 65, 155, 23))
                                      : const Icon(Icons.cancel_outlined,
                                          color:
                                              Color.fromARGB(200, 210, 0, 48))),
                            );
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
                            bool state = issueReportedProvider.carBodyInspectR;
                            CarBodywork carBodyWorkState =
                                rendererContext.cell.value;

                            return Container(
                              height: rowHeight,
                              decoration:
                                  BoxDecoration(gradient: whiteGradient),
                              child: InkWell(
                                  onTap: () => showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return StatefulBuilder(
                                            builder: (context, setState) {
                                          if (state) {
                                            return Text("");
                                          } else {
                                            if (carBodyWorkState.state!) {
                                              return IssuesPopUpTotal(
                                                text: "CarBodyWork",
                                                contador: 3,
                                                issueComments:
                                                    issueReportedProvider
                                                        .carBodyWorkR,
                                              );
                                            } else {
                                              return IssuesPopUpTotal(
                                                text: "CarBodyWork",
                                                contador: 3,
                                                issueComments:
                                                    issueReportedProvider
                                                        .carBodyWorkD,
                                              );
                                            }
                                          }
                                        });
                                      }),
                                  child: state
                                      ? const Icon(
                                          Icons.check_circle_outline_outlined,
                                          color:
                                              Color.fromARGB(200, 65, 155, 23))
                                      : const Icon(Icons.cancel_outlined,
                                          color:
                                              Color.fromARGB(200, 210, 0, 48))),
                            );
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
                            bool state = issueReportedProvider.securityInspectR;
                            Security securityState = rendererContext.cell.value;

                            return Container(
                              height: rowHeight,
                              decoration:
                                  BoxDecoration(gradient: whiteGradient),
                              child: InkWell(
                                  onTap: () => showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return StatefulBuilder(
                                            builder: (context, setState) {
                                          if (state) {
                                            return Text("");
                                          } else {
                                            if (securityState.state!) {
                                              return IssuesPopUpTotal(
                                                text: "Security",
                                                contador: 4,
                                                issueComments:
                                                    issueReportedProvider
                                                        .securityR,
                                              );
                                            } else {
                                              return IssuesPopUpTotal(
                                                text: "Security",
                                                contador: 4,
                                                issueComments:
                                                    issueReportedProvider
                                                        .securityD,
                                              );
                                            }
                                          }
                                        });
                                      }),
                                  child: state
                                      ? const Icon(
                                          Icons.check_circle_outline_outlined,
                                          color:
                                              Color.fromARGB(200, 65, 155, 23))
                                      : const Icon(Icons.cancel_outlined,
                                          color:
                                              Color.fromARGB(200, 210, 0, 48))),
                            );
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
                          width: MediaQuery.of(context).size.width * 0.09,
                          cellPadding: EdgeInsets.zero,
                          titleTextAlign: PlutoColumnTextAlign.center,
                          textAlign: PlutoColumnTextAlign.center,
                          type: PlutoColumnType.text(),
                          enableEditingMode: false,
                          renderer: (rendererContext) {
                            bool state = issueReportedProvider.extraInspectR;
                            Extra extraState = rendererContext.cell.value;

                            return Container(
                              height: rowHeight,
                              decoration:
                                  BoxDecoration(gradient: whiteGradient),
                              child: InkWell(
                                  onTap: () => showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return StatefulBuilder(
                                            builder: (context, setState) {
                                          if (state) {
                                            return Text("");
                                          } else {
                                            if (extraState.state!) {
                                              return IssuesPopUpTotal(
                                                text: "Extra",
                                                contador: 5,
                                                issueComments:
                                                    issueReportedProvider
                                                        .extraR,
                                              );
                                            } else {
                                              return IssuesPopUpTotal(
                                                text: "Extra",
                                                contador: 5,
                                                issueComments:
                                                    issueReportedProvider
                                                        .extraD,
                                              );
                                            }
                                          }
                                        });
                                      }),
                                  child: state
                                      ? const Icon(
                                          Icons.check_circle_outline_outlined,
                                          color:
                                              Color.fromARGB(200, 65, 155, 23))
                                      : const Icon(Icons.cancel_outlined,
                                          color:
                                              Color.fromARGB(200, 210, 0, 48))),
                            );
                          }),
                      PlutoColumn(
                        title: 'Equipment',
                        field: 'Equipment',
                        backgroundColor: const Color(0XFF6491F7),
                        titleSpan: TextSpan(children: [
                          WidgetSpan(
                              child: Icon(Icons.call_to_action_outlined,
                                  color:
                                      AppTheme.of(context).primaryBackground)),
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
                          bool state = issueReportedProvider.equipmentInspectR;
                          Equiment equipmentState = rendererContext.cell.value;
                          return Container(
                            height: rowHeight,
                            decoration: BoxDecoration(gradient: whiteGradient),
                            child: InkWell(
                                onTap: () => showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return StatefulBuilder(
                                          builder: (context, setState) {
                                        if (state) {
                                          return Text("");
                                        } else {
                                          if (equipmentState.state!) {
                                            return IssuesPopUpTotal(
                                              text: "Equipment",
                                              contador: 6,
                                              issueComments:
                                                  issueReportedProvider
                                                      .equipmentR,
                                            );
                                          } else {
                                            return IssuesPopUpTotal(
                                              text: "Equipment",
                                              contador: 6,
                                              issueComments:
                                                  issueReportedProvider
                                                      .equipmentD,
                                            );
                                          }
                                        }
                                      });
                                    }),
                                child: state
                                    ? const Icon(
                                        Icons.check_circle_outline_outlined,
                                        color: Color.fromARGB(200, 65, 155, 23))
                                    : const Icon(Icons.cancel_outlined,
                                        color:
                                            Color.fromARGB(200, 210, 0, 48))),
                          );
                        },
                      ),
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
                            bool state = issueReportedProvider.bucketInspectR;
                            BucketInspection bucketInspectionstate =
                                rendererContext.cell.value;

                            return Container(
                              height: rowHeight,
                              decoration:
                                  BoxDecoration(gradient: whiteGradient),
                              child: InkWell(
                                  onTap: () => showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return StatefulBuilder(
                                            builder: (context, setState) {
                                          if (state) {
                                            return Text("");
                                          } else {
                                            if (bucketInspectionstate.state!) {
                                              return IssuesPopUpTotal(
                                                text: "BucketInspection",
                                                contador: 7,
                                                issueComments:
                                                    issueReportedProvider
                                                        .bucketInspectionR,
                                              );
                                            } else {
                                              return IssuesPopUpTotal(
                                                text: "BucketInspection",
                                                contador: 7,
                                                issueComments:
                                                    issueReportedProvider
                                                        .bucketInspectionD,
                                              );
                                            }
                                          }
                                        });
                                      }),
                                  child: state
                                      ? const Icon(
                                          Icons.check_circle_outline_outlined,
                                          color:
                                              Color.fromARGB(200, 65, 155, 23))
                                      : const Icon(Icons.cancel_outlined,
                                          color:
                                              Color.fromARGB(200, 210, 0, 48))),
                            );
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
                            bool state = issueReportedProvider.measureInspectR;

                            Measure measureState = rendererContext.cell.value;

                            return Container(
                              height: rowHeight,
                              decoration:
                                  BoxDecoration(gradient: whiteGradient),
                              child: InkWell(
                                  onTap: () => showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return StatefulBuilder(
                                            builder: (context, setState) {
                                          if (state) {
                                            return Text("");
                                          } else {
                                            if (measureState.state!) {
                                              return IssuesPopUpTotal(
                                                text: "Measures",
                                                contador: 8,
                                                issueComments:
                                                    issueReportedProvider
                                                        .measureR,
                                              );
                                            } else {
                                              return IssuesPopUpTotal(
                                                text: "Measures",
                                                contador: 8,
                                                issueComments:
                                                    issueReportedProvider
                                                        .measureD,
                                              );
                                            }
                                          }
                                        });
                                      }),
                                  child: state
                                      ? const Icon(
                                          Icons.check_circle_outline_outlined,
                                          color:
                                              Color.fromARGB(200, 65, 155, 23))
                                      : const Icon(Icons.cancel_outlined,
                                          color:
                                              Color.fromARGB(200, 210, 0, 48))),
                            );
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
