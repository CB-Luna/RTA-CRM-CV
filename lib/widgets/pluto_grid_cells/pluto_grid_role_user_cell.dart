
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rta_crm_cv/helpers/constants.dart';
import 'package:rta_crm_cv/public/colors.dart';
import 'package:rta_crm_cv/theme/theme.dart';

import '../../models/monitory.dart';
import '../../providers/ctrlv/monitory_provider.dart';

class PlutoGridRoleUserCellCV extends StatelessWidget {
  const PlutoGridRoleUserCellCV({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    MonitoryProvider provider = Provider.of<MonitoryProvider>(context);
    String role = "";
    
    for(Monitory row in provider.lista){
      String complete = "${row.worker.name} ${row.worker.lastName}";

      if(text == complete){
        role = row.worker.role;
      }
    }
    return Container(
      height: rowHeight,
      // // width: rendererContext.cell.column.width,
      decoration: BoxDecoration(gradient: whiteGradient),
      child: Center(
        child: Container(
          width: 120,
          decoration: BoxDecoration(
            color: statusColor(role,context),
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

Color statusColor(String status,BuildContext context) {
  late Color color;

  switch (status) {
    case "Employee": //Sales Form
      color = AppTheme.of(context).employeePrimary;
      break;
    case "Manager": //Sen. Exec. Validate
      color = AppTheme.of(context).managerPrimary;
      break;
    case "Tech Supervisor": //Finance Validate
      color = AppTheme.of(context).techSupPrimary;
      break;

    default:
      return Colors.black;
  }
  return color;
}
