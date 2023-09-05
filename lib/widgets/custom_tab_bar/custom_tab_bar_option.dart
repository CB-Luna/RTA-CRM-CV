import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rta_crm_cv/public/colors.dart';
import 'package:rta_crm_cv/theme/theme.dart';

class CustomTabBarOption extends StatefulWidget {
  const CustomTabBarOption({
    super.key,
    required this.isOn,
    this.width,
    required this.text,
    required this.border,
    required this.gradient,
    this.onTap,
  });

  final bool isOn;
  final String text;
  final double? width;
  final Gradient border;
  final Gradient gradient;
  final Function()? onTap;

  @override
  State<CustomTabBarOption> createState() => _CustomTabBarOptionState();
}

class _CustomTabBarOptionState extends State<CustomTabBarOption> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      hoverColor: Colors.transparent,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: widget.onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(15),
            bottomRight: Radius.circular(40),
            bottomLeft: Radius.circular(15),
          ),
          gradient: widget.isOn ? widget.border : blueGradient,
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            height: 40,
            width: widget.width,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(4),
                bottomRight: Radius.circular(30),
                bottomLeft: Radius.circular(4),
              ),
              gradient: widget.isOn ? widget.gradient : blueRadial,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Center(
                child: Text(
                  widget.text,
                  style: GoogleFonts.poppins(
                    color: AppTheme.of(context).primaryBackground,
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
