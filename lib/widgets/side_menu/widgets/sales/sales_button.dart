import 'package:flutter/material.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:go_router/go_router.dart';
import 'package:rta_crm_cv/helpers/constants.dart';
import 'package:rta_crm_cv/helpers/globals.dart';
import 'package:rta_crm_cv/theme/theme.dart';

class SalesButton extends StatefulWidget {
  const SalesButton({
    Key? key,
    this.borderRadius = 15,
    this.buttonSize = 70,
    this.fillColor = const Color(0XFF09A963),
    required this.icon,
    this.iconColor = const Color(0XFFB6B6B6),
    this.isTaped = false,
    required this.tooltip,
  }) : super(key: key);

  final double borderRadius;
  final double buttonSize;
  final Color fillColor;
  final IconData icon;
  final Color iconColor;
  final bool isTaped;
  final String tooltip;

  @override
  State<SalesButton> createState() => _SalesButtonState();
}

class _SalesButtonState extends State<SalesButton> {
  bool hover = false;
  bool hover2 = false;
  final userPermissions = currentUser!;
  @override
  Widget build(BuildContext context) {
    // Boton sales inicial
    return MouseRegion(
      child: PortalTarget(
        visible: hover,
        anchor: const Aligned(
          follower: Alignment.topLeft,
          target: Alignment.topRight,
        ),
        // MouseRegion de primer nivel
        portalFollower: MouseRegion(
          child: Material(
            color: AppTheme.of(context).primaryColor.withOpacity(0.3),
            borderRadius: const BorderRadiusDirectional.only(
              topEnd: Radius.circular(8),
              bottomEnd: Radius.circular(8),
            ),
            child: IntrinsicWidth(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  userPermissions.isEmployee
                      // MouseRegion de Segundo Nivel
                      ? ListTile(
                          title: Text(
                            'OpCo Subscriber Targets',
                            style: AppTheme.of(context).bodyText1,
                          ),
                          onTap: () async {
                            context.pushReplacement(opcoSuscriberTarget);
                          },
                          hoverColor: AppTheme.of(context)
                              .primaryColor
                              .withOpacity(0.4),
                        )
                      : const SizedBox.shrink(),
                  userPermissions.isEmployee
                      ? ListTile(
                          title: Text(
                            'New Sales Tracking Dashboards',
                            style: AppTheme.of(context).bodyText1,
                          ),
                          onTap: () async {
                            context.pushReplacement(newSalesTrackingDashboard);
                          },
                          hoverColor: AppTheme.of(context)
                              .primaryColor
                              .withOpacity(0.4),
                        )
                      : const SizedBox.shrink(),
                  userPermissions.isEmployee
                      ? ListTile(
                          title: Text(
                            'Monthly Churn %',
                            style: AppTheme.of(context).bodyText1,
                          ),
                          onTap: () async {
                            context.pushReplacement(monthlyChurn);
                          },
                          hoverColor: AppTheme.of(context)
                              .primaryColor
                              .withOpacity(0.4),
                        )
                      : const SizedBox.shrink(),
                  userPermissions.isEmployee
                      ? MouseRegion(
                          child: PortalTarget(
                              visible: hover,
                              anchor: const Aligned(
                                follower: Alignment.topLeft,
                                target: Alignment.topRight,
                              ),
                              portalFollower: MouseRegion(
                                child: Visibility(
                                  visible: hover2,
                                  child: Material(
                                    color: AppTheme.of(context)
                                        .primaryColor
                                        .withOpacity(0.3),
                                    borderRadius:
                                        const BorderRadiusDirectional.only(
                                      topEnd: Radius.circular(8),
                                      bottomEnd: Radius.circular(8),
                                    ),
                                    child: IntrinsicWidth(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          ListTile(
                                            title: Text(
                                              'Configurator Stats',
                                              style: AppTheme.of(context)
                                                  .bodyText1,
                                            ),
                                            onTap: () async {
                                              context.pushReplacement(
                                                  configuratorStats);
                                            },
                                            hoverColor: AppTheme.of(context)
                                                .primaryColor
                                                .withOpacity(0.4),
                                          ),
                                          ListTile(
                                            title: Text(
                                              'No coverage Leads',
                                              style: AppTheme.of(context)
                                                  .bodyText1,
                                            ),
                                            onTap: () async {
                                              context.pushReplacement(
                                                  noCoverageLeads);
                                            },
                                            hoverColor: AppTheme.of(context)
                                                .primaryColor
                                                .withOpacity(0.4),
                                          ),
                                          ListTile(
                                            title: Text(
                                              'New Configurator Stats',
                                              style: AppTheme.of(context)
                                                  .bodyText1,
                                            ),
                                            onTap: () async {
                                              context.pushReplacement(
                                                  newConfiguratorStats);
                                            },
                                            hoverColor: AppTheme.of(context)
                                                .primaryColor
                                                .withOpacity(0.4),
                                          ),
                                          ListTile(
                                            title: Text(
                                              'Referrals Tracking',
                                              style: AppTheme.of(context)
                                                  .bodyText1,
                                            ),
                                            onTap: () async {
                                              context.pushReplacement(
                                                  referralsTracking);
                                            },
                                            hoverColor: AppTheme.of(context)
                                                .primaryColor
                                                .withOpacity(0.4),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                onHover: (_) {
                                  hover = true;
                                  hover2 = true;
                                  setState(() {});
                                },
                                onExit: (_) {
                                  hover = false;
                                  hover2 = false;
                                  setState(() {});
                                },
                              ),
                              child: ListTile(
                                title: Text(
                                  'Configurator',
                                  style: AppTheme.of(context).bodyText1,
                                ),
                                trailing:
                                    const Icon(Icons.chevron_right_outlined),
                                onTap: () async {
                                  context.pushReplacement(monthlyChurn);
                                },
                                hoverColor: AppTheme.of(context)
                                    .primaryColor
                                    .withOpacity(0.4),
                              )),
                          onHover: (_) {
                            hover2 = true;
                            setState(() {});
                          },
                          onExit: (_) {
                            hover2 = false;
                            setState(() {});
                          },
                        )
                      : const SizedBox.shrink(),
                  userPermissions.isEmployee
                      ? ListTile(
                          title: Text(
                            'Residentials and Business Customers',
                            style: AppTheme.of(context).bodyText1,
                          ),
                          onTap: () async {
                            context.pushReplacement(
                                residentialAndBusinessCustomer);
                          },
                          hoverColor: AppTheme.of(context)
                              .primaryColor
                              .withOpacity(0.4),
                        )
                      : const SizedBox.shrink(),
                  userPermissions.isEmployee
                      ? ListTile(
                          title: Text(
                            'Wireless and Fiber Customers',
                            style: AppTheme.of(context).bodyText1,
                          ),
                          onTap: () async {
                            context.pushReplacement(wirelessAndFiberCustomer);
                          },
                          hoverColor: AppTheme.of(context)
                              .primaryColor
                              .withOpacity(0.4),
                        )
                      : const SizedBox.shrink(),
                  userPermissions.isEmployee
                      ? ListTile(
                          title: Text(
                            'VoIP Tracking',
                            style: AppTheme.of(context).bodyText1,
                          ),
                          onTap: () async {
                            context.pushReplacement(voIPTracking);
                          },
                          hoverColor: AppTheme.of(context)
                              .primaryColor
                              .withOpacity(0.4),
                        )
                      : const SizedBox.shrink(),
                  userPermissions.isEmployee
                      ? ListTile(
                          title: Text(
                            'IPTV Tracking',
                            style: AppTheme.of(context).bodyText1,
                          ),
                          onTap: () async {
                            context.pushReplacement(ipTVTracking);
                          },
                          hoverColor: AppTheme.of(context)
                              .primaryColor
                              .withOpacity(0.4),
                        )
                      : const SizedBox.shrink(),
                  userPermissions.isEmployee
                      ? ListTile(
                          title: Text(
                            'ARPU Tracking Residential',
                            style: AppTheme.of(context).bodyText1,
                          ),
                          onTap: () async {
                            context.pushReplacement(arpuTrackingResidential);
                          },
                          hoverColor: AppTheme.of(context)
                              .primaryColor
                              .withOpacity(0.4),
                        )
                      : const SizedBox.shrink(),
                  userPermissions.isEmployee
                      ? ListTile(
                          title: Text(
                            'ARPU Tracking Wholesale',
                            style: AppTheme.of(context).bodyText1,
                          ),
                          onTap: () async {
                            context.pushReplacement(arpuTrackingWholesale);
                          },
                          hoverColor: AppTheme.of(context)
                              .primaryColor
                              .withOpacity(0.4),
                        )
                      : const SizedBox.shrink(),
                  userPermissions.isEmployee
                      ? ListTile(
                          title: Text(
                            'Monthly ARPU Tracking Wholesale',
                            style: AppTheme.of(context).bodyText1,
                          ),
                          onTap: () async {
                            context
                                .pushReplacement(monthlyARPUTrackingWholesale);
                          },
                          hoverColor: AppTheme.of(context)
                              .primaryColor
                              .withOpacity(0.4),
                        )
                      : const SizedBox.shrink(),
                  userPermissions.isEmployee
                      ? ListTile(
                          title: Text(
                            'Monthly ARPU Tracking Residential',
                            style: AppTheme.of(context).bodyText1,
                          ),
                          onTap: () async {
                            context.pushReplacement(
                                monthlyARPUTrackingResidential);
                          },
                          hoverColor: AppTheme.of(context)
                              .primaryColor
                              .withOpacity(0.4),
                        )
                      : const SizedBox.shrink(),
                  userPermissions.isEmployee
                      ? ListTile(
                          title: Text(
                            'Engage Option',
                            style: AppTheme.of(context).bodyText1,
                          ),
                          onTap: () async {
                            context.pushReplacement(engageOption);
                          },
                          hoverColor: AppTheme.of(context)
                              .primaryColor
                              .withOpacity(0.4),
                        )
                      : const SizedBox.shrink(),
                  userPermissions.isEmployee
                      ? ListTile(
                          title: Text(
                            'Conversion rate',
                            style: AppTheme.of(context).bodyText1,
                          ),
                          onTap: () async {
                            context.pushReplacement(conversionRate);
                          },
                          hoverColor: AppTheme.of(context)
                              .primaryColor
                              .withOpacity(0.4),
                        )
                      : const SizedBox.shrink(),
                  userPermissions.isEmployee
                      ? ListTile(
                          title: Text(
                            'Deact Contact Log',
                            style: AppTheme.of(context).bodyText1,
                          ),
                          onTap: () async {
                            context.pushReplacement(deactContactLog);
                          },
                          hoverColor: AppTheme.of(context)
                              .primaryColor
                              .withOpacity(0.4),
                        )
                      : const SizedBox.shrink(),
                ],
              ),
            ),
          ),
          onHover: (_) {
            hover = true;
            setState(() {});
          },
          onExit: (_) {
            hover = false;
            setState(() {});
          },
        ),
        child: Material(
          borderRadius:
              hover ? BorderRadius.circular(widget.borderRadius) : null,
          elevation: hover ? 5 : 0,
          color: Colors.transparent,
          clipBehavior: Clip.antiAlias,
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 65 / 1920,
            height: MediaQuery.of(context).size.width * 65 / 1920,
            child: Container(
              decoration: BoxDecoration(
                border: hover || widget.isTaped
                    ? Border.all(color: const Color(0XFFFFFFFF), width: 2)
                    : null,
                borderRadius: BorderRadius.circular(15),
                color: hover || widget.isTaped ? widget.fillColor : null,
              ),
              child: Tooltip(
                message: widget.tooltip,
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Icon(
                    widget.icon,
                    size: MediaQuery.of(context).size.width * 45 / 1920,
                    color: hover || widget.isTaped
                        ? const Color(0XFFFFFFFF)
                        : widget.iconColor,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      onHover: (_) {
        hover = true;
        setState(() {});
      },
      onExit: (_) {
        hover = false;
        setState(() {});
      },
    );
  }
}
