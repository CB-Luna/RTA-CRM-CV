import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rta_crm_cv/functions/sizes.dart';
import 'package:rta_crm_cv/providers/ctrlv/dashboard_provider.dart';
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
    DashboardCVProvider provider = Provider.of<DashboardCVProvider>(context);
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomeMarcador(
          width: getWidth(216, context),
          height: getHeight(200, context),
          bordercolor: AppTheme.of(context).tertiaryColor,
          contador: '${provider.vehiclesCRY + provider.vehiclesODE + provider.vehiclesSMI} Vehicles',
          titulo: 'All',
          text: '${provider.cry + provider.ode + provider.smi} Issues',
          icon: Icons.star_border_outlined,
        ),
        SizedBox(width: getWidth(56, context)),
        CustomeMarcador(
          width: getWidth(216, context),
          height: getHeight(200, context),
          bordercolor: const Color(0xFF2E5899),
          contador: '${provider.vehiclesCRY} Vehicles',
          titulo: 'CRY',
          text: '${provider.cry} Issues',
          icon: Icons.local_shipping_outlined,
        ),
        SizedBox(width: getWidth(56, context)),
        CustomeMarcador(
          width: getWidth(216, context),
          height: getHeight(200, context),
          bordercolor: const Color(0xFFD20030),
          contador: '${provider.vehiclesODE} Vehicles',
          titulo: 'ODE',
          text: '${provider.ode} Issues',
          icon: Icons.airport_shuttle_outlined,
        ),
        SizedBox(width: getWidth(56, context)),
        CustomeMarcador(
          width: getWidth(216, context),
          height: getHeight(200, context),
          bordercolor: const Color.fromRGBO(255, 138, 0, 1),
          contador: '${provider.vehiclesSMI} Vehicles',
          titulo: 'SMI',
          text: '${provider.smi} issues',
          icon: Icons.directions_car_outlined,
        ),
        SizedBox(width: getWidth(56, context)),
      ],
    );
  }
}
