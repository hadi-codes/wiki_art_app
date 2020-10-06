class Painting {
  Painting({
    this.id,
    this.title,
    this.url,
    this.artistUrl,
    this.artistName,
    this.artistId,
    this.completitionYear,
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
  String completitionYear;
  double width;
  String image;
  double height;

  factory Painting.fromJson(Map<String, dynamic> json) => Painting(
        id: json["id"],
        title: json["title"],
        url: json["url"],
        artistUrl: json["artistUrl"],
        artistName: json["artistName"],
        artistId: json["artistId"],
        completitionYear: json["completitionYear"] == null
            ? null
            : json["completitionYear"].toString(),
        image: json["image"],
        width: json["width"].toDouble(),
        height: json["height"].toDouble(),
      );

  Map<dynamic, dynamic> toJson() => {
        "id": id,
        "title": title,
        "url": url,
        "artistUrl": artistUrl,
        "artistName": artistName,
        "artistId": artistId,
        "image": "no",
        "completitionYear":
            completitionYear == null ? "null" : completitionYear.toString(),
        "width": width,
        "height": height,
      };
}
