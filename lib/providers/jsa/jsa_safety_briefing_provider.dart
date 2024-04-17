import 'package:flutter/material.dart';

class JsaSafetyProvider extends ChangeNotifier {
  TextEditingController titleController = TextEditingController();
  TextEditingController UserController =
      TextEditingController(); // Preguntar si el usuario lo crea
  // TextEditingController titleController = TextEditingController(); Preguntar por los usuarios
  TextEditingController dateController = TextEditingController();
  TextEditingController issueController = TextEditingController();
  TextEditingController backgroundController = TextEditingController();
  TextEditingController analisisController = TextEditingController();
  TextEditingController recomendationsController = TextEditingController();
}
