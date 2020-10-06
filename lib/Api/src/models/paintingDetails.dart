import 'dart:convert';

PaintingDetails paintingDetailsFromJson(String str) =>
    PaintingDetails.fromJson(json.decode(str));

class PaintingDetails {
  PaintingDetails({
    this.id,
    this.title,
    this.url,
    this.artistUrl,
    this.artistName,
    this.artistId,
    this.completitionYear,
    this.dictionaries,
    this.location,
    this.period,
    this.serie,
    this.genres,
    this.styles,
    this.media,
    this.sizeX,
    this.sizeY,
    this.diameter,
    this.galleries,
    this.tags,
    this.description,
    this.width,
    this.image,
    this.height,
  });

  String id;
  String title;
  String url;
  String artistUrl;
  String artistName;
  String artistId;
  int completitionYear;
  List<String> dictionaries;
  String location;
  dynamic period;
  dynamic serie;
  List<String> genres;
  List<String> styles;
  List<String> media;
  int sizeX;
  int sizeY;
  dynamic diameter;
  List<String> galleries;
  List<String> tags;
  String description;
  int width;
  String image;
  int height;

  factory PaintingDetails.fromJson(Map<String, dynamic> json) =>
      PaintingDetails(
        id: json["id"],
        title: json["title"],
        url: json["url"],
        artistUrl: json["artistUrl"],
        artistName: json["artistName"],
        artistId: json["artistId"],
        completitionYear: json["completitionYear"],
        dictionaries: List<String>.from(json["dictionaries"].map((x) => x)),
        location: json["location"],
        period: json["period"],
        serie: json["serie"],
        genres: List<String>.from(json["genres"].map((x) => x)),
        styles: List<String>.from(json["styles"].map((x) => x)),
        media: List<String>.from(json["media"].map((x) => x)),
        sizeX: json["sizeX"],
        sizeY: json["sizeY"],
        diameter: json["diameter"],
        galleries: List<String>.from(json["galleries"].map((x) => x)),
        tags: List<String>.from(json["tags"].map((x) => x)),
        description: json["description"],
        width: json["width"],
        image: json["image"],
        height: json["height"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "url": url,
        "artistUrl": artistUrl,
        "artistName": artistName,
        "artistId": artistId,
        "completitionYear": completitionYear,
        "dictionaries": List<dynamic>.from(dictionaries.map((x) => x)),
        "location": location,
        "period": period,
        "serie": serie,
        "genres": List<dynamic>.from(genres.map((x) => x)),
        "styles": List<dynamic>.from(styles.map((x) => x)),
        "media": List<dynamic>.from(media.map((x) => x)),
        "sizeX": sizeX,
        "sizeY": sizeY,
        "diameter": diameter,
        "galleries": List<dynamic>.from(galleries.map((x) => x)),
        "tags": List<dynamic>.from(tags.map((x) => x)),
        "description": description,
        "width": width,
        "image": image,
        "height": height,
      };
}
