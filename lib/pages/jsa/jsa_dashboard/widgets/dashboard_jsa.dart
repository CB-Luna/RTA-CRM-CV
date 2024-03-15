import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rta_crm_cv/pages/jsa/jsa_dashboard/widgets/pluto_grid_dashboard_jsa.dart';
import 'package:rta_crm_cv/theme/theme.dart';

import '../../../../providers/jsa/jsa_dashboards_provider.dart';
import 'jsa_graphics.dart';
import 'jsa_information_card.dart';

class DashboardJsa extends StatefulWidget {
  const DashboardJsa({super.key});

  @override
  State<DashboardJsa> createState() => _DashboardJsaState();
}

class _DashboardJsaState extends State<DashboardJsa> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final JSADashboardProvider provider = Provider.of<JSADashboardProvider>(
        context,
        listen: false,
      );
      await provider.updateState();
    });
  }

  @override
  Widget build(BuildContext context) {
    JSADashboardProvider provider = Provider.of<JSADashboardProvider>(context);

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            JSAInformationCard(
              colorCard: AppTheme.of(context).primaryColor,
              text: "Documents",
              value: provider.listJSA.length,
            ),
            JSAInformationCard(
              colorCard: Colors.green,
              text: "Signeds",
              value: provider.jsaSigned,
            ),
            JSAInformationCard(
              colorCard: AppTheme.of(context).smiPrimary,
              text: "Pending",
              value: provider.jsaPending,
            ),
            JSAInformationCard(
              colorCard: AppTheme.of(context).odePrimary,
              text: "Draft",
              value: provider.jsaDraft,
            ),
          ],
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.4,
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppTheme.of(context).cryPrimary)),
          child: BarChartExample(
            labels: [
              DateFormat("MMM").format(DateTime(provider.dateRange.end.year,
                  provider.dateRange.end.month - 11)),
              DateFormat("MMM").format(DateTime(provider.dateRange.end.year,
                  provider.dateRange.end.month - 10)),
              DateFormat("MMM").format(DateTime(provider.dateRange.end.year,
                  provider.dateRange.end.month - 9)),
              DateFormat("MMM").format(DateTime(provider.dateRange.end.year,
                  provider.dateRange.end.month - 8)),
              DateFormat("MMM").format(DateTime(provider.dateRange.end.year,
                  provider.dateRange.end.month - 7)),
              DateFormat("MMM").format(DateTime(provider.dateRange.end.year,
                  provider.dateRange.end.month - 6)),
              DateFormat("MMM").format(DateTime(provider.dateRange.end.year,
                  provider.dateRange.end.month - 5)),
              DateFormat("MMM").format(DateTime(provider.dateRange.end.year,
                  provider.dateRange.end.month - 4)),
              DateFormat("MMM").format(DateTime(provider.dateRange.end.year,
                  provider.dateRange.end.month - 3)),
              DateFormat("MMM").format(DateTime(provider.dateRange.end.year,
                  provider.dateRange.end.month - 2)),
              DateFormat("MMM").format(DateTime(provider.dateRange.end.year,
                  provider.dateRange.end.month - 1)),
              DateFormat("MMM").format(provider.dateRange.end)
            ],
            totaldocuments: [
              provider.elevenMonthsAgoEndSigned +
                  provider.elevenMonthsAgoEndPending +
                  provider.elevenMonthsAgoEndDraft,
              provider.tenMonthsAgoEndSigned +
                  provider.tenMonthsAgoEndPending +
                  provider.tenMonthsAgoEndDraft,
              provider.nineMonthsAgoEndSigned +
                  provider.nineMonthsAgoEndPending +
                  provider.nineMonthsAgoEndDraft,
              provider.eightMonthsAgoEndSigned +
                  provider.eightMonthsAgoEndPending +
                  provider.eightMonthsAgoEndDraft,
              provider.sevenMonthsAgoEndSigned +
                  provider.sevenMonthsAgoEndPending +
                  provider.sevenMonthsAgoEndDraft,
              provider.sixMonthsAgoEndSigned +
                  provider.sixMonthsAgoEndPending +
                  provider.sixMonthsAgoEndDraft,
              provider.fiveMonthsAgoEndSigned +
                  provider.fiveMonthsAgoEndPending +
                  provider.fiveMonthsAgoEndDraft,
              provider.fourMonthsAgoEndSigned +
                  provider.fourMonthsAgoEndPending +
                  provider.fourMonthsAgoEndDraft,
              provider.threeMonthsAgoEndSigned +
                  provider.threeMonthsAgoEndPending +
                  provider.threeMonthsAgoEndDraft,
              provider.twoMonthsAgoEndSigned +
                  provider.twoMonthsAgoEndPending +
                  provider.twoMonthsAgoEndDraft,
              provider.oneMonthAgoEndSigned +
                  provider.oneMonthAgoEndPending +
                  provider.oneMonthAgoEndDraft,
              provider.actualMonthEndSigned +
                  provider.actualMonthEndPending +
                  provider.actualMonthEndDraft,
            ], // TotalDocuments
            totalsigned: [
              provider.elevenMonthsAgoEndSigned,
              provider.tenMonthsAgoEndSigned,
              provider.nineMonthsAgoEndSigned,
              provider.eightMonthsAgoEndSigned,
              provider.sevenMonthsAgoEndSigned,
              provider.sixMonthsAgoEndSigned,
              provider.fiveMonthsAgoEndSigned,
              provider.fourMonthsAgoEndSigned,
              provider.threeMonthsAgoEndSigned,
              provider.twoMonthsAgoEndSigned,
              provider.oneMonthAgoEndSigned,
              provider.actualMonthEndSigned,
            ],
            totalpending: [
              provider.elevenMonthsAgoEndPending,
              provider.tenMonthsAgoEndPending,
              provider.nineMonthsAgoEndPending,
              provider.eightMonthsAgoEndPending,
              provider.sevenMonthsAgoEndPending,
              provider.sixMonthsAgoEndPending,
              provider.fiveMonthsAgoEndPending,
              provider.fourMonthsAgoEndPending,
              provider.threeMonthsAgoEndPending,
              provider.twoMonthsAgoEndPending,
              provider.oneMonthAgoEndPending,
              provider.actualMonthEndPending,
            ],
            totalDraft: [
              provider.elevenMonthsAgoEndDraft,
              provider.tenMonthsAgoEndDraft,
              provider.nineMonthsAgoEndDraft,
              provider.eightMonthsAgoEndDraft,
              provider.sevenMonthsAgoEndDraft,
              provider.sixMonthsAgoEndDraft,
              provider.fiveMonthsAgoEndDraft,
              provider.fourMonthsAgoEndDraft,
              provider.threeMonthsAgoEndDraft,
              provider.twoMonthsAgoEndDraft,
              provider.oneMonthAgoEndDraft,
              provider.actualMonthEndDraft,
            ],
          ),
        ),
        const PlutoGridDashboardJSA()
        // Container(
        //     decoration: BoxDecoration(
        //         border: Border.all(color: AppTheme.of(context).primaryColor),
        //         borderRadius: BorderRadius.circular(10)),
        //     child: Column(
        //       mainAxisAlignment: MainAxisAlignment.start,
        //       crossAxisAlignment: CrossAxisAlignment.start,
        //       children: [
        //         Padding(
        //           padding: const EdgeInsets.symmetric(
        //               horizontal: 20.0, vertical: 10.0),
        //           child: Text(
        //             "JSA Document History",
        //             style: TextStyle(
        //                 color: AppTheme.of(context).primaryColor, fontSize: 25),
        //           ),
        //         ),
        //         ExpansionPanelList(
        //           expandedHeaderPadding: EdgeInsets.zero,
        //           elevation: 0,
        //           children: [
        //             ExpansionPanel(
        //               isExpanded: provider.istaped,
        //               canTapOnHeader: true,
        //               headerBuilder: (context, expanded) {
        //                 return Container(
        //                   decoration: BoxDecoration(
        //                       gradient: whiteGradient,
        //                       borderRadius: BorderRadius.circular(10)),
        //                   child: const Row(
        //                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //                     children: [
        //                       Text("a"),
        //                       Text("b"),
        //                       Text("c"),
        //                       Text("d"),
        //                       Text("e"),
        //                       Text("f"),
        //                       Text("g"),
        //                     ],
        //                   ),
        //                 );
        //               },
        //               body: Container(
        //                 height: 300,
        //                 child: Padding(
        //                   padding: const EdgeInsets.symmetric(
        //                     //horizontal: 24,
        //                     vertical: 6,
        //                   ),
        //                   child: ListView.builder(
        //                     shrinkWrap: true,
        //                     itemCount: provider.jsaDocuments.length,
        //                     controller: ScrollController(),
        //                     scrollDirection: Axis.vertical,
        //                     itemBuilder: (BuildContext ctx, index) {
        //                       return Container(
        //                         height: 50,
        //                         width: 200,
        //                         color: Colors.red,
        //                       );
        //                     },
        //                   ),
        //                 ),
        //               ),
        //             )

        //             // const PlutoGridDashboardJSA()),
        //             // ExpansionPanel(
        //             //     isExpanded: provider.istaped,
        //             //     canTapOnHeader: true,
        //             //     headerBuilder: (context, expanded) {
        //             //       return Container(
        //             //         margin: const EdgeInsets.symmetric(horizontal: 10),
        //             //         decoration: BoxDecoration(
        //             //             gradient: whiteGradient,
        //             //             borderRadius: BorderRadius.circular(10)),
        //             //         child: const Row(
        //             //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //             //           children: [
        //             //             Text("a"),
        //             //             Text("b"),
        //             //             Text("c"),
        //             //             Text("d"),
        //             //             Text("e"),
        //             //             Text("f"),
        //             //             Text("g"),
        //             //           ],
        //             //         ),
        //             //       );
        //             //     },
        //             //     body: const PlutoGridDashboardJSA()),
        //           ],
        //           expansionCallback: (panelIndex, isExpanded) {
        //             print(provider.jsaDocuments.length);
        //             setState(() {
        //               provider.istaped = !provider.istaped;
        //             });
        //           },
        //         ),
        //       ],
        //     ))
      ],
    );
  }
}
