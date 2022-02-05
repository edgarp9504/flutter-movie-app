import 'package:app_movies/model/model_movie.dart';
import 'package:app_movies/model/model_api_movie.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class ProviderMovie extends ChangeNotifier {
  final _key = '20b8ddd284df3910dac90aace99729e3';
  final _url = 'api.themoviedb.org';
  List<Movie> moviesPopular = [];
  List<Movie> moviesNowPlaying = [];
  List<Movie> movieUpComing = [];
  int index = 0;

  String path = '';

  ProviderMovie() {
    getMoviePopular();
    getMovieNowPlaying();
    getMovieUpcoming();
  }

  Future<String> getPosterInitial() async {
    final url = Uri.https(_url, '3/movie/popular',
        {'api_key': _key, 'language': 'es-MX', 'page': '1'});

    final respJson = await http.get(url);
    final popularMovies = ModelPopular.fromJson(respJson.body);

    return popularMovies.results[0].posterPath!;
  }

  getMoviePopular() async {
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

  getMovieNowPlaying() async {
    try {
      final url = Uri.https(_url, '3/movie/now_playing',
          {'api_key': _key, 'language': 'es-MX', 'page': '1'});

      final respJson = await http.get(url);

      final playingMovie = ModelPopular.fromJson(respJson.body);
      moviesNowPlaying = playingMovie.results;
      notifyListeners();
      return playingMovie.results;
    } catch (e) {
      throw 'error al cargar las peliculas Playing Now';
    }
  }

  getMovieUpcoming() async {
    try {
      final url = Uri.https(_url, '3/movie/upcoming',
          {'api_key': _key, 'language': 'es-MX', 'page': '1'});
      final respJson = await http.get(url);
      final upcomingMovie = ModelPopular.fromJson(respJson.body);
      movieUpComing = upcomingMovie.results;
      notifyListeners();
    } catch (e) {
      throw 'error al cargar las peliculas Upcoming';
    }
  }
}
