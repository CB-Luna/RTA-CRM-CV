import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:rta_crm_cv/helpers/globals.dart';
import '../models/user.dart';
import '../models/user_role.dart';

class DashboardRTA extends ChangeNotifier {
  List<dynamic> roleInstallers = [];
  List<dynamic> usersRoleInstaller = [];
  List<dynamic> usersRoleInstallerCompany = [];
  List<dynamic> usersCRY = [];
  List<dynamic> usersSMI = [];
  List<User> installers = [];
  List<UserRole> usersRoleInstallers = [];
  List<String> idsinstallers = [];

  UserRole? userRoleInstaller;
  UserRole? userSelected;

  void selectInstaller(String installer, {bool notify = true}) {
    userSelected =
        usersRoleInstallers.firstWhere((elem) => elem.email == installer);
    if (notify) notifyListeners();
  }

  Future<void> getInstallers({bool notify = true}) async {
    usersRoleInstallers = [];
    userRoleInstaller = null;
    idsinstallers = [];
    roleInstallers = [];
    usersCRY = [];
    usersSMI = [];
    try {
      final res =
          await supabase.from('role').select("").eq('name', "Installers 1");
      // print(res);
      // print("--------");
      roleInstallers = (res as List<dynamic>);
      // print(roleInstallers.first["role_id"]);

      final res2 = await supabase
          .from('user_role')
          .select("user_fk")
          .eq("role_fk", roleInstallers.first["role_id"]);
      // print(res2);
      usersRoleInstaller = (res2 as List<dynamic>);

      // Utiliza un bucle for para obtener los IDs
      for (var user in usersRoleInstaller) {
        final id = user["user_fk"];
        idsinstallers.add(id);
      }
      // Brooke Johnson
      if (currentUser!.isDashboardsSupervisor1) {
        for (int i = 0; i < idsinstallers.length; i++) {
          print("Para la posición $i del id: ${idsinstallers[i]}");
          final res4 = await supabase
              .from('user_company')
              .select("user_fk")
              .eq("user_fk", idsinstallers[i])
              .eq('company_fk', 1);
          usersRoleInstallerCompany = (res4 as List<dynamic>);

          print(res4);
          for (var user in usersRoleInstallerCompany) {
            final id = user["user_fk"];
            usersCRY.add(id);
          }
        }

        usersRoleInstallers = [];
        for (int i = 0; i < usersCRY.length; i++) {
          final res3 = await supabase
              .from("users")
              .select("email, name, last_name")
              .eq("id", usersCRY[i]);

          // print("----------");
          // print("res3: $res3");
          // print("Cuantas veces va: $i");
          userRoleInstaller = (res3 as List<dynamic>)
              .map((userrole) => UserRole.fromJson(jsonEncode(userrole)))
              .toList()
              .first;
          usersRoleInstallers.add(userRoleInstaller!);
          // print("El UserRole es: ${usersRoleInstallers[i].email}");
        }
        print(
            "El resultado de cuantos usuarios hay de cry es: ${usersCRY.length}");
      } else if (currentUser!.isDashboardsSupervisor2) {
        // Christine Hodges
        for (int i = 0; i < idsinstallers.length; i++) {
          // print("Para la posición $i del id: ${idsinstallers[i]}");
          final res4 = await supabase
              .from('user_company')
              .select("user_fk")
              .eq("user_fk", idsinstallers[i])
              .eq('company_fk', 3);
          usersRoleInstallerCompany = (res4 as List<dynamic>);

          for (var user in usersRoleInstallerCompany) {
            final id = user["user_fk"];
            print(id);
            usersSMI.add(id);
          }
        }

        usersRoleInstallers = [];
        for (int i = 0; i < usersSMI.length; i++) {
          final res3 = await supabase
              .from("users")
              .select("email, name, last_name")
              .eq("id", usersSMI[i]);

          // print("----------");
          // print("res3: $res3");
          // print("Cuantas veces va: $i");
          userRoleInstaller = (res3 as List<dynamic>)
              .map((userrole) => UserRole.fromJson(jsonEncode(userrole)))
              .toList()
              .first;
          usersRoleInstallers.add(userRoleInstaller!);
          // print("El UserRole es: ${usersRoleInstallers[i].email}");
        }
        print(
            "El resultado de cuantos usuarios hay de SMI es: ${usersSMI.length}");
      } else {
        usersRoleInstallers = [];
        for (int i = 0; i < idsinstallers.length; i++) {
          final res3 = await supabase
              .from("users")
              .select("email, name, last_name")
              .eq("id", idsinstallers[i]);

          userRoleInstaller = (res3 as List<dynamic>)
              .map((userrole) => UserRole.fromJson(jsonEncode(userrole)))
              .toList()
              .first;
          usersRoleInstallers.add(userRoleInstaller!);
          // print("El UserRole es: ${usersRoleInstallers[i].email}");
        }
        print(
            "El resultado de cuantos usuarios hay de En general  es: ${idsinstallers.length}");
      }

      if (notify) notifyListeners();
    } catch (e) {
      log('Error in getInstallers() -$e');
    }
  }
}
