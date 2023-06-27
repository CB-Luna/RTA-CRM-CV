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
              text ?? '-',
              textAlign: TextAlign.center,
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

  switch (status) {
    case 'In process':
      color = Colors.greenAccent;
      break;
    case 'In proccess':
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
    case 'Accepted':
      color = Colors.green;
      break;
    case 'Rejected':
      color = Colors.red;
      break;
    case 'Closed':
      color = Colors.redAccent;
      break;
    default:
      return Colors.black;
  }

  return color;
}

Color statusTextColor(String? status) {
  late Color color;
  switch (status) {
    case 'In process':
      color = Colors.white;
      break;
    case 'In proccess':
      color = Colors.white;
      break;
    case 'Opened':
      color = Colors.white;
      break;
    case 'Margin Positive':
      color = Colors.white;
      break;
    case 'Sen. Exec. Validate':
      color = Colors.white;
      break;
    case 'Finance Validate':
      color = Colors.white;
      break;
    case 'Validated':
      color = Colors.white;
      break;
    case 'Accepted':
      color = Colors.white;
      break;
    case 'Rejected':
      color = Colors.white;
      break;
    case 'Closed':
      color = Colors.white;
      break;
    default:
      return Colors.white;
  }
  return color;
}
