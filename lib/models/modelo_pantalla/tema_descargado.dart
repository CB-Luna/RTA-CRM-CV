import 'dart:convert';

import 'package:rta_crm_cv/models/configuration.dart';


class TemaDescargado {
  TemaDescargado({
    required this.id,
    required this.nombre,
    required this.tema,
  });

  int id;
  String nombre;
  Configuration tema;

  factory TemaDescargado.fromJson(String str) =>
      TemaDescargado.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TemaDescargado.fromMap(Map<String, dynamic> json) => TemaDescargado(
      id: json['id_tema'],
      nombre: json['nombre_tema'],
      tema: Configuration.fromMap(json['configuracion']));

  Map<String, dynamic> toMap() => {
        "id_tema": id,
        'nombre_tema': nombre,
        'Configuracion': tema.toMap(),
      };
}