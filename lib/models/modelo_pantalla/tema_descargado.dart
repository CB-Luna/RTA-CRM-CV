import 'dart:convert';

import 'package:rta_crm_cv/models/configuration.dart';


class TemaDescargado {
  TemaDescargado({
    required this.idTema,
    required this.nombreTema,
    required this.configuracion,
  });

  int idTema;
  String nombreTema;
  Configuration configuracion;

  factory TemaDescargado.fromJson(String str) =>
      TemaDescargado.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TemaDescargado.fromMap(Map<String, dynamic> json) => TemaDescargado(
      idTema: json['id_tema'],
      nombreTema: json['nombre_tema'],
      configuracion: Configuration.fromMap(json['configuracion']));

  Map<String, dynamic> toMap() => {
        "id_tema": idTema,
        'nombre_tema': nombreTema,
        'Configuracion': configuracion.toMap(),
      };
}