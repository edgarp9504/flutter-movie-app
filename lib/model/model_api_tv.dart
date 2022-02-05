// To parse this JSON data, do
//
//     final modelTv = modelTvFromMap(jsonString);

import 'dart:convert';

import 'package:app_movies/model/model_tv.dart';

class ModelTv {
  ModelTv({
    required this.page,
    required this.results,
    required this.totalResults,
    required this.totalPages,
  });

  int page;
  List<TV> results;
  int totalResults;
  int totalPages;

  factory ModelTv.fromJson(String str) => ModelTv.fromMap(json.decode(str));

  factory ModelTv.fromMap(Map<String, dynamic> json) => ModelTv(
        page: json["page"],
        results: List<TV>.from(json["results"].map((x) => TV.fromMap(x))),
        totalResults: json["total_results"],
        totalPages: json["total_pages"],
      );
}
