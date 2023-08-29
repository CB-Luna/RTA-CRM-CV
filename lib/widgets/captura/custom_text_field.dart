import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rta_crm_cv/public/colors.dart';
import 'package:rta_crm_cv/theme/theme.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    this.width = 150,
    this.height = 35,
    required this.enabled,
    required this.controller,
    required this.icon,
    required this.label,
    required this.keyboardType,
    this.inputFormatters,
    this.onDone,
    this.onChanged,
    this.maxLength,
    this.validator,
  });

  final String label;
  final IconData icon;
  final TextEditingController controller;
  final bool enabled;
  final TextInputType keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final double? width;
  final double height;
  final Function(String)? onDone;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;

  final int? maxLength;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 51,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          AnimatedContainer(
            width: widget.width,
            height: widget.height,
            duration: const Duration(milliseconds: 100),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: AppTheme.of(context).primaryBackground,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 0.1,
                    blurRadius: 3,
                    offset: const Offset(0, 0), // changes position of shadow
                  ),
                ]),
            child: Form(
              child: TextFormField(
                maxLength: widget.maxLength,
                controller: widget.controller,
                validator: widget.validator,
                enabled: widget.enabled,
                keyboardType: widget.keyboardType,
                inputFormatters: widget.inputFormatters,
                textCapitalization: TextCapitalization.words,
                decoration: InputDecoration(
                  counterText: "",
                  disabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Color(Colors.grey[350]!.value), width: 0.5),
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
                  prefixIcon: Icon(
                    widget.icon,
                    color: AppTheme.of(context).hintText.color,
                  ),
                  prefixIconColor: AppTheme.of(context).primaryColor,
                  label: Text(
                    widget.label,
                    style: TextStyle(
                        fontSize: 20,
                        color: widget.enabled
                            ? AppTheme.of(context).primaryColor
                            : AppTheme.of(context).hintText.color),
                  ),
                ),
                cursorColor: AppTheme.of(context).primaryColor,
                onChanged: widget.onChanged,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
