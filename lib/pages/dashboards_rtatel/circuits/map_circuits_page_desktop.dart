import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:rta_crm_cv/helpers/constants.dart';
import 'package:rta_crm_cv/models/dashboard_rta/circuits.dart';
import 'package:rta_crm_cv/providers/dashboard_rta/map_circuits_provider.dart';
import 'package:rta_crm_cv/theme/theme.dart';
import 'package:latlong2/latlong.dart';
import 'package:rta_crm_cv/widgets/custom_card.dart';
import 'package:rta_crm_cv/widgets/custom_text_icon_button.dart';
import 'package:rta_crm_cv/widgets/side_menu/sidemenu.dart';
import '../../../public/colors.dart';

class MapCircuitsPageDesktop extends StatefulWidget {
  const MapCircuitsPageDesktop({super.key});

  @override
  State<MapCircuitsPageDesktop> createState() =>
      _MapCircuitsPageDesktopState();
}

class _MapCircuitsPageDesktopState
    extends State<MapCircuitsPageDesktop> {
  @override
  void initState() {
    super.initState();
    // _initializeMap();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final MapCircuitsProvider provider = Provider.of<MapCircuitsProvider>(
        context,
        listen: false,
      );
      await provider.updateState();
    });
  }

  @override
  Widget build(BuildContext context) {
    MapCircuitsProvider provider = Provider.of<MapCircuitsProvider>(context);

    return Material(
      child: SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Row(children: [
        const SideMenu(),
        Flexible(
          child: Container(
              decoration: BoxDecoration(gradient: whiteGradient),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: CustomCard(
                  title:  "Map Circuits",
                  height: MediaQuery.of(context).size.height - 20,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            // vertical: 0, horizontal: 30),
                            vertical: 15,
                            horizontal: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 30),
                              child: CustomTextIconButton(
                                  isLoading: false,
                                  icon: Icon(Icons.arrow_back_outlined,
                                      color: AppTheme.of(context)
                                          .primaryBackground),
                                  text: 'Go Back',
                                  style: AppTheme.of(context)
                                  .contenidoTablas
                                  .override(
                                    fontFamily: 'Gotham-Regular',
                                    useGoogleFonts: false,
                                    color: AppTheme.of(context)
                                        .primaryBackground,
                                  ),
                                  onTap: () {
                                    if (!context.mounted) return;
                                    context.pushReplacement(
                                      routeCircuits,
                                    );
                                  }),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 30),
                              child: CustomTextIconButton(
                                  color: provider.circuitButton ? 
                                  AppTheme.of(context).primaryColor
                                  :
                                  AppTheme.of(context).primaryColor.withOpacity(0.5),
                                  isLoading: false,
                                  icon: Icon(Icons.ssid_chart_outlined,
                                      color: AppTheme.of(context)
                                          .primaryBackground),
                                  text: 'Circuits',
                                  style: AppTheme.of(context)
                                  .contenidoTablas
                                  .override(
                                    fontFamily: 'Gotham-Regular',
                                    useGoogleFonts: false,
                                    color: AppTheme.of(context)
                                        .primaryBackground,
                                  ),
                                  onTap: () {
                                    provider.updateStatusButton(0);
                                  }),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 30),
                              child: CustomTextIconButton(
                                  color: provider.towerButton ? 
                                  AppTheme.of(context).primaryColor
                                  :
                                  AppTheme.of(context).primaryColor.withOpacity(0.5),
                                  isLoading: false,
                                  icon: Icon(Icons.cell_tower_outlined,
                                      color: AppTheme.of(context)
                                          .primaryBackground),
                                  text: 'Towers',
                                  style: AppTheme.of(context)
                                  .contenidoTablas
                                  .override(
                                    fontFamily: 'Gotham-Regular',
                                    useGoogleFonts: false,
                                    color: AppTheme.of(context)
                                        .primaryBackground,
                                  ),
                                  onTap: () {
                                    provider.updateStatusButton(1);
                                  }),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 30),
                              child: CustomTextIconButton(
                                  color: provider.dataCenterButton ? 
                                  AppTheme.of(context).primaryColor
                                  :
                                  AppTheme.of(context).primaryColor.withOpacity(0.5),
                                  isLoading: false,
                                  icon: Icon(Icons.apartment_outlined,
                                      color: AppTheme.of(context)
                                          .primaryBackground),
                                  text: 'Data Centers',
                                  style: AppTheme.of(context)
                                  .contenidoTablas
                                  .override(
                                    fontFamily: 'Gotham-Regular',
                                    useGoogleFonts: false,
                                    color: AppTheme.of(context)
                                        .primaryBackground,
                                  ),
                                  onTap: () {
                                    provider.updateStatusButton(2);
                                  }),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height:
                            MediaQuery.of(context).size.height * 0.8,
                        width: MediaQuery.of(context).size.width - 30,
                        child: Stack(
                          children: [
                            FlutterMap(
                              options: MapOptions(
                                center: const LatLng(39.805406, -98.878322),
                                minZoom: 5,
                                maxZoom: 16,
                                zoom: 5,
                                // Agregar puntos manualmente
                                // onTap: (tapPosition, point) {
                                //   provider.addPoint(point);
                                // },
                              ),
                              nonRotatedChildren: [
                                TileLayer(
                                  urlTemplate: "https://api.mapbox.com/styles/v1/{id}/tiles/{z}/{x}/{y}?access_token={accessToken}",
                                  additionalOptions: {
                                    "accessToken": mapboxAccessToken,
                                    "id": mapboxStyle
                                  },
                                ),

                                // Lines Apops
                                if(provider.circuitButton)
                                PolylineLayer(
                                  polylines: provider.linesApops.map((line) {
                                    return Polyline(
                                      points: line,
                                      strokeWidth: 4.0,
                                      color: AppTheme.of(context).primaryColor,
                                      isDotted: true,
                                    );
                                  }).toList(),
                                ),

                                // Lines Bpops
                                if(provider.circuitButton)
                                PolylineLayer(
                                  polylines: provider.linesBpops.map((line) {
                                    return Polyline(
                                      points: line,
                                      strokeWidth: 4.0,
                                      color: AppTheme.of(context).secondaryColor,
                                    );
                                  }).toList(),
                                ),

                                if(provider.circuitButton)
                                MarkerLayer(
                                  markers: provider.markersCircuits,
                                ),

                                if(provider.towerButton)
                                MarkerLayer(
                                  markers: provider.markersTowers,
                                ),


                                // PolylineLayer(
                                //   polylines: [
                                //     Polyline(
                                //       points: provider.points,
                                //       strokeWidth: 5.0,
                                //       color: AppTheme.of(context).tertiaryColor
                                //     )
                                //   ],
                                // ),
                              ],
                            ),
                            Positioned(
                              top: 20,
                              right: 20,
                              height: MediaQuery.of(context).size.height * 0.4,
                              width: MediaQuery.of(context).size.width * 0.15,
                              // child: Container(
                              //   color: Colors.red,
                              //   child: Text(
                              //     "Hola"
                              //   ),
                              // ),
                              child: PageView.builder(
                                controller: provider.pageController,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: 1,
                                itemBuilder: (context, _ ) {
                                  final item = provider.circuitSelected;
                                  return MapItemDetails(
                                    mapMarker: item,
                                  );
                                }
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )),
        )
      ]),
    ));
  }
}

class MapItemDetails extends StatelessWidget {

  const MapItemDetails({
    Key? key,
    required this.mapMarker,
  }) : super (key: key);

  final Circuits? mapMarker;

  @override
  Widget build(BuildContext context) {
    return Padding(
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
          const SizedBox(height: 10,),
          Icon(
            Icons.location_on_outlined,
            color: AppTheme.of(context)
                .secondaryColor,
            size: 40,
          ),
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