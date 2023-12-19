import 'package:flutter/material.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:go_router/go_router.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';
import 'package:rta_crm_cv/helpers/constants.dart';
import 'package:rta_crm_cv/helpers/globals.dart';
import 'package:rta_crm_cv/theme/theme.dart';

class JobCompleteButton extends StatefulWidget {
  const JobCompleteButton(
      {required this.hover, required this.onHoverChange, super.key});
  final bool hover;
  final Function(bool) onHoverChange;
  @override
  State<JobCompleteButton> createState() => _JobCompleteButtonState();
}

class _JobCompleteButtonState extends State<JobCompleteButton> {
  bool hover = false;

  @override
  Widget build(BuildContext context) {
    final userPermissions = currentUser!;
    return MouseRegion(
      child: PortalTarget(
        visible: widget.hover,
        anchor: const Aligned(
          follower: Alignment.topLeft,
          target: Alignment.topRight,
        ),
        portalFollower: PointerInterceptor(
          child: MouseRegion(
            child: Visibility(
              visible: hover,
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
                      userPermissions.isAdminDashboards ||
                              userPermissions.isDashboardsOperation
                          ? ListTile(
                              title: Text(
                                'Job Complete Incentives',
                                style: AppTheme.of(context).bodyText1.override(
                                      fontFamily: 'Gotham-Bold',
                                      color: AppTheme.of(context).gris,
                                      useGoogleFonts: false,
                                    ),
                              ),
                              onTap: () async {
                                context.pushReplacement(jobCompleteIncentives);
                              },
                              hoverColor: AppTheme.of(context)
                                  .primaryColor
                                  .withOpacity(0.4),
                            )
                          : const SizedBox.shrink(),
                      userPermissions.isAdminDashboards ||
                              userPermissions.isDashboardsOperation
                          ? ListTile(
                              title: Text(
                                'Job Complete Service Overall',
                                style: AppTheme.of(context).bodyText1.override(
                                      fontFamily: 'Gotham-Bold',
                                      color: AppTheme.of(context).gris,
                                      useGoogleFonts: false,
                                    ),
                              ),
                              onTap: () async {
                                context.pushReplacement(
                                    jobCompletedServiceOverall);
                              },
                              hoverColor: AppTheme.of(context)
                                  .primaryColor
                                  .withOpacity(0.4),
                            )
                          : const SizedBox.shrink(),
                      userPermissions.isAdminDashboards ||
                              userPermissions.isDashboardsOperation
                          ? ListTile(
                              title: Text(
                                'Job Complete CRY',
                                style: AppTheme.of(context).bodyText1.override(
                                      fontFamily: 'Gotham-Bold',
                                      color: AppTheme.of(context).gris,
                                      useGoogleFonts: false,
                                    ),
                              ),
                              onTap: () async {
                                context.pushReplacement(jobCompleteCRY);
                              },
                              hoverColor: AppTheme.of(context)
                                  .primaryColor
                                  .withOpacity(0.4),
                            )
                          : const SizedBox.shrink(),
                      userPermissions.isAdminDashboards ||
                              userPermissions.isDashboardsOperation
                          ? ListTile(
                              title: Text(
                                'Job Complete EAS',
                                style: AppTheme.of(context).bodyText1.override(
                                      fontFamily: 'Gotham-Bold',
                                      color: AppTheme.of(context).gris,
                                      useGoogleFonts: false,
                                    ),
                              ),
                              onTap: () async {
                                context.pushReplacement(jobCompleteEAS);
                              },
                              hoverColor: AppTheme.of(context)
                                  .primaryColor
                                  .withOpacity(0.4),
                            )
                          : const SizedBox.shrink(),
                      userPermissions.isAdminDashboards ||
                              userPermissions.isDashboardsOperation
                          ? ListTile(
                              title: Text(
                                'Job Complete ODE',
                                style: AppTheme.of(context).bodyText1.override(
                                      fontFamily: 'Gotham-Bold',
                                      color: AppTheme.of(context).gris,
                                      useGoogleFonts: false,
                                    ),
                              ),
                              onTap: () async {
                                context.pushReplacement(jobCompleteODE);
                              },
                              hoverColor: AppTheme.of(context)
                                  .primaryColor
                                  .withOpacity(0.4),
                            )
                          : const SizedBox.shrink(),
                      userPermissions.isAdminDashboards ||
                              userPermissions.isDashboardsOperation
                          ? ListTile(
                              title: Text(
                                'Job Complete SMI',
                                style: AppTheme.of(context).bodyText1.override(
                                      fontFamily: 'Gotham-Bold',
                                      color: AppTheme.of(context).gris,
                                      useGoogleFonts: false,
                                    ),
                              ),
                              onTap: () async {
                                context.pushReplacement(jobCompleteSMI);
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
            ),
            onHover: (_) {
              widget.onHoverChange(true);
              hover = true;
              setState(() {});
            },
            onExit: (_) {
              widget.onHoverChange(false);
              hover = false;
              setState(() {});
            },
          ),
        ),
        child: ListTile(
          title: Text(
            'Job Complete',
            style: AppTheme.of(context).bodyText1.override(
                  fontFamily: 'Gotham-Bold',
                  color: AppTheme.of(context).gris,
                  useGoogleFonts: false,
                ),
          ),
          trailing: Icon(Icons.chevron_right_outlined,
              color: AppTheme.of(context).gris),
          onTap: () async {},
          hoverColor: AppTheme.of(context).primaryColor.withOpacity(0.4),
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
