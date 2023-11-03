import 'package:flutter/material.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:go_router/go_router.dart';
import 'package:rta_crm_cv/helpers/constants.dart';
import 'package:rta_crm_cv/theme/theme.dart';

class OpcoSubscriberTargetButton extends StatefulWidget {
  OpcoSubscriberTargetButton({required this.hover, super.key});
  bool hover;
  @override
  State<OpcoSubscriberTargetButton> createState() =>
      _OpcoSubscriberTargetButtonState();
}

class _OpcoSubscriberTargetButtonState
    extends State<OpcoSubscriberTargetButton> {
  bool hover2 = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      child: PortalTarget(
        visible: widget.hover,
        anchor: const Aligned(
          follower: Alignment.topLeft,
          target: Alignment.topRight,
        ),
        portalFollower: MouseRegion(
          child: Visibility(
            visible: hover2,
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
                    ListTile(
                      title: Text(
                        'Option 1',
                        style: AppTheme.of(context).bodyText1,
                      ),
                      onTap: () async {
                        context.pushReplacement(opcoSuscriberTarget);
                      },
                      hoverColor:
                          AppTheme.of(context).primaryColor.withOpacity(0.4),
                    ),
                    ListTile(
                      title: Text(
                        'Option 2',
                        style: AppTheme.of(context).bodyText1,
                      ),
                      onTap: () async {
                        context.pushReplacement(opcoSuscriberTarget);
                      },
                      hoverColor:
                          AppTheme.of(context).primaryColor.withOpacity(0.4),
                    ),
                  ],
                ),
              ),
            ),
          ),
          onHover: (_) {
            widget.hover = true;
            hover2 = true;
            setState(() {});
          },
          onExit: (_) {
            widget.hover = false;
            hover2 = false;
            setState(() {});
          },
        ),
        child: ListTile(
          title: Text(
            'OpCo Subscriber Targets',
            style: AppTheme.of(context).bodyText1,
          ),
          onTap: () async {
            context.pushReplacement(opcoSuscriberTarget);
          },
          hoverColor: AppTheme.of(context).primaryColor.withOpacity(0.4),
        ),
      ),
      onHover: (_) {
        hover2 = true;
        setState(() {});
      },
      onExit: (_) {
        hover2 = false;
        setState(() {});
      },
    );
  }
}
