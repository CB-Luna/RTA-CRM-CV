import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rta_crm_cv/pages/ctrlv/inventory_page/pop_up/comments_photos_pop_up.dart';

import '../../../../models/user.dart';
import '../../../../models/vehicle.dart';
import '../../../../providers/ctrlv/inventory_provider.dart';
import '../../../../widgets/custom_card.dart';
import '../widgets/listIssuesCard.dart';

class ReportedIssues extends StatefulWidget {
  final Vehicle vehicle;
  const ReportedIssues({super.key, required this.vehicle});

  @override
  State<ReportedIssues> createState() => _ReportedIssuesState();
}

class _ReportedIssuesState extends State<ReportedIssues> {
  @override
  Widget build(BuildContext context) {
    InventoryProvider provider = Provider.of<InventoryProvider>(context);
    List<String> IssuesName = ["gas", "motor", "oil"];

    //provider.getIssues(widget.vehicle, provider.users);
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
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(20)),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 0.1,
                                      blurRadius: 3,
                                      offset: const Offset(
                                          0, 0), // changes position of shadow
                                    ),
                                  ]),
                              child: Text(widget.vehicle.licesensePlates)),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 500,
                      width: 450,
                      child: ListView.builder(
                          padding: const EdgeInsets.all(8),
                          itemCount: IssuesName.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                                padding: const EdgeInsets.only(bottom: 5.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(),
                                      color: Colors.white,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(20))),
                                  width: MediaQuery.of(context).size.width,
                                  height: 200,
                                  child: ListIssuesCard(
                                    TextoPrueba: IssuesName[index],
                                  ),
                                ));
                          }),
                    )
                  ],
                ),
              )
            : const CommentsPhotosPopUp());
  }
}
