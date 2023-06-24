import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rta_crm_cv/functions/sizes.dart';
import 'package:rta_crm_cv/providers/crm/dashboard_provider.dart';
import 'package:rta_crm_cv/widgets/custome_marcador.dart';

class MarcadoresDashboard extends StatefulWidget {
  const MarcadoresDashboard({Key? key}) : super(key: key);

  @override
  State<MarcadoresDashboard> createState() => _MarcadoresDashboardState();
}

class _MarcadoresDashboardState extends State<MarcadoresDashboard> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final DashboardCRMProvider provider = Provider.of<DashboardCRMProvider>(
        context,
        listen: false,
      );
      await provider.updateState();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomeMarcador(
          width: getWidth(216, context),
          height: getHeight(189.33, context),
          titulo: 'Orders',
          text: '\$500',
          icon: Icons.attach_money,
        ),
        SizedBox(width: getWidth(56, context)),
        CustomeMarcador(
          width: getWidth(216, context),
          height: getHeight(189.33, context),
          titulo: 'Quotes',
          text: '\$500',
          icon: Icons.attach_money,
        ),
        SizedBox(width: getWidth(56, context)),
        CustomeMarcador(
          width: getWidth(216, context),
          height: getHeight(189.33, context),
          titulo: 'Canceled',
          text: '\$500',
          icon: Icons.attach_money,
        ),
        SizedBox(width: getWidth(56, context)),
       /*  CustomeMarcador(
          width: getWidth(216, context),
          height: getHeight(189.33, context),
          titulo: 'Lead',
          text: '\$500',
          icon: Icons.attach_money,
        ),
        SizedBox(width: getWidth(56, context)),
        CustomeMarcador(
          width: getWidth(216, context),
          height: getHeight(189.33, context),
          titulo: 'Opportunities',
          text: '\$500',
          icon: Icons.attach_money,
        ),
        SizedBox(width: getWidth(56, context)),
        CustomeMarcador(
          width: getWidth(216, context),
          height: getHeight(189.33, context),
          titulo: 'Quotes',
          text: '\$500',
          icon: Icons.attach_money,
        ), */
      ],
    );
  }
}
