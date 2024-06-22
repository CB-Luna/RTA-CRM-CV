import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:rta_crm_cv/helpers/constants.dart';
// import 'package:pluto_grid/pluto_grid.dart';

import 'package:rta_crm_cv/helpers/globals.dart';
import 'package:rta_crm_cv/models/dashboard_rta/circuits.dart';
import 'package:rta_crm_cv/models/dashboard_rta/towers.dart';
import 'package:rta_crm_cv/theme/theme.dart';

class MapCircuitsProvider extends ChangeNotifier {
  // PlutoGridStateManager? stateManager;
  List<Marker> markersCircuits = [];
  List<Marker> markersTowers = [];
  Circuits? circuitSelected;
  TowerRta? towerSelected;
  int? indexCircuitSelected;
  int? indexTowerSelected;
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
  List<TowerRta> listTowers = [];

  // Controladores
  final searchController = TextEditingController();
  final pageController = PageController();

  bool circuitButton = true;
  bool towerButton = true;
  bool dataCenterButton = true;

  void updateStatusButton(int index) {
    switch (index) {
      case 0:
        circuitButton = !circuitButton;
        break;
      case 1:
        towerButton = !towerButton;
        break;
      case 2:
        dataCenterButton = !dataCenterButton;
        break;
      default:
    }
    notifyListeners();
  }



  Future<void> updateState() async {
    markersCircuits.clear();
    markersTowers.clear();
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
      //Circuits
      final queryCircuits = await supabase.rpc('search_circuits', params: {
        'busqueda': searchController.text,
      });
      print("getMapCircuits");

      final resCircuits = await queryCircuits;

      listCircuits = (resCircuits as List<dynamic>)
          .map((vehicles) => Circuits.fromJson(jsonEncode(vehicles)))
          .toList();

      for (var circuit in listCircuits) {
        //Se guarda el index actual de Markers
        final indexCircuit = markersCircuits.length;
        List<LatLng> subLineApop = [];
        List<LatLng> subLineBpop = [];
        if (circuit.gemap == "Yes") {
          var point = LatLng(
            double.parse(circuit.latitude!), 
            double.parse(circuit.longitude!)
          );
          subLineApop.add(point);
          markersCircuits.add(
            Marker(
              height: markerSizeExpaned,
              width: markerSizeExpaned,
              point: point, 
              builder: (_) {
                return GestureDetector(
                  onTap: () {
                    //Se salta hacia la información del marker que se presione
                    circuitSelected = circuit;
                    indexCircuitSelected = indexCircuit;
                    print("Circuit es: ${circuit.id}");
                    pageController.jumpToPage(indexCircuit);
                    print("Selected: ${circuit.carrier}, ${circuit.apopstreet}, ${circuit.apopcity}");
                    notifyListeners();
                  },
                  child: LocationMarkerCircuit(
                    selected: indexCircuitSelected == indexCircuit,
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

      //Towers

      final resTowers = await supabaseDashboard.from("rta_towers").select();

      listTowers = (resTowers as List<dynamic>)
          .map((tower) => TowerRta.fromJson(jsonEncode(tower)))
          .toList();

      for (TowerRta tower in listTowers) {
        //Se guarda el index actual de Markers
        final indexTower = markersTowers.length;
        if (tower.lat != null && tower.lat != '""' && tower.long != null && tower.long != '""') {
          var point = LatLng(
            double.parse(tower.long!), 
            double.parse(tower.lat!)
          );
          markersTowers.add(
            Marker(
              height: markerSizeExpaned,
              width: markerSizeExpaned,
              point: point, 
              builder: (_) {
                return GestureDetector(
                  onTap: () {
                    //Se salta hacia la información del marker que se presione
                    towerSelected = tower;
                    indexTowerSelected = indexTower;
                    print("Tower es: ${tower.id}");
                    pageController.jumpToPage(indexTower);
                    print("Selected: ${tower.make}, ${tower.model}, ${tower.frequency}");
                    notifyListeners();
                  },
                  child: LocationMarkerTower(
                    selected: indexTowerSelected == indexTower,
                    logo: "icon",
                  ),
                );
              }
            ),
          );
        }
      }
      print("Tamaño Lines Apop: ${linesApops.length}");
      print("Tamaño Lines Bpop: ${linesBpops.length}");
      print("Tamaño Markers Tower: ${markersTowers.length}");
      // if (stateManager != null) stateManager!.notifyListeners();
    } catch (e) {
      log('Error en getMapCircuits() - $e');
      print("Tamaño Lines Apop: ${linesApops.length}");
      print("Tamaño Lines Bpop: ${linesBpops.length}");
      print("Tamaño Markers Tower: ${markersTowers.length}");
    }
    notifyListeners();
  }

  // Limpiar los Controladores
  void clearAll() {
    searchController.clear();
    listCircuits.clear();
    markersCircuits.clear();
    markersTowers.clear();
    linesApops.clear();
    linesBpops.clear();
  }

}

class LocationMarkerCircuit extends StatelessWidget {
  const LocationMarkerCircuit({
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
        child: Image.network("$supabaseUrl/storage/v1/object/public/assets/circuits/$logo.png"),
      ),
    );
  }
}

class LocationMarkerTower extends StatelessWidget {
  const LocationMarkerTower({
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
        child: Icon(
          Icons.location_on_rounded,
          color: AppTheme.of(context).secondaryColor,
          size: 24,
        ),
      ),
    );
  }
}
