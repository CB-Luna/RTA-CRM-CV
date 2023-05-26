import 'package:flutter/material.dart';
import 'package:rta_crm_cv/public/colors.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    required this.label,
    required this.icon,
    required this.controller,
    required this.enabled,
    this.width = 500,
  });

  final String label;
  final IconData icon;
  final TextEditingController controller;
  final bool enabled;
  final double width;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      width: widget.width,
      height: 35,
      duration: const Duration(milliseconds: 100),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 0.1,
              blurRadius: 3,
              offset: const Offset(0, 0), // changes position of shadow
            ),
          ]),
      child: Form(
        child: TextField(
          controller: widget.controller,
          enabled: widget.enabled,
          decoration: InputDecoration(
            disabledBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: Color(Colors.grey[350]!.value), width: 0.5),
              borderRadius: BorderRadius.circular(5),
            ),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: primaryColor, width: 0.5),
              borderRadius: BorderRadius.circular(5),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: secondaryColor, width: 0.5),
              borderRadius: BorderRadius.circular(5),
            ),
            prefixIcon: Icon(widget.icon),
            prefixIconColor: primaryColor,
            label: Text(
              widget.label,
              style: TextStyle(color: primaryColor),
            ),
          ),
          cursorColor: primaryColor,
        ),
      ),
    );
  }
}
