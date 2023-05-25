import 'dart:convert';

class CompanyApi {
  CompanyApi({
    required this.company,
    required this.companyId,
  });

  int companyId;
  String company;

  factory CompanyApi.fromJson(String str) =>
      CompanyApi.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CompanyApi.fromMap(Map<String, dynamic> json) => CompanyApi(
        company: json["company"],
        companyId: json["id_company"],
      );

  Map<String, dynamic> toMap() => {
        "company": company,
        "id_company": companyId,
      };
}
