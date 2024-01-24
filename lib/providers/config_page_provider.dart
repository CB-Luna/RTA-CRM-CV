import 'package:flutter/material.dart';
import 'package:rta_crm_cv/helpers/globals.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ConfigPageProvider extends ChangeNotifier {
  Map<String, TextEditingController> controllers = {};
  Map<String, TextEditingController> controllersRoute = {};

  TextEditingController controllerName = TextEditingController();

  TextEditingController controllerRoute = TextEditingController();
  // List<dynamic> listaMenu = [];
  List<dynamic> listaMenu = [];

  // Función para crear un menu
  Future<bool> createMenuPage(String valor) async {
    try {
      // final res = await supabase
      //     .from('menu_dashboards')
      //     .select("menu_name, id")
      //     .is_('menu_fk', null);

      // final res2 = await supabase
      //     .from('menu_dashboards')
      //     .select("id")
      //     .contains('menu_fk', valor);
      // // listaMenu.add(res);
      // // print(listaMenu);
      // print(res2);
      // // print(res);

      await supabase.from('menu_dashboards').insert({
        'created_at': DateTime.now().toIso8601String(),
        'menu_name': controllerName.text,
        'application': 3,
        'link': controllerRoute.text,
      });
      notifyListeners();

      return true;
    } catch (e) {
      print("Error in createMenuPage() - $e");
      //print(actualVehicle!.idVehicle);
      return false;
    }
  }
}
