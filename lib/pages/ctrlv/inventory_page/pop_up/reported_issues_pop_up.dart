import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../providers/ctrlv/inventory_provider.dart';
import '../../../../widgets/custom_card.dart';
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
                  ElevatedButton(
                      onPressed: () {
                        provider.setIssueViewActual(0);
                      },
                      child: const Text("BACK")),
                  Container(
                      width: 100,
                      height: 25,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        boxShadow: [BoxShadow(blurRadius: 4, color: Colors.grey, offset: Offset(10, 10))],
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      child: Text(
                        provider.actualVehicle!.licesensePlates,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      )),
                ],
              ),
            ),
            SizedBox(
              height: 500,
              width: 850,
              child: ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: provider.menuIssuesReceived.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                        padding: const EdgeInsets.only(bottom: 20.0, right: 10),
                        child: Container(
                          decoration: const BoxDecoration(
                              color: Colors.white, boxShadow: [BoxShadow(blurRadius: 4, color: Colors.grey, offset: Offset(10, 10))], borderRadius: BorderRadius.all(Radius.circular(20))),
                          width: MediaQuery.of(context).size.width,
                          height: 200,
                          child: ListIssuesCard(
                            issuesComments: provider.menuIssuesReceived[index]!,
                            index: index,
                          ),
                        ));
                  }),
            ),
            // Container(
            //   padding: const EdgeInsets.all(10),
            //   height: 850,
            //   child: Column(
            //     children: [
            //       SizedBox(
            //         height: 30,
            //         child: TabBar(
            //           labelStyle: const TextStyle(
            //             color: Colors.white,
            //             fontSize: 20,
            //             fontWeight: FontWeight.bold,
            //           ),
            //           unselectedLabelColor:
            //               AppTheme.of(context).primaryColor,
            //           indicator: BoxDecoration(
            //             gradient: blueRadial,
            //             borderRadius: const BorderRadius.vertical(
            //                 top: Radius.circular(10)),
            //           ),
            //           tabs: const [
            //             Tab(
            //               height: 30,
            //               text: "Issues Received",
            //             ),
            //             Tab(
            //               height: 30,
            //               text: "Issues Delivered",
            //             ),
            //           ],
            //         ),
            //       ),
            //       Expanded(
            //           child: TabBarView(
            //         children: [
            //           // Menu ISSUES_R

            //           // MENU ISSUES_D
            //           SizedBox(
            //             height: 500,
            //             width: 850,
            //             child: ListView.builder(
            //                 padding: const EdgeInsets.all(8),
            //                 itemCount: provider.menuIssuesReceivedD.length,
            //                 itemBuilder: (BuildContext context, int index) {
            //                   return Padding(
            //                       padding: const EdgeInsets.only(
            //                           bottom: 20.0, right: 10),
            //                       child: Container(
            //                         decoration: const BoxDecoration(
            //                             color: Colors.white,
            //                             boxShadow: [
            //                               BoxShadow(
            //                                   blurRadius: 4,
            //                                   color: Colors.grey,
            //                                   offset: Offset(10, 10))
            //                             ],
            //                             borderRadius: BorderRadius.all(
            //                                 Radius.circular(20))),
            //                         width:
            //                             MediaQuery.of(context).size.width,
            //                         height: 200,
            //                         child: ListIssuesCard(
            //                           issuesComments: provider
            //                               .menuIssuesReceivedD[index]!,
            //                           index: index,
            //                         ),
            //                       ));
            //                 }),
            //           ),
            //         ],
            //       ))
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
