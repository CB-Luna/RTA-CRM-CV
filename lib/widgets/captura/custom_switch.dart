import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/material.dart';
import 'package:rta_crm_cv/theme/theme.dart';

class CustomSwitch extends StatefulWidget {
  const CustomSwitch({
    super.key,
    this.enabled = true,
    required this.value,
    required this.label,
    this.optOn = 'Yes',
    this.optOff = 'No',
    this.iconOn = Icons.check,
    this.iconOff = Icons.close,
    this.onChanged,
  });

  final bool enabled;
  final bool value;
  final String label;
  final String optOn;
  final String optOff;

  final IconData? iconOn;
  final IconData? iconOff;
  final Function(bool)? onChanged;

  @override
  State<CustomSwitch> createState() => _CustomSwitchState();
}

class _CustomSwitchState extends State<CustomSwitch> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 50,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(width: 40),
                Text(
                  widget.label,
                  style: TextStyle(
                    color: widget.enabled ? AppTheme.of(context).primaryColor : AppTheme.of(context).hintText.color,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
            AnimatedToggleSwitch.dual(
              height: 38,
              current: widget.value,
              first: false,
              second: true,
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  spreadRadius: 1,
                  blurRadius: 2,
                  offset: Offset(0, 1.5),
                ),
              ],
              onChanged: widget.enabled ? widget.onChanged : null,
              colorBuilder: (value) => widget.enabled
                  ? value
                      ? AppTheme.of(context).tertiaryColor
                      : AppTheme.of(context).primaryColor
                  : AppTheme.of(context).hintText.color,
              iconBuilder: (value) => value
                  ? Icon(
                      widget.iconOn,
                      color: AppTheme.of(context).primaryBackground,
                    )
                  : Icon(
                      widget.iconOff,
                      color: AppTheme.of(context).primaryBackground,
                    ),
              textBuilder: (value) => value
                  ? Center(
                      child: Text(
                        widget.optOn,
                        style: TextStyle(color: widget.enabled ? AppTheme.of(context).tertiaryColor : AppTheme.of(context).hintText.color),
                      ),
                    )
                  : Center(
                      child: Text(
                        widget.optOff,
                        style: TextStyle(color: widget.enabled ? AppTheme.of(context).primaryColor : AppTheme.of(context).hintText.color),
                      ),
                    ),
              borderWidth: 1,
              borderColorBuilder: (value) => widget.enabled
                  ? value
                      ? AppTheme.of(context).tertiaryColor
                      : AppTheme.of(context).primaryColor
                  : AppTheme.of(context).hintText.color,
              //innerColor: ,
            ),
          ],
        )
        /*  child: Switch(
        value: widget.on,
        trackOutlineColor: MaterialStateProperty.resolveWith<Color>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.disabled)) {
              return AppTheme.of(context).hintText.color!;
            } else {
              return AppTheme.of(context).primaryColor;
            }
          },
        ),
        trackColor: MaterialStateProperty.resolveWith<Color>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.disabled)) {
              if (states.contains(MaterialState.selected)) {
                return AppTheme.of(context).hintText.color!;
              } else {
                return AppTheme.of(context).primaryBackground;
              }
            } else {
              if (states.contains(MaterialState.selected)) {
                return AppTheme.of(context).primaryColor;
              } else {
                return AppTheme.of(context).primaryBackground;
              }
            }
          },
        ),
        thumbColor: MaterialStateProperty.resolveWith<Color>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.disabled)) {
              if (states.contains(MaterialState.selected)) {
                return AppTheme.of(context).primaryBackground;
              } else {
                return AppTheme.of(context).hintText.color!;
              }
            } else {
              if (states.contains(MaterialState.selected)) {
                return AppTheme.of(context).primaryBackground;
              } else {
                return AppTheme.of(context).primaryColor;
              }
            }
          },
        ),
        thumbIcon: MaterialStateProperty.resolveWith<Icon?>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.disabled) && states.contains(MaterialState.selected)) {
              if (states.contains(MaterialState.selected)) {
                return Icon(widget.iconOn, color: AppTheme.of(context).hintText.color);
              } else {
                return Icon(widget.iconOff, color: AppTheme.of(context).primaryBackground);
              }
            } else {
              if (states.contains(MaterialState.selected)) {
                return Icon(widget.iconOn, color: AppTheme.of(context).primaryColor);
              } else {
                return Icon(widget.iconOff, color: AppTheme.of(context).primaryBackground);
              }
            }
          },
        ),
        onChanged: widget.onChanged,
      ),*/
        );
  }
}
