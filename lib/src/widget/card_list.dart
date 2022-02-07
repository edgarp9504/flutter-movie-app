import 'package:app_movies/model/model_tv.dart';
import 'package:app_movies/utils/text_format.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CardList extends StatelessWidget {
  const CardList({Key? key, required this.tvModel}) : super(key: key);
  final TV tvModel;

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
                  placeholder: AssetImage('assets/loading.gif'),
                  image: NetworkImage(
                      'https://image.tmdb.org/t/p/w500${tvModel.posterPath!}')),
            ),
          ),
          const SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(tvModel.name,
                  style: GoogleFonts.dongle(
                      color: Colors.white, fontSize: sizeTitle2)),
              Row(
                children: [
                  Text(tvModel.voteAverage.toString(),
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
          )
        ],
      ),
    );
  }
}
