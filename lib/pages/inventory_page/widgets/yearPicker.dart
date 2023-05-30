import 'package:flutter/material.dart';

class YearPickerPopUp extends StatefulWidget {
  const YearPickerPopUp({super.key});

  @override
  State<YearPickerPopUp> createState() => _YearPickerPopUpState();
}

class _YearPickerPopUpState extends State<YearPickerPopUp> {
  @override
  Widget build(BuildContext context) {
    DateTime _selectedYear = DateTime.now();

    return AlertDialog(
        content: Container(
      width: 300,
      height: 300,
      child: YearPicker(
          firstDate: DateTime(DateTime.now().year - 100, 1),
          lastDate: DateTime(DateTime.now().year + 100, 1),
          initialDate: DateTime.now(),
          selectedDate: _selectedYear,
          onChanged: (DateTime dateTime) {
            setState(() {
              _selectedYear = dateTime;
            });
          }),
    ));
  }
}
