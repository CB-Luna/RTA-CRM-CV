import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../providers/ctrlv/inventory_provider.dart';
import '../../../../providers/ctrlv/issue_reported_provider.dart';
import '../../../../public/colors.dart';
import '../../../../theme/theme.dart';
import '../../../../widgets/custom_text_icon_button.dart';
import '../widgets/listIssuesCard.dart';
import '../widgets/listIssuesCardD.dart';

class ReportedIssues extends StatefulWidget {
  const ReportedIssues({super.key});

  @override
  State<ReportedIssues> createState() => _ReportedIssuesState();
}

class _ReportedIssuesState extends State<ReportedIssues> {
  @override
  Widget build(BuildContext context) {
    InventoryProvider provider = Provider.of<InventoryProvider>(context);
    IssueReportedProvider isssueReportedProvider =
        Provider.of<IssueReportedProvider>(context);
    return Container(
      width: MediaQuery.of(context).size.width - 100,
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.all(8.0),
            child: Row(
              ///mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(right: 325.0),
                  child: CustomTextIconButton(
                    width: 50,
                    isLoading: false,
                    icon: Icon(Icons.arrow_back_outlined,
                        color: AppTheme.of(context).primaryBackground),
                    text: '',
                    color: AppTheme.of(context).primaryColor,
                    onTap: () async {
                      isssueReportedProvider.setIssueViewActual(0);
                      isssueReportedProvider.clearListgetIssues();
                    },
                  ),
                ),
                Container(
                    width: 400,
                    height: 25,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 4,
                            color: Colors.grey,
                            offset: Offset(10, 10))
                      ],
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          provider.actualVehicle!.licesensePlates,
                          style: TextStyle(
                              fontFamily: AppTheme.of(context)
                                  .encabezadoTablas
                                  .fontFamily,
                              fontSize:
                                  AppTheme.of(context).contenidoTablas.fontSize,
                              fontStyle: AppTheme.of(context)
                                  .encabezadoTablas
                                  .fontStyle,
                              fontWeight: AppTheme.of(context)
                                  .encabezadoTablas
                                  .fontWeight,
                              color: AppTheme.of(context).primaryText),
                        ),
                        Text(
                          provider.actualVehicle!.make,
                          style: TextStyle(
                              fontFamily: AppTheme.of(context)
                                  .encabezadoTablas
                                  .fontFamily,
                              fontSize:
                                  AppTheme.of(context).contenidoTablas.fontSize,
                              fontStyle: AppTheme.of(context)
                                  .encabezadoTablas
                                  .fontStyle,
                              fontWeight: AppTheme.of(context)
                                  .encabezadoTablas
                                  .fontWeight,
                              color: AppTheme.of(context).primaryText),
                        ),
                        Text(
                          provider.actualVehicle!.model,
                          style: TextStyle(
                              fontFamily: AppTheme.of(context)
                                  .encabezadoTablas
                                  .fontFamily,
                              fontSize:
                                  AppTheme.of(context).contenidoTablas.fontSize,
                              fontStyle: AppTheme.of(context)
                                  .encabezadoTablas
                                  .fontStyle,
                              fontWeight: AppTheme.of(context)
                                  .encabezadoTablas
                                  .fontWeight,
                              color: AppTheme.of(context).primaryText),
                        ),
                        Text(
                          provider.actualVehicle!.year,
                          style: TextStyle(
                              fontFamily: AppTheme.of(context)
                                  .encabezadoTablas
                                  .fontFamily,
                              fontSize:
                                  AppTheme.of(context).contenidoTablas.fontSize,
                              fontStyle: AppTheme.of(context)
                                  .encabezadoTablas
                                  .fontStyle,
                              fontWeight: AppTheme.of(context)
                                  .encabezadoTablas
                                  .fontWeight,
                              color: AppTheme.of(context).primaryText),
                        ),
                      ],
                    )),
              ],
            ),
          ),
          Container(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.only(right: 40.0, left: 60.0),
                child: Text(
                  "Check Out",
                  style: TextStyle(
                      fontFamily:
                          AppTheme.of(context).encabezadoTablas.fontFamily,
                      fontSize: AppTheme.of(context).encabezadoTablas.fontSize,
                      fontStyle:
                          AppTheme.of(context).encabezadoTablas.fontStyle,
                      fontWeight:
                          AppTheme.of(context).encabezadoTablas.fontWeight,
                      color: Colors.orange),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 40.0, right: 50),
                child: Text(
                  "Check In",
                  style: TextStyle(
                      fontFamily:
                          AppTheme.of(context).encabezadoTablas.fontFamily,
                      fontSize: AppTheme.of(context).encabezadoTablas.fontSize,
                      fontStyle:
                          AppTheme.of(context).encabezadoTablas.fontStyle,
                      fontWeight:
                          AppTheme.of(context).encabezadoTablas.fontWeight,
                      color: const Color(0XFF25A531)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 80,
                  right: 30,
                ),
                child: CustomTextIconButton(
                    width: 82,
                    isLoading: false,
                    icon: Icon(Icons.calendar_today_outlined,
                        color: AppTheme.of(context).primaryBackground),
                    text: 'Date',
                    color: AppTheme.of(context).primaryColor,
                    onTap: () {
                      provider.filtrarPorMes(12);
                    }),
              ),
            ],
          )),
          Container(
            width: MediaQuery.of(context).size.width - 100,
            height: MediaQuery.of(context).size.height - 245,
            child: DefaultTabController(
              length: 8,
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
                          color: AppTheme.of(context).primaryColor, width: 2),
                    ),
                    child: TabBar(
                      onTap: (value) {
                        switch (value) {
                          case 0:
                            provider.setIndexIssue(0); // FluidCheck
                            break;
                          case 1:
                            provider.setIndexIssue(1); // Carbodywork
                            break;
                          case 2:
                            provider.setIndexIssue(2); // Equipment
                            break;
                          case 3:
                            provider.setIndexIssue(3); // Extra
                            break;
                          case 4:
                            provider.setIndexIssue(4); // BucketInspection
                            break;
                          case 5:
                            provider.setIndexIssue(5); // Lights
                            break;
                          case 6:
                            provider.setIndexIssue(6); // Measures
                            break;
                          case 7:
                            provider.setIndexIssue(7); // Security
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
                        color: provider.indexSelectedIssue[1]
                            ? Colors.greenAccent
                            : provider.indexSelectedIssue[0]
                                ? Colors.blue
                                : provider.indexSelectedIssue[2]
                                    ? Colors.yellow
                                    : provider.indexSelectedIssue[3]
                                        ? Colors.grey
                                        : provider.indexSelectedIssue[4]
                                            ? Colors.purple
                                            : provider.indexSelectedIssue[5]
                                                ? Colors.pink
                                                : provider.indexSelectedIssue[6]
                                                    ? Colors.white
                                                    : provider
                                                            .indexSelectedIssue[7]
                                                        ? Colors.teal
                                                        : Colors.black,
                      ),
                      splashBorderRadius: BorderRadius.circular(40),
                      labelStyle: const TextStyle(
                        fontFamily: 'UniNeue',
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                      unselectedLabelColor: AppTheme.of(context).primaryColor,
                      unselectedLabelStyle: const TextStyle(
                        fontFamily: 'UniNeue',
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                        fontSize: 15,
                      ),
                      tabs: const [
                        Tab(text: 'Fluids Check'),
                        Tab(text: 'Car Bodywork'),
                        Tab(text: 'Equipment'),
                        Tab(text: 'Extra'),
                        Tab(text: 'Bucket Inspection'),
                        Tab(text: 'Lights'),
                        Tab(text: 'Measure'),
                        Tab(text: 'Security'),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                        width: 1250,
                        height: 700,
                        alignment: Alignment.topCenter,
                        child: TabBarView(children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10.0),
                                child: ListIssuesCard(
                                    contador: 1,
                                    issuesComments:
                                        isssueReportedProvider.fluidCheckRR),
                              ),
                              ListIssuesCardD(
                                  contador: 1,
                                  issuesComments:
                                      isssueReportedProvider.fluidCheckDD),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10.0),
                                child: ListIssuesCard(
                                    contador: 2,
                                    issuesComments:
                                        isssueReportedProvider.carBodyWorkRR),
                              ),
                              ListIssuesCardD(
                                  contador: 2,
                                  issuesComments:
                                      isssueReportedProvider.carBodyWorkDD),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10.0),
                                child: ListIssuesCard(
                                    contador: 3,
                                    issuesComments:
                                        isssueReportedProvider.equipmentRR),
                              ),
                              ListIssuesCardD(
                                  contador: 3,
                                  issuesComments:
                                      isssueReportedProvider.equipmentDD),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10.0),
                                child: ListIssuesCard(
                                    contador: 4,
                                    issuesComments:
                                        isssueReportedProvider.extraRR),
                              ),
                              ListIssuesCardD(
                                  contador: 4,
                                  issuesComments:
                                      isssueReportedProvider.extraDD),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10.0),
                                child: ListIssuesCard(
                                    contador: 5,
                                    issuesComments: isssueReportedProvider
                                        .bucketInspectionRR),
                              ),
                              ListIssuesCardD(
                                  contador: 5,
                                  issuesComments: isssueReportedProvider
                                      .bucketInspectionDD),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10.0),
                                child: ListIssuesCard(
                                    contador: 6,
                                    issuesComments:
                                        isssueReportedProvider.lightsRR),
                              ),
                              ListIssuesCardD(
                                  contador: 6,
                                  issuesComments:
                                      isssueReportedProvider.lightsDD),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10.0),
                                child: ListIssuesCard(
                                    contador: 7,
                                    issuesComments:
                                        isssueReportedProvider.measureRR),
                              ),
                              ListIssuesCardD(
                                  contador: 7,
                                  issuesComments:
                                      isssueReportedProvider.measureDD),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10.0),
                                child: ListIssuesCard(
                                    contador: 8,
                                    issuesComments:
                                        isssueReportedProvider.securityRR),
                              ),
                              ListIssuesCardD(
                                  contador: 8,
                                  issuesComments:
                                      isssueReportedProvider.securityDD),
                            ],
                          ),
                        ])),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
