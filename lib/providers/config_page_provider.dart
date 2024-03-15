import 'package:flutter/material.dart';
import 'package:rta_crm_cv/helpers/globals.dart';

class ConfigPageProvider extends ChangeNotifier {
  Map<String, TextEditingController> controllers = {};
  Map<String, TextEditingController> controllersRoute = {};

  TextEditingController controllerName = TextEditingController();
  TextEditingController controllerRoute = TextEditingController();
  // List<dynamic> listaMenu = [];
  List<dynamic> listaMenu = [];

  int? idMenufk;
  int? idCategoryfk;
  List<String> operationCategory = [];
  List<String> menuCategory = [];
  List<String> subMenuCategory = [];
  String? operationName;

  // Función para crear un menu
  Future<bool> createMenuPage(String valor) async {
    try {
      final res2 = await supabase.from('menu_dashboards').select("id").eq('menu_name', valor);

      for (var elemento in res2) {
        idMenufk = elemento["id"];
      }

      // Menu
      final resMenu = await supabase.from('menu_dashboards').select("menu_name, category_fk").eq('category_fk', 1);
      for (var elemento in resMenu) {
        menuCategory.add(elemento["menu_name"]);
      }
      if (menuCategory.contains(valor)) {
        for (var elemento in resMenu) {
          menuCategory.add(elemento["menu_name"]);
        }
        print("El valor $valor se encuentra en la lista menucategory");
        idCategoryfk = 3;
      } else {
        print("El valor $valor no se encuentra en la lista");
      }

      //Option
      final resOption = await supabase.from('menu_dashboards').select("menu_name, category_fk").eq('category_fk', 3);
      for (var elemento in resOption) {
        operationCategory.add(elemento["menu_name"]);
      }
      if (operationCategory.contains(valor)) {
        for (var elemento in resOption) {
          operationCategory.add(elemento["menu_name"]);
        }
        idCategoryfk = 2;
        print("El valor $valor se encuentra en la lista operationcategory");
      } else {
        print("El valor $valor no se encuentra en la lista");
      }

      //SubMenu
      final resSubMenu = await supabase.from('menu_dashboards').select("menu_name, category_fk").eq('category_fk', 2);
      for (var elemento in resSubMenu) {
        subMenuCategory.add(elemento["menu_name"]);
      }
      if (subMenuCategory.contains(valor)) {
        for (var elemento in resSubMenu) {
          subMenuCategory.add(elemento["menu_name"]);
        }
        print("El valor $valor se encuentra en la lista operationcategory");
        idCategoryfk = 3;
      } else {
        print("El valor $valor no se encuentra en la lista");
      }

      print(resMenu);
      print(subMenuCategory);
      // print(menuCategory);
      // print(operationCategory);
      // print(res3);
      // print(res2);
      // print("El valor IDMENUFK: $idMenufk");
      print("Desde el provider, el controllerName: ${controllerName.text} y controllerRoute: ${controllerRoute.text}");
      // print(res);

      await supabase.from('menu_dashboards').insert({
        'created_at': DateTime.now().toIso8601String(),
        'menu_name': controllerName.text,
        'application': 3,
        'link': controllerRoute.text,
        'menu_fk': idMenufk,
        'category_fk': idCategoryfk
      });
      notifyListeners();

      return true;
    } catch (e) {
      print("Error in createMenuPage() - $e");
      //print(actualVehicle!.idVehicle);
      return false;
    }
  }

  Future<bool> deleteMenuPage() async {
    try {
      await supabase.from('menu_dashboards').delete().eq('menu_name', controllerName.text);
      notifyListeners();
      print("Elimado con exito el valor ${controllerName.text}");
      return true;
    } catch (e) {
      print("Error in deleteMenuPage() - $e");
      //print(actualVehicle!.idVehicle);
      return false;
    }
  }
}
