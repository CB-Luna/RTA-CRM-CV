import 'package:flutter/material.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:go_router/go_router.dart';
import 'package:rta_crm_cv/helpers/constants.dart';
import 'package:rta_crm_cv/helpers/globals.dart';
import 'package:rta_crm_cv/theme/theme.dart';

class ConfiguratorButton extends StatefulWidget {
  const ConfiguratorButton(
      {required this.hover, required this.onHoverChange, super.key});
  final bool hover;
  final Function(bool) onHoverChange;
  @override
  State<ConfiguratorButton> createState() => _ConfiguratorButtonState();
}

class _ConfiguratorButtonState extends State<ConfiguratorButton> {
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
        portalFollower: MouseRegion(
          child: Visibility(
            visible: hover,
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
                    userPermissions.isAdminDashboards
                      ? ListTile(
                      title: Text(
                        'Configurator Stats',
                        style: AppTheme.of(context).bodyText1,
                      ),
                      onTap: () async {
                        context.pushReplacement(opcoSuscriberTarget);
                      },
                      hoverColor:
                          AppTheme.of(context).primaryColor.withOpacity(0.4),
                    )
                    : const SizedBox.shrink(),
                    userPermissions.isAdminDashboards
                      ? ListTile(
                      title: Text(
                        'No Coverage Leads',
                        style: AppTheme.of(context).bodyText1,
                      ),
                      onTap: () async {
                        context.pushReplacement(newSalesTrackingDashboard);
                      },
                      hoverColor:
                          AppTheme.of(context).primaryColor.withOpacity(0.4),
                    )
                    : const SizedBox.shrink(),
                    userPermissions.isAdminDashboards
                      ? ListTile(
                      title: Text(
                        'New Configurator Stats',
                        style: AppTheme.of(context).bodyText1,
                      ),
                      onTap: () async {
                        context.pushReplacement(newConfiguratorStats);
                      },
                      hoverColor:
                          AppTheme.of(context).primaryColor.withOpacity(0.4),
                    )
                    : const SizedBox.shrink(),
                    userPermissions.isAdminDashboards
                      ? ListTile(
                      title: Text(
                        'Referrals Tracking',
                        style: AppTheme.of(context).bodyText1,
                      ),
                      onTap: () async {
                        context.pushReplacement(referralsTracking);
                      },
                      hoverColor:
                          AppTheme.of(context).primaryColor.withOpacity(0.4),
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
        child: ListTile(
          title: Text(
            'Configurator',
            style: AppTheme.of(context).bodyText1,
          ),
          trailing: const Icon(Icons.chevron_right_outlined),
          hoverColor: AppTheme.of(context).primaryColor.withOpacity(0.4),
          onTap:() {

          },
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
