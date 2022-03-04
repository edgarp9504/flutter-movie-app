import 'package:app_movies/model/model_tv.dart';
import 'package:app_movies/model/model_tv_details.dart';
import 'package:app_movies/provider/tv_provider.dart';
import 'package:app_movies/src/pages/tv_details.dart';
import 'package:app_movies/utils/text_format.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CardList extends StatefulWidget {
  const CardList({Key? key, required this.tvModel}) : super(key: key);
  final TV tvModel;

  @override
  State<CardList> createState() => _CardListState();
}

class _CardListState extends State<CardList> {
  ModelTvDeatis? tvDeatis;

  @override
  void initState() {
    final tvProvider = Provider.of<TvProvider>(context, listen: false);
    tvProvider
        .getDetailsTv(widget.tvModel.id.toString())
        .then((detailsDB) => tvDeatis = detailsDB);
    super.initState();
  }

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
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    PageRouteBuilder(
                      transitionDuration: const Duration(milliseconds: 900),
                      pageBuilder: (_, __, ___) => TvDetailsPages(
                        tvDetails: tvDeatis!,
                        tvSeries: widget.tvModel,
                      ),
                    ));
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: FadeInImage(
                    placeholder: const AssetImage('assets/loading.gif'),
                    image: NetworkImage(
                        'https://image.tmdb.org/t/p/w500${widget.tvModel.posterPath!}')),
              ),
            ),
          ),
          const SizedBox(width: 20),
          if (tvDeatis == null) Container(),
          if (tvDeatis != null)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.tvModel.name,
                    style: GoogleFonts.dongle(
                        color: Colors.white, fontSize: sizeTitle2)),
                Row(
                  children: [
                    Text(widget.tvModel.voteAverage.toString(),
                        style: GoogleFonts.dongle(
                            color: Colors.white, fontSize: sizeText)),
                    const Icon(Icons.star_rate_rounded, color: Colors.yellow),
                  ],
                ),
                Text('${tvDeatis!.numberOfSeasons.toString()} Temporadas',
                    style: GoogleFonts.dongle(
                        color: Colors.white, fontSize: sizeText)),
                Text('${tvDeatis!.numberOfEpisodes.toString()} Episodios',
                    style: GoogleFonts.dongle(
                        color: Colors.white, fontSize: sizeText))
              ],
            )
        ],
      ),
    );
  }
}
