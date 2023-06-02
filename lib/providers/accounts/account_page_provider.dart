import 'package:flutter/material.dart';

class AccountsPageProvider extends ChangeNotifier {
  List<bool> tabBar = [
    true,
    false,
    false,
    false,
    false,
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
