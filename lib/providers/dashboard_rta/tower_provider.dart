import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:rta_crm_cv/helpers/globals.dart';
import 'package:rta_crm_cv/models/dashboard_rta/towers.dart';

class TowerProvider extends ChangeNotifier {
  // Controladores Tower
  final nameController = TextEditingController();
  final opcoController = TextEditingController();
  final heightController = TextEditingController();
  final typeController = TextEditingController();
  final addressController = TextEditingController();
  final cityController = TextEditingController();
  final longController = TextEditingController();
  final latController = TextEditingController();
  final frequencyController = TextEditingController();
  // final cktTypeController = TextEditingController(); leased - owned
  final lessorController = TextEditingController();
  final licensedController = TextEditingController();
  final useController = TextEditingController();
  final makeController = TextEditingController();
  final modelController = TextEditingController();
  final numbCustomerServedController = TextEditingController();

  // Individual
  TowerRta? towerSelected;
  String companyName = "-";
  String leasedOwnerSelectedValue = "";

  //  Lists
  List<String> leasedType = ["leased", "Owned", "Barter -t", "Barter"];

  // --------- FUNCTIONS -------------

  // Función para actualizar el type
  void selectedLeasedType(String selected) {
    leasedOwnerSelectedValue = selected;
    notifyListeners();
  }

  // Nos trae la información del circuito seleccionado
  Future<void> getInformationTower(int id) async {
    try {
      final res =
          await supabaseDashboard.from('rta_towers').select().eq('id', id);
      List<TowerRta> towers = [];
      towers = (res as List<dynamic>)
          .map((tower) => TowerRta.fromJson(jsonEncode(tower)))
          .toList();

      towerSelected = towers.first;

      if (towerSelected?.companyId == 1) {
        companyName = "CRY";
      } else if (towerSelected?.companyId == 2) {
        companyName = "ODE";
      } else {
        companyName = "SMI";
      }
      nameController.text = towerSelected?.name ?? "-";
      opcoController.text = companyName;
      heightController.text = towerSelected?.height.toString() ?? "-";
      typeController.text = towerSelected?.type ?? "-";
      addressController.text = towerSelected?.address ?? "-";
      leasedOwnerSelectedValue = towerSelected?.leasedOwned ?? "-";
      cityController.text = towerSelected?.city ?? "-";
      longController.text = towerSelected?.long ?? "-";
      latController.text = towerSelected?.lat ?? "-";
      lessorController.text = towerSelected?.lessor ?? "-";
      licensedController.text = towerSelected?.licensed ?? "-";
      useController.text = towerSelected?.use ?? "-";
      makeController.text = towerSelected?.make ?? "-";
      modelController.text = towerSelected?.model ?? "-";
      numbCustomerServedController.text =
          towerSelected?.numbCustomerServed.toString() ?? "-";

      notifyListeners();
    } catch (e) {
      print('Error en getInformationTower() - $e');
    }
  }

  // Update Towers
  Future<bool> updateTowers() async {
    try {
      await supabaseDashboard.from('rta_towers').update({
        "name": nameController.text,
        "height": heightController.text,
        "type": typeController.text,
        "address": addressController.text,
        "city": cityController.text,
        "long": longController.text,
        "lat": latController.text,
        "leased_owned": leasedOwnerSelectedValue,
        "lessor": lessorController.text,
        "licensed": licensedController.text,
        "use": useController.text,
        "make": makeController.text,
        "model": modelController.text,
        "numb_customer_served": numbCustomerServedController.text,
        "company_id": opcoController.text,
        "frequency": frequencyController.text,
      }).eq("id", towerSelected!.id);
      return true;
    } catch (e) {
      print("Error in updateTowers - $e");
      return false;
    }
  }
}
