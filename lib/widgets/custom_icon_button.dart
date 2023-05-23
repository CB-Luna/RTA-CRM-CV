import 'package:flutter/material.dart';
import 'package:rta_crm_cv/public/colors.dart';
import 'package:rta_crm_cv/theme/theme.dart';

class CustomIconButton extends StatefulWidget {
  const CustomIconButton({super.key, required this.icon, required this.toolTip, this.onTap});

  final IconData icon;
  final String toolTip;
  final Function()? onTap;

  @override
  State<CustomIconButton> createState() => CustomIconButtonState();
}

class CustomIconButtonState extends State<CustomIconButton> {
  bool hover = false;
  bool pressing = false;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: widget.toolTip,
      preferBelow: true,
      child: GestureDetector(
        onTap: widget.onTap,
        onTapDown: (details) {
          setState(() {
            pressing = true;
          });
        },
        onTapUp: (details) {
          setState(() {
            pressing = false;
          });
        },
        onTapCancel: () {
          setState(() {
            pressing = false;
          });
        },
        child: MouseRegion(
          child: AnimatedContainer(
            height: 35,
            duration: const Duration(milliseconds: 100),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Colors.white, boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 0.1,
                blurRadius: 3,
                offset: Offset(
                  0,
                  pressing
                      ? -2
                      : hover
                          ? 5
                          : 0,
                ), // changes position of shadow
              ),
            ]),
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Center(
                child: Icon(
                  widget.icon,
                  color: primaryColor,
                ),
              ),
            ),
          ),
          onEnter: (event) {
            setState(() {
              hover = true;
            });
          },
          onExit: (event) {
            setState(() {
              hover = false;
            });
          },
        ),
      ),
    );
  }
}
