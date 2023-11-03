import 'package:flutter/material.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:go_router/go_router.dart';
import 'package:rta_crm_cv/helpers/constants.dart';
import 'package:rta_crm_cv/helpers/globals.dart';
import 'package:rta_crm_cv/theme/theme.dart';

class JobCompleteButton extends StatefulWidget {
  const JobCompleteButton(
      {Key? key,
      this.borderRadius = 15,
      this.buttonSize = 70,
      this.fillColor = const Color(0XFF09A963),
      required this.icon,
      this.iconColor = const Color(0XFFB6B6B6),
      this.isTaped = false,
      required this.tooltip,
      this.hovers = false})
      : super(key: key);

  final double borderRadius;
  final double buttonSize;
  final Color fillColor;
  final IconData icon;
  final Color iconColor;
  final bool isTaped;
  final String tooltip;
  final bool hovers;

  @override
  State<JobCompleteButton> createState() => _JobCompleteButtonState();
}

class _JobCompleteButtonState extends State<JobCompleteButton> {
  bool hover = false;

  final userPermissions = currentUser!;
  @override
  void initState() {
    super.initState();
    hover = widget.hovers;
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      child: PortalTarget(
        visible: hover,
        anchor: const Aligned(
          follower: Alignment.topLeft,
          target: Alignment.topRight,
        ),
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
                      ? ListTile(
                          title: Text(
                            'Job Complete Incentives',
                            style: AppTheme.of(context).bodyText1,
                          ),
                          onTap: () async {
                            context.pushReplacement(jobCompleteIncentives);
                          },
                          hoverColor: AppTheme.of(context)
                              .primaryColor
                              .withOpacity(0.4),
                        )
                      : const SizedBox.shrink(),
                  userPermissions.isEmployee
                      ? ListTile(
                          title: Text(
                            'Job Completed Service Overall',
                            style: AppTheme.of(context).bodyText1,
                          ),
                          onTap: () async {
                            context.pushReplacement(jobCompletedServiceOverall);
                          },
                          hoverColor: AppTheme.of(context)
                              .primaryColor
                              .withOpacity(0.4),
                        )
                      : const SizedBox.shrink(),
                  userPermissions.isEmployee
                      ? ListTile(
                          title: Text(
                            'Job Complete CRY',
                            style: AppTheme.of(context).bodyText1,
                          ),
                          onTap: () async {
                            context.pushReplacement(jobCompleteCRY);
                          },
                          hoverColor: AppTheme.of(context)
                              .primaryColor
                              .withOpacity(0.4),
                        )
                      : const SizedBox.shrink(),
                  userPermissions.isEmployee
                      ? ListTile(
                          title: Text(
                            'Job Complete EAS',
                            style: AppTheme.of(context).bodyText1,
                          ),
                          onTap: () async {
                            context.pushReplacement(jobCompleteEAS);
                          },
                          hoverColor: AppTheme.of(context)
                              .primaryColor
                              .withOpacity(0.4),
                        )
                      : const SizedBox.shrink(),
                  userPermissions.isEmployee
                      ? ListTile(
                          title: Text(
                            'Job Complete ODE',
                            style: AppTheme.of(context).bodyText1,
                          ),
                          onTap: () async {
                            context.pushReplacement(jobCompleteODE);
                          },
                          hoverColor: AppTheme.of(context)
                              .primaryColor
                              .withOpacity(0.4),
                        )
                      : const SizedBox.shrink(),
                  userPermissions.isEmployee
                      ? ListTile(
                          title: Text(
                            'Job Complete SMI',
                            style: AppTheme.of(context).bodyText1,
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
          onHover: (_) {
            hover = true;
            print("-----------------------");
            print("Se selecciono");
            print(hover);
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
        // print("-----------------------");
        // print("Se selecciono");
        setState(() {});
      },
      onExit: (_) {
        hover = false;
        setState(() {});
      },
    );
  }
}
