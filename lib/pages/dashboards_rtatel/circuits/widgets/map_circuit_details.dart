import 'package:flutter/material.dart';
import 'package:rta_crm_cv/helpers/constants.dart';
import 'package:rta_crm_cv/models/dashboard_rta/circuits.dart';
import 'package:rta_crm_cv/theme/theme.dart';

class MapCircuitDetails extends StatelessWidget {

  const MapCircuitDetails({
    Key? key,
    required this.mapMarker,
  }) : super (key: key);

  final Circuits? mapMarker;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.4,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Card(
          color: AppTheme.of(context).primaryBackground,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.08,
                height: MediaQuery.of(context).size.width * 0.08,
                child: mapMarker?.carrier?.toLowerCase() != null ? 
                Image.network("$supabaseUrl/storage/v1/object/public/assets/circuits/${mapMarker!.carrier!.toLowerCase()}.png") :
                Image.network("$supabaseUrl/storage/v1/object/public/assets/circuits/icon.png")
              ),
            ),
            Text(
              "${mapMarker?.street ?? 'Street'}, ${mapMarker?.zip ?? 'Zipcode'}",
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
              "${mapMarker?.city ?? 'City'}, ${mapMarker?.state ?? 'State'}",
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
              "Carrier: ${mapMarker?.carrier ?? 'Not selected'}",
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
              mapMarker?.rtaCustomer ?? 'Not selected',
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
      ),
    );
  }

}