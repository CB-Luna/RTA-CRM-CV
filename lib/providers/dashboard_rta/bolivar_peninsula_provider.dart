import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:rta_crm_cv/helpers/globals.dart';

import '../../models/dashboard_rta/ftth.dart';
import '../../models/dashboard_rta/home_and_lots.dart';

class BolivarPeninsulaProvider extends ChangeNotifier {
  // Variables
  List<HomeAndLots>? listHomesAndLots;
  List<Ftth>? listFTTH;

  HomeAndLots? homeandLots;
  Ftth? ftth;

  // Funciones

  Future<void> updateState() async {
    await getHomesAndLots();
  }

  Future<void> getHomesAndLots({bool notify = true}) async {
    try {
      final res = await supabaseDashboard.from("homes_and_lots").select();
      listHomesAndLots = (res as List<dynamic>)
          .map((homes) => HomeAndLots.fromJson(jsonEncode(homes)))
          .toList();
      homeandLots = listHomesAndLots!.first;

      // FTTH
      final resFTTH = await supabaseDashboard.from("ftth").select();
      listFTTH = (resFTTH as List<dynamic>)
          .map((homes) => Ftth.fromJson(jsonEncode(homes)))
          .toList();
      ftth = listFTTH!.first;
      if (notify) notifyListeners();
      print(res);
    } catch (e) {
      //print("Error in GetVehicle() $e");
    }
  }
}
