import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../providers/ctrlv/inventory_provider.dart';
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

    return SingleChildScrollView(
      child: SizedBox(
        width: 1500,
        height: 400,
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
                      width: 83,
                      isLoading: false,
                      icon: Icon(Icons.arrow_back_outlined,
                          color: AppTheme.of(context).primaryBackground),
                      text: 'Back',
                      color: AppTheme.of(context).primaryColor,
                      onTap: () async {
                        provider.setIssueViewActual(0);
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
                                fontSize: AppTheme.of(context)
                                    .contenidoTablas
                                    .fontSize,
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
                                fontSize: AppTheme.of(context)
                                    .contenidoTablas
                                    .fontSize,
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
                                fontSize: AppTheme.of(context)
                                    .contenidoTablas
                                    .fontSize,
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
                                fontSize: AppTheme.of(context)
                                    .contenidoTablas
                                    .fontSize,
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
            SizedBox(
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
                        fontSize:
                            AppTheme.of(context).encabezadoTablas.fontSize,
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
                        fontSize:
                            AppTheme.of(context).encabezadoTablas.fontSize,
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
                      onTap: () => {provider.filtrarPorMes(19)}),
                ),
              ],
            )),
            Expanded(
              child: DefaultTabController(
                length: 8,
                initialIndex: 0,
                child: Column(
                  children: [
                    SizedBox(
                      height: 36,
                      child: TabBar(
                        labelStyle: TextStyle(
                            fontFamily: AppTheme.of(context)
                                .encabezadoTablas
                                .fontFamily,
                            fontSize:
                                AppTheme.of(context).contenidoTablas.fontSize,
                            fontWeight: AppTheme.of(context)
                                .encabezadoTablas
                                .fontWeight,
                            color: AppTheme.of(context).primaryText),
                        unselectedLabelColor: Colors.black,
                        indicator: BoxDecoration(
                          color: AppTheme.of(context).primaryColor,
                          borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(10)),
                        ),
                        tabs: const [
                          Tab(
                            height: 30,
                            text: "Fluid Check",
                          ),
                          Tab(
                            height: 30,
                            text: "Car BodyWork",
                          ),
                          Tab(
                            height: 30,
                            text: "Equipment",
                          ),
                          Tab(
                            height: 30,
                            text: "Extra",
                          ),
                          Tab(
                            height: 30,
                            text: "Bucket Inpection",
                          ),
                          Tab(
                            height: 30,
                            text: "Lights",
                          ),
                          Tab(
                            height: 35,
                            text: "Measures",
                          ),
                          Tab(
                            height: 35,
                            text: "Security",
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                          width: 1250,
                          height: 100,
                          alignment: Alignment.topCenter,
                          child: TabBarView(children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10.0),
                                  child: ListIssuesCard(
                                      contador: 1,
                                      issuesComments: provider.fluidCheckRR),
                                ),
                                ListIssuesCardD(
                                    issuesComments: provider.fluidCheckDD),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10.0),
                                  child: ListIssuesCard(
                                      contador: 2,
                                      issuesComments: provider.carBodyWorkRR),
                                ),
                                ListIssuesCardD(
                                    issuesComments: provider.carBodyWorkDD),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10.0),
                                  child: ListIssuesCard(
                                      contador: 3,
                                      issuesComments: provider.equipmentRR),
                                ),
                                ListIssuesCardD(
                                    issuesComments: provider.equipmentDD),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10.0),
                                  child: ListIssuesCard(
                                      contador: 4,
                                      issuesComments: provider.extraRR),
                                ),
                                ListIssuesCardD(
                                    issuesComments: provider.extraDD),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10.0),
                                  child: ListIssuesCard(
                                      contador: 5,
                                      issuesComments:
                                          provider.bucketInspectionRR),
                                ),
                                ListIssuesCardD(
                                    issuesComments:
                                        provider.bucketInspectionDD),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10.0),
                                  child: ListIssuesCard(
                                      contador: 6,
                                      issuesComments: provider.lightsRR),
                                ),
                                ListIssuesCardD(
                                    issuesComments: provider.lightsDD),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10.0),
                                  child: ListIssuesCard(
                                      contador: 7,
                                      issuesComments: provider.measureRR),
                                ),
                                ListIssuesCardD(
                                    issuesComments: provider.measureDD),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10.0),
                                  child: ListIssuesCard(
                                      contador: 8,
                                      issuesComments: provider.securityRR),
                                ),
                                ListIssuesCardD(
                                    issuesComments: provider.securityDD),
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
      ),
    );
  }
}
