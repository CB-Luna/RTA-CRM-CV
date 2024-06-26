import 'package:flutter/material.dart';
import 'package:rta_crm_cv/models/dashboard_rta/leads_not_serviceable.dart';
import 'package:rta_crm_cv/theme/theme.dart';

class LeadNotServiceableDetails extends StatelessWidget {

  const LeadNotServiceableDetails({
    Key? key,
    required this.mapMarker,
  }) : super (key: key);

  final LeadsNotServiceable? mapMarker;

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
                mapMarker?.companyFk == 1 ? "CRY" :
                mapMarker?.companyFk == 2 ? "ODE" :
                mapMarker?.companyFk == 3 ? "SMI" :
                "RTA",
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: AppTheme.of(context)
                .bodyText1
                .override(
                  fontFamily: 'Gotham-Regular',
                  useGoogleFonts: false,
                  color: mapMarker?.companyFk == 1 ? AppTheme.of(context).cryPrimary :
                  mapMarker?.companyFk == 2 ? AppTheme.of(context).odePrimary :
                  mapMarker?.companyFk == 3 ? AppTheme.of(context).smiPrimary :
                  AppTheme.of(context).primaryColor,
                  fontSize: 40,
                ),
              ),
            ),
          ),
          const SizedBox(height: 5,),
          Text(
            "${mapMarker?.name ?? 'Name'} ${mapMarker?.lastName ?? 'Last Name'}",
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
            mapMarker?.email ?? "Email",
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
            mapMarker?.sourceFk == 1 ? "E-commerce" :
            mapMarker?.sourceFk == 2 ? "Facebook" :
            "Unknown",
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
            "Phone: ${mapMarker?.phone ?? 'Not selected'}",
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
            "[Latitude: ${mapMarker?.latitude ?? 'Unknown'},",
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
            "Longitude: ${mapMarker?.longitude ?? 'Unknown'}]",
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