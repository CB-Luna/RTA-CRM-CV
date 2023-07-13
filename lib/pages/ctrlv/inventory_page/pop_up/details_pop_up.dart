import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../theme/theme.dart';
import '../../../../widgets/custom_text_icon_button.dart';
import 'issues_pop_up.dart';
import 'service_pop_up.dart';

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
                  Container(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    alignment: Alignment.centerLeft,
                    child: CustomTextIconButton(
                      width: 93,
                      isLoading: false,
                      icon: Icon(Icons.exit_to_app_outlined,
                          color: AppTheme.of(context).primaryBackground),
                      text: 'Exit',
                      onTap: () {
                        context.pop();
                      },
                    ),
                  ),
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
                          text: " Service",
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        GeneralInfoPopUP(vehicle: widget.vehicle),
                        const IssuesPopUp(),
                        const ServicePopUp()
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
