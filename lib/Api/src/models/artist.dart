import 'package:wiki_art/Api/src/models/period.dart';

import 'gender.dart';

class Artist {
  Artist({
    this.id,
    this.artistName,
    this.url,
    this.lastNameFirst,
    this.birthDay,
    this.deathDay,
    this.birthDayAsString,
    this.deathDayAsString,
    this.image,
    this.wikipediaUrl,
    this.dictionaries,
    this.periods,
    this.series,
    this.activeYearsStart,
    this.activeYearsCompletion,
    this.biography,
    this.gender,
    this.originalArtistName,
    this.relatedArtists,
  });

  String id;
  String artistName;
  String url;
  String lastNameFirst;
  String birthDay;
  String deathDay;
  String birthDayAsString;
  String deathDayAsString;
  String image;
  dynamic wikipediaUrl;
  List<String> dictionaries;
  List<Period> periods;
  List<Period> series;
  int activeYearsStart;
  int activeYearsCompletion;
  String biography;
  Gender gender;
  String originalArtistName;
  List<String> relatedArtists;

  factory Artist.fromJson(Map<String, dynamic> json) => Artist(
        id: json["id"],
        artistName: json["artistName"],
        url: json["url"],
        lastNameFirst:
            json["lastNameFirst"] == null ? null : json["lastNameFirst"],
        birthDay: json["birthDay"],
        deathDay: json["deathDay"],
        birthDayAsString: json["birthDayAsString"],
        deathDayAsString: json["deathDayAsString"],
        image: json["image"],
        wikipediaUrl: json["wikipediaUrl"],
        dictionaries: List<String>.from(json["dictionaries"].map((x) => x)),
        periods:
            List<Period>.from(json["periods"].map((x) => Period.fromJson(x))),
        series:
            List<Period>.from(json["series"].map((x) => Period.fromJson(x))),
        activeYearsStart:
            json["activeYearsStart"] == null ? null : json["activeYearsStart"],
        activeYearsCompletion: json["activeYearsCompletion"] == null
            ? null
            : json["activeYearsCompletion"],
        biography: json["biography"],
        gender: genderValues.map[json["gender"]],
        originalArtistName: json["originalArtistName"],
        relatedArtists: List<String>.from(json["relatedArtists"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "artistName": artistName,
        "url": url,
        "lastNameFirst": lastNameFirst == null ? null : lastNameFirst,
        "birthDay": birthDay,
        "deathDay": deathDay,
        "birthDayAsString": birthDayAsString,
        "deathDayAsString": deathDayAsString,
        "image": image,
        "wikipediaUrl": wikipediaUrl,
        "dictionaries": List<dynamic>.from(dictionaries.map((x) => x)),
        "periods": List<dynamic>.from(periods.map((x) => x.toJson())),
        "series": List<dynamic>.from(series.map((x) => x.toJson())),
        "activeYearsStart": activeYearsStart == null ? null : activeYearsStart,
        "activeYearsCompletion":
            activeYearsCompletion == null ? null : activeYearsCompletion,
        "biography": biography,
        "gender": genderValues.reverse[gender],
        "originalArtistName": originalArtistName,
        "relatedArtists": List<dynamic>.from(relatedArtists.map((x) => x)),
      };
}
