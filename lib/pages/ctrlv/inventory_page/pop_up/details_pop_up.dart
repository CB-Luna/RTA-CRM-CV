import 'package:flutter/material.dart';
import 'package:rta_crm_cv/models/vehicle.dart';
import 'package:rta_crm_cv/pages/ctrlv/inventory_page/pop_up/generalinfo_pop_up.dart';
import 'package:rta_crm_cv/widgets/custom_card.dart';

import '../../../../theme/theme.dart';
import 'issues_pop_up.dart';

class DetailsPopUp extends StatefulWidget {
  final Vehicle vehicle;
  const DetailsPopUp({super.key, required this.vehicle});

  @override
  State<DetailsPopUp> createState() => _DetailsPopUpState();
}

class _DetailsPopUpState extends State<DetailsPopUp> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.transparent,
      content: CustomCard(
          title: 'Details',
          width: 1250,
          height: 600,
          child: SizedBox(
            height: 500,
            width: 1250,
            child: DefaultTabController(
              length: 3,
              initialIndex: 0,
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
                      unselectedLabelColor: Colors.black,
                      indicator: BoxDecoration(
                        color: AppTheme.of(context).primaryColor,
                        borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(10)),
                      ),
                      tabs: const [
                        Tab(
                          height: 30,
                          text: "General Information",
                        ),
                        Tab(
                          height: 30,
                          text: "Issue Reported",
                        ),
                        Tab(
                          height: 30,
                          text: " Services",
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        GeneralInfoPopUP(vehicle: widget.vehicle),
                        // const IssuesPopUp(),
                        // Container(
                        //   height: 200,
                        //   width: 200,
                        //   color: Colors.white,
                        // ),
                        // Container(
                        //   height: 200,
                        //   width: 200,
                        //   color: Colors.blue,
                        // ),
                        const IssuesPopUp(),
                        Container(
                          height: 200,
                          width: 200,
                          color: Colors.green,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
