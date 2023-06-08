import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rta_crm_cv/providers/crm/dashboard_provider.dart';
import 'package:rta_crm_cv/providers/side_menu_provider.dart';
import 'package:rta_crm_cv/public/colors.dart';
import 'package:rta_crm_cv/widgets/card_header.dart';
import 'package:rta_crm_cv/widgets/side_menu/sidemenu.dart';

class DashboardsCTRLVPage extends StatefulWidget {
  const DashboardsCTRLVPage({super.key});

  @override
  State<DashboardsCTRLVPage> createState() => _DashboardsCTRLVPageState();
}

class _DashboardsCTRLVPageState extends State<DashboardsCTRLVPage> {
  @override
  Widget build(BuildContext context) {
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

    SideMenuProvider provider = Provider.of<SideMenuProvider>(context);
    provider.setIndex(0);

    return Material(
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SideMenu(),
            Expanded(
              child: Container(
                alignment: Alignment.topCenter,
                decoration: BoxDecoration(gradient: whiteGradient),
                child: const CardHeader(text: "Dashboards"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
