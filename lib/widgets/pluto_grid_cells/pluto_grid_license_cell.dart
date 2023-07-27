import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rta_crm_cv/helpers/constants.dart';
import 'package:rta_crm_cv/public/colors.dart';
import 'package:rta_crm_cv/theme/theme.dart';

import '../../models/monitory.dart';
import '../../models/vehicle.dart';
import '../../providers/ctrlv/monitory_provider.dart';

class PlutoGridLicenseCellCV extends StatelessWidget {
  const PlutoGridLicenseCellCV({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    MonitoryProvider provider = Provider.of<MonitoryProvider>(context);
    String license = "";
    
    for(Monitory row in provider.lista){

      if(text == row.vehicle.licesensePlates){
        license =row.vehicle.company.company;
      }
    }

    return Container(
      height: rowHeight,
      // // width: rendererContext.cell.column.width,
      decoration: BoxDecoration(gradient: whiteGradient),
      child: Center(
        child: Container(
          width: 150,
          decoration: BoxDecoration(
            color: statusColor(license),
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
    case "ODE": //Sales Form
      color = const Color(0XFFB2333A);
      break;
    case "SMI": //Sen. Exec. Validate
      color = const Color.fromRGBO(255, 138, 0, 1);
      break;
    case "CRY": //Finance Validate
      color = const Color(0XFF345694);
      break;

    default:
      return Colors.black;
  }
  return color;
}
