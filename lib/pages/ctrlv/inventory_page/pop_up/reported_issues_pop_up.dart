import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rta_crm_cv/public/colors.dart';

import '../../../../providers/ctrlv/inventory_provider.dart';
import '../../../../theme/theme.dart';
import '../../../../widgets/custom_card.dart';
import '../../../../widgets/custom_text_icon_button.dart';
import '../widgets/listIssuesCard.dart';

class ReportedIssues extends StatefulWidget {
  const ReportedIssues({super.key});

  @override
  State<ReportedIssues> createState() => _ReportedIssuesState();
}

class _ReportedIssuesState extends State<ReportedIssues> {
  @override
  Widget build(BuildContext context) {
    InventoryProvider provider = Provider.of<InventoryProvider>(context);
    String dropdownvalue = "Check In";
    var items = [
      'Check In',
      'Check Out',
    ];
    void changeDropdown(String? newValue) {
      setState(() {
        dropdownvalue = newValue!;
      });
    }

    return AlertDialog(
      shadowColor: Colors.transparent,
      backgroundColor: Colors.transparent,
      content: CustomCard(
        width: 800,
        height: 560,
        title: "List of Issues ",
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CustomTextIconButton(
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
                    padding: const EdgeInsets.only(right: 87.0),
                    child: DropdownButton(
                      value: dropdownvalue,
                      icon: const Icon(Icons.keyboard_arrow_down_outlined),
                      items: items.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(items),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        print("----------------------");
                        print(dropdownvalue);

                        changeDropdown(newValue);

                        print("----------------------");
                        print(dropdownvalue);

                        if (dropdownvalue == 'Check In') {
                        } else if (dropdownvalue == 'Check Out') {}
                      },
                    )),
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
                    left: 50,
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
            SizedBox(
              height: 500,
              width: 850,
              child: DefaultTabController(
                length: 8,
                initialIndex: 0,
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                      child: TabBar(
                        labelStyle: TextStyle(
                            fontFamily: AppTheme.of(context)
                                .encabezadoTablas
                                .fontFamily,
                            fontSize:
                                AppTheme.of(context).contenidoTablas.fontSize,
                            fontStyle:
                                AppTheme.of(context).encabezadoTablas.fontStyle,
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
                            height: 20,
                            text: "Bucket Inpection",
                          ),
                          Tab(
                            height: 20,
                            text: "Car Bodywork",
                          ),
                          Tab(
                            height: 20,
                            text: "Equipment",
                          ),
                          Tab(
                            height: 20,
                            text: "Extra",
                          ),
                          Tab(
                            height: 20,
                            text: "Fluid Check",
                          ),
                          Tab(
                            height: 20,
                            text: "Lights",
                          ),
                          Tab(
                            height: 20,
                            text: "Measures",
                          ),
                          Tab(
                            height: 20,
                            text: "Security",
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                        child: TabBarView(children: [
                      ListIssuesCard(
                          issuesComments: provider.bucketInspectionRR),
                      Container(
                        color: Colors.black,
                      ),
                      Container(
                        color: Colors.blue,
                      ),
                      Container(
                        color: Colors.green,
                      ),
                      Container(
                        color: Colors.yellow,
                      ),
                      Container(
                        color: Colors.pink,
                      ),
                      Container(
                        color: Colors.white,
                      ),
                      Container(
                        color: Colors.orange,
                      ),
                      // ListIssuesCard(
                      //   issuesComments: provider.bucketInspectionRR,
                      //   //index: index,
                      //   // issuesCommentsD:
                      //   //     provider.menuIssuesReceivedD[index]!,
                      // ),
                    ]))
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      // ListView.builder(
      //     padding: const EdgeInsets.all(8),
      //     itemCount: 8,
      //     itemBuilder: (BuildContext context, int index) {
      //       provider.selectIssuesCommentsR(index);
      //       provider.selectIssuesCommentsD(index);
      //       return Padding(
      //           padding: const EdgeInsets.only(bottom: 20.0, right: 10),
      //           child: Container(
      //             decoration: const BoxDecoration(
      //                 color: Colors.white,
      //                 boxShadow: [
      //                   BoxShadow(
      //                       blurRadius: 4,
      //                       color: Colors.grey,
      //                       offset: Offset(10, 10))
      //                 ],
      //                 borderRadius:
      //                     BorderRadius.all(Radius.circular(20))),
      //             width: MediaQuery.of(context).size.width,
      //             height: 200,
      //             child: ListIssuesCard(
      //               issuesComments: provider.bucketInspectionRR,
      //               index: index,
      //               issuesCommentsD:
      //                   provider.menuIssuesReceivedD[index]!,
      //             ),
      //           ));
    );
  }
}
