import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:rta_crm_cv/helpers/constants.dart';
// import 'package:pluto_grid/pluto_grid.dart';

import 'package:rta_crm_cv/helpers/globals.dart';
import 'package:rta_crm_cv/models/dashboard_rta/circuits.dart';
import 'package:rta_crm_cv/models/dashboard_rta/leads_not_serviceable.dart';
import 'package:rta_crm_cv/models/dashboard_rta/towers.dart';
import 'package:rta_crm_cv/theme/theme.dart';

class MapCircuitsProvider extends ChangeNotifier {
  // PlutoGridStateManager? stateManager;
  List<Marker> markersCircuits = [];
  List<Marker> markersTowersSMI = [];
  List<Marker> markersTowersCRY = [];
  List<Marker> markersTowersODE = [];
  List<Marker> markersLeadsNotServiceableE = [];
  List<Marker> markersLeadsNotServiceableF = [];
  Circuits? circuitSelected;
  TowerRta? towerSelected;
  LeadsNotServiceable? leadNotServiceableSelected;
  int? indexCircuitSelected;
  int? indexTowerSelected;
  int? indexLeadNotServiceableSelected;
  int? itemSelected;
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
  List<LeadsNotServiceable> listLeadsNotServiceable= [];

  // Controladores
  final searchController = TextEditingController();
  final pageController = PageController();

  bool circuitButton = true;
  bool towerButton = true;
  bool towerButtonCRY = true;
  bool towerButtonODE = true;
  bool towerButtonSMI = true;
  bool dataCenterButton = true;
  bool leadNotServiceableButton = true;
  bool leadNotServiceableButtonE = true;
  bool leadNotServiceableButtonF = true;

  void updateStatusButton(int index) {
    switch (index) {
      case 0:
        circuitButton = !circuitButton;
        break;
      case 1:
        if(!towerButton) {
          towerButtonCRY = true;
          towerButtonODE = true;
          towerButtonSMI = true;
        }
        towerButton = !towerButton;
        break;
      case 2:
        dataCenterButton = !dataCenterButton;
        break;
      case 3:
      if(!leadNotServiceableButton) {
          leadNotServiceableButtonE = true;
          leadNotServiceableButtonF = true;
        }
        leadNotServiceableButton = !leadNotServiceableButton;
        break;
      default:
    }
    notifyListeners();
  }

  void updateStatusTowerButton(int index) {
    switch (index) {
      case 0:
        towerButtonCRY = !towerButtonCRY;
        break;
      case 1:
        towerButtonODE = !towerButtonODE;
        break;
      case 2:
        towerButtonSMI = !towerButtonSMI;
        break;
      default:
    }
    notifyListeners();
  }

  void updateStatusLeadNotServiceableButton(int index) {
    switch (index) {
      case 0:
        leadNotServiceableButtonE = !leadNotServiceableButtonE;
        break;
      case 1:
        leadNotServiceableButtonF = !leadNotServiceableButtonF;
        break;
      default:
    }
    notifyListeners();
  }



  Future<void> updateState() async {
    markersCircuits.clear();
    markersTowersSMI.clear();
    markersTowersCRY.clear();
    markersTowersODE.clear();
    linesApops.clear();
    linesBpops.clear();

    await getMapCircuits();
  }

  // Traer los circuitos
  Future<void> getMapCircuits() async {
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
                return MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () {
                      //Se salta hacia la información del marker que se presione
                      itemSelected = 1;
                      towerSelected = null;
                      indexTowerSelected = null;
                      leadNotServiceableSelected = null;
                      indexLeadNotServiceableSelected = null;
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
        final indexTower = markersTowersCRY.length + markersTowersSMI.length + markersTowersODE.length;
        if (tower.lat != null && tower.lat != '""' && tower.long != null && tower.long != '""') {
          var point = LatLng(
            double.parse(tower.long!), 
            double.parse(tower.lat!)
          );
          switch (tower.companyId) {
            case 1:
              markersTowersCRY.add(
                Marker(
                  height: markerSizeExpaned,
                  width: markerSizeExpaned,
                  point: point, 
                  builder: (_) {
                    return MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: () {
                          //Se salta hacia la información del marker que se presione
                          itemSelected = 2;
                          circuitSelected = null;
                          indexCircuitSelected = null;
                          leadNotServiceableSelected = null;
                          indexLeadNotServiceableSelected = null;
                          towerSelected = tower;
                          indexTowerSelected = indexTower;
                          pageController.jumpToPage(indexTower);
                          notifyListeners();
                        },
                        child: LocationMarkerTower(
                          selected: indexTowerSelected == indexTower,
                          company: tower.companyId,
                        ),
                      ),
                    );
                  }
                ),
              );
              break;
            case 2:
            markersTowersODE.add(
                Marker(
                  height: markerSizeExpaned,
                  width: markerSizeExpaned,
                  point: point, 
                  builder: (_) {
                    return MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: () {
                          //Se salta hacia la información del marker que se presione
                          itemSelected = 2;
                          circuitSelected = null;
                          indexCircuitSelected = null;
                          leadNotServiceableSelected = null;
                          indexLeadNotServiceableSelected = null;
                          towerSelected = tower;
                          indexTowerSelected = indexTower;
                          pageController.jumpToPage(indexTower);
                          notifyListeners();
                        },
                        child: LocationMarkerTower(
                          selected: indexTowerSelected == indexTower,
                          company: tower.companyId,
                        ),
                      ),
                    );
                  }
                ),
              );
              break;
            case 3:
              markersTowersSMI.add(
                Marker(
                  height: markerSizeExpaned,
                  width: markerSizeExpaned,
                  point: point, 
                  builder: (_) {
                    return MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: () {
                          //Se salta hacia la información del marker que se presione
                          itemSelected = 2;
                          circuitSelected = null;
                          indexCircuitSelected = null;
                          leadNotServiceableSelected = null;
                          indexLeadNotServiceableSelected = null;
                          towerSelected = tower;
                          indexTowerSelected = indexTower;
                          pageController.jumpToPage(indexTower);
                          notifyListeners();
                        },
                        child: LocationMarkerTower(
                          selected: indexTowerSelected == indexTower,
                          company: tower.companyId,
                        ),
                      ),
                    );
                  }
                ),
              );
              break;
            default:
              break;
          }
        }
      }

      //Leads Not Serviceable

      final resLeadsNotServiceable = await supabaseDashboard.from("leads_not_serviceable").select();

      listLeadsNotServiceable = (resLeadsNotServiceable as List<dynamic>)
          .map((leadNotServiceable) => LeadsNotServiceable.fromJson(jsonEncode(leadNotServiceable)))
          .toList();

      for (LeadsNotServiceable leadNotServiceable in listLeadsNotServiceable) {
        //Se guarda el index actual de Markers
        final indexLeadNotServiceable = markersLeadsNotServiceableE.length + markersLeadsNotServiceableF.length;
        var point = LatLng(
          double.parse(leadNotServiceable.latitude), 
          double.parse(leadNotServiceable.longitude)
        );
        switch (leadNotServiceable.sourceFk) {
          case 1:
            markersLeadsNotServiceableE.add(
              Marker(
                height: markerSizeExpaned,
                width: markerSizeExpaned,
                point: point, 
                builder: (_) {
                  return MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: () {
                        //Se salta hacia la información del marker que se presione
                        itemSelected = 3;
                        circuitSelected = null;
                        indexCircuitSelected = null;
                        towerSelected = null;
                        indexTowerSelected = null;
                        leadNotServiceableSelected = leadNotServiceable;
                        indexLeadNotServiceableSelected = indexLeadNotServiceable;
                        pageController.jumpToPage(indexLeadNotServiceable);
                        notifyListeners();
                      },
                      child: LocationLeadNotServiceable(
                        selected: indexLeadNotServiceableSelected == indexLeadNotServiceable,
                        source: leadNotServiceable.sourceFk,
                      ),
                    ),
                  );
                }
              ),
            );
            break;
          case 2:
            markersLeadsNotServiceableF.add(
              Marker(
                height: markerSizeExpaned,
                width: markerSizeExpaned,
                point: point, 
                builder: (_) {
                  return MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: () {
                        //Se salta hacia la información del marker que se presione
                        itemSelected = 3;
                        circuitSelected = null;
                        indexCircuitSelected = null;
                        towerSelected = null;
                        indexTowerSelected = null;
                        leadNotServiceableSelected = leadNotServiceable;
                        indexLeadNotServiceableSelected = indexLeadNotServiceable;
                        pageController.jumpToPage(indexLeadNotServiceable);
                        notifyListeners();
                      },
                      child: LocationLeadNotServiceable(
                        selected: indexLeadNotServiceableSelected == indexLeadNotServiceable,
                        source: leadNotServiceable.sourceFk,
                      ),
                    ),
                  );
                }
              ),
            );
            break;
          default:
        }
      }
      
      // if (stateManager != null) stateManager!.notifyListeners();
    } catch (e) {
      log('Error en getMapCircuits() - $e');
    }
    notifyListeners();
  }

  // Limpiar los Controladores
  void clearAll() {
    searchController.clear();
    listCircuits.clear();
    listTowers.clear();
    listLeadsNotServiceable.clear();
    markersCircuits.clear();
    markersTowersCRY.clear();
    markersTowersODE.clear();
    markersTowersSMI.clear();
    markersLeadsNotServiceableE.clear();
    markersLeadsNotServiceableF.clear();
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
    required this.company, 
  });

  final bool selected;
  final int? company;

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
          color: company == 1 ? AppTheme.of(context).cryPrimary :
          company == 2 ? AppTheme.of(context).odePrimary :
          company == 3 ? AppTheme.of(context).smiPrimary :
          AppTheme.of(context).primaryColor,
          size: size * 0.8,
        ),
      ),
    );
  }
}


class LocationLeadNotServiceable extends StatelessWidget {
  const LocationLeadNotServiceable({
    super.key,
    this.selected = false,
    required this.source, 
  });

  final bool selected;
  final int? source;

  @override
  Widget build(BuildContext context) {
    final size = selected ? markerSizeExpaned : markerSizeShrinked;
    return Center(
      child: AnimatedContainer(
        height: size,
        width: size,
        duration: const Duration(milliseconds: 400),
        child: Icon(
          Icons.person_rounded,
          color: source == 1 ? AppTheme.of(context).tertiaryColor :
          AppTheme.of(context).primaryColor,
          size: size * 0.8,
        ),
      ),
    );
  }
}
