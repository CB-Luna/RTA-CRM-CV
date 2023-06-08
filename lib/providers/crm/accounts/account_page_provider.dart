import 'package:flutter/material.dart';

class AccountsPageProvider extends ChangeNotifier {
  List<bool> tabBar = [
    false, //Quotes
    false, //Oportunities
    true, //Leads
    false, //Campagins
    false, //Billing
  ];

  Future setIndex(int index) async {
    for (var i = 0; i < tabBar.length; i++) {
      tabBar[i] = false;
    }
    tabBar[index] = true;

    notifyListeners();
  }

  ////////////////////////////////////////////////////////
  //////////////////////////RIVE//////////////////////////
  ////////////////////////////////////////////////////////
}
