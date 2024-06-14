import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
// import 'package:pluto_grid/pluto_grid.dart';

import 'package:rta_crm_cv/helpers/globals.dart';
import 'package:rta_crm_cv/models/dashboard_rta/circuits.dart';

class MapCircuitsProvider extends ChangeNotifier {

  // PlutoGridStateManager? stateManager;
  List<Marker> markers = [];
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

      for (Circuits circuit in listCircuits) {
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
              height: 40,
              width: 40,
              point: point, 
              builder: (_) {
                return GestureDetector(
                  onTap: () {
                    print("Selected: ${circuit.carrier}, ${circuit.apopstreet}, ${circuit.apopcity}");
                  },
                  child: Image.asset("assets/images/icon.png"),
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
