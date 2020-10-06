import 'dart:convert';

import 'painting.dart';

MostViewedPaintings mostViewedPaintingsFromJson(String str) =>
    MostViewedPaintings.fromJson(json.decode(str));

class MostViewedPaintings {
  MostViewedPaintings({
    this.painting,
    this.paginationToken,
    this.hasMore,
  });
  List<Painting> painting;
  String paginationToken;
  bool hasMore;

  factory MostViewedPaintings.fromJson(Map<String, dynamic> json) =>
      MostViewedPaintings(
        painting:
            List<Painting>.from(json["data"].map((x) => Painting.fromJson(x))),
        paginationToken: json["paginationToken"],
        hasMore: json["hasMore"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(painting.map((x) => x.toJson())),
        "paginationToken": paginationToken,
        "hasMore": hasMore,
      };
}
