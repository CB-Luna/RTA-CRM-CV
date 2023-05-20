import 'package:flutter/material.dart';
import 'package:rta_crm_cv/public/colors.dart';

class CustomTextIconButton extends StatefulWidget {
  const CustomTextIconButton({super.key, required this.icon, required this.text, this.onTap});

  final Widget icon;
  final String text;
  final Function()? onTap;

  @override
  State<CustomTextIconButton> createState() => CustomTextIconButtonState();
}

class CustomTextIconButtonState extends State<CustomTextIconButton> {
  bool hover = false;
  bool pressing = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
            child: Center(
              child: Row(
                children: [
                  widget.icon,
                  SizedBox(width: 5),
                  Text(
                    widget.text,
                    style: TextStyle(color: primaryColor),
                  ),
                ],
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
    );
  }
}
