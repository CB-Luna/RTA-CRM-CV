// ignore_for_file: unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:rta_crm_cv/helpers/constants.dart';
import 'package:rta_crm_cv/public/colors.dart';
import 'package:rta_crm_cv/theme/theme.dart';

class PlutoGridCompanyCellTowers extends StatelessWidget {
  const PlutoGridCompanyCellTowers({
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
            color: statusColor(text, context),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: Text(
              nameCompany(text, context),
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
    case "1": // CRY
      color = AppTheme.of(context).cryPrimary;
      break;
    case "2": // ODE
      color = AppTheme.of(context).odePrimary;
      break;
    case "3": // SMI
      color = AppTheme.of(context).smiPrimary;
      break;

    default:
      return Colors.black;
  }
  return color;
}

String nameCompany(String index, BuildContext context) {
  late String companyName;
  switch (index) {
    case "1": // CRY
      companyName = "CRY";
      break;
    case "2": // ODE
      companyName = "ODE";
      break;
    case "3": // SMI
      companyName = "SMI";
      break;

    default:
      return "RTA";
  }
  return companyName;
}
