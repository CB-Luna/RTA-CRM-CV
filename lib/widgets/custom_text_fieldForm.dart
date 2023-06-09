import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rta_crm_cv/public/colors.dart';
import 'package:rta_crm_cv/theme/theme.dart';

class CustomTextFieldForm extends StatefulWidget {
  const CustomTextFieldForm(
      {super.key,
      this.width = 500,
      required this.enabled,
      required this.controller,
      this.hint,
      required this.label,
      required this.keyboardType,
      this.inputFormatters,
      this.onTap,
      this.onTapCheck = false,
      this.designColor = 0xffffffff});

  final String label;
  //final IconData icon;
  final TextEditingController controller;
  final bool enabled;
  final TextInputType keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final double width;
  final void Function()? onTap;
  final bool onTapCheck;
  final int? designColor;
  final String? hint;

  @override
  State<CustomTextFieldForm> createState() => _CustomTextFieldFormState();
}

class _CustomTextFieldFormState extends State<CustomTextFieldForm> {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      width: widget.width,
      height: 35,
      duration: const Duration(milliseconds: 100),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Color(widget.designColor!),
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
          readOnly: widget.onTapCheck ? true : false,
          onTap: widget.onTap,
          controller: widget.controller,
          enabled: widget.enabled,
          keyboardType: widget.keyboardType,
          inputFormatters: widget.inputFormatters,
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
                color: AppTheme.of(context).primaryColor,
                fontFamily: 'Bicyclette-Thin',
                fontSize: AppTheme.of(context).contenidoTablas.fontSize,
              ),
            ),
          ),
          cursorColor: AppTheme.of(context).primaryColor,
        ),
      ),
    );
  }
}
