import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:rta_crm_cv/helpers/constants.dart';
// import 'package:pluto_grid/pluto_grid.dart';

import 'package:rta_crm_cv/helpers/globals.dart';
import 'package:rta_crm_cv/models/dashboard_rta/circuits.dart';

class MapCircuitsProvider extends ChangeNotifier {
  // PlutoGridStateManager? stateManager;
  List<Marker> markers = [];
  Circuits? circuitSelected;
  int? indexSelected;
  List<List<LatLng>> linesApops = [];
  List<List<LatLng>> linesBpops = [];

  var points = const [
    LatLng(35.22, -101.83),
    LatLng(35.77, -96.79),
    LatLng(29.76, -95.36)
  ];

  void addPoint(LatLng point) {
      points.add(point);
      // print(points);
      notifyListeners();
  }

  // Listas
  List<Circuits> listCircuits = [];

  // Controladores
  final searchController = TextEditingController();
  final pageController = PageController();


  Future<void> updateState() async {
    markers.clear();
    linesApops.clear();
    linesBpops.clear();

    await getMapCircuits();
  }

  // Traer los circuitos
  Future<void> getMapCircuits() async {
    // if (stateManager != null) {
    //   stateManager!.setShowLoading(true);
    //   notifyListeners();
    // }
    try {

      final query = await supabase.rpc('search_circuits', params: {
        'busqueda': searchController.text,
      });
      print("getMapCircuits");

      final res = await query;

      listCircuits = (res as List<dynamic>)
          .map((vehicles) => Circuits.fromJson(jsonEncode(vehicles)))
          .toList();

      for (var circuit in listCircuits) {
        //Se guarda el index actual de Markers
        final index = markers.length;
        List<LatLng> subLineApop = [];
        List<LatLng> subLineBpop = [];
        if (circuit.gemap == "Yes") {
          var point = LatLng(
            double.parse(circuit.latitude!), 
            double.parse(circuit.longitude!)
          );
          subLineApop.add(point);
          markers.add(
            Marker(
              height: markerSizeExpaned,
              width: markerSizeExpaned,
              point: point, 
              builder: (_) {
                return GestureDetector(
                  onTap: () {
                    //Se salta hacia la información del marker que se presione
                    circuitSelected = circuit;
                    indexSelected = index;
                    print("Circuit es: ${circuit.id}");
                    pageController.jumpToPage(index);
                    print("Selected: ${circuit.carrier}, ${circuit.apopstreet}, ${circuit.apopcity}");
                    notifyListeners();
                  },
                  child: LocationMarker(
                    selected: indexSelected == index,
                    logo: circuit.carrier?.toLowerCase(),
                  ),
                );
              }
            ),
          );
          if (circuit.apoplat != null && circuit.apoplat != '""' 
          && circuit.apoplong != null && circuit.apoplong != '""') {
            var pointApop = LatLng(
              double.parse(circuit.apoplat!), 
              double.parse(circuit.apoplong!)
            );
            subLineApop.add(pointApop);
            subLineBpop.add(pointApop);
            linesApops.add(subLineApop);
          }
          if (circuit.bpoplat != null && circuit.bpoplat != '""' 
          && circuit.bpoplong != null && circuit.bpoplong != '""') {
            var pointBpop = LatLng(
              double.parse(circuit.bpoplat!), 
              double.parse(circuit.bpoplong!)
            );
            subLineBpop.add(pointBpop);
            linesBpops.add(subLineBpop);
          }
        }
      }
      print("Tamaño Lines Apop: ${linesApops.length}");
      print("Tamaño Lines Bpop: ${linesBpops.length}");
      // if (stateManager != null) stateManager!.notifyListeners();
    } catch (e) {
      log('Error en getMapCircuits() - $e');
      print("Tamaño Lines Apop: ${linesApops.length}");
      print("Tamaño Lines Bpop: ${linesBpops.length}");
    }
    notifyListeners();
  }

  // Limpiar los Controladores
  void clearAll() {
    searchController.clear();
    listCircuits.clear();
    markers.clear();
    linesApops.clear();
    linesBpops.clear();
  }

}

class LocationMarker extends StatelessWidget {
  const LocationMarker({
    super.key,
    this.selected = false, 
    this.logo = "icon",
  });

  final bool selected;
  final String? logo;

  @override
  Widget build(BuildContext context) {
    final size = selected ? markerSizeExpaned : markerSizeShrinked;
    return Center(
      child: AnimatedContainer(
        height: size,
        width: size,
        duration: const Duration(milliseconds: 400),
        child: Image.asset("assets/images/$logo.png"),
      ),
    );
  }
}
