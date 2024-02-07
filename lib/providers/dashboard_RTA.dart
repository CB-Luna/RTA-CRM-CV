import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:rta_crm_cv/helpers/globals.dart';
import '../models/user.dart';
import '../models/user_role.dart';

class DashboardRTA extends ChangeNotifier {
  List<dynamic> roleInstallers = [];
  List<dynamic> usersRoleInstaller = [];
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

      usersRoleInstallers = [];
      for (int i = 0; i < idsinstallers.length; i++) {
        final res3 = await supabase
            .from("users")
            .select("email, name, last_name")
            .eq("id", idsinstallers[i]);

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
      // if (currentUser!.isDashboardsSupervisor1) {
      //   for (int i = 0; i < idsinstallers.length; i++) {
      //     final res3 = await supabase
      //         .from("users")
      //         .select("email, name, last_name")
      //         .eq("id", idsinstallers[i])
      //         .eq('company', value);

      //     // print("----------");
      //     // print("res3: $res3");
      //     // print("Cuantas veces va: $i");
      //     userRoleInstaller = (res3 as List<dynamic>)
      //         .map((userrole) => UserRole.fromJson(jsonEncode(userrole)))
      //         .toList()
      //         .first;
      //     usersRoleInstallers.add(userRoleInstaller!);
      //     // print("El UserRole es: ${usersRoleInstallers[i].email}");
      //   }
      // } else if (currentUser!.isDashboardsSupervisor2) {
      //   for (int i = 0; i < idsinstallers.length; i++) {
      //     final res3 = await supabase
      //         .from("users")
      //         .select("email, name, last_name")
      //         .eq("id", idsinstallers[i]);

      //     // print("----------");
      //     // print("res3: $res3");
      //     // print("Cuantas veces va: $i");
      //     userRoleInstaller = (res3 as List<dynamic>)
      //         .map((userrole) => UserRole.fromJson(jsonEncode(userrole)))
      //         .toList()
      //         .first;
      //     usersRoleInstallers.add(userRoleInstaller!);
      //     // print("El UserRole es: ${usersRoleInstallers[i].email}");
      //   }
      // } else {
      //   for (int i = 0; i < idsinstallers.length; i++) {
      //     final res3 = await supabase
      //         .from("users")
      //         .select("email, name, last_name")
      //         .eq("id", idsinstallers[i]);

      //     // print("----------");
      //     // print("res3: $res3");
      //     // print("Cuantas veces va: $i");
      //     userRoleInstaller = (res3 as List<dynamic>)
      //         .map((userrole) => UserRole.fromJson(jsonEncode(userrole)))
      //         .toList()
      //         .first;
      //     usersRoleInstallers.add(userRoleInstaller!);
      //     // print("El UserRole es: ${usersRoleInstallers[i].email}");
      //   }
      // }
      // print("Length ids ${idsinstallers.length}");
      // print("Length userRoleInstallers ${usersRoleInstallers.length}");
      if (notify) notifyListeners();
    } catch (e) {
      log('Error in getInstallers() -$e');
    }
  }
}
