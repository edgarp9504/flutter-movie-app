import 'package:app_movies/model/model_api_tv.dart';
import 'package:app_movies/model/model_credits.dart';
import 'package:app_movies/model/model_tv.dart';
import 'package:app_movies/model/model_tv_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class TvProvider extends ChangeNotifier {
  final _key = '20b8ddd284df3910dac90aace99729e3';
  final _url = 'api.themoviedb.org';
  List<TV> lisTVPopular = [];

  TV? tvTop1;
  TV? tvTop2;
  TV? tvTop3;

  TvProvider() {
    getPopularTV();
    //getCastTv('85552');

    //getDetailsTv('132712');
  }

  Future<List<TV>> getPopularTV() async {
    try {
      final url = Uri.https(_url, '3/tv/popular',
          {'api_key': _key, 'language': 'es-MX', 'page': '1'});
      final respJson = await http.get(url);

      final tvPopular = ModelTv.fromJson(respJson.body);
      lisTVPopular = tvPopular.results;
      tvTop1 = lisTVPopular[0];
      tvTop2 = lisTVPopular[1];
      tvTop3 = lisTVPopular[2];

      //print('${lisTVPopular.length} lista 1');

      notifyListeners();
      return tvPopular.results;
    } catch (e) {
      throw 'error al cargar las losTV';
    }
  }

  Future<ModelTvDeatis> getDetailsTv(String id) async {
    try {
      final url =
          Uri.https(_url, '3/tv/$id', {'api_key': _key, 'language': 'es-MX'});
      final respJson = await http.get(url);

      final tvDetails = ModelTvDeatis.fromJson(respJson.body);

      //print(tvPopular.name + ' ' + tvPopular.id.toString());
      notifyListeners();

      return tvDetails;
    } catch (e) {
      throw 'Error al cargar en el $id';
    }
  }

  Future<List<Cast>> getCastTv(String id) async {
    try {
      final url = Uri.https(
          _url, '3/tv/$id/credits', {'api_key': _key, 'language': 'es-MX'});
      final respJson = await http.get(url);

      final tvDetails = CreditsResponse.fromJson(respJson.body);

      //print(tvPopular.name + ' ' + tvPopular.id.toString());

      notifyListeners();

      return tvDetails.cast;
    } catch (e) {
      throw 'Error al cargar en el $id';
    }
  }
}
