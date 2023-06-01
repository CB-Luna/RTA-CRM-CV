import 'package:flutter/material.dart';
import 'package:rta_crm_cv/public/colors.dart';
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
        //TODO: Change color
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Text(
            widget.label,
            style: TextStyle(color: primaryColor),
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
              SizedBox(
                width: widget.width - 50,
                child: DropdownButton<String>(
                  hint: Text(
                    widget.hint ?? '',
                    style: TextStyle(color: primaryColor),
                  ),
                  icon: Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      //TODO: Change color
                      children: [
                        Icon(
                          Icons.arrow_drop_down,
                          color: primaryColor,
                          size: 25,
                        )
                      ],
                    ),
                  ),
                  borderRadius: BorderRadius.circular(5),
                  elevation: 0,
                  dropdownColor: AppTheme.of(context).primaryBackground,
                  //TODO: Change color
                  style: TextStyle(color: primaryColor),
                  underline: const SizedBox.shrink(),
                  onChanged: widget.onChanged,
                  value: widget.dropdownValue,
                  items:
                      widget.list.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: TextStyle(color: primaryColor),
                      ),
                    );
                  }).toList(),

                  /*  items: widget.list
                      .map<DropdownMenuItem<DDownSelected>>((DDownSelected item) => DropdownMenuItem<DDownSelected>(
                            value: item,
                            child: Container(
                              color: item.selected ? primaryColor : AppTheme.of(context).primaryBackground,
                              child: Text(item.name, style: TextStyle(color: item.selected ? AppTheme.of(context).primaryBackground : primaryColor)),
                            ),
                          ))
                      .toList(),  */

                  /* selectedItemBuilder: (BuildContext context) {
                    return widget.list.map<Widget>((String item) {
                      // This is the widget that will be shown when you select an item.
                      // Here custom text style, alignment and layout size can be applied
                      // to selected item string.
                      return Container(
                        alignment: Alignment.centerLeft,
                        constraints: const BoxConstraints(minWidth: 100),
                        color: item == widget.dropdownValue ? primaryColor : AppTheme.of(context).primaryBackground,
                        child: Text(
                          item,
                          style: TextStyle(
                            color: item == widget.dropdownValue ? AppTheme.of(context).primaryBackground : primaryColor,
                          ),
                        ),
                      );
                    }).toList();
                  }, */
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
