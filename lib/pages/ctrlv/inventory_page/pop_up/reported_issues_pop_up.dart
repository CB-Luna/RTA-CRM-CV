import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
                        setState(() {
                          dropdownvalue = newValue!;
                        });
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
                    onTap: () => provider.stateManager!.setShowColumnFilter(
                        !provider.stateManager!.showColumnFilter),
                  ),
                ),
              ],
            )),
            SizedBox(
              height: 500,
              width: 850,
              child: ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: 8,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                        padding: const EdgeInsets.only(bottom: 20.0, right: 10),
                        child: Container(
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 4,
                                    color: Colors.grey,
                                    offset: Offset(10, 10))
                              ],
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          width: MediaQuery.of(context).size.width,
                          height: 200,
                          child: ListIssuesCard(
                            issuesComments: provider.menuIssuesReceived[index]!,
                            index: index,
                            issuesCommentsD:
                                provider.menuIssuesReceivedD[index]!,
                          ),
                        ));
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
