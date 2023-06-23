import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rta_crm_cv/public/colors.dart';
import 'package:rta_crm_cv/theme/theme.dart';

class CustomTextFieldDatePicker extends StatefulWidget {
  const CustomTextFieldDatePicker({
    super.key,
    this.width = 500,
    required this.enabled,
    required this.label,
    required this.keyboardType,
    required this.child,
    this.inputFormatters,
  });

  final String label;
  //final IconData icon;
  //final TextEditingController controller;
  final bool enabled;
  final TextInputType keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final double width;
  final Widget child;

  @override
  State<CustomTextFieldDatePicker> createState() =>
      _CustomTextFieldDatePickerState();
}

class _CustomTextFieldDatePickerState extends State<CustomTextFieldDatePicker> {
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
          enabled: widget.enabled,
          keyboardType: widget.keyboardType,
          inputFormatters: widget.inputFormatters,
          decoration: InputDecoration(
            fillColor: Colors.transparent,
            filled: true,
            border: const OutlineInputBorder(borderSide: BorderSide.none),
            disabledBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: Color(Colors.grey[350]!.value), width: 0.5),
              borderRadius: BorderRadius.circular(5),
            ),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: AppTheme.of(context).primaryColor, width: 0.5),
              borderRadius: BorderRadius.circular(5),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: secondaryColor, width: 0.5),
              borderRadius: BorderRadius.circular(5),
            ),
            //prefixIcon: Icon(widget.icon),
            prefixIconColor: AppTheme.of(context).primaryColor,
            label: Text(
              widget.label,
              style: TextStyle(
                  fontFamily: 'UniNeue',
                  color: AppTheme.of(context).primaryText),
            ),
          ),
          cursorColor: AppTheme.of(context).primaryColor,
        ),
      ),
    );
  }
}
