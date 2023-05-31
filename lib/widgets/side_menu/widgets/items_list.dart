import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart';
import 'package:rta_crm_cv/functions/sizes.dart';
import 'package:rta_crm_cv/providers/providers.dart';
import 'package:rta_crm_cv/widgets/side_menu/widgets/item.dart';

class SideMenuItemsList extends StatefulWidget {
  const SideMenuItemsList({super.key, required this.isOpen});

  final bool isOpen;

  @override
  State<SideMenuItemsList> createState() => _SideMenuItemsListState();
}

class _SideMenuItemsListState extends State<SideMenuItemsList> {
  @override
  Widget build(BuildContext context) {
    SideMenuProvider provider = Provider.of<SideMenuProvider>(context);
    final UserState userState = Provider.of<UserState>(context);
    return Padding(
      padding: EdgeInsets.only(left: widget.isOpen ? 40 : 0),
      child: SizedBox(
        width: !widget.isOpen ? 70 : null,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SideMenuItem(
              selected: provider.indexSelected[0],
              leading: provider.aRDashboards != null ? Rive(artboard: provider.aRDashboards!) : const CircularProgressIndicator(),
              isOpen: widget.isOpen,
              title: 'Dashbords',
              onTap: () async {
                context.pushReplacement('/dashboards');
              },
              onEnter: (event) {
                provider.iHoverDashboards?.change(true);
              },
              onExit: (event) {
                provider.iHoverDashboards?.change(false);
              },
            ),
            SideMenuItem(
              selected: provider.indexSelected[1],
              leading: provider.aRAccounts != null ? Rive(artboard: provider.aRAccounts!) : const CircularProgressIndicator(),
              isOpen: widget.isOpen,
              title: 'Accounts',
              onTap: () async {
                context.pushReplacement('/accounts');
              },
              onEnter: (event) {
                provider.iHoverAccounts?.change(true);
              },
              onExit: (event) {
                provider.iHoverAccounts?.change(false);
              },
            ),
            SideMenuItem(
              selected: provider.indexSelected[2],
              leading: provider.aRSchedulings != null ? Rive(artboard: provider.aRSchedulings!) : const CircularProgressIndicator(),
              isOpen: widget.isOpen,
              title: 'Scheduling',
              onTap: () async {
                context.pushReplacement('/schedulings');
              },
              onEnter: (event) {
                provider.iHoverSchedulings?.change(true);
              },
              onExit: (event) {
                provider.iHoverSchedulings?.change(false);
              },
            ),
            SideMenuItem(
              selected: provider.indexSelected[3],
              leading: provider.aRNetworks != null ? Rive(artboard: provider.aRNetworks!) : const CircularProgressIndicator(),
              isOpen: widget.isOpen,
              title: 'Network',
              onTap: () async {
                context.pushReplacement('/network');
              },
              onEnter: (event) {
                provider.iHoverNetworks?.change(true);
              },
              onExit: (event) {
                provider.iHoverNetworks?.change(false);
              },
            ),
            SideMenuItem(
              selected: provider.indexSelected[4],
              leading: provider.aRTickets != null ? Rive(artboard: provider.aRTickets!) : const CircularProgressIndicator(),
              isOpen: widget.isOpen,
              title: 'Tickets',
              onTap: () async {
                context.pushReplacement('/tickets');
              },
              onEnter: (event) {
                provider.iHoverTickets?.change(true);
              },
              onExit: (event) {
                provider.iHoverTickets?.change(false);
              },
            ),
            SideMenuItem(
              selected: provider.indexSelected[5],
              leading: provider.aRInventories != null ? Rive(artboard: provider.aRInventories!) : const CircularProgressIndicator(),
              isOpen: widget.isOpen,
              title: 'Inventory',
              onTap: () async {
                context.pushReplacement('/inventory');
              },
              onEnter: (event) {
                provider.iHoverInventories?.change(true);
              },
              onExit: (event) {
                provider.iHoverInventories?.change(false);
              },
            ),
            SideMenuItem(
              selected: provider.indexSelected[6],
              leading: provider.aRReports != null ? Rive(artboard: provider.aRReports!) : const CircularProgressIndicator(),
              isOpen: widget.isOpen,
              title: 'Reports',
              onTap: () async {
                context.pushReplacement('/reports');
              },
              onEnter: (event) {
                provider.iHoverReports?.change(true);
              },
              onExit: (event) {
                provider.iHoverReports?.change(false);
              },
            ),
            SideMenuItem(
              selected: provider.indexSelected[7],
              leading: provider.aRUsers != null ? Rive(artboard: provider.aRUsers!) : const CircularProgressIndicator(),
              isOpen: widget.isOpen,
              title: 'Users',
              onTap: () async {
                context.pushReplacement('/users');
              },
              onEnter: (event) {
                provider.iHoverUsers?.change(true);
              },
              onExit: (event) {
                provider.iHoverUsers?.change(false);
              },
            ),
            SideMenuItem(
              selected: provider.indexSelected[8],
              leading: Icon(Icons.color_lens_outlined, color: Color(Colors.grey[300]!.value)),
              isOpen: widget.isOpen,
              title: 'Configurator',
              onTap: () async {
                context.pushReplacement('/config');
              },
              onEnter: (event) {
                //provider.iHoverUsers?.change(true);
              },
              onExit: (event) {
                //provider.iHoverUsers?.change(false);
              },
            ),
            SideMenuItem(
              selected: provider.indexSelected[8],
              leading: Icon(Icons.power_settings_new_outlined, color: Colors.red),
              isOpen: widget.isOpen,
              title: 'Logout',
              onTap: () async {
                userState.logout();
              },
              onEnter: (event) {
                //provider.iHoverUsers?.change(true);
              },
              onExit: (event) {
                //provider.iHoverUsers?.change(false);
              },
            ),
          ],
        ),
      ),
    );
  }
}
