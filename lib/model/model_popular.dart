// To parse this JSON data, do
//
//     final modelPopular = modelPopularFromMap(jsonString);

import 'dart:convert';

import 'package:app_movies/model/model_movie.dart';

class ModelPopular {
  ModelPopular({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  int page;
  List<Movie> results;
  int totalPages;
  int totalResults;

  factory ModelPopular.fromJson(String str) =>
      ModelPopular.fromMap(json.decode(str));

  factory ModelPopular.fromMap(Map<String, dynamic> json) => ModelPopular(
        page: json["page"],
        results: List<Movie>.from(json["results"].map((x) => Movie.fromMap(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );
}
