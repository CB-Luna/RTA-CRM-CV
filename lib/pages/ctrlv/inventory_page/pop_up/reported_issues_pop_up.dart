import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rta_crm_cv/pages/ctrlv/inventory_page/pop_up/comments_photos_pop_up.dart';
import 'package:rta_crm_cv/public/colors.dart';

import '../../../../providers/ctrlv/inventory_provider.dart';
import '../../../../theme/theme.dart';
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
        backgroundColor: Colors.transparent,
        content: provider.vistaPhotosComments
            ? CustomCard(
                width: 450,
                height: 562,
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
                                provider.cambioVistaIssues();
                              },
                              child: Text("BACK")),
                          Container(
                              width: 100,
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
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                              ),
                              child: Text(
                                provider.actualVehicle!.licesensePlates,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              )),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      height: 550,
                      child: DefaultTabController(
                          length: 2,
                          child: Column(
                            children: [
                              SizedBox(
                                height: 30,
                                child: TabBar(
                                  labelStyle: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  unselectedLabelColor:
                                      AppTheme.of(context).primaryColor,
                                  indicator: BoxDecoration(
                                    color: AppTheme.of(context).primaryColor,
                                    borderRadius: const BorderRadius.vertical(
                                        top: Radius.circular(10)),
                                  ),
                                  tabs: const [
                                    Tab(
                                      height: 30,
                                      text: "Issues_R",
                                    ),
                                    Tab(
                                      height: 30,
                                      text: "Issues_D",
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                  child: TabBarView(
                                children: [
                                  // Menu ISSUES_R
                                  SizedBox(
                                    height: 500,
                                    width: 450,
                                    child: ListView.builder(
                                        padding: const EdgeInsets.all(8),
                                        itemCount:
                                            provider.menuIssuesReceived.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 20.0, right: 10),
                                              child: Container(
                                                decoration: const BoxDecoration(
                                                    color: Colors.white,
                                                    boxShadow: [
                                                      BoxShadow(
                                                          blurRadius: 4,
                                                          color: Colors.grey,
                                                          offset:
                                                              Offset(10, 10))
                                                    ],
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                20))),
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                height: 200,
                                                child: ListIssuesCard(
                                                  issuesComments: provider
                                                          .menuIssuesReceived[
                                                      index]!,
                                                  index: index,
                                                ),
                                              ));
                                        }),
                                  ),
                                  // MENU ISSUES_D
                                  SizedBox(
                                    height: 500,
                                    width: 450,
                                    child: ListView.builder(
                                        padding: const EdgeInsets.all(8),
                                        itemCount:
                                            provider.menuIssuesReceivedD.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 20.0, right: 10),
                                              child: Container(
                                                decoration: const BoxDecoration(
                                                    color: Colors.white,
                                                    boxShadow: [
                                                      BoxShadow(
                                                          blurRadius: 4,
                                                          color: Colors.grey,
                                                          offset:
                                                              Offset(10, 10))
                                                    ],
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                20))),
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                height: 200,
                                                child: ListIssuesCard(
                                                  issuesComments: provider
                                                          .menuIssuesReceivedD[
                                                      index]!,
                                                  index: index,
                                                ),
                                              ));
                                        }),
                                  ),
                                ],
                              ))
                            ],
                          )),
                    ),
                  ],
                ),
              )
            : const CommentsPhotosPopUp());
  }
}
