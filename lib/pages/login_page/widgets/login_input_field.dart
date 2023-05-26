import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rta_crm_cv/theme/theme.dart';

class LoginInputField extends StatefulWidget {
  const LoginInputField({
    Key? key,
    required this.label,
    this.isPasswordField = false,
    required this.controller,
    this.validator,
    this.unfocusedTextColor = Colors.grey,
  }) : super(key: key);

  final String label;
  final bool isPasswordField;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final Color unfocusedTextColor;

  @override
  State<LoginInputField> createState() => _LoginInputFieldState();
}

class _LoginInputFieldState extends State<LoginInputField> {
  bool passwordVisibility = false;

  late Color currentTextColor;

  @override
  void initState() {
    currentTextColor = widget.unfocusedTextColor;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: SizedBox(
        width: 445,
        height: 65,
        child: FocusScope(
          onFocusChange: (value) {
            if (value) {
              currentTextColor = AppTheme.of(context).primaryColor;
            } else {
              currentTextColor = Colors.grey;
            }
            setState(() {});
            // print('${widget.label} field has $value focus');
          },
          child: TextFormField(
            key: widget.key,
            controller: widget.controller,
            obscureText: widget.isPasswordField ? !passwordVisibility : false,
            validator: widget.validator,
            decoration: InputDecoration(
              isCollapsed: true,
              isDense: true,
              contentPadding: const EdgeInsets.only(
                left: 10,
                right: 10,
                top: 15,
                bottom: 15,
              ),
              labelText: widget.label,
              labelStyle: GoogleFonts.poppins(
                color: currentTextColor,
                fontWeight: FontWeight.normal,
              ),
              alignLabelWithHint: true,
              hintText: widget.label,
              hintStyle: GoogleFonts.poppins(
                color: currentTextColor,
                fontWeight: FontWeight.normal,
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: AppTheme.of(context).primaryColor,
                  width: 0.4,
                ),
                borderRadius: BorderRadius.circular(4.88),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: AppTheme.of(context).primaryColor,
                  width: 0.4,
                ),
                borderRadius: BorderRadius.circular(4.88),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Colors.red,
                  width: 0.4,
                ),
                borderRadius: BorderRadius.circular(4.88),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Colors.red,
                  width: 0.4,
                ),
                borderRadius: BorderRadius.circular(4.88),
              ),
              focusColor: AppTheme.of(context).primaryColor,
              prefixIcon: widget.isPasswordField
                  ? const Icon(Icons.key_sharp)
                  : const Icon(Icons.person_2_outlined),
              prefixIconColor: MaterialStateColor.resolveWith((states) =>
                  states.contains(MaterialState.focused)
                      ? AppTheme.of(context).primaryColor
                      : Colors.grey),
              suffixIcon: widget.isPasswordField
                  ? InkWell(
                      onTap: () => setState(
                        () => passwordVisibility = !passwordVisibility,
                      ),
                      focusNode: FocusNode(skipTraversal: true),
                      child: Icon(
                        passwordVisibility
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        color: Colors.grey,
                        size: 22,
                      ),
                    )
                  : null,
            ),
            style: GoogleFonts.poppins(
              color: AppTheme.of(context).primaryColor,
              fontSize: 15.6,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }
}
