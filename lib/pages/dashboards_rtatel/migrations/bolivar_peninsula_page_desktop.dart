import 'dart:math';

import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:rta_crm_cv/public/colors.dart';
import 'package:rta_crm_cv/theme/theme.dart';
import 'package:rta_crm_cv/widgets/side_menu/sidemenu.dart';

import '../../../functions/sizes.dart';
import '../../../helpers/globals.dart';
import '../../../providers/dashboard_rta/bolivar_peninsula_provider.dart';
import 'widgets/bolivar_widgets/ftth_card.dart';
import 'widgets/bolivar_widgets/homes_and_lots.dart';

class BolivarPeninsulaPageDeskop extends StatefulWidget {
  const BolivarPeninsulaPageDeskop({super.key});

  @override
  State<BolivarPeninsulaPageDeskop> createState() =>
      _BolivarPeninsulaPageDeskopState();
}

class _BolivarPeninsulaPageDeskopState
    extends State<BolivarPeninsulaPageDeskop> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final BolivarPeninsulaProvider provider =
          Provider.of<BolivarPeninsulaProvider>(
        context,
        listen: false,
      );
      await provider.updateState();
    });
  }

  @override
  Widget build(BuildContext context) {
    // BolivarPeninsulaProvider provider =
    //     Provider.of<BolivarPeninsulaProvider>(context);
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
                      Flexible(
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.5,
                          height: MediaQuery.of(context).size.height * 0.15,
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                              gradient: whiteGradient,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.blue)),
                          child: LinearPercentIndicator(
                            width: MediaQuery.of(context).size.width * 0.3,
                            leading: const Text("93.95%"),
                            animation: true,
                            lineHeight: 20.0,
                            animationDuration: 2000,
                            percent: 0.9395,
                            center: const Text(
                              "93.95%",
                              style: TextStyle(color: Colors.white),
                            ),
                            linearStrokeCap: LinearStrokeCap.roundAll,
                            progressColor: Color(0xff0072F0),
                          ),
                        ),
                      ),
                    ],
                  ),
                  // const SubscriberCardBolivar(),
                  const HomesandLots(),
                  const FTTHCard(),
                  // const FixedWirelessCard(),
                ],
              ),
            ),
          )
        ]),
      ),
    );
  }
}
