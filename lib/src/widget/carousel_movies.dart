import 'package:app_movies/src/pages/movie_detail.dart';
import 'package:app_movies/src/pages/movie_page_soon.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:app_movies/provider/ui_provider.dart';
import 'package:app_movies/model/model_movie.dart';
import 'package:app_movies/utils/text_format.dart';

class CarouselMovies extends StatelessWidget {
  const CarouselMovies({
    Key? key,
    required this.tittle1,
    required this.tittle2,
    required this.listMovie,
    this.index = 0,
  }) : super(key: key);

  final String tittle1;
  final String tittle2;
  final List<Movie> listMovie;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              children: [
                RichText(
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
                const Spacer(),
                InkWell(
                    onTap: () {
                      if (index != 0) {
                        final uiProvider =
                            Provider.of<UIProvider>(context, listen: false);
                        uiProvider.selectOnTap = index;
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MoviePageSoon()),
                        );
                      }
                    },
                    child: Text(
                      'ver más',
                      style: TextStyle(color: Colors.red[400]),
                    ))
              ],
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
                final idmovie = '${movie.id.toString()}A${index.toString()}';
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 140,
                    height: 50,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Hero(
                        tag: idmovie,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                PageRouteBuilder(
                                    settings: RouteSettings(arguments: movie),
                                    transitionDuration:
                                        const Duration(milliseconds: 900),
                                    pageBuilder: (_, __, ___) =>
                                        MovieDetailsPages(
                                          idMovie: idmovie,
                                          id: movie.id.toString(),
                                        )));
                          },
                          child: FadeInImage(
                              fit: BoxFit.cover,
                              placeholder:
                                  const AssetImage('assets/loading.gif'),
                              image: NetworkImage(
                                  'https://image.tmdb.org/t/p/w500${movie.posterPath}')),
                        ),
                      ),
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
