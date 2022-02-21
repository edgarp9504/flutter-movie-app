import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:app_movies/provider/movies_provider.dart';
import 'package:app_movies/src/widget/card_list_movie.dart';

class MoviePageSoon extends StatelessWidget {
  const MoviePageSoon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final movieProvider = Provider.of<ProviderMovie>(context);

    return Scaffold(
        backgroundColor: Colors.black,
        body: SizedBox(
            width: double.infinity,
            child: ListView.builder(
              itemCount: movieProvider.movieUpComing.length,
              itemBuilder: (context, index) {
                final movieModel = movieProvider.movieUpComing[index];
                return CardListMovie(
                  movieModel: movieModel,
                );
              },
            )));
  }
}
