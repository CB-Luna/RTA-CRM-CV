import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rta_crm_cv/providers/dashboard_rta/map_circuits_provider.dart';
import 'package:rta_crm_cv/theme/theme.dart';
import 'package:rta_crm_cv/widgets/custom_text_icon_button.dart';

class MapLeadNotServiceableOptions extends StatelessWidget {

  const MapLeadNotServiceableOptions({
    Key? key,
  }) : super (key: key);


  @override
  Widget build(BuildContext context) {

    MapCircuitsProvider provider = Provider.of<MapCircuitsProvider>(context);

    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
        Padding(
          padding: const EdgeInsets.symmetric(
              vertical: 10, horizontal: 20),
          child: CustomTextIconButton(
            color: 
            provider.leadNotServiceableButtonE ? 
            AppTheme.of(context).tertiaryColor
            :
            AppTheme.of(context).tertiaryColor.withOpacity(0.5),
            isLoading: false,
            icon: Icon(Icons.person_outline,
                color: AppTheme.of(context)
                    .primaryBackground),
            text: 'E-Commerce',
            style: AppTheme.of(context)
            .contenidoTablas
            .override(
              fontFamily: 'Gotham-Regular',
              useGoogleFonts: false,
              color: AppTheme.of(context)
                  .primaryBackground,
            ),
            onTap: () {
              provider.updateStatusLeadNotServiceableButton(0);
            }),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
              vertical: 10, horizontal: 20),
          child: CustomTextIconButton(
            color: 
            provider.leadNotServiceableButtonF ? 
            AppTheme.of(context).primaryColor
            :
            AppTheme.of(context).primaryColor.withOpacity(0.5),
            isLoading: false,
            icon: Icon(Icons.person_outline,
                color: AppTheme.of(context)
                    .primaryBackground),
            text: 'Facebook',
            style: AppTheme.of(context)
            .contenidoTablas
            .override(
              fontFamily: 'Gotham-Regular',
              useGoogleFonts: false,
              color: AppTheme.of(context)
                  .primaryBackground,
            ),
            onTap: () {
              provider.updateStatusLeadNotServiceableButton(1);
            }),
        ),
        ]
      ),
    );
  }

}