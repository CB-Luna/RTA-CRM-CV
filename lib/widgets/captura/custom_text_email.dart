import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:rta_crm_cv/providers/ctrlv/homeowner_ftth_document_provider.dart';
import 'package:rta_crm_cv/theme/theme.dart';
import 'package:rta_crm_cv/widgets/custom_text_icon_button.dart';

class CustomTextEmail extends StatefulWidget {
  const CustomTextEmail({
    super.key,
    this.width = 150,
    this.height = 45,
  });
  final double? width;
  final double height;

  @override
  State<CustomTextEmail> createState() => _CustomTextEmailState();
}

class _CustomTextEmailState extends State<CustomTextEmail> {
  @override
  Widget build(BuildContext context) {
    final HomeownerFTTHDocumentProvider provider = Provider.of<HomeownerFTTHDocumentProvider>(context);
    final contactos = provider.emails;

    final List<Widget> contactosWidgets = List.generate(
      contactos.length,
      (index) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: EmailInfo(
          key: Key(index.toString()),
          index: index,
          // contacto: contactos[index],
        ),
      ),
    );

    return SizedBox(
      //height: widget.height,
      width: widget.width,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ...contactosWidgets,
        ],
      ),
    );
  }
}

class EmailInfo extends StatefulWidget {
  const EmailInfo({
    super.key,
    required this.index,
  });

  final int index;

  @override
  State<EmailInfo> createState() => _EmailInfoState();
}

class _EmailInfoState extends State<EmailInfo> {
  bool readOnly = true;

  @override
  Widget build(BuildContext context) {
    final HomeownerFTTHDocumentProvider provider = Provider.of<HomeownerFTTHDocumentProvider>(context);

    String contacto = provider.emails[widget.index];

    return Row(
      children: [
        Expanded(
          child: CustomInputField(
            enabled: true,
            icon: Icons.email,
            label: 'Other Email',
            keyboardType: TextInputType.emailAddress,
            controller: TextEditingController(text: contacto),
            onChanged: (value) => contacto = value,
            bgColor: readOnly ? Colors.white : const Color(0x4D0090FF),
            readOnly: false,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please add Email';
              } else if (!value.contains('@')) {
                return 'Please Add a Valid Email (missing "@")';
              }
              return null;
            },
          ),
        ),
        const SizedBox(width: 5),
        CustomTextIconButton(
          text: 'Delete',
          isLoading: false,
          icon: Icon(
            Icons.delete,
            color: AppTheme.of(context).primaryBackground,
          ),
          color: AppTheme.of(context).secondaryColor,
          onTap: () {
            setState(() {
              provider.eliminarContacto(widget.index);
            });
          },
        ),
        CustomTextIconButton(
            text: 'save',
            isLoading: false,
            icon: Icon(
              Icons.save,
              color: AppTheme.of(context).primaryBackground,
            ),
            color: AppTheme.of(context).primaryColor,
            onTap: () {
              setState(() {
                provider.emails.add(contacto);
                provider.eliminarContacto(widget.index);
                //print((provider.emails.toString()));
              });
            })
        ],
    );
  }
}

class CustomInputField extends StatefulWidget {
  const CustomInputField({
    super.key,
    required this.label,
    required this.controller,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.formatters,
    this.onChanged,
    this.bgColor = const Color(0x4D0090FF),
    this.readOnly = false,
    this.icon,
    required this.enabled,
    this.required = false,
  });

  final String label;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? formatters;
  final void Function(String)? onChanged;
  final Color bgColor;
  final bool readOnly;
  final IconData? icon;
  final bool enabled;
  final bool required;

  @override
  State<CustomInputField> createState() => _CustomInputFieldState();
}

class _CustomInputFieldState extends State<CustomInputField> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
        validator: widget.validator,
        keyboardType: widget.keyboardType,
        inputFormatters: widget.formatters,
        readOnly: widget.readOnly,
        onChanged: widget.onChanged,
        textAlign: TextAlign.start,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppTheme.of(context).primaryText),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppTheme.of(context).primaryColor, width: 0.5),
            borderRadius: BorderRadius.circular(5),
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(Colors.grey[350]!.value), width: 0.5),
            borderRadius: BorderRadius.circular(5),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppTheme.of(context).secondaryColor, width: 0.5),
            borderRadius: BorderRadius.circular(5),
          ),
          prefixIcon: Icon(widget.icon),
          prefixIconColor: widget.enabled ? AppTheme.of(context).primaryColor : AppTheme.of(context).hintText.color,
          label: RichText(
            text: TextSpan(
              text: widget.label,
              style: TextStyle(fontSize: 14, color: widget.enabled ? AppTheme.of(context).primaryColor : AppTheme.of(context).hintText.color),
              children: widget.required
                  ? [
                      TextSpan(
                        text: ' *',
                        style: TextStyle(fontSize: 14, color: widget.enabled ? AppTheme.of(context).secondaryColor : AppTheme.of(context).hintText.color),
                      )
                    ]
                  : null,
            ),
          ),
        ),
        cursorColor: AppTheme.of(context).primaryColor,
      ),
    );
  }
}
