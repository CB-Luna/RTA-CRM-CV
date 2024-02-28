import 'package:flutter/material.dart';
import 'package:rta_crm_cv/public/colors.dart';
import 'package:rta_crm_cv/widgets/side_menu/sidemenu.dart';

class JSADashboards extends StatefulWidget {
  const JSADashboards({super.key});

  @override
  State<JSADashboards> createState() => _JSADashboardsState();
}

class _JSADashboardsState extends State<JSADashboards> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(gradient: whiteGradient),
        child: Row(
          children: [
            const SideMenu(),
            Container(),
          ],
        ),
      ),
    );
  }
}
