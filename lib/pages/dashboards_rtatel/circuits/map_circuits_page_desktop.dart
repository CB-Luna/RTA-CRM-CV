import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:rta_crm_cv/helpers/constants.dart';
import 'package:rta_crm_cv/pages/dashboards_rtatel/circuits/widgets/map_circuit_details.dart';
import 'package:rta_crm_cv/pages/dashboards_rtatel/circuits/widgets/map_lead_not_serviceable_options.dart';
import 'package:rta_crm_cv/pages/dashboards_rtatel/circuits/widgets/map_tower_options.dart';
import 'package:rta_crm_cv/pages/dashboards_rtatel/circuits/widgets/map_lead_not_serviceable_details.dart';
import 'package:rta_crm_cv/pages/dashboards_rtatel/circuits/widgets/map_tower_details.dart';
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
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 30),
                              child: CustomTextIconButton(
                                  color: provider.leadNotServiceableButton ? 
                                  AppTheme.of(context).primaryColor
                                  :
                                  AppTheme.of(context).primaryColor.withOpacity(0.5),
                                  isLoading: false,
                                  icon: Icon(Icons.person_pin_circle_sharp,
                                      color: AppTheme.of(context)
                                          .primaryBackground),
                                  text: 'Leads Not Serviceable',
                                  style: AppTheme.of(context)
                                  .contenidoTablas
                                  .override(
                                    fontFamily: 'Gotham-Regular',
                                    useGoogleFonts: false,
                                    color: AppTheme.of(context)
                                        .primaryBackground,
                                  ),
                                  onTap: () {
                                    provider.updateStatusButton(3);
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

                                if(provider.towerButton && provider.towerButtonCRY)
                                MarkerLayer(
                                  markers: provider.markersTowersCRY,
                                ),
                                if(provider.towerButton && provider.towerButtonODE)
                                MarkerLayer(
                                  markers: provider.markersTowersODE,
                                ),
                                if(provider.towerButton && provider.towerButtonSMI)
                                MarkerLayer(
                                  markers: provider.markersTowersSMI,
                                ),

                                if(provider.leadNotServiceableButton && provider.leadNotServiceableButtonE)
                                MarkerLayer(
                                  markers: provider.markersLeadsNotServiceableE,
                                ),
                                if(provider.leadNotServiceableButton && provider.leadNotServiceableButtonF)
                                MarkerLayer(
                                  markers: provider.markersLeadsNotServiceableF,
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
                              bottom: 20,
                              width: MediaQuery.of(context).size.width * 0.15,
                              child: PageView.builder(
                                controller: provider.pageController,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: 1,
                                itemBuilder: (context, _ ) {
                                  switch (provider.itemSelected) {
                                    case 1:
                                      if(provider.circuitButton) {
                                        final item = provider.circuitSelected;
                                        return Column(
                                          children: [
                                            MapCircuitDetails(
                                              mapMarker: item,
                                            ),
                                          ],
                                        );
                                      } else {
                                        return Container();
                                      }
                                    case 2:
                                      if(provider.towerButton) {
                                        final item = provider.towerSelected;
                                        return Column(
                                          children: [
                                            MapTowerDetails(
                                              mapMarker: item,
                                            ),
                                            const MapTowerOptions(),
                                          ],
                                        );
                                      } else {
                                        return Container();
                                      }
                                      case 3:
                                      if(provider.leadNotServiceableButton) {
                                        final item = provider.leadNotServiceableSelected;
                                        return Column(
                                          children: [
                                            LeadNotServiceableDetails(
                                              mapMarker: item,
                                            ),
                                            const MapLeadNotServiceableOptions(),
                                          ],
                                        );
                                      } else {
                                        return Container();
                                      }
                                      
                                    default:
                                      return Container();
                                  }
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