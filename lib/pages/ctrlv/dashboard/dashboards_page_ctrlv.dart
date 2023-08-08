import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart';
import 'package:rta_crm_cv/pages/crm/dashboard/widgets/Transaction_history.dart';
import 'package:rta_crm_cv/pages/ctrlv/dashboard/widgets/grafica_dashboard_ctrlv.dart';
import 'package:rta_crm_cv/pages/ctrlv/dashboard/widgets/macadores_dashboards_ctrlv.dart';
import 'package:rta_crm_cv/pages/ctrlv/dashboard/widgets/tabla_meses_ctrlv.dart';
import 'package:rta_crm_cv/providers/ctrlv/dashboard_provider.dart';
import 'package:rta_crm_cv/providers/side_menu_provider.dart';
import 'package:rta_crm_cv/public/colors.dart';
import 'package:rta_crm_cv/theme/theme.dart';
import 'package:rta_crm_cv/widgets/custom_scrollbar.dart';
import 'package:rta_crm_cv/widgets/side_menu/sidemenu.dart';

class DashboardsCTRLVPage extends StatefulWidget {
  const DashboardsCTRLVPage({super.key});

  @override
  State<DashboardsCTRLVPage> createState() => _DashboardsCTRLVPageState();
}

class _DashboardsCTRLVPageState extends State<DashboardsCTRLVPage> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final DashboardCVProvider provider = Provider.of<DashboardCVProvider>(
        context,
        listen: false,
      );
      await provider.updateState();
    });
  }

  @override
  Widget build(BuildContext context) {
    SideMenuProvider sideM = Provider.of<SideMenuProvider>(context);
    sideM.setIndex(9);
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
                        padding: const EdgeInsets.only(left: 10, top: 10, right: 10, bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: SizedBox(
                                  height: 40,
                                  width: 40,
                                  child: sideM.aRAccounts != null ? Rive(artboard: sideM.aRDashboards!) : const CircularProgressIndicator(),
                                )),
                            Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: SizedBox(
                                height: 40,
                                child: Text('Dashboards', style: AppTheme.of(context).title1),
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
                          child: MarcadoresDashboardCtrlV(),
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
                              child: GraficaDashboardCtrlV(),
                            ),
                            Padding(
                              padding: EdgeInsets.all(10),
                              child: TablaMesesCtrlV(),
                            ),
                          ],
                        ),
                      ),
                      //Transaction history
                      // const Padding(
                      //   padding: EdgeInsets.all(10),
                      //   child: TransactionHistory(),
                      // )
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
