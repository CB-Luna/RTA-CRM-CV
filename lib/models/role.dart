import 'dart:convert';

class Role {
  Role({
    required this.id,
    required this.roleName,
    required this.permissions,
  });

  int id;
  String roleName;
  Permissions permissions;

  factory Role.fromJson(String str) => Role.fromMap(json.decode(str));

  factory Role.fromMap(Map<String, dynamic> json) => Role(
        id: json["id"],
        roleName: json["name"],
        permissions: Permissions.fromMap(json["permissions"]),
      );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Role && other.roleName == roleName && other.id == id;
  }

  @override
  int get hashCode => Object.hash(roleName, id, permissions);
}

class Permissions {
  Permissions({
    required this.home,
    required this.homeProveedor,
    required this.extraccionDeFacturas,
    required this.seguimientoDeFacturas,
    required this.pagos,
    required this.seguimientoProveedor,
    required this.seguimientoNC,
    required this.solicitudDppCBC,
    required this.solicitudDppProveedor,
    required this.cargaNc,
    required this.validacionNC,
    required this.notificaciones,
    required this.administracionDeProveedores,
    required this.administracionDeUsuarios,
    required this.reportes,
    required this.perfilDeUsuario,
  });

  String? home;
  String? homeProveedor;
  String? extraccionDeFacturas;
  String? seguimientoDeFacturas;
  String? pagos;
  String? seguimientoProveedor;
  String? seguimientoNC;
  String? solicitudDppCBC;
  String? solicitudDppProveedor;
  String? cargaNc;
  String? validacionNC;
  String? notificaciones;
  String? administracionDeProveedores;
  String? administracionDeUsuarios;
  String? reportes;
  String? perfilDeUsuario;

  factory Permissions.fromJson(String str) =>
      Permissions.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Permissions.fromMap(Map<String, dynamic> json) => Permissions(
        home: json['Home'],
        homeProveedor: json['HomeProveedor'],
        extraccionDeFacturas: json["Extraccion de Facturas"],
        seguimientoDeFacturas: json["Seguimiento de Facturas"],
        pagos: json["Pagos"],
        seguimientoProveedor: json["Seguimiento Proveedor"],
        seguimientoNC: json["Seguimiento NC"],
        solicitudDppCBC: json['SolicitudDPPCBC'],
        solicitudDppProveedor: json['SolicitudDPPProveedor'],
        cargaNc: json['CargaNC'],
        validacionNC: json["Validacion NC"],
        notificaciones: json["Notificaciones"],
        administracionDeProveedores: json["Administracion de Proveedores"],
        administracionDeUsuarios: json["Administracion de Usuarios"],
        reportes: json["Reportes"],
        perfilDeUsuario: json["Perfil de Usuario"],
      );

  Map<String, dynamic> toMap() => {
        "Home": home,
        "Extraccion de Facturas": extraccionDeFacturas,
        "Seguimiento de Facturas": seguimientoDeFacturas,
        "Pagos": pagos,
        "Seguimiento Proveedor": seguimientoProveedor,
        "Seguimiento NC": seguimientoNC,
        "Validacion NC": validacionNC,
        "Notificaciones": notificaciones,
        "Administracion de Proveedores": administracionDeProveedores,
        "Administracion de Usuarios": administracionDeUsuarios,
        "Reportes": reportes,
        "Perfil de Usuario": perfilDeUsuario,
      };
}
