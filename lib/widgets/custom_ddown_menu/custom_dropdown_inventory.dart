import 'package:flutter/material.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';
import 'package:rta_crm_cv/theme/theme.dart';

class CustomDropDownInventory extends StatefulWidget {
  const CustomDropDownInventory({
    super.key,
    required this.list,
    required this.dropdownValue,
    required this.onChanged,
    required this.label,
    required this.width,
    this.hint,
  });

  final double width;
  final String label;
  final List<String> list;
  final String? dropdownValue;
  final Function(String?) onChanged;
  final String? hint;

  @override
  State<CustomDropDownInventory> createState() =>
      _CustomDropDownInventoryState();
}

class _CustomDropDownInventoryState extends State<CustomDropDownInventory> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Text(
            widget.label,
            style: TextStyle(color: AppTheme.of(context).primaryColor),
          ),
        ),
        Container(
          width: widget.width,
          height: 35,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: AppTheme.of(context).primaryBackground,
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 0.1,
                  blurRadius: 3,
                  offset: const Offset(0, 0) // changes position of shadow
                  )
            ],
          ),
          child: Row(
            children: [
              const SizedBox(width: 10),
              PointerInterceptor(
                child: SizedBox(
                  width: widget.width - 50,
                  child: DropdownButton<String>(
                    hint: Text(
                      widget.hint ?? '',
                      style:
                          TextStyle(color: AppTheme.of(context).primaryColor),
                    ),
                    icon: Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(
                            Icons.arrow_drop_down,
                            color: AppTheme.of(context).primaryColor,
                            size: 25,
                          )
                        ],
                      ),
                    ),
                    borderRadius: BorderRadius.circular(5),
                    elevation: 0,
                    dropdownColor: AppTheme.of(context).primaryBackground,
                    style: TextStyle(color: AppTheme.of(context).primaryColor),
                    underline: const SizedBox.shrink(),
                    onChanged: widget.onChanged,
                    value: widget.dropdownValue,
                    items: widget.list
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: PointerInterceptor(
                          child: Text(
                            value,
                            style: TextStyle(
                              color: AppTheme.of(context).primaryColor,
                              fontFamily: 'Bicyclette-Thin',
                              fontSize:
                                  AppTheme.of(context).contenidoTablas.fontSize,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
