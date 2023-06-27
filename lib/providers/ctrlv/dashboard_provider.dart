import 'dart:convert';

import 'package:flutter/material.dart';

import '../../helpers/globals.dart';
import '../../models/issues.dart';
import '../../models/vehicle_dashboard.dart';

class DashboardCVProvider extends ChangeNotifier {
  int issuesCry = 0;
  int issuesSmi = 0;
  int issuesOde = 0;

  //variable para las secciones del detail popup
  Issues? issue;

  DashboardCVProvider() {
    updateState();
  }
  Future<void> updateState() async {
    await getIssues();
  }

  clearAll() {}

  Future<bool> getIssues() async {
    // Limpiar listas
    issue = null;

    issuesCry = 0;
    issuesSmi = 0;
    issuesOde = 0;

    print("estoy en getIssues");
    try {
      final res = await supabaseCtrlV.from('issues_view').select();
      if (res != null) {
        final listData = res as List<dynamic>;

        for (var i = 0; i < listData.length; i++) {
          issue = Issues.fromJson(jsonEncode(listData[i]));
          final resp = await supabaseCtrlV
              .from('vehicle')
              .select()
              .eq('id_vehicle', issue!.idVehicle);
          //print("resp ${resp.toString()}");
          //print(jsonEncode(resp.toString()));
          if (resp != null) {
            final listVehicle = resp as List<dynamic>;
           // print(listVehicle[0].toString());
            final vehicle = VehicleDash.fromJson(jsonEncode(listVehicle[0]));
            if (vehicle.company == 3) {
              if (issue!.issuesD != null) {
                issuesSmi = issuesSmi + issue!.issuesR + issue!.issuesD!;
              }
              issuesSmi = issuesSmi + issue!.issuesR;
            }
            if (vehicle.company == 2) {
              if (issue!.issuesD != null) {
                issuesOde = issuesOde + issue!.issuesR + issue!.issuesD!;
              }
              issuesOde = issuesOde + issue!.issuesR;
            }
            if (vehicle.company == 1) {
              if (issue!.issuesD != null) {
                issuesCry = issuesCry + issue!.issuesR + issue!.issuesD!;
              }
              issuesCry = issuesCry + issue!.issuesR;
            }
          }
        }
        notifyListeners();
        return true;
      } else {
        notifyListeners();
        return false;
      }
    } catch (e) {
      print("error ${e}");
      return false;
    }
  }
}
