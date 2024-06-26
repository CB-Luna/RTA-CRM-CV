// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart';
import 'package:rta_crm_cv/helpers/constants.dart';
import 'package:rta_crm_cv/helpers/globals.dart';
import 'package:rta_crm_cv/providers/jsa/jsa_training_provider.dart';
import 'package:rta_crm_cv/providers/providers.dart';
import 'package:rta_crm_cv/theme/theme.dart';
import 'package:rta_crm_cv/widgets/side_menu/widgets/item.dart';
import 'package:rta_crm_cv/widgets/side_menu/widgets/manager_button.dart';
import 'package:rta_crm_cv/widgets/side_menu/widgets/menu_button.dart';
import 'package:rta_crm_cv/widgets/side_menu/widgets/sales/sales_button.dart';

import 'call_center_button.dart';
import 'gigfast_network_button.dart';
import 'surveys/surveys_button.dart';

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
    JsaSafetyProvider providerJSASP = Provider.of<JsaSafetyProvider>(context);

    // UsersProvider userProvider = Provider.of<UsersProvider>(context);
    final UserState userState = Provider.of<UserState>(context);
    final userPermissions = currentUser!.currentRole.permissions;
    return Padding(
      padding: EdgeInsets.only(left: widget.isOpen ? 40 : 0),
      child: SizedBox(
        width: !widget.isOpen ? 70 : null,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Sección CRM
            if (userPermissions.prospects != null)
              SideMenuItem(
                selected: provider.indexSelected[1],
                leading: provider.aRAccounts != null
                    ? Rive(artboard: provider.aRAccounts!)
                    : const CircularProgressIndicator(),
                isOpen: widget.isOpen,
                title: 'Prospects',
                onTap: () async {
                  context.pushReplacement('/prospects');
                },
                onEnter: (event) {
                  provider.iHoverAccounts?.change(true);
                },
                onExit: (event) {
                  provider.iHoverAccounts?.change(false);
                },
              ),
            if (userPermissions.scheduling != null)
              SideMenuItem(
                selected: provider.indexSelected[2],
                leading: provider.aRSchedulings != null
                    ? Rive(artboard: provider.aRSchedulings!)
                    : const CircularProgressIndicator(),
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
            if (userPermissions.network != null)
              SideMenuItem(
                selected: provider.indexSelected[3],
                leading: provider.aRNetworks != null
                    ? Rive(artboard: provider.aRNetworks!)
                    : const CircularProgressIndicator(),
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
            if (userPermissions.tickets != null)
              SideMenuItem(
                selected: provider.indexSelected[4],
                leading: provider.aRTickets != null
                    ? Rive(artboard: provider.aRTickets!)
                    : const CircularProgressIndicator(),
                isOpen: widget.isOpen,
                //title: 'Tickets',
                onTap: () async {
                  context.pushReplacement(routeTickets);
                },
                onEnter: (event) {
                  provider.iHoverTickets?.change(true);
                },
                onExit: (event) {
                  provider.iHoverTickets?.change(false);
                },
              ),
            if (userPermissions.order != null)
              SideMenuItem(
                selected: provider.indexSelected[4],
                leading: provider.aRTickets != null
                    ? Rive(artboard: provider.aRTickets!)
                    : const CircularProgressIndicator(),
                isOpen: widget.isOpen,
                title: 'Order',
                onTap: () async {
                  context.pushReplacement(routeQuotes);
                },
                onEnter: (event) {
                  provider.iHoverTickets?.change(true);
                },
                onExit: (event) {
                  provider.iHoverTickets?.change(false);
                },
              ),
            if (userPermissions.campaigns != null)
              SideMenuItem(
                selected: provider.indexSelected[5],
                leading: provider.aRInventories != null
                    ? Rive(artboard: provider.aRInventories!)
                    : const CircularProgressIndicator(),
                isOpen: widget.isOpen,
                title: 'Campaigns',
                onTap: () async {
                  context.pushReplacement(routeCampaigns);
                },
                onEnter: (event) {
                  provider.iHoverInventories?.change(true);
                },
                onExit: (event) {
                  provider.iHoverInventories?.change(false);
                },
              ),
            if (userPermissions.reports != null)
              SideMenuItem(
                selected: provider.indexSelected[6],
                leading: provider.aRReports != null
                    ? Rive(artboard: provider.aRReports!)
                    : const CircularProgressIndicator(),
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

            // Sección CONTROL VEHICULAR
            if (userPermissions.vehicleStatus != null)
              SideMenuItem(
                selected: provider.indexSelected[8],
                leading: provider.aRMonitory != null
                    ? Rive(artboard: provider.aRMonitory!)
                    : const CircularProgressIndicator(),
                isOpen: widget.isOpen,
                title: 'Vehicle Status',
                onTap: () async {
                  context.pushReplacement('/vehicle_status');
                },
                onEnter: (event) {
                  provider.iHoverMonitory?.change(true);
                },
                onExit: (event) {
                  provider.iHoverMonitory?.change(false);
                },
              ),
            if (userPermissions.inventory != null)
              SideMenuItem(
                selected: provider.indexSelected[7],
                leading: provider.aRInventories != null
                    ? Rive(artboard: provider.aRInventories!)
                    : const CircularProgressIndicator(),
                isOpen: widget.isOpen,
                title: 'Inventory',
                onTap: () async {
                  context.pushReplacement(routeInventory);
                },
                onEnter: (event) {
                  provider.iHoverInventories?.change(true);
                },
                onExit: (event) {
                  provider.iHoverInventories?.change(false);
                },
              ),
            if (userPermissions.downloadApk != null)
              SideMenuItem(
                selected: provider.indexSelected[13],
                leading: provider.aRDownloadAPK != null
                    ? Rive(artboard: provider.aRDownloadAPK!)
                    : const CircularProgressIndicator(),
                isOpen: widget.isOpen,
                title: 'Download APK',
                onTap: () async {
                  context.pushReplacement(routeDownloadAPK);
                },
                onEnter: (event) {
                  provider.iHoverDownloadAPK?.change(true);
                },
                onExit: (event) {
                  provider.iHoverDownloadAPK?.change(false);
                },
              ),

            if (userPermissions.users != null)
              SideMenuItem(
                selected: provider.indexSelected[10],
                leading: provider.aRUsers != null
                    ? Rive(artboard: provider.aRUsers!)
                    : const CircularProgressIndicator(),
                isOpen: widget.isOpen,
                title: 'Users',
                onTap: () async {
                  context.pushReplacement('/users');
                  // userProvider.company = currentUser!.company.company;
                },
                onEnter: (event) {
                  provider.iHoverUsers?.change(true);
                },
                onExit: (event) {
                  provider.iHoverUsers?.change(false);
                },
              ),
            if (userPermissions.dashboards != null)
              SideMenuItem(
                selected: provider.indexSelected[9],
                leading: provider.aRDashboards != null
                    ? Rive(artboard: provider.aRDashboards!)
                    : const CircularProgressIndicator(),
                isOpen: widget.isOpen,
                title: 'Dashboards',
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
            if (userPermissions.configuratorSm != null)
              SideMenuItem(
                selected: provider.indexSelected[11],
                leading: Icon(Icons.color_lens_outlined,
                    color: Color(Colors.grey[300]!.value)),
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

            // Sección Dashboards RTATEL
            userPermissions.sales != null
                ? Padding(
                    padding: const EdgeInsets.only(top: 5.5, bottom: 5.5),
                    child: SalesButton(
                      tooltip: 'Sales',
                      fillColor: AppTheme.of(context).primaryColor,
                      icon: Icons.point_of_sale_outlined,
                      // isTaped: visualState.isTaped[3],
                    ),
                  )
                : Container(),

            userPermissions.surveys != null
                ? Padding(
                    padding: const EdgeInsets.only(top: 5.5, bottom: 5.5),
                    child: SurveysButton(
                      tooltip: 'Surveys',
                      fillColor: AppTheme.of(context).primaryColor,
                      icon: Icons.content_paste_outlined,
                      // isTaped: visualState.isTaped[3],
                    ),
                  )
                : Container(),

            userPermissions.manager != null
                ? Padding(
                    padding: const EdgeInsets.only(top: 5.5, bottom: 5.5),
                    child: ManagerButton(
                      tooltip: 'Manager',
                      fillColor: AppTheme.of(context).primaryColor,
                      icon: Icons.group_outlined,
                      // isTaped: visualState.isTaped[3],
                    ),
                  )
                : Container(),

            userPermissions.gigFastNetwork != null
                ? Padding(
                    padding: const EdgeInsets.only(top: 5.5, bottom: 5.5),
                    child: GigfastNetworkButton(
                      tooltip: 'GigFast Network',
                      fillColor: AppTheme.of(context).primaryColor,
                      icon: Icons.rss_feed_outlined,
                      // isTaped: visualState.isTaped[3],
                    ),
                  )
                : Container(),

            userPermissions.callCenter != null
                ? Padding(
                    padding: const EdgeInsets.only(top: 5.5, bottom: 5.5),
                    child: CallCenterButton(
                      tooltip: 'Call Center',
                      fillColor: AppTheme.of(context).primaryColor,
                      icon: Icons.phone_in_talk_outlined,
                      // isTaped: visualState.isTaped[3],
                    ),
                  )
                : Container(),

            userPermissions.fmt != null
                ? Padding(
                    padding: const EdgeInsets.only(top: 5.5, bottom: 5.5),
                    child: MenuButton(
                      tooltip: 'FMT',
                      fillColor: AppTheme.of(context).primaryColor,
                      icon: Icons.local_shipping_outlined,
                      // isTaped: visualState.isTaped[7],
                      onPressed: () {
                        context.pushReplacement(fmt);
                      },
                    ),
                  )
                : Container(),
            // userPermissions.wop != null
            //     ? Padding(
            //         padding: const EdgeInsets.only(top: 5.5, bottom: 5.5),
            //         child: MenuButton(
            //           tooltip: 'WOP',
            //           fillColor: AppTheme.of(context).primaryColor,
            //           icon: Icons.engineering_outlined,
            //           // isTaped: visualState.isTaped[7],
            //           onPressed: () {
            //             context.pushReplacement(wop);
            //           },
            //         ),
            //       )
            //     : Container(),
            currentUser!.isAdminDashboards
                ? Padding(
                    padding: const EdgeInsets.only(top: 5.5, bottom: 5.5),
                    child: MenuButton(
                      buttonSize: 40,
                      tooltip: 'Create Menu',
                      fillColor: AppTheme.of(context).primaryColor,
                      icon: Icons.menu,
                      // isTaped: visualState.isTaped[7],
                      onPressed: () async {
                        // await showDialog(
                        //     context: context,
                        //     builder: (BuildContext context) {
                        //       return const ConfigPageDashboard();
                        //     });
                        context.pushReplacement(routemaintenanceDashboard);
                      },
                    ),
                  )
                : Container(),

            // JSA Section

            // Jsa Dashboards
            currentUser!.isAdminJSA ||
                    currentUser!.isRepresentativeJSA ||
                    currentUser!.isManagerJSA
                ? Padding(
                    padding: const EdgeInsets.only(top: 5.5, bottom: 5.5),
                    child: MenuButton(
                      buttonSize: 40,
                      tooltip: 'JSA Dashbords',
                      fillColor: AppTheme.of(context).primaryColor,
                      icon: Icons.menu,
                      // isTaped: visualState.isTaped[7],
                      onPressed: () async {
                        // await showDialog(
                        //     context: context,
                        //     builder: (BuildContext context) {
                        //       return const ConfigPageDashboard();
                        //     });
                        context.pushReplacement(routeJSADashboard);
                      },
                    ),
                  )
                : Container(),
            // JSA Document List
            currentUser!.isAdminJSA ||
                    currentUser!.isLeadJSA ||
                    currentUser!.isManagerJSA
                ? Padding(
                    padding: const EdgeInsets.only(top: 5.5, bottom: 5.5),
                    child: MenuButton(
                      buttonSize: 40,
                      tooltip: 'JSA Document List',
                      fillColor: AppTheme.of(context).primaryColor,
                      icon: Icons.document_scanner_outlined,
                      // isTaped: visualState.isTaped[7],
                      onPressed: () async {
                        // await showDialog(
                        //     context: context,
                        //     builder: (BuildContext context) {
                        //       return const ConfigPageDashboard();
                        //     });
                        context.pushReplacement(routeJSADochument);
                      },
                    ),
                  )
                : Container(),
            // Download apk
            currentUser!.isTechnicianJSA
                ? Padding(
                    padding: const EdgeInsets.only(top: 5.5, bottom: 5.5),
                    child: MenuButton(
                      buttonSize: 40,
                      tooltip: 'JSA Download APK',
                      fillColor: AppTheme.of(context).primaryColor,
                      icon: Icons.download_outlined,
                      // isTaped: visualState.isTaped[7],
                      onPressed: () async {
                        // await showDialog(
                        //     context: context,
                        //     builder: (BuildContext context) {
                        //       return const ConfigPageDashboard();
                        //     });
                        context.pushReplacement(routeDownloadAPKJSA);
                      },
                    ),
                  )
                : Container(),
            // JSA Safety Briefing
            currentUser!.isAdminJSA ||
                    currentUser!.isManagerJSA ||
                    currentUser!.isLeadJSA ||
                    currentUser!.isRepresentativeJSA
                ? Padding(
                    padding: const EdgeInsets.only(top: 5.5, bottom: 5.5),
                    child: MenuButton(
                      buttonSize: 40,
                      tooltip: 'Safety Briefing',
                      fillColor: AppTheme.of(context).primaryColor,
                      icon: Icons.description_outlined,
                      // isTaped: visualState.isTaped[7],
                      onPressed: () async {
                        // await showDialog(
                        //     context: context,
                        //     builder: (BuildContext context) {
                        //       return const ConfigPageDashboard();
                        //     });
                        // providerJSASP.createJsaGeneralInfo("", "", "", []);

                        providerJSASP.teamMembers.clear();
                        var membersCopy =
                            List.from(providerJSASP.membersSelection);

                        for (var user in membersCopy) {
                          providerJSASP.membersSelection.remove(user);
                          providerJSASP.deleteTeamMembers(user.id.toString());
                        }

                        providerJSASP.clearAll();
                        // final pdfController = await providerJSASP.clientPDF();

                        context.pushReplacement(routeSafetyBriefing);
                      },
                    ),
                  )
                : Container(),
            // JSA Safety Briefing List
            currentUser!.isAdminJSA ||
                    currentUser!.isManagerJSA ||
                    currentUser!.isRepresentativeJSA ||
                    currentUser!.isLeadJSA
                ? Padding(
                    padding: const EdgeInsets.only(top: 5.5, bottom: 5.5),
                    child: MenuButton(
                      buttonSize: 40,
                      tooltip: 'Safety Briefing List',
                      fillColor: AppTheme.of(context).primaryColor,
                      icon: Icons.list_alt_outlined,
                      // isTaped: visualState.isTaped[7],
                      onPressed: () async {
                        // await showDialog(
                        //     context: context,
                        //     builder: (BuildContext context) {
                        //       return const ConfigPageDashboard();
                        //     });
                        // providerJSASP.createJsaGeneralInfo("", "", "", []);

                        // await providerJSASP.getListUsers();
                        // final pdfController = await providerJSASP.clientPDF();
                        context.pushReplacement(routeSafetyBriefingList);
                      },
                    ),
                  )
                : Container(),
            // JSA Training
            currentUser!.isAdminJSA ||
                    currentUser!.isManagerJSA ||
                    currentUser!.isTechnicianJSA ||
                    currentUser!.isRepresentativeJSA ||
                    currentUser!.isLeadJSA
                ? Padding(
                    padding: const EdgeInsets.only(top: 5.5, bottom: 5.5),
                    child: MenuButton(
                      buttonSize: 40,
                      tooltip: 'Training List',
                      fillColor: AppTheme.of(context).primaryColor,
                      icon: Icons.topic_outlined,
                      // isTaped: visualState.isTaped[7],
                      onPressed: () async {
                        // await showDialog(
                        //     context: context,
                        //     builder: (BuildContext context) {
                        //       return const ConfigPageDashboard();
                        //     });
                        context.pushReplacement(routeTrainingList);
                      },
                    ),
                  )
                : Container(),

            SideMenuItem(
              selected: provider.indexSelected[12],
              leading: const Icon(Icons.power_settings_new_outlined,
                  color: Colors.red),
              isOpen: widget.isOpen,
              title: 'Logout',
              onTap: () async {
                await userState.logout();
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
