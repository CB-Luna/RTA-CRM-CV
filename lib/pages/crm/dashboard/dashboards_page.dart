import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart';
import 'package:rta_crm_cv/pages/crm/dashboard/widgets/grafica_esfera_dashboard.dart';
import 'package:rta_crm_cv/pages/crm/dashboard/widgets/marcadores_dashboard.dart';
import 'package:rta_crm_cv/pages/crm/dashboard/widgets/pluto_dashboard.dart';
import 'package:rta_crm_cv/pages/crm/dashboard/widgets/grafica_dashboard.dart';
//import 'package:rta_crm_cv/providers/crm/dashboard_provider.dart';
import 'package:rta_crm_cv/providers/side_menu_provider.dart';
import 'package:rta_crm_cv/public/colors.dart';
import 'package:rta_crm_cv/theme/theme.dart';
import 'package:rta_crm_cv/widgets/side_menu/sidemenu.dart';

class DashboardsCRMPage extends StatefulWidget {
  const DashboardsCRMPage({super.key});

  @override
  State<DashboardsCRMPage> createState() => _DashboardsCRMPageState();
}

class _DashboardsCRMPageState extends State<DashboardsCRMPage> {
  @override
  Widget build(BuildContext context) {
    SideMenuProvider sideM = Provider.of<SideMenuProvider>(context);
    //DashboardCRMProvider provider = Provider.of<DashboardCRMProvider>(context);
    sideM.setIndex(0);

    return Material(
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SideMenu(),
            Flexible(
              child: Container(
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(gradient: whiteGradient),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      //Titulo
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 10, top: 10, right: 10, bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: SizedBox(
                                  height: 40,
                                  width: 40,
                                  child: sideM.aRAccounts != null
                                      ? Rive(artboard: sideM.aRDashboards!)
                                      : const CircularProgressIndicator(),
                                )),
                            Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: SizedBox(
                                height: 40,
                                child: Text('Dashboards',
                                    style: AppTheme.of(context).title1),
                              ),
                            ),
                          ],
                        ),
                      ),
                      //Contenido
                      const Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          // marcadores y grafica
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              //marcadores
                              Padding(
                                padding: EdgeInsets.all(10),
                                child: MarcadoresDashboard(),
                              ),
                              //grafica
                              Padding(
                                padding: EdgeInsets.all(10),
                                child: GraficaDashboard(),
                              )
                            ],
                          ),
                          //Grafica esferas
                          GraficaEsferaDashboard()
                        ],
                      ),
                      //Transaction history
                      const Padding(
                        padding: EdgeInsets.all(10),
                        child: PlutoDashboard(),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
