// import 'dart:developer';

import 'package:flutter/material.dart';

class AddUsersProvider extends ChangeNotifier {
  AddUsersProvider() {
    clearAll();
  }

  clearAll() {
    nameController.clear();
    lastNameController.clear();
    emailController.clear();
  }

  final nameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final coutryController = TextEditingController();
  final roleController = TextEditingController();
}
