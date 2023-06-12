import 'package:flutter/material.dart';
import 'package:rta_crm_cv/helpers/constants.dart';
import 'package:rta_crm_cv/public/colors.dart';
import 'package:rta_crm_cv/theme/theme.dart';

class PlutoGridStatusCell extends StatelessWidget {
  PlutoGridStatusCell({
    super.key,
    required this.text,
  });

  String? text;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: rowHeight,
      // width: rendererContext.cell.column.width,
      decoration: BoxDecoration(gradient: whiteGradient),
      child: Center(
        child: Container(
          decoration: BoxDecoration(
            color: statusColor(text),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: Text(
              text ?? '-',
              style: AppTheme.of(context).contenidoTablas.override(
                    fontFamily: 'Gotham-Regular',
                    useGoogleFonts: false,
                    color: statusTextColor(text),
                  ),
            ),
          ),
        ),
      ),
    );
  }
}

Color statusColor(String? status) {
  late Color color;

  if (status != null) {
    switch (status) {
      case 'In process':
        color = Colors.greenAccent;
        break;
      case 'Opened':
        color = Colors.greenAccent;
        break;
      case 'Margin Positive':
        color = Colors.blueAccent;
        break;
      case 'Sen. Exec. Validate':
        color = Colors.pinkAccent;
        break;
      case 'Finance Validate':
        color = Colors.orangeAccent;
        break;
      case 'Validated':
        color = Colors.purpleAccent;
        break;
      case 'Closed':
        color = Colors.redAccent;
        break;
      default:
        return Colors.transparent;
    }
  } else {
    return color = Colors.transparent;
  }

  return color;
}

Color statusTextColor(String? status) {
  if (status != null) {
    return Colors.white;
  } else {
    return Colors.black;
  }
}
