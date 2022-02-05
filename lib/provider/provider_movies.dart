import 'package:app_movies/model/model_movie.dart';
import 'package:app_movies/model/model_popular.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class ProviderMovie extends ChangeNotifier {
  final _key = '20b8ddd284df3910dac90aace99729e3';
  final _url = 'api.themoviedb.org';
  List<Movie> moviesPopular = [];
  List<Movie> moviesNowPlaying = [];
  int index = 0;

  String path = '';

  ProviderMovie() {
    getMoviePopular();
  }

  getPathPoster(int index) async {}

  Future<String> getPosterInitial() async {
    final url = Uri.https(_url, '3/movie/popular',
        {'api_key': _key, 'language': 'es-MX', 'page': '1'});

    final respJson = await http.get(url);
    final popularMovies = ModelPopular.fromJson(respJson.body);

    return popularMovies.results[0].posterPath!;
  }

  Future<List<Movie>> getMoviePopular() async {
    try {
      final url = Uri.https(_url, '3/movie/popular',
          {'api_key': _key, 'language': 'es-MX', 'page': '1'});

      final respJson = await http.get(url);
      final popularMovies = ModelPopular.fromJson(respJson.body);
      moviesPopular = popularMovies.results;
      notifyListeners();
      return popularMovies.results;
    } catch (e) {
      throw 'error al cargar las peliculas';
    }
  }

  Future<List<Movie>> getMovieNowPlaying() async {
    try {
      final url = Uri.https(_url, '3/movie/now_playing',
          {'api_key': _key, 'language': 'es-MX', 'page': '1'});

      final respJson = await http.get(url);
      final popularMovies = ModelPopular.fromJson(respJson.body);
      moviesPopular = popularMovies.results;
      notifyListeners();
      return popularMovies.results;
    } catch (e) {
      throw 'error al cargar las peliculas Playing Now';
    }
  }
}
