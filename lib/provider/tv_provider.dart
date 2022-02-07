import 'package:app_movies/model/model_api_tv.dart';
import 'package:app_movies/model/model_tv.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class TvProvider extends ChangeNotifier {
  final _key = '20b8ddd284df3910dac90aace99729e3';
  final _url = 'api.themoviedb.org';
  List<TV> lisTVPopular = [];

  TvProvider() {
    getPopularTV();
  }

  Future<List<TV>> getPopularTV() async {
    try {
      final url = Uri.https(_url, '3/tv/popular',
          {'api_key': _key, 'language': 'es-MX', 'page': '1'});
      final respJson = await http.get(url);

      final tvPopular = ModelTv.fromJson(respJson.body);
      lisTVPopular = tvPopular.results;

      notifyListeners();
      return tvPopular.results;
    } catch (e) {
      throw 'error al cargar las losTV';
    }
  }
}
