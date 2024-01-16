import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:rta_crm_cv/helpers/globals.dart';

import '../models/menu_dashboards.dart';

class MenuProvider extends ChangeNotifier {
  List<MenuDashboards> menuDashboards = [];
  MenuDashboards? menuDashboardSelected;
  bool isChecked = false;
  TextEditingController? menuController = TextEditingController();

  Future<void> getMenu({bool notify = true}) async {
    // Menu
    final res =
        await supabase.from('menu_dashboards').select().eq('category_fk', "1");

    // SubMenu
    final res2 =
        await supabase.from('menu_dashboards').select().eq('category_fk', "2");
    print(res);
    //print("Entro a getServices()");
    menuDashboards = (res as List<dynamic>)
        .map((service) => MenuDashboards.fromJson(jsonEncode(service)))
        .toList();
    if (notify) notifyListeners();
  }

  void selectMenu(String menuname) {
    menuDashboardSelected =
        menuDashboards.firstWhere((elem) => elem.menuName == menuname);
    notifyListeners();
  }

  Future<bool> createMenu() async {
    try {
      // Si esta en true es por que es submenu
      if (isChecked) {
        await supabase.from('menu_dashboards').insert({
          //         final String menuName;
          // final DateTime createdAt;
          // final int application;
          // final int menuFk;
          // final int categoryFk;
          // final bool submenu2;
          // final String? link;
          'menu_name': menuController?.text,
          'created_at': DateTime.now().toIso8601String(),
          'application': 3,
          'menu_fk': menuDashboardSelected?.id,
          'category_fk': 2,
          'submenu-2': false,
          'link': null,
        });
        notifyListeners();
      } else {
        // si falso entonces es un MENU
        await supabase.from('menu_dashboards').insert({
          'menu_name': menuController?.text,
          'created_at': DateTime.now().toIso8601String(),
          'application': 3,
          // 'menufk': menuDashboardSelected?.id,
          'category_fk': 1,
          'submenu-2': false,
          'link': null,
        });
        notifyListeners();
      }

      return true;
    } catch (e) {
      print("Error in createMenu() - $e");
      return false;
    }
  }

  void ClearControllers({bool notify = false}) {
    menuController?.clear();
    if (notify) notifyListeners();
  }
}
