import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rta_crm_cv/providers/side_menu_provider.dart';
import 'package:rta_crm_cv/widgets/side_menu/sidemenu.dart';

class NetworkPage extends StatefulWidget {
  const NetworkPage({super.key});

  @override
  State<NetworkPage> createState() => _NetworkPageState();
}

class _NetworkPageState extends State<NetworkPage> {
  @override
  Widget build(BuildContext context) {
    SideMenuProvider provider = Provider.of<SideMenuProvider>(context);
    provider.setIndex(3);

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
                color: Colors.purple,
              ),
            )
          ],
        ),
      ),
    );
  }
}
