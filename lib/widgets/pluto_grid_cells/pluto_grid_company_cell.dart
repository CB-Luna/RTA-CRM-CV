import 'package:flutter/material.dart';
import 'package:rta_crm_cv/helpers/constants.dart';
import 'package:rta_crm_cv/public/colors.dart';
import 'package:rta_crm_cv/theme/theme.dart';

class PlutoGridCompanyCellCV extends StatelessWidget {
  const PlutoGridCompanyCellCV({
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
          width: 120,
          decoration: BoxDecoration(
            color: statusColor(text,context),
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
    case "ODE": //Sales Form
      color = AppTheme.of(context).odePrimary;
      break;
    case "SMI": //Sen. Exec. Validate
      color = AppTheme.of(context).smiPrimary;
      break;
    case "CRY": //Finance Validate
      color = AppTheme.of(context).cryPrimary;
      break;

    default:
      return Colors.black;
  }
  return color;
}
