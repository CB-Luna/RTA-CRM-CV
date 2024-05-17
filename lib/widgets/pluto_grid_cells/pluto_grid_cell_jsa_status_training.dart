import 'package:flutter/material.dart';
import 'package:rta_crm_cv/helpers/constants.dart';
import 'package:rta_crm_cv/theme/theme.dart';

class PlutoGrdiJsaStatusTraining extends StatelessWidget {
  const PlutoGrdiJsaStatusTraining({
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

Color statusColor(String? status, BuildContext context) {
  late Color color;

  switch (status) {
    case "Active": //Sen. Exec. Validate
      color = Colors.green;
      break;
    case "Expired": //Finance Validate
      color = AppTheme.of(context).secondaryColor;
      break;

    default:
      return Colors.black;
  }
  return color;
}
