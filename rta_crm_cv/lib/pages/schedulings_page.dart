import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rta_crm_cv/side_menu_provider.dart';
import 'package:rta_crm_cv/widgets/side_menu/sidemenu.dart';

class SchedulingsPage extends StatefulWidget {
  const SchedulingsPage({super.key});

  @override
  State<SchedulingsPage> createState() => _SchedulingsPageState();
}

class _SchedulingsPageState extends State<SchedulingsPage> {
  @override
  Widget build(BuildContext context) {
    SideMenuProvider provider = Provider.of<SideMenuProvider>(context);
    provider.setIndex(2);

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
                color: Colors.yellow,
              ),
            )
          ],
        ),
      ),
    );
  }
}
