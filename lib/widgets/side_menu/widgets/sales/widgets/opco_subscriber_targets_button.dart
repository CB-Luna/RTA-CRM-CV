import 'package:flutter/material.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:go_router/go_router.dart';
import 'package:rta_crm_cv/helpers/constants.dart';
import 'package:rta_crm_cv/theme/theme.dart';

class OpcoSubscriberTargetButton extends StatefulWidget {
  const OpcoSubscriberTargetButton({
    required this.hover, 
    required this.onHoverChange,
    super.key
  });
  final bool hover;
  final Function(bool) onHoverChange;
  @override
  State<OpcoSubscriberTargetButton> createState() =>
      _OpcoSubscriberTargetButtonState();
}

class _OpcoSubscriberTargetButtonState
    extends State<OpcoSubscriberTargetButton> {
  bool hover = false;

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
