import 'package:flutter/material.dart';
import 'package:rta_crm_cv/helpers/constants.dart';
import 'package:rta_crm_cv/theme/theme.dart';

import '../../models/company.dart';
import '../../public/colors.dart';

class PlutoGridCompanyCellCV extends StatelessWidget {
  final List<Company> companies;

  const PlutoGridCompanyCellCV({
    super.key,
    required this.companies,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: rowHeight,
      decoration: BoxDecoration(gradient: whiteGradient),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: companies.length,
        itemBuilder: (context, index) {
          Company currentCompany = companies[index];
          return Align(
            alignment: Alignment.centerRight,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.04,
              height: rowHeight,
              alignment: Alignment.center,
              margin: const EdgeInsets.symmetric(horizontal: 2, vertical: 3),
              decoration: BoxDecoration(
                color: statusColor(currentCompany.company, context),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                currentCompany.company,
                style: AppTheme.of(context).contenidoTablas.override(
                      fontFamily: 'Gotham-Regular',
                      useGoogleFonts: false,
                      color: AppTheme.of(context).primaryBackground,
                    ),
              ),
            ),
          );
        },
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
