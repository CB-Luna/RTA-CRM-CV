import 'package:flutter/material.dart';
import 'package:rta_crm_cv/functions/sizes.dart';
import 'package:rta_crm_cv/theme/theme.dart';
import 'package:rta_crm_cv/widgets/custome_marcador.dart';

class MarcadoresDashboardCtrlV extends StatefulWidget {
  const MarcadoresDashboardCtrlV({Key? key}) : super(key: key);

  @override
  State<MarcadoresDashboardCtrlV> createState() => _MarcadoresDashboardCtrlVState();
}

class _MarcadoresDashboardCtrlVState extends State<MarcadoresDashboardCtrlV> {


  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomeMarcador(
          width: getWidth(216, context),
          height: getHeight(200, context),
          bordercolor: AppTheme.of(context).tertiaryColor,
          contador: '33',
          titulo: 'All',
          text: '120 Issues',
          icon: Icons.star_border_outlined,
        ),
        SizedBox(width: getWidth(56, context)),
        CustomeMarcador(
          width: getWidth(216, context),
          height: getHeight(200, context),
          bordercolor: const Color(0xFF2E5899),
          contador: '15',
          titulo: 'CRY',
          text: '62 Issues',
          icon: Icons.local_shipping_outlined,
        ),
        SizedBox(width: getWidth(56, context)),
        CustomeMarcador(
          width: getWidth(216, context),
          height: getHeight(200, context),
          bordercolor: const Color(0xFFD20030),
          contador: '8',
          titulo: 'ODE',
          text: '30 Issues',
          icon: Icons.airport_shuttle_outlined,
        ),
        SizedBox(width: getWidth(56, context)),
        CustomeMarcador(
          width: getWidth(216, context),
          height: getHeight(200, context),
          bordercolor: const Color.fromRGBO(255, 138, 0, 1),
          contador: '10',
          titulo: 'SMI',
          text: '28 issues',
          icon: Icons.directions_car_outlined,
        ),
        SizedBox(width: getWidth(56, context)),
      ],
    );
  }
}
