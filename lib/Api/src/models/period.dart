class Period {
  Period({
    this.id,
    this.title,
  });

  String id;
  String title;

  factory Period.fromJson(Map<String, dynamic> json) => Period(
        id: json["id"],
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
      };
}
