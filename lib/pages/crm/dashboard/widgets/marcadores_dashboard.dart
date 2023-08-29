import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rta_crm_cv/functions/money_format.dart';
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
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(width: getWidth(56, context)),
        CustomeMarcador(
          width: getWidth(216, context),
          height: getHeight(200, context),
          bordercolor: AppTheme.of(context).primaryColor,
          contador: '${provider.ctotal}',
          titulo: 'Totals',
          text: '\$${moneyFormat(provider.mtotal)}',
          icon: Icons.folder_special,
        ),
        SizedBox(width: getWidth(56, context)),
        CustomeMarcador(
          width: getWidth(216, context),
          height: getHeight(200, context),
          bordercolor: provider.verde,
          contador: '${provider.cOrder}',
          titulo: 'Orders',
          text: '\$${moneyFormat(provider.mOrder)}',
          icon: Icons.receipt_long,
        ),
        SizedBox(width: getWidth(56, context)),
        CustomeMarcador(
          width: getWidth(216, context),
          height: getHeight(200, context),
          bordercolor: provider.amarillo,
          contador: '${provider.cQuote}',
          titulo: 'Quotes',
          text: '\$${moneyFormat(provider.mQuote)}',
          icon: Icons.request_quote,
        ),
        SizedBox(width: getWidth(56, context)),
        CustomeMarcador(
          width: getWidth(216, context),
          height: getHeight(200, context),
          bordercolor: provider.rojo,
          contador: '${provider.cCancel}',
          titulo: 'Canceled',
          text: '\$${moneyFormat(provider.mCancel)}',
          icon: Icons.cancel,
        ),
        SizedBox(width: getWidth(56, context)),
      ],
    );
  }
}
