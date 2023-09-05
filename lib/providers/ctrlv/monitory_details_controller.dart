import 'package:flutter/material.dart';

class DetailsMonitoryController extends ChangeNotifier {
  //OPCIONES MENU:
  final menuTapedReceived = {
    // 0: const MeasuresSectionR(),// Measures 0
    // 1: const LightsSectionR(), // Lights 1
    // 2: const FluidsSectionR(), // Fluids 2
    // 3: const SecuritySectionR(), // Security 3
    // 4: const EquipmentSectionR(), // Equipment 4
  };

  final menuTapedDelivered = {
    // 0: const MeasuresSectionD(),// Measures 0
    // 1: const LightsSectionD(), // Lights 1
    // 2: const FluidsSectionD(), // Fluids 2
    // 3: const SecuritySectionD(), // Security 3
    // 4: const EquipmentSectionD(), // Equipment 4
  };

  int isTapedReceived = 0;

  int isTapedDelivered = 0;
  
  void setTapedOptionReceived(int index) {
    isTapedReceived = index;
    notifyListeners();
  }
  void setTapedOptionDelivered(int index) {
    isTapedDelivered = index;
    notifyListeners();
  }

}
