// To parse this JSON data, do
//
//     final artistDictionary = artistDictionaryFromJson(jsonString);

import 'dart:convert';
import 'artist.dart';

ArtistDictionary artistDictionaryFromJson(String str) =>
    ArtistDictionary.fromJson(json.decode(str));

class ArtistDictionary {
  ArtistDictionary({
    this.artists,
    this.paginationToken,
    this.hasMore,
  });

  List<Artist> artists;
  String paginationToken;
  bool hasMore;

  factory ArtistDictionary.fromJson(Map<String, dynamic> json) =>
      ArtistDictionary(
        artists: List<Artist>.from(json["data"].map((x) => Artist.fromJson(x))),
        paginationToken: json["paginationToken"],
        hasMore: json["hasMore"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(artists.map((x) => x.toJson())),
        "paginationToken": paginationToken,
        "hasMore": hasMore,
      };
}
