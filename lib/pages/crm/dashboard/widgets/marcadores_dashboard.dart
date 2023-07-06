import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rta_crm_cv/functions/sizes.dart';
import 'package:rta_crm_cv/providers/crm/dashboard_provider.dart';
import 'package:rta_crm_cv/theme/theme.dart';
import 'package:rta_crm_cv/widgets/custome_marcador.dart';

class MarcadoresDashboard extends StatefulWidget {
  const MarcadoresDashboard({Key? key}) : super(key: key);

  @override
  State<MarcadoresDashboard> createState() => _MarcadoresDashboardState();
}

class _MarcadoresDashboardState extends State<MarcadoresDashboard> {


  @override
  Widget build(BuildContext context) {
     DashboardCRMProvider provider = Provider.of<DashboardCRMProvider>(context);
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomeMarcador(
          width: getWidth(216, context),
          height: getHeight(200, context),
          bordercolor: AppTheme.of(context).primaryColor,
          contador: '102',
          titulo: 'Totals',
          text: '\$12,439',
          icon: Icons.folder_special,
        ),
        SizedBox(width: getWidth(56, context)),
        CustomeMarcador(
          width: getWidth(216, context),
          height: getHeight(200, context),
          bordercolor: provider.verde,
          contador: '60',
          titulo: 'Orders',
          text: '\$7,896',
          icon: Icons.receipt_long,
        ),
        SizedBox(width: getWidth(56, context)),
        CustomeMarcador(
          width: getWidth(216, context),
          height: getHeight(200, context),
          bordercolor: provider.amarillo,
          contador: '42',
          titulo: 'Quotes',
          text: '\$4,543',
          icon: Icons.request_quote,
        ),
        SizedBox(width: getWidth(56, context)),
        CustomeMarcador(
          width: getWidth(216, context),
          height: getHeight(200, context),
          bordercolor: provider.rojo,
          contador: '20',
          titulo: 'Canceled',
          text: '\$1,879',
          icon: Icons.cancel,
        ),
        SizedBox(width: getWidth(56, context)),
      ],
    );
  }
}
