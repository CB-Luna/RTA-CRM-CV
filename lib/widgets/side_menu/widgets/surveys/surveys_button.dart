import 'package:flutter/material.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:go_router/go_router.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';
import 'package:provider/provider.dart';
import 'package:rta_crm_cv/helpers/constants.dart';
import 'package:rta_crm_cv/helpers/globals.dart';
import 'package:rta_crm_cv/theme/theme.dart';
import 'package:rta_crm_cv/widgets/side_menu/widgets/surveys/widgets/job_complete_button.dart';
import 'package:rta_crm_cv/widgets/side_menu/widgets/surveys/widgets/job_completed_technicians.dart';

import '../../../../providers/users_provider.dart';

class SurveysButton extends StatefulWidget {
  const SurveysButton({
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
  State<SurveysButton> createState() => _SurveysButtonState();
}

class _SurveysButtonState extends State<SurveysButton> {
  bool hover = false;
  bool hover2 = false;
  bool hover3 = false;

  final userPermissions = currentUser!.currentRole.permissions;
  @override
  Widget build(BuildContext context) {
    UsersProvider provider = Provider.of<UsersProvider>(context);

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
                    userPermissions.wispapalooza2021Survey != null
                        ? ListTile(
                            title: Text(
                              'Wizpapalooza 2021 Survey',
                              style: AppTheme.of(context).bodyText1.override(
                                    fontFamily: 'Gotham-Bold',
                                    color: AppTheme.of(context).gris,
                                    useGoogleFonts: false,
                                  ),
                            ),
                            onTap: () async {
                              context.pushReplacement(wispapalooza2021Survey);
                            },
                            hoverColor: AppTheme.of(context)
                                .primaryColor
                                .withOpacity(0.4),
                          )
                        : const SizedBox.shrink(),
                    userPermissions.jobComplete != null
                        ? JobCompleteButton(
                            hover: hover,
                            onHoverChange: (newHover) {
                              setState(() {
                                hover = newHover;
                              });
                            },
                          )
                        : const SizedBox.shrink(),
                    userPermissions.jobCompleteTechnicians != null
                        ? ListTile(
                            title: Text(
                              'Job Complete Technicians',
                              style: AppTheme.of(context).bodyText1.override(
                                    fontFamily: 'Gotham-Bold',
                                    color: AppTheme.of(context).gris,
                                    useGoogleFonts: false,
                                  ),
                            ),
                            onTap: () async {
                              provider.pagesearch = true;
                              context.pushReplacement(routeJobCompleteTechni);
                            },
                            hoverColor: AppTheme.of(context)
                                .primaryColor
                                .withOpacity(0.4),
                          )
                        : const SizedBox.shrink(),
                    userPermissions.itSurveyOctober2021 != null
                        ? ListTile(
                            title: Text(
                              'IT Survey October 2021',
                              style: AppTheme.of(context).bodyText1.override(
                                    fontFamily: 'Gotham-Bold',
                                    color: AppTheme.of(context).gris,
                                    useGoogleFonts: false,
                                  ),
                            ),
                            onTap: () async {
                              context.pushReplacement(itSurveyOctober2021);
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
