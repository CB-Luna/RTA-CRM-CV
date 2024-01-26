import 'dart:convert';

class MenuBuilder {
  int? menuId;
  String? menuName;
  String? link;
  List<Child>? child;

  MenuBuilder({
    this.menuId,
    this.menuName,
    this.link,
    this.child,
  });

  factory MenuBuilder.fromJson(String str) =>
      MenuBuilder.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory MenuBuilder.fromMap(Map<String, dynamic> json) => MenuBuilder(
        menuId: json["menu_id"],
        menuName: json["menu_name"],
        link: json["link"],
        child: json["menu_option"] == null
            ? []
            : List<Child>.from(
                json["menu_option"]!.map((x) => Child.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "menu_id": menuId,
        "menu_name": menuName,
        "link": link,
        "menu_option": child == null
            ? []
            : List<dynamic>.from(child!.map((x) => x.toMap())),
      };
}

class Child {
  int? id;
  int? menuFk;
  List<Child>? children;
  String? menuName;
  int? categoryFk;
  String? link;

  Child({
    this.id,
    this.menuFk,
    this.children,
    this.menuName,
    this.categoryFk,
    this.link,
  });

  factory Child.fromJson(String str) => Child.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Child.fromMap(Map<String, dynamic> json) => Child(
        id: json["id"],
        menuFk: json["menu_fk"],
        children: json["children"] == null
            ? []
            : List<Child>.from(json["children"]!.map((x) => Child.fromMap(x))),
        menuName: json["menu_name"],
        categoryFk: json["category_fk"],
        link: json["link"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "menu_fk": menuFk,
        "children": children == null
            ? []
            : List<dynamic>.from(children!.map((x) => x.toMap())),
        "menu_name": menuName,
        "category_fk": categoryFk,
        "link": link,
      };
}
