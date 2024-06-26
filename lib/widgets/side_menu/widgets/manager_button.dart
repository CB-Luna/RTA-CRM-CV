import 'package:flutter/material.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:go_router/go_router.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';
import 'package:rta_crm_cv/helpers/constants.dart';
import 'package:rta_crm_cv/helpers/globals.dart';
import 'package:rta_crm_cv/theme/theme.dart';

class ManagerButton extends StatefulWidget {
  const ManagerButton({
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
  State<ManagerButton> createState() => _ManagerButtonState();
}

class _ManagerButtonState extends State<ManagerButton> {
  bool hover = false;
  final userPermissions = currentUser!.currentRole.permissions;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      child: PortalTarget(
        visible: hover,
        anchor: const Aligned(
          follower: Alignment.topLeft,
          target: Alignment.topRight,
        ),
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
                    userPermissions.bolivarPeninsulaFiberToTheHome != null
                        ? ListTile(
                            title: Text(
                              'Bolivar Peninsula Fiber to the home',
                              style: AppTheme.of(context).bodyText1.override(
                                    fontFamily: 'Gotham-Bold',
                                    color: AppTheme.of(context).gris,
                                    useGoogleFonts: false,
                                  ),
                            ),
                            onTap: () async {
                              context.pushReplacement(
                                  bolivarPeninsulaFibertotheHome);
                            },
                            hoverColor: AppTheme.of(context)
                                .primaryColor
                                .withOpacity(0.4),
                          )
                        : const SizedBox.shrink(),
                    userPermissions.applefwadashboard != null
                        ? ListTile(
                            title: Text(
                              'Apple FWA Dashboard',
                              style: AppTheme.of(context).bodyText1.override(
                                    fontFamily: 'Gotham-Bold',
                                    color: AppTheme.of(context).gris,
                                    useGoogleFonts: false,
                                  ),
                            ),
                            onTap: () async {
                              context.pushReplacement(applefwaDashboard);
                            },
                            hoverColor: AppTheme.of(context)
                                .primaryColor
                                .withOpacity(0.4),
                          )
                        : const SizedBox.shrink(),
                    userPermissions.sheridianfwadashboard != null
                        ? ListTile(
                            title: Text(
                              'Sheridan FWA Dashboard',
                              style: AppTheme.of(context).bodyText1.override(
                                    fontFamily: 'Gotham-Bold',
                                    color: AppTheme.of(context).gris,
                                    useGoogleFonts: false,
                                  ),
                            ),
                            onTap: () async {
                              context.pushReplacement(sheridianfwaDashboard);
                            },
                            hoverColor: AppTheme.of(context)
                                .primaryColor
                                .withOpacity(0.4),
                          )
                        : const SizedBox.shrink(),
                    userPermissions.stoneridgeftthdashboard != null
                        ? ListTile(
                            title: Text(
                              'Stoneridge FTTH Dashboard',
                              style: AppTheme.of(context).bodyText1.override(
                                    fontFamily: 'Gotham-Bold',
                                    color: AppTheme.of(context).gris,
                                    useGoogleFonts: false,
                                  ),
                            ),
                            onTap: () async {
                              context.pushReplacement(stoneridgeFTTHDashboard);
                            },
                            hoverColor: AppTheme.of(context)
                                .primaryColor
                                .withOpacity(0.4),
                          )
                        : const SizedBox.shrink(),
                    userPermissions.greenwoodftthdashboard != null
                        ? ListTile(
                            title: Text(
                              'Greenwood FTTH Dashboard',
                              style: AppTheme.of(context).bodyText1.override(
                                    fontFamily: 'Gotham-Bold',
                                    color: AppTheme.of(context).gris,
                                    useGoogleFonts: false,
                                  ),
                            ),
                            onTap: () async {
                              context.pushReplacement(greenwoodFTTHDashboard);
                            },
                            hoverColor: AppTheme.of(context)
                                .primaryColor
                                .withOpacity(0.4),
                          )
                        : const SizedBox.shrink(),
                    userPermissions.operationReport != null
                        ? ListTile(
                            title: Text(
                              'Operation Report',
                              style: AppTheme.of(context).bodyText1.override(
                                    fontFamily: 'Gotham-Bold',
                                    color: AppTheme.of(context).gris,
                                    useGoogleFonts: false,
                                  ),
                            ),
                            onTap: () async {
                              context.pushReplacement(operationReport);
                            },
                            hoverColor: AppTheme.of(context)
                                .primaryColor
                                .withOpacity(0.4),
                          )
                        : const SizedBox.shrink(),
                    userPermissions.techJobTimeTracking != null
                        ? ListTile(
                            title: Text(
                              'Tech Job Time Tracking',
                              style: AppTheme.of(context).bodyText1.override(
                                    fontFamily: 'Gotham-Bold',
                                    color: AppTheme.of(context).gris,
                                    useGoogleFonts: false,
                                  ),
                            ),
                            onTap: () async {
                              context.pushReplacement(techJobTimeTracking);
                            },
                            hoverColor: AppTheme.of(context)
                                .primaryColor
                                .withOpacity(0.4),
                          )
                        : const SizedBox.shrink(),
                    userPermissions.jobsTracking != null
                        ? ListTile(
                            title: Text(
                              'Jobs Tracking',
                              style: AppTheme.of(context).bodyText1.override(
                                    fontFamily: 'Gotham-Bold',
                                    color: AppTheme.of(context).gris,
                                    useGoogleFonts: false,
                                  ),
                            ),
                            onTap: () async {
                              context.pushReplacement(jobsTracking);
                            },
                            hoverColor: AppTheme.of(context)
                                .primaryColor
                                .withOpacity(0.4),
                          )
                        : const SizedBox.shrink(),
                    userPermissions.jobsUtilizationTracking != null
                        ? ListTile(
                            title: Text(
                              'Jobs Utilization Tracking',
                              style: AppTheme.of(context).bodyText1.override(
                                    fontFamily: 'Gotham-Bold',
                                    color: AppTheme.of(context).gris,
                                    useGoogleFonts: false,
                                  ),
                            ),
                            onTap: () async {
                              context.pushReplacement(jobsUtilizationTracking);
                            },
                            hoverColor: AppTheme.of(context)
                                .primaryColor
                                .withOpacity(0.4),
                          )
                        : const SizedBox.shrink(),
                    userPermissions.ivrStats != null
                        ? ListTile(
                            title: Text(
                              'IVR Stats',
                              style: AppTheme.of(context).bodyText1.override(
                                    fontFamily: 'Gotham-Bold',
                                    color: AppTheme.of(context).gris,
                                    useGoogleFonts: false,
                                  ),
                            ),
                            onTap: () async {
                              context.pushReplacement(ivrStats);
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
