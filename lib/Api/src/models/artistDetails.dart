// To parse this JSON data, do
//
//     final ArtistDetails = artistFromJson(jsonString);

import 'dart:convert';

ArtistDetails artistDetailsFromJson(String str) =>
    ArtistDetails.fromJson(json.decode(str));

String artistDetailsToJson(ArtistDetails data) => json.encode(data.toJson());

class ArtistDetails {
  ArtistDetails({
    this.relatedArtistsIds,
    this.originalArtistName,
    this.gender,
    this.story,
    this.biography,
    this.activeYearsCompletion,
    this.activeYearsStart,
    this.series,
    this.themes,
    this.periodsOfWork,
    this.contentId,
    this.artistName,
    this.url,
    this.lastNameFirst,
    this.birthDay,
    this.deathDay,
    this.birthDayAsString,
    this.deathDayAsString,
    this.image,
    this.wikipediaUrl,
    this.dictonaries,
  });

  List<dynamic> relatedArtistsIds;
  String originalArtistName;
  String gender;
  String story;
  String biography;
  int activeYearsCompletion;
  int activeYearsStart;
  String series;
  String themes;
  String periodsOfWork;
  int contentId;
  String artistName;
  String url;
  String lastNameFirst;
  String birthDay;
  String deathDay;
  String birthDayAsString;
  String deathDayAsString;
  String image;
  String wikipediaUrl;
  List<int> dictonaries;

  factory ArtistDetails.fromJson(Map<String, dynamic> json) => ArtistDetails(
        relatedArtistsIds:
            List<dynamic>.from(json["relatedArtistsIds"].map((x) => x)),
        originalArtistName: json["OriginalArtistName"],
        gender: json["gender"],
        story: json["story"],
        biography: json["biography"],
        activeYearsCompletion: json["activeYearsCompletion"],
        activeYearsStart: json["activeYearsStart"],
        series: json["series"],
        themes: json["themes"],
        periodsOfWork: json["periodsOfWork"],
        contentId: json["contentId"],
        artistName: json["artistName"],
        url: json["url"],
        lastNameFirst: json["lastNameFirst"],
        birthDay: json["birthDay"],
        deathDay: json["deathDay"],
        birthDayAsString: json["birthDayAsString"],
        deathDayAsString: json["deathDayAsString"],
        image: json["image"],
        wikipediaUrl: json["wikipediaUrl"],
        dictonaries: List<int>.from(json["dictonaries"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "relatedArtistsIds":
            List<dynamic>.from(relatedArtistsIds.map((x) => x)),
        "OriginalArtistName": originalArtistName,
        "gender": gender,
        "story": story,
        "biography": biography,
        "activeYearsCompletion": activeYearsCompletion,
        "activeYearsStart": activeYearsStart,
        "series": series,
        "themes": themes,
        "periodsOfWork": periodsOfWork,
        "contentId": contentId,
        "artistName": artistName,
        "url": url,
        "lastNameFirst": lastNameFirst,
        "birthDay": birthDay,
        "deathDay": deathDay,
        "birthDayAsString": birthDayAsString,
        "deathDayAsString": deathDayAsString,
        "image": image,
        "wikipediaUrl": wikipediaUrl,
        "dictonaries": List<dynamic>.from(dictonaries.map((x) => x)),
      };

  String get getImage {
    String img = this.image ??
        "https://us.123rf.com/450wm/pavelstasevich/pavelstasevich1811/pavelstasevich181101032/112815935-stock-vector-no-image-available-icon-flat-vector-illustration.jpg?ver=6";
    return img;
  }
}
