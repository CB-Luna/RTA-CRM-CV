import 'package:flutter/material.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:go_router/go_router.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';
import 'package:rta_crm_cv/helpers/constants.dart';
import 'package:rta_crm_cv/helpers/globals.dart';
import 'package:rta_crm_cv/theme/theme.dart';
import 'package:rta_crm_cv/widgets/side_menu/widgets/sales/widgets/configurator_button.dart';
import 'package:google_fonts/google_fonts.dart';

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
  final userPermissions = currentUser!.currentRole.permissions;
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
        portalFollower: PointerInterceptor(
          child: MouseRegion(
            child: Material(
              color: AppTheme.of(context).primaryColor.withOpacity(0.8),
              borderRadius: const BorderRadiusDirectional.only(
                topEnd: Radius.circular(8),
                bottomEnd: Radius.circular(8),
              ),
              child: IntrinsicWidth(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    userPermissions.opCoSubscriberTargets != null
                        ? ListTile(
                            title: Text(
                              'Opco Subscriber Targets',
                              style: AppTheme.of(context).bodyText1.override(
                                    fontFamily: 'Gotham-Bold',
                                    color: AppTheme.of(context).gris,
                                    useGoogleFonts: false,
                                  ),
                            ),
                            onTap: () async {
                              // context.pushReplacement(opcoSuscriberTarget);
                              context.pushReplacement(
                                  "/dashboard-page?title=${"Opco Subscriber Targets"}&source=${"/business_plan"}");
                            },
                            hoverColor: AppTheme.of(context)
                                .primaryColor
                                .withOpacity(0.4),
                          )
                        : const SizedBox.shrink(),
                    userPermissions.newSalesTrackingDashboard != null
                        ? ListTile(
                            title: Text(
                              'New Sales Tracking Dashboards',
                              style: AppTheme.of(context).bodyText1.override(
                                    fontFamily: 'Gotham-Bold',
                                    color: AppTheme.of(context).gris,
                                    useGoogleFonts: false,
                                  ),
                            ),
                            onTap: () async {
                              context
                                  .pushReplacement(newSalesTrackingDashboard);
                            },
                            hoverColor: AppTheme.of(context)
                                .primaryColor
                                .withOpacity(0.4),
                          )
                        : const SizedBox.shrink(),
                    userPermissions.monthlyChurn != null
                        ? ListTile(
                            title: Text(
                              'Monthly Churn %',
                              style: AppTheme.of(context).bodyText1.override(
                                    fontFamily: 'Gotham-Bold',
                                    color: AppTheme.of(context).gris,
                                    useGoogleFonts: false,
                                  ),
                            ),
                            onTap: () async {
                              context.pushReplacement(monthlyChurn);
                            },
                            hoverColor: AppTheme.of(context)
                                .primaryColor
                                .withOpacity(0.4),
                          )
                        : const SizedBox.shrink(),
                    userPermissions.configurator != null
                        // MouseRegion de Segundo Nivel
                        ? ConfiguratorButton(
                            hover: hover,
                            onHoverChange: (newHover) {
                              setState(() {
                                hover = newHover;
                              });
                            },
                          )
                        : const SizedBox.shrink(),
                    userPermissions.residentialAndBusinessCustomers != null
                        ? ListTile(
                            title: Text(
                              'Residentials and Business Customers',
                              style: AppTheme.of(context).bodyText1.override(
                                    fontFamily: 'Gotham-Bold',
                                    color: AppTheme.of(context).gris,
                                    useGoogleFonts: false,
                                  ),
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
                    userPermissions.wirelessFiberCustomers != null
                        ? ListTile(
                            title: Text(
                              'Wireless and Fiber Customers',
                              style: AppTheme.of(context).bodyText1.override(
                                    fontFamily: 'Gotham-Bold',
                                    color: AppTheme.of(context).gris,
                                    useGoogleFonts: false,
                                  ),
                            ),
                            onTap: () async {
                              context.pushReplacement(wirelessAndFiberCustomer);
                            },
                            hoverColor: AppTheme.of(context)
                                .primaryColor
                                .withOpacity(0.4),
                          )
                        : const SizedBox.shrink(),
                    userPermissions.voipTracking != null
                        ? ListTile(
                            title: Text(
                              'VoIP Tracking',
                              style: AppTheme.of(context).bodyText1.override(
                                    fontFamily: 'Gotham-Bold',
                                    color: AppTheme.of(context).gris,
                                    useGoogleFonts: false,
                                  ),
                            ),
                            onTap: () async {
                              context.pushReplacement(voIPTracking);
                            },
                            hoverColor: AppTheme.of(context)
                                .primaryColor
                                .withOpacity(0.4),
                          )
                        : const SizedBox.shrink(),
                    userPermissions.iptvTracking != null
                        ? ListTile(
                            title: Text(
                              'IPTV Tracking',
                              style: AppTheme.of(context).bodyText1.override(
                                    fontFamily: 'Gotham-Bold',
                                    color: AppTheme.of(context).gris,
                                    useGoogleFonts: false,
                                  ),
                            ),
                            onTap: () async {
                              context.pushReplacement(ipTVTracking);
                            },
                            hoverColor: AppTheme.of(context)
                                .primaryColor
                                .withOpacity(0.4),
                          )
                        : const SizedBox.shrink(),
                    userPermissions.arpuTrackingResidential != null
                        ? ListTile(
                            title: Text(
                              'ARPU Tracking Residential',
                              style: AppTheme.of(context).bodyText1.override(
                                    fontFamily: 'Gotham-Bold',
                                    color: AppTheme.of(context).gris,
                                    useGoogleFonts: false,
                                  ),
                            ),
                            onTap: () async {
                              context.pushReplacement(arpuTrackingResidential);
                            },
                            hoverColor: AppTheme.of(context)
                                .primaryColor
                                .withOpacity(0.4),
                          )
                        : const SizedBox.shrink(),
                    userPermissions.arpuTrackingWholesale != null
                        ? ListTile(
                            title: Text(
                              'ARPU Tracking Wholesale',
                              style: AppTheme.of(context).bodyText1.override(
                                    fontFamily: 'Gotham-Bold',
                                    color: AppTheme.of(context).gris,
                                    useGoogleFonts: false,
                                  ),
                            ),
                            onTap: () async {
                              context.pushReplacement(arpuTrackingWholesale);
                            },
                            hoverColor: AppTheme.of(context)
                                .primaryColor
                                .withOpacity(0.4),
                          )
                        : const SizedBox.shrink(),
                    userPermissions.monthlyArpuTrackingWholesale != null
                        ? ListTile(
                            title: Text(
                              'Monthly ARPU Tracking Wholesale',
                              style: AppTheme.of(context).bodyText1.override(
                                    fontFamily: 'Gotham-Bold',
                                    color: AppTheme.of(context).gris,
                                    useGoogleFonts: false,
                                  ),
                            ),
                            onTap: () async {
                              context.pushReplacement(
                                  monthlyARPUTrackingWholesale);
                            },
                            hoverColor: AppTheme.of(context)
                                .primaryColor
                                .withOpacity(0.4),
                          )
                        : const SizedBox.shrink(),
                    userPermissions.monthlyArpuTrackingResidential != null
                        ? ListTile(
                            title: Text(
                              'Monthly ARPU Tracking Residential',
                              style: AppTheme.of(context).bodyText1.override(
                                    fontFamily: 'Gotham-Bold',
                                    color: AppTheme.of(context).gris,
                                    useGoogleFonts: false,
                                  ),
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
                    userPermissions.engageOption != null
                        ? ListTile(
                            title: Text(
                              'Engage Option',
                              style: AppTheme.of(context).bodyText1.override(
                                    fontFamily: 'Gotham-Bold',
                                    color: AppTheme.of(context).gris,
                                    useGoogleFonts: false,
                                  ),
                            ),
                            onTap: () async {
                              context.pushReplacement(engageOption);
                            },
                            hoverColor: AppTheme.of(context)
                                .primaryColor
                                .withOpacity(0.4),
                          )
                        : const SizedBox.shrink(),
                    userPermissions.conversionRate != null
                        ? ListTile(
                            title: Text(
                              'Conversion rate',
                              style: AppTheme.of(context).bodyText1.override(
                                    fontFamily: 'Gotham-Bold',
                                    color: AppTheme.of(context).gris,
                                    useGoogleFonts: false,
                                  ),
                            ),
                            onTap: () async {
                              context.pushReplacement(conversionRate);
                            },
                            hoverColor: AppTheme.of(context)
                                .primaryColor
                                .withOpacity(0.4),
                          )
                        : const SizedBox.shrink(),
                    userPermissions.deactContactLog != null
                        ? ListTile(
                            title: Text(
                              'Deact Contact Log',
                              style: AppTheme.of(context).bodyText1.override(
                                    fontFamily: 'Gotham-Bold',
                                    color: AppTheme.of(context).gris,
                                    useGoogleFonts: false,
                                  ),
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
