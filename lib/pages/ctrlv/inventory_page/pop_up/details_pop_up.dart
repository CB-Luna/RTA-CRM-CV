import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rta_crm_cv/pages/ctrlv/inventory_page/pop_up/generalinfo_pop_up.dart';
import 'package:rta_crm_cv/widgets/custom_card.dart';

import '../../../../models/vehicle.dart';
import '../../../../providers/ctrlv/inventory_provider.dart';
import '../../../../public/colors.dart';
import '../../../../theme/theme.dart';
import '../../../../widgets/side_menu/sidemenu.dart';
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
    InventoryProvider provider = Provider.of<InventoryProvider>(context);

    return Scaffold(
        backgroundColor: Colors.transparent,
        body: Row(
          children: [
            const SideMenu(),
            CustomCard(
                title: 'Details',
                width: MediaQuery.of(context).size.width - 100,
                height: MediaQuery.of(context).size.height,
                child: DefaultTabController(
                  length: 3,
                  initialIndex: 0,
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          gradient: whiteGradient,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(15),
                            bottomRight: Radius.circular(40),
                            bottomLeft: Radius.circular(15),
                          ),
                          border: Border.all(
                              color: AppTheme.of(context).primaryColor,
                              width: 2),
                        ),
                        child: TabBar(
                          onTap: (value) {
                            switch (value) {
                              case 0:
                                provider.setIndex(0);
                                break;
                              case 1:
                                provider.setIndex(1);
                                break;
                              case 2:
                                provider.setIndex(2); //2-3-4
                                break;

                              default:
                            }
                          },
                          indicator: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(40),
                              topRight: Radius.circular(15),
                              bottomRight: Radius.circular(40),
                              bottomLeft: Radius.circular(15),
                            ),
                            color: provider.indexSelected[1]
                                ? Colors.greenAccent
                                : provider.indexSelected[0]
                                    ? Colors.blue
                                    : provider.indexSelected[2]
                                        ? Colors.yellow
                                        : Colors.black,
                          ),
                          splashBorderRadius: BorderRadius.circular(40),
                          labelStyle: const TextStyle(
                            fontFamily: 'UniNeue',
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                          ),
                          unselectedLabelColor:
                              AppTheme.of(context).primaryColor,
                          unselectedLabelStyle: const TextStyle(
                            fontFamily: 'UniNeue',
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                            fontSize: 15,
                          ),
                          tabs: const [
                            Tab(text: 'General Information'),
                            Tab(text: 'Issue Reported'),
                            Tab(text: 'Service'),
                          ],
                        ),
                      ),
                      //
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.81,
                        child: const TabBarView(
                          children: [
                            GeneralInfoPopUP(), //0
                            IssuesPopUp(), // 1
                            ServicePopUp() // 2
                          ],
                        ),
                      ),
                    ],
                  ),
                )),
          ],
        ));
  }
}
