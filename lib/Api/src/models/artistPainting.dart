// To parse this JSON data, do
//
//     final artistPainting = artistPaintingFromJson(jsonString);

import 'dart:convert';

import 'package:wiki_art/Api/src/models/painting.dart';

ArtistPainting artistPaintingFromJson(String str) =>
    ArtistPainting.fromJson(json.decode(str));

String artistPaintingToJson(ArtistPainting data) => json.encode(data.toJson());

class ArtistPainting {
  ArtistPainting({
    this.painting,
    this.paginationToken,
    this.hasMore,
  });

  List<Painting> painting;
  String paginationToken;
  bool hasMore;

  factory ArtistPainting.fromJson(Map<String, dynamic> json) => ArtistPainting(
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
