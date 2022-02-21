import 'package:app_movies/provider/movies_provider.dart';
import 'package:app_movies/src/widget/card_list_movie.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MoviePage extends StatelessWidget {
  const MoviePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final movieProvider = Provider.of<ProviderMovie>(context);

    return SizedBox(
        width: double.infinity,
        child: ListView.builder(
          itemCount: movieProvider.moviesPopular.length,
          itemBuilder: (context, index) {
            final movieModel = movieProvider.moviesPopular[index];
            return CardListMovie(
              movieModel: movieModel,
            );
          },
        ));
  }
}
