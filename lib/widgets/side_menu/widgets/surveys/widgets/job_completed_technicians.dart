import 'package:flutter/material.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:go_router/go_router.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';
import 'package:rta_crm_cv/helpers/constants.dart';
import 'package:rta_crm_cv/helpers/globals.dart';
import 'package:rta_crm_cv/theme/theme.dart';

class JobCompleteTechnicians extends StatefulWidget {
  const JobCompleteTechnicians(
      {required this.hover, required this.onHoverChange, super.key});
  final bool hover;
  final Function(bool) onHoverChange;
  @override
  State<JobCompleteTechnicians> createState() => _JobCompleteTechniciansState();
}

class _JobCompleteTechniciansState extends State<JobCompleteTechnicians> {
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
        portalFollower: Visibility(
          visible: hover,
          child: Material(
              color: AppTheme.of(context).primaryColor.withOpacity(0.8),
              borderRadius: const BorderRadiusDirectional.only(
                topEnd: Radius.circular(8),
                bottomEnd: Radius.circular(8),
              ),
              child: Container()),
        ),
        child: ListTile(
          title: Text(
            'Job Complete Technicians',
            style: AppTheme.of(context).bodyText1.override(
                  fontFamily: 'Gotham-Bold',
                  color: AppTheme.of(context).gris,
                  useGoogleFonts: false,
                ),
          ),
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
