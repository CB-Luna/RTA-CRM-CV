import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart';
import 'package:rta_crm_cv/pages/crm/dashboard/widgets/Tabla_meses.dart';
import 'package:rta_crm_cv/pages/crm/dashboard/widgets/marcadores_dashboard.dart';
import 'package:rta_crm_cv/pages/crm/dashboard/widgets/Transaction_history.dart';
import 'package:rta_crm_cv/pages/crm/dashboard/widgets/grafica_dashboard.dart';
import 'package:rta_crm_cv/providers/crm/dashboard_provider.dart';
import 'package:rta_crm_cv/providers/side_menu_provider.dart';
import 'package:rta_crm_cv/public/colors.dart';
import 'package:rta_crm_cv/theme/theme.dart';
import 'package:rta_crm_cv/widgets/custom_scrollbar.dart';
import 'package:rta_crm_cv/widgets/side_menu/sidemenu.dart';

class DashboardsCRMPage extends StatefulWidget {
  const DashboardsCRMPage({super.key});

  @override
  State<DashboardsCRMPage> createState() => _DashboardsCRMPageState();
}

class _DashboardsCRMPageState extends State<DashboardsCRMPage> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final DashboardCRMProvider provider = Provider.of<DashboardCRMProvider>(
        context,
        listen: false,
      );
      await provider.updateState();
    });
  }

  @override
  Widget build(BuildContext context) {
    SideMenuProvider sideM = Provider.of<SideMenuProvider>(context);
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
                child: CustomScrollBar(
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
                      const Padding(
                        padding: EdgeInsets.all(10),
                        child: CustomScrollBar(
                          scrollDirection: Axis.horizontal,
                          child: MarcadoresDashboard(),
                        ),
                      ),
                      const CustomScrollBar(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(10),
                              child: GraficaDashboard(),
                            ),
                            Padding(
                              padding: EdgeInsets.all(10),
                              child: TablaMeses(),
                            ),
                          ],
                        ),
                      ),
                      //Transaction history
                      const Padding(
                        padding: EdgeInsets.all(10),
                        child: TransactionHistory(),
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
