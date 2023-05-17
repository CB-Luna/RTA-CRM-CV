import 'dart:convert';

class Country {
  Country({
    required this.nombrePais,
    required this.idPaisPk,
    required this.clave,
  });

  String nombrePais;
  int idPaisPk;
  String clave;

  factory Country.fromJson(String str) => Country.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Country.fromMap(Map<String, dynamic> json) {
    return Country(
      nombrePais: json["nombre_pais"],
      idPaisPk: json["id_pais_pk"],
      clave: json["clave"],
    );
  }

  Map<String, dynamic> toMap() => {
        "nombre_pais": nombrePais,
        "id_pais_pk": idPaisPk,
        "clave": clave,
      };

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Country &&
        other.nombrePais == nombrePais &&
        other.idPaisPk == idPaisPk &&
        other.clave == clave;
  }

  @override
  int get hashCode => Object.hash(nombrePais, idPaisPk, clave);
}
