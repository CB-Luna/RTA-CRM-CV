import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rta_crm_cv/theme/theme.dart';

class CustomTextFieldCircuit extends StatefulWidget {
  const CustomTextFieldCircuit({
    super.key,
    this.width = 150,
    this.height = 45,
    required this.enabled,
    this.required = false,
    required this.controller,
    this.icon,
    required this.label,
    required this.keyboardType,
    this.inputFormatters,
    this.onDone,
    this.onChanged,
    this.maxLength,
    this.validator,
    this.hint,
  });

  final String label;
  final IconData? icon;
  final TextEditingController controller;
  final bool enabled;
  final bool required;
  final TextInputType keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final double? width;
  final double height;
  final Function(String)? onDone;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final String? hint;

  final int? maxLength;

  @override
  State<CustomTextFieldCircuit> createState() => _CustomTextFieldCircuitState();
}

class _CustomTextFieldCircuitState extends State<CustomTextFieldCircuit> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      //height: widget.height,
      width: widget.width,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: AppTheme.of(context).primaryBackground,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 0.1,
              blurRadius: 3,
              // changes position of shadow
              offset: const Offset(0, 0),
            ),
          ],
        ),
        child: TextFormField(
          controller: widget.controller,
          enabled: widget.enabled,
          keyboardType: widget.keyboardType,
          inputFormatters: widget.inputFormatters,
          style: TextStyle(color: AppTheme.of(context).primaryText),
          decoration: InputDecoration(
            hintText: widget.hint,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppTheme.of(context).primaryText),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: AppTheme.of(context).primaryColor, width: 0.5),
              borderRadius: BorderRadius.circular(5),
            ),
            disabledBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: Color(Colors.grey[350]!.value), width: 0.5),
              borderRadius: BorderRadius.circular(5),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: AppTheme.of(context).secondaryColor, width: 0.5),
              borderRadius: BorderRadius.circular(5),
            ),
            prefixIcon: Icon(
              widget.icon,
              color: AppTheme.of(context).cryPrimary,
            ),
            prefixIconColor: widget.enabled
                ? AppTheme.of(context).primaryColor
                : AppTheme.of(context).hintText.color,
            label: RichText(
              text: TextSpan(
                text: widget.label,
                style: TextStyle(
                    fontSize: 14,
                    color: widget.enabled
                        ? AppTheme.of(context).primaryText
                        : AppTheme.of(context).hintText.color),
                children: widget.required
                    ? [
                        TextSpan(
                          text: ' *',
                          style: TextStyle(
                              fontSize: 14,
                              color: widget.enabled
                                  ? AppTheme.of(context).primaryText
                                  : AppTheme.of(context).hintText.color),
                        )
                      ]
                    : null,
              ),
            ),
          ),
          cursorColor: AppTheme.of(context).primaryColor,
          onChanged: widget.onChanged,
          validator: widget.validator,
        ),
      ),
    );
  }
}
