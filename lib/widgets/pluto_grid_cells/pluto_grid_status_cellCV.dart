// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:rta_crm_cv/helpers/constants.dart';
import 'package:rta_crm_cv/public/colors.dart';
import 'package:rta_crm_cv/theme/theme.dart';

class PlutoGridStatusCellCV extends StatelessWidget {
  const PlutoGridStatusCellCV({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: rowHeight,
      // // width: rendererContext.cell.column.width,
      decoration: BoxDecoration(gradient: whiteGradient),
      child: Center(
        child: Container(
          width: 150,
          decoration: BoxDecoration(
            color: statusColor(text),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: AppTheme.of(context).contenidoTablas.override(
                    fontFamily: 'Gotham-Regular',
                    useGoogleFonts: false,
                    color: AppTheme.of(context).primaryBackground,
                  ),
            ),
          ),
        ),
      ),
    );
  }
}

Color statusColor(String status) {
  late Color color;

  switch (status) {
    case "Assigned": //Sales Form
      color = Colors.blueAccent;
      break;
    case "Available": //Sen. Exec. Validate
      color = Colors.greenAccent; // Colors.blueAccent;
      break;
    case "Repair": //Finance Validate
      color = Colors.orangeAccent;
      break;
    case "Not Active": //Finance Validate
      color = Colors.black;
      break;

    default:
      return Colors.black;
  }
  return color;
}
