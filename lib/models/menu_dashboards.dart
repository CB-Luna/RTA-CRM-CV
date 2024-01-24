import 'dart:convert';

class MenuDashboards {
  final int id;
  final String menuName;
  final DateTime createdAt;
  final int application;
  final int? menuFk;
  final int categoryFk;
  final bool submenu2;
  final String? link;

  MenuDashboards({
    required this.id,
    required this.menuName,
    required this.createdAt,
    required this.application,
    this.menuFk,
    required this.categoryFk,
    required this.submenu2,
    this.link,
  });

  factory MenuDashboards.fromJson(String str) =>
      MenuDashboards.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory MenuDashboards.fromMap(Map<String, dynamic> json) => MenuDashboards(
        id: json["id"],
        menuName: json["menu_name"],
        createdAt: DateTime.parse(json["created_at"]),
        application: json["application"],
        menuFk: json["menu_fk"],
        categoryFk: json["category_fk"],
        submenu2: json["submenu-2"],
        link: json["link"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "menu_name": menuName,
        "created_at": createdAt.toIso8601String(),
        "application": application,
        "menu_fk": menuFk,
        "category_fk": categoryFk,
        "submenu-2": submenu2,
        "link": link,
      };
}
