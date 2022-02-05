import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:app_movies/model/model_movie.dart';
import 'package:app_movies/utils/text_format.dart';

class CarouselMovies extends StatelessWidget {
  const CarouselMovies({
    Key? key,
    required this.tittle1,
    required this.tittle2,
    required this.listMovie,
  }) : super(key: key);

  final String tittle1;
  final String tittle2;
  final List<Movie> listMovie;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: RichText(
              text: TextSpan(children: [
                TextSpan(
                    text: tittle1,
                    style: GoogleFonts.dongle(
                        fontSize: sizeTitle1, fontWeight: FontWeight.bold)),
                TextSpan(
                    text: tittle2,
                    style: GoogleFonts.dongle(
                        fontSize: sizeTitle1, fontWeight: FontWeight.w300)),
              ]),
            ),
          ),
          SizedBox(
            height: 200,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: listMovie.length,
              itemBuilder: (context, index) {
                //List Movie now playing
                final movie = listMovie[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 140,
                    height: 50,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: FadeInImage(
                          fit: BoxFit.cover,
                          placeholder: const AssetImage('assets/loading.gif'),
                          image: NetworkImage(
                              'https://image.tmdb.org/t/p/w500${movie.posterPath}')),
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
