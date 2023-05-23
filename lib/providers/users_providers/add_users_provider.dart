// import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:rta_crm_cv/public/colors.dart';

class AddUsersProvider extends ChangeNotifier {
  AddUsersProvider() {
    clearAll();
  }

  clearAll() {
    nameController.clear();
    lastNameController.clear();
    emailController.clear();
    phoneController.clear();
    roleSelecValue = roles.first;
    stateSelecValue = states.first;
  }

  void selecRole(String selected) {
    roleSelecValue = selected;
    notifyListeners();
  }

  void selecState(String selected) {
    stateSelecValue = selected;
    notifyListeners();
  }

  /*List<DDownSelected> roles = [
    DDownSelected('Admin', false),
    DDownSelected('Sales', false),
    DDownSelected('Financy', false),
    DDownSelected('Operative', false),
    DDownSelected('Sen Exec', false),
  ];
  late String roleSelecValue;
  List<DDownSelected> states = [
    DDownSelected('Texas', false),
    DDownSelected('Louisiana', false),
    DDownSelected('Oklahoma', false),
    DDownSelected('New Mexico', false),
  ];
  late String stateSelecValue;*/

  List<String> roles = [
    'Admin',
    'Sales',
    'Financy',
    'Operative',
    ' Sales',
    'Sen Exec',
  ];
  late String roleSelecValue;
  List<String> states = [
    'Texas',
    'Louisiana',
    'Oklahoma',
    'New Mexico',
  ];
  late String stateSelecValue;

  final nameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final coutryController = TextEditingController();
  final roleController = TextEditingController();
}
