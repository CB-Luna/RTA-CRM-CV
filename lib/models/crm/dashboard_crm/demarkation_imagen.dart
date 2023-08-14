import 'dart:convert';

class DemarcationImage {
    final String demarcationUrl;

    DemarcationImage({
        required this.demarcationUrl,
    });

    factory DemarcationImage.fromJson(String str) => DemarcationImage.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory DemarcationImage.fromMap(Map<String, dynamic> json) => DemarcationImage(
        demarcationUrl: json["demarcation_url"],
    );

    Map<String, dynamic> toMap() => {
        "demarcation_url": demarcationUrl,
    };
}
