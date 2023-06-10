import 'package:flutter/material.dart';
import 'package:rta_crm_cv/functions/sizes.dart';
import 'package:rta_crm_cv/public/colors.dart';
import 'package:rta_crm_cv/theme/theme.dart';

class GraficaEsferaDashboard extends StatefulWidget {
  const GraficaEsferaDashboard({Key? key}) : super(key: key);

  @override
  State<GraficaEsferaDashboard> createState() => _GraficaDashboardState();
}

class _GraficaDashboardState extends State<GraficaEsferaDashboard> {
  @override
  Widget build(BuildContext context) {
    //DashboardCRMProvider provider = Provider.of<DashboardCRMProvider>(context);
    return Container(
        width: getWidth(280, context),
        height: getHeight(640, context),
        decoration: BoxDecoration(
          border:
              Border.all(color: AppTheme.of(context).primaryColor, width: 2),
          borderRadius: BorderRadius.circular(10),
          gradient: whiteGradient,
        ),
        child: Column(
          children: [
            //Activity
            Column(
              children: [
                Text(
                  'Activity',
                  style: TextStyle(
                      fontFamily: 'UniNeue',
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.of(context).primaryText),
                ),
                Container(
                  width: 230,
                  height: 300,
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: AppTheme.of(context).primaryColor, width: 2),
                    borderRadius: BorderRadius.circular(10),
                    gradient: whiteGradient,
                  ),
                )
              ],
            ),
            //Comparation Month
            Column(
              children: [
                Text(
                  'Comparation Month',
                  style: TextStyle(
                      fontFamily: 'UniNeue',
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.of(context).primaryText),
                ),
                Container(
                  width: 230,
                  height: 300,
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: AppTheme.of(context).primaryColor, width: 2),
                    borderRadius: BorderRadius.circular(10),
                    gradient: whiteGradient,
                  ),
                )
              ],
            ),
          ],
        ));
  }
}
