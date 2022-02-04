import 'package:app_movies/model/model_movie.dart';
import 'package:app_movies/model/model_popular.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class ProviderMovie extends ChangeNotifier {
  final _key = '20b8ddd284df3910dac90aace99729e3';
  final _url = 'api.themoviedb.org';
  List<Movie> moviesPopular = [];

  ProviderMovie() {
    getMoviePopular();
  }

  getMoviePopular() async {
    try {
      final url = Uri.https(_url, '3/movie/popular',
          {'api_key': _key, 'language': 'es-MX', 'page': '1'});

      final respJson = await http.get(url);
      final popularMovies = ModelPopular.fromJson(respJson.body);
      moviesPopular = popularMovies.results;
      notifyListeners();
    } catch (e) {
      throw 'error al cargar las peliculas';
    }
  }
}
