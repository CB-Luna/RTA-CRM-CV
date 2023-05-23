import 'package:flutter/material.dart';
import 'package:rta_crm_cv/public/colors.dart';
import 'package:rta_crm_cv/theme/theme.dart';

class CustomDDownMenu extends StatefulWidget {
  const CustomDDownMenu({super.key, required this.list, required this.dropdownValue, required this.onChanged, required this.icon, required this.label, required this.width});

  final double width;
  final IconData icon;
  final String label;
  final List<String> list;
  final String dropdownValue;
  final Function(String?) onChanged;

  @override
  State<CustomDDownMenu> createState() => _CustomDDownMenuState();
}

class _CustomDDownMenuState extends State<CustomDDownMenu> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //TODO: Change color
        Padding(
          padding: const EdgeInsets.only(left: 40),
          child: Text(widget.label, style: TextStyle(color: primaryColor)),
        ),
        Container(
          width: widget.width,
          height: 35,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: primaryColor, boxShadow: [
            BoxShadow(color: Colors.grey.withOpacity(0.5), spreadRadius: 0.1, blurRadius: 3, offset: const Offset(0, 0) // changes position of shadow
                )
          ]),
          child: Row(
            children: [
              const SizedBox(width: 10),
              Icon(widget.icon, color: AppTheme.of(context).primaryBackground),
              const SizedBox(width: 10),
              SizedBox(
                width: widget.width - 50,
                child: DropdownButton<String>(
                  icon: Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [Icon(Icons.arrow_drop_down, color: AppTheme.of(context).primaryBackground, size: 25)],
                    ),
                  ),
                  borderRadius: BorderRadius.circular(5),
                  elevation: 0,
                  dropdownColor: primaryColor,
                  iconEnabledColor: AppTheme.of(context).primaryBackground,
                  style: TextStyle(color: AppTheme.of(context).primaryBackground),
                  underline: SizedBox.shrink(),
                  onChanged: widget.onChanged,
                  value: widget.dropdownValue,
                  items: widget.list.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value, style: TextStyle(color: AppTheme.of(context).primaryBackground)),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
