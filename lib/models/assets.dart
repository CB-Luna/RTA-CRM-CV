import 'dart:convert';

class Assets {
  Assets({
    required this.logoColor,
    required this.logoBlanco,
    required this.bg1,
    required this.bgLogin,
    required this.avatar,
    required this.background,
    required this.background2,
    required this.background3,
    required this.background4,
  });

  String logoColor;
  String logoBlanco;
  String bg1;
  String bgLogin;
  String avatar;
  String background;
  String background2;
  String background3;
  String background4;

  factory Assets.fromJson(String str) => Assets.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Assets.fromMap(Map<String, dynamic> json) {
    return Assets(
      logoColor: json['logoColor'],
      logoBlanco: json['logoBlanco'],
      bg1: json['bg1'],
      bgLogin: json['bgLogin'],
      avatar: json['avatar'],
      background: json['background'],
      background2: json['background2'],
      background3: json['background3'],
      background4: json['background4'],
    );
  }

  Map<String, dynamic> toMap() => {
        "logoColor": logoColor,
        "logoBlanco": logoBlanco,
        "bg1": bg1,
        "bgLogin": bgLogin,
        "avatar":avatar,
        "background":background,
        "background2":background2,
        "background3":background3,
        "background4":background4,
      };
}
