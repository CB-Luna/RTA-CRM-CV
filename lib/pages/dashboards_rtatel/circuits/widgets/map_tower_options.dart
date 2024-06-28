import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rta_crm_cv/providers/dashboard_rta/map_circuits_provider.dart';
import 'package:rta_crm_cv/theme/theme.dart';
import 'package:rta_crm_cv/widgets/custom_text_icon_button.dart';

class MapTowerOptions extends StatelessWidget {

  const MapTowerOptions({
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
            provider.towerButtonCRY ? 
            AppTheme.of(context).cryPrimary
            :
            AppTheme.of(context).cryPrimary.withOpacity(0.5),
            isLoading: false,
            icon: Icon(Icons.location_on_outlined,
                color: AppTheme.of(context)
                    .primaryBackground),
            text: 'CRY',
            style: AppTheme.of(context)
            .contenidoTablas
            .override(
              fontFamily: 'Gotham-Regular',
              useGoogleFonts: false,
              color: AppTheme.of(context)
                  .primaryBackground,
            ),
            onTap: () {
              provider.updateStatusTowerButton(0);
            }),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
              vertical: 10, horizontal: 20),
          child: CustomTextIconButton(
            color: 
            provider.towerButtonODE ? 
            AppTheme.of(context).odePrimary
            :
            AppTheme.of(context).odePrimary.withOpacity(0.5),
            isLoading: false,
            icon: Icon(Icons.location_on,
                color: AppTheme.of(context)
                    .primaryBackground),
            text: 'ODE',
            style: AppTheme.of(context)
            .contenidoTablas
            .override(
              fontFamily: 'Gotham-Regular',
              useGoogleFonts: false,
              color: AppTheme.of(context)
                  .primaryBackground,
            ),
            onTap: () {
              provider.updateStatusTowerButton(1);
            }),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
              vertical: 10, horizontal: 20),
          child: CustomTextIconButton(
            color: 
            provider.towerButtonSMI ? 
            AppTheme.of(context).smiPrimary
            :
            AppTheme.of(context).smiPrimary.withOpacity(0.5),
            isLoading: false,
            icon: Icon(Icons.location_on,
                color: AppTheme.of(context)
                    .primaryBackground),
            text: 'SMI',
            style: AppTheme.of(context)
            .contenidoTablas
            .override(
              fontFamily: 'Gotham-Regular',
              useGoogleFonts: false,
              color: AppTheme.of(context)
                  .primaryBackground,
            ),
            onTap: () {
              provider.updateStatusTowerButton(2);
            }),
        ),
        ]
      ),
    );
  }

}