import 'package:flutter/material.dart';
import 'package:rta_crm_cv/theme/theme.dart';

class CustomeDDownMenuDashboard extends StatefulWidget {
  const CustomeDDownMenuDashboard({
    super.key,
    this.enabled = true,
    required this.list,
    required this.dropdownValue,
    required this.onChanged,
    required this.icon,
    required this.width,
    this.hint,
  });

  final bool enabled;
  final double width;
  final IconData icon;
  final List<String> list;
  final String? dropdownValue;
  final Function(String?) onChanged;
  final String? hint;

  @override
  State<CustomeDDownMenuDashboard> createState() => _CustomeDDownMenuDashboardState();
}

class _CustomeDDownMenuDashboardState extends State<CustomeDDownMenuDashboard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: 35,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: AppTheme.of(context).primaryColor,
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
      child: Row(
        children: [
          const SizedBox(width: 10),
          Icon(widget.icon, color: widget.enabled ? AppTheme.of(context).primaryBackground : AppTheme.of(context).hintText.color),
          const SizedBox(width: 10),
          SizedBox(
            width: widget.width - 50,
            child: DropdownButton<String>(
              hint: Text(
                widget.hint ?? '',
                style: TextStyle(color: widget.enabled ? AppTheme.of(context).primaryBackground : AppTheme.of(context).hintText.color),
              ),
              icon: Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(
                      Icons.arrow_drop_down,
                      color: widget.enabled ? AppTheme.of(context).primaryBackground : AppTheme.of(context).hintText.color,
                      size: 25,
                    )
                  ],
                ),
              ),
              borderRadius: BorderRadius.circular(5),
              elevation: 0,
              dropdownColor: AppTheme.of(context).primaryColor,
              underline: const SizedBox.shrink(),
              onChanged: widget.enabled ? widget.onChanged : null,
              value: widget.dropdownValue,
              items: widget.list.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: TextStyle(fontSize: 14, color: widget.enabled ? AppTheme.of(context).primaryBackground : AppTheme.of(context).hintText.color),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
