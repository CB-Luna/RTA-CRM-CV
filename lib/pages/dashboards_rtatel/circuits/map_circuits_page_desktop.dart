import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:rta_crm_cv/helpers/constants.dart';
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
                          ],
                        ),
                      ),
                      SizedBox(
                        height:
                            MediaQuery.of(context).size.height * 0.8,
                        width: MediaQuery.of(context).size.width - 30,
                        child: FlutterMap(
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

                            MarkerLayer(
                              markers: provider.markers,
                            ),

                            //Lines Apops
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

                            //Lines Bpops
                            PolylineLayer(
                              polylines: provider.linesBpops.map((line) {
                                return Polyline(
                                  points: line,
                                  strokeWidth: 4.0,
                                  color: AppTheme.of(context).secondaryColor,
                                );
                              }).toList(),
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