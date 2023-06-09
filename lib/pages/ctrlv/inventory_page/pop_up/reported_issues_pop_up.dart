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
    List<String> IssuesName = ["gas", "motor", "oil"];

    return CustomCard(
      width: 450,
      height: 650,
      title: "Photos and Comments ",
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
                onPressed: () {
                  provider.cambioVistaIssues();
                },
                child: Text("BACK")),
          ),
          Container(
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
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20))),
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
    );
  }
}
