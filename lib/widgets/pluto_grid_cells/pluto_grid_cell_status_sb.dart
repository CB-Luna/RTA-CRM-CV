import 'package:flutter/material.dart';
import 'package:rta_crm_cv/helpers/constants.dart';
import 'package:rta_crm_cv/public/colors.dart';
import 'package:rta_crm_cv/theme/theme.dart';

class PlutoGrdiJsaStatusSafety extends StatelessWidget {
  const PlutoGrdiJsaStatusSafety({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: rowHeight,
      // // width: rendererContext.cell.column.width,
      child: Center(
        child: Container(
          width: 120,
          decoration: BoxDecoration(
            color: statusColor(text, context),
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

Color statusColor(String status, BuildContext context) {
  late Color color;

  switch (status) {
    case "Received": //Sales Form
      color = AppTheme.of(context).odePrimary;
      break;
    case "Completed": //Sen. Exec. Validate
      color = Colors.green;
      break;
    case "Opened": //Finance Validate
      color = AppTheme.of(context).employeePrimary;
      break;

    case "-": //Finance Validate
      color = AppTheme.of(context).alternate;
      break;
    default:
      return Colors.black;
  }
  return color;
}
