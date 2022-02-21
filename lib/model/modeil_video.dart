// To parse this JSON data, do
//
//     final modelVideo = modelVideoFromMap(jsonString);

import 'dart:convert';

class ModelVideo {
  ModelVideo({
    required this.id,
    required this.results,
  });

  int id;
  List<ListVideo> results;

  factory ModelVideo.fromJson(String str) =>
      ModelVideo.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ModelVideo.fromMap(Map<String, dynamic> json) => ModelVideo(
        id: json["id"],
        results: List<ListVideo>.from(
            json["results"].map((x) => ListVideo.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "results": List<dynamic>.from(results.map((x) => x.toMap())),
      };
}

class ListVideo {
  ListVideo({
    required this.iso6391,
    required this.iso31661,
    required this.name,
    required this.key,
    required this.site,
    required this.size,
    required this.type,
    required this.official,
    required this.publishedAt,
    required this.id,
  });

  String iso6391;
  String iso31661;
  String name;
  String key;
  String site;
  int size;
  String type;
  bool official;
  DateTime publishedAt;
  String id;

  factory ListVideo.fromJson(String str) => ListVideo.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ListVideo.fromMap(Map<String, dynamic> json) => ListVideo(
        iso6391: json["iso_639_1"],
        iso31661: json["iso_3166_1"],
        name: json["name"],
        key: json["key"],
        site: json["site"],
        size: json["size"],
        type: json["type"],
        official: json["official"],
        publishedAt: DateTime.parse(json["published_at"]),
        id: json["id"],
      );

  Map<String, dynamic> toMap() => {
        "iso_639_1": iso6391,
        "iso_3166_1": iso31661,
        "name": name,
        "key": key,
        "site": site,
        "size": size,
        "type": type,
        "official": official,
        "published_at": publishedAt.toIso8601String(),
        "id": id,
      };
}
