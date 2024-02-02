import 'dart:math';

import 'package:flutter/material.dart';
import 'package:rta_crm_cv/pages/dashboards_rtatel/migrations/widgets/pie_chart_bolivar.dart';
import 'package:rta_crm_cv/public/colors.dart';
import 'package:rta_crm_cv/theme/theme.dart';
import 'package:rta_crm_cv/widgets/side_menu/sidemenu.dart';

import '../../../functions/sizes.dart';
import '../../../helpers/globals.dart';
import '../../../widgets/custom_card.dart';
import 'widgets/bolivar_widgets/ftth_card.dart';
import 'widgets/bolivar_widgets/homes_and_lots.dart';
import 'widgets/bolivar_widgets/pie_chart_2.dart';
import 'widgets/bolivar_widgets/subscriber_card.dart';

class BolivarPeninsulaPageDeskop extends StatefulWidget {
  const BolivarPeninsulaPageDeskop({super.key});

  @override
  State<BolivarPeninsulaPageDeskop> createState() =>
      _BolivarPeninsulaPageDeskopState();
}

class _BolivarPeninsulaPageDeskopState
    extends State<BolivarPeninsulaPageDeskop> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(gradient: whiteGradient),
        child: Row(children: [
          const SideMenu(),
          Expanded(
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: ListView(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.1,
                    child: Row(children: [
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Image.network(
                          assets.logoColor,
                          key: ValueKey(Random().nextInt(100)),
                          height: getHeight(50, context),
                        ),
                      ),
                      Container(
                        //usando el width y el alignment lo pone en el centro, pero marca overflow
                        padding: const EdgeInsets.only(left: 100),
                        child: Text(
                          "​Bolivar Peninsula Fiber to the Home Project",
                          style: AppTheme.of(context).title1,
                        ),
                      )
                    ]),
                  ),
                  Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.all(10),
                        width: MediaQuery.of(context).size.width * 0.2,
                        height: MediaQuery.of(context).size.height * 0.15,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: const Color(0xff263238),
                            borderRadius: BorderRadius.circular(10)),
                        child: const Text(
                          " Overall Target%",
                          style: TextStyle(
                            fontSize: 30,
                            fontFamily: 'Gotham',
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                            width: MediaQuery.of(context).size.width * 0.5,
                            height: MediaQuery.of(context).size.height * 0.15,
                            margin: const EdgeInsets.symmetric(horizontal: 40),
                            color: Colors.white,
                            child: PieChart2(
                              valor: 0.2,
                            )),
                      )
                    ],
                  ),
                  const SubscriberCardBolivar(),
                  const HomesandLots(),
                  const FTTHCard(),
                ],
              ),
            ),
          )
        ]),
      ),
    );
  }
}
