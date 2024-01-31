import 'package:flutter/material.dart';
import 'package:rta_crm_cv/theme/theme.dart';

class CustomDDownMenu extends StatefulWidget {
  const CustomDDownMenu({
    super.key,
    this.enabled = true,
    this.required = false,
    required this.list,
    required this.dropdownValue,
    required this.onChanged,
    required this.icon,
    required this.label,
    this.width,
    this.hint,
  });

  final bool enabled;
  final bool required;
  final IconData icon;
  final String label;
  final List<String> list;
  final String? dropdownValue;
  final Function(String?) onChanged;
  final String? hint;
  final double? width;

  @override
  State<CustomDDownMenu> createState() => _CustomDDownMenuState();
}

class _CustomDDownMenuState extends State<CustomDDownMenu> {
  @override
  Widget build(BuildContext context) {
    List<DropdownMenuEntry<String>> dropdownMenuEntries = [];
    for (String string in widget.list) {
      dropdownMenuEntries.add(DropdownMenuEntry<String>(label: string, value: string));
    }
    return SizedBox(
      //height: 55,
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
        child: DropdownMenu<String>(
          enabled: widget.enabled,
          width: widget.width,
          leadingIcon: Icon(widget.icon, color: widget.enabled ? AppTheme.of(context).primaryColor : AppTheme.of(context).hintText.color),
          trailingIcon: Icon(Icons.arrow_drop_down, color: widget.enabled ? AppTheme.of(context).primaryColor : AppTheme.of(context).hintText.color),
          initialSelection: widget.dropdownValue,
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
          textStyle: TextStyle(fontSize: 14, color: widget.enabled ? AppTheme.of(context).primaryColor : AppTheme.of(context).hintText.color),
          dropdownMenuEntries: dropdownMenuEntries,
          onSelected: widget.enabled ? widget.onChanged : null,
          inputDecorationTheme: InputDecorationTheme(
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
          ),
        ),
      ),
    );
  }
}
