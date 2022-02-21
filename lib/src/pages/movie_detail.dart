import 'package:app_movies/model/modeil_video.dart';
import 'package:app_movies/provider/movies_provider.dart';
import 'package:app_movies/src/widget/card_casting.dart';
import 'package:app_movies/src/widget/video_youtube.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:app_movies/model/model_movie.dart';
import 'package:provider/provider.dart';

class MovieDetailsPages extends StatefulWidget {
  const MovieDetailsPages({
    Key? key,
    required this.idMovie,
    required this.id,
  }) : super(key: key);

  final String idMovie;
  final String id;

  @override
  State<MovieDetailsPages> createState() => _MovieDetailsPagesState();
}

class _MovieDetailsPagesState extends State<MovieDetailsPages> {
  List<ListVideo>? video;

  @override
  void initState() {
    final movieProvider = Provider.of<ProviderMovie>(context, listen: false);
    print(widget.id);
    movieProvider.getMovieVideo(widget.id).then((videoDB) {
      video = videoDB;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final movieProvider = Provider.of<ProviderMovie>(context);
    final movie = ModalRoute.of(context)!.settings.arguments as Movie;
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(9.0),
                child: ListView(
                  children: [
                    _TittleCustom(
                        movie: movie,
                        idMovie: widget.idMovie,
                        movieProvider: movieProvider),
                    const SizedBox(height: 20),

                    //Description
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Descripcción',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                        const SizedBox(height: 10),
                        Text(movie.overview,
                            style: const TextStyle(
                                color: Colors.white,
                                letterSpacing: 1,
                                fontSize: 12)),
                      ],
                    ),

                    const SizedBox(height: 20),

                    CardCasting(idMovie: movie.id.toString())
                  ],
                ),
              )),
          (movieProvider.isBool)
              ? Positioned(
                  top: 200,
                  left: size.width / 10,
                  height: 250,
                  width: size.width * 0.8,
                  child: VideoPlayCustome(
                    movieProvider: movieProvider,
                    keyVideo: video![0].key,
                  ))
              : Container(),
        ],
      ),
    );
  }
}

class _TittleCustom extends StatelessWidget {
  const _TittleCustom({
    Key? key,
    required this.movie,
    required this.idMovie,
    required this.movieProvider,
  }) : super(key: key);

  final Movie movie;
  final String idMovie;
  final ProviderMovie movieProvider;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30.0),
      child: Row(
        children: [
          SizedBox(
              height: 200,
              width: 160,
              child: Hero(
                  tag: idMovie,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                        'https://image.tmdb.org/t/p/w500${movie.posterPath!}'),
                  ))),
          const SizedBox(width: 10.0),
          Expanded(
            child: SizedBox(
              height: 200,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${movie.originalTitle} (2021)',
                    style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  Row(
                    children: [
                      Text(
                        '${movie.releaseDate.toString()} 2h 28m',
                        style:
                            const TextStyle(color: Colors.white, fontSize: 10),
                      ),
                    ],
                  ),
                  const Spacer(),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {
                      movieProvider.getOpenVideo();
                      print('object');
                    },
                    child: CircleAvatar(
                        backgroundColor: Colors.red[400],
                        child: const Icon(Icons.play_arrow)),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
