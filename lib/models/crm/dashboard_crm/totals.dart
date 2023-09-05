import 'dart:convert';

class Totales {
    final int week;
    final int year;
    final Total total;
    final Marcadores marcadores;

    Totales({
        required this.week,
        required this.year,
        required this.total,
        required this.marcadores,
    });

    factory Totales.fromJson(String str) => Totales.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Totales.fromMap(Map<String, dynamic> json) => Totales(
        week: json["Week"],
        year: json["Year"],
        total: Total.fromMap(json["Total"]),
        marcadores: Marcadores.fromMap(json["Marcadores"]),
    );

    Map<String, dynamic> toMap() => {
        "Week": week,
        "Year": year,
        "Total": total.toMap(),
        "Marcadores": marcadores.toMap(),
    };
}

class Marcadores {
    final double cOrders;
    final double cQuotes;
    final double cTotals;
    final double mOrders;
    final double mQuotes;
    final double mTotals;
    final double cCanceled;
    final double mCanceled;

    Marcadores({
        required this.cOrders,
        required this.cQuotes,
        required this.cTotals,
        required this.mOrders,
        required this.mQuotes,
        required this.mTotals,
        required this.cCanceled,
        required this.mCanceled,
    });

    factory Marcadores.fromJson(String str) => Marcadores.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Marcadores.fromMap(Map<String, dynamic> json) => Marcadores(
        cOrders: json["C_Orders"],
        cQuotes: json["C_Quotes"],
        cTotals: json["C_Totals"],
        mOrders: json["M_Orders"],
        mQuotes: json["M_Quotes"],
        mTotals: json["M_Totals"],
        cCanceled: json["C_Canceled"],
        mCanceled: json["M_Canceled"],
    );

    Map<String, dynamic> toMap() => {
        "C_Orders": cOrders,
        "C_Quotes": cQuotes,
        "C_Totals": cTotals,
        "M_Orders": mOrders,
        "M_Quotes": mQuotes,
        "M_Totals": mTotals,
        "C_Canceled": cCanceled,
        "M_Canceled": mCanceled,
    };
}

class Total {
    final double total;
    final double orders;
    final double quotes;
    final double canceled;

    Total({
        required this.total,
        required this.orders,
        required this.quotes,
        required this.canceled,
    });

    factory Total.fromJson(String str) => Total.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Total.fromMap(Map<String, dynamic> json) => Total(
        total: json["Total"],
        orders: json["Orders"],
        quotes: json["Quotes"],
        canceled: json["Canceled"],
    );

    Map<String, dynamic> toMap() => {
        "Total": total,
        "Orders": orders,
        "Quotes": quotes,
        "Canceled": canceled,
    };
}
