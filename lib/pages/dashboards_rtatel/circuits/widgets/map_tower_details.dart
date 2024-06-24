import 'package:flutter/material.dart';
import 'package:rta_crm_cv/models/dashboard_rta/towers.dart';
import 'package:rta_crm_cv/theme/theme.dart';

class MapTowerDetails extends StatelessWidget {

  const MapTowerDetails({
    Key? key,
    required this.mapMarker,
  }) : super (key: key);

  final TowerRta? mapMarker;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Card(
        color: AppTheme.of(context).primaryBackground,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.08,
              child: Text(
                mapMarker?.companyId == 1 ? "CRY" :
                mapMarker?.companyId == 2 ? "ODE" :
                mapMarker?.companyId == 3 ? "SMI" :
                "RTA",
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: AppTheme.of(context)
                .bodyText1
                .override(
                  fontFamily: 'Gotham-Regular',
                  useGoogleFonts: false,
                  color: mapMarker?.companyId == 1 ? AppTheme.of(context).cryPrimary :
                  mapMarker?.companyId == 2 ? AppTheme.of(context).odePrimary :
                  mapMarker?.companyId == 3 ? AppTheme.of(context).smiPrimary :
                  AppTheme.of(context).primaryColor,
                  fontSize: 40,
                ),
              ),
            ),
          ),
          const SizedBox(height: 5,),
          Text(
            mapMarker?.address ?? 'Address',
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: AppTheme.of(context)
            .bodyText1
            .override(
              fontFamily: 'Gotham-Regular',
              useGoogleFonts: false,
              color: AppTheme.of(context)
                  .primaryText,
            ),
          ),
          const SizedBox(height: 5,),
          Text(
            mapMarker?.city ?? 'City',
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: AppTheme.of(context)
            .bodyText1
            .override(
              fontFamily: 'Gotham-Regular',
              useGoogleFonts: false,
              color: AppTheme.of(context)
                  .primaryText,
            ),
          ),
          const SizedBox(height: 10,),
          Text(
            "Make: ${mapMarker?.make ?? 'Not selected'}",
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: AppTheme.of(context)
            .subtitle2
            .override(
              fontFamily: 'Gotham-Regular',
              useGoogleFonts: false,
              color: AppTheme.of(context)
                  .primaryColor,
            ),
          ),
          Text(
            "Model: ${mapMarker?.model ?? 'Not selected'}",
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: AppTheme.of(context)
            .subtitle2
            .override(
              fontFamily: 'Gotham-Regular',
              useGoogleFonts: false,
              color: AppTheme.of(context)
                  .primaryText,
            ),
          ),
          const SizedBox(height: 10,),
          Text(
            "[Latitude: ${mapMarker?.long ?? 'Unknown'},",
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: AppTheme.of(context)
            .subtitle2
            .override(
              fontFamily: 'Gotham-Regular',
              useGoogleFonts: false,
              color: AppTheme.of(context)
                  .secondaryColor,
            ),
          ),
          Text(
            "Longitude: ${mapMarker?.lat ?? 'Unknown'}]",
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: AppTheme.of(context)
            .subtitle2
            .override(
              fontFamily: 'Gotham-Regular',
              useGoogleFonts: false,
              color: AppTheme.of(context)
                  .secondaryColor,
            ),
          ),
          ]
        ),
      ),
    );
  }

}