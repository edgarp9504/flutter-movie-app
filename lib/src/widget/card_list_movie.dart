import 'package:app_movies/model/model_movie.dart';

import 'package:app_movies/utils/text_format.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CardListMovie extends StatelessWidget {
  const CardListMovie({Key? key, required this.movieModel}) : super(key: key);
  final Movie movieModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Row(
        children: [
          Container(
            width: 100,
            height: 150,
            decoration: BoxDecoration(
                color: Colors.grey, borderRadius: BorderRadius.circular(20)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                  placeholder: const AssetImage('assets/loading.gif'),
                  image: NetworkImage(
                      'https://image.tmdb.org/t/p/w500${movieModel.posterPath!}')),
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(movieModel.originalTitle,
                    style: GoogleFonts.dongle(
                        color: Colors.white, fontSize: sizeTitle2)),
                Row(
                  children: [
                    Text(movieModel.voteAverage.toString(),
                        style: GoogleFonts.dongle(
                            color: Colors.white, fontSize: sizeText)),
                    const Icon(Icons.star_rate_rounded, color: Colors.yellow),
                  ],
                ),
                Text('4 temporadas',
                    style: GoogleFonts.dongle(
                        color: Colors.white, fontSize: sizeText)),
                Text('20 episodios',
                    style: GoogleFonts.dongle(
                        color: Colors.white, fontSize: sizeText))
              ],
            ),
          )
        ],
      ),
    );
  }
}
