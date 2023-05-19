import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rta_crm_cv/providers/side_menu_provider.dart';
import 'package:rta_crm_cv/widgets/side_menu/sidemenu.dart';

class DashboardsPage extends StatefulWidget {
  const DashboardsPage({super.key});

  @override
  State<DashboardsPage> createState() => _DashboardsPageState();
}

class _DashboardsPageState extends State<DashboardsPage> {
  @override
  Widget build(BuildContext context) {
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
                color: Colors.red,
              ),
            )
          ],
        ),
      ),
    );
  }
}
