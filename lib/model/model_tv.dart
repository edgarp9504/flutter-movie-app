import 'dart:convert';

class TV {
  TV({
    required this.posterPath,
    required this.popularity,
    required this.id,
    required this.backdropPath,
    required this.voteAverage,
    required this.overview,
    required this.firstAirDate,
    required this.originCountry,
    required this.genreIds,
    required this.originalLanguage,
    required this.voteCount,
    required this.name,
    required this.originalName,
  });

  String posterPath;
  double popularity;
  int id;
  String backdropPath;
  double voteAverage;
  String overview;
  DateTime firstAirDate;
  String originCountry;
  List<int> genreIds;
  String originalLanguage;
  int voteCount;
  String name;
  String originalName;

  factory TV.fromJson(String str) => TV.fromMap(json.decode(str));

  factory TV.fromMap(Map<String, dynamic> json) => TV(
        posterPath: json["poster_path"],
        popularity: json["popularity"].toDouble(),
        id: json["id"],
        backdropPath: json["backdrop_path"],
        voteAverage: json["vote_average"].toDouble(),
        overview: json["overview"],
        firstAirDate: DateTime.parse(json["first_air_date"]),
        originCountry: json["origin_country"],
        genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
        originalLanguage: json["original_language"],
        voteCount: json["vote_count"],
        name: json["name"],
        originalName: json["original_name"],
      );
}
