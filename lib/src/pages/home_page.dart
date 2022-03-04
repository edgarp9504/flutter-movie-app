import 'dart:ui';

import 'package:app_movies/provider/ui_provider.dart';
import 'package:app_movies/src/pages/movie_detail.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';

import 'package:app_movies/provider/movies_provider.dart';
import 'package:app_movies/provider/tv_provider.dart';

import 'package:app_movies/src/widget/card_list_tv.dart';
import 'package:app_movies/src/widget/carousel_movies.dart';

import 'package:app_movies/utils/text_format.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final movieProvider = Provider.of<ProviderMovie>(context);
    return SingleChildScrollView(
        child: Padding(
      padding: const EdgeInsets.only(left: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _Carousel(),

          //Popular nowplayingmovies
          CarouselMovies(
            listMovie: movieProvider.moviesNowPlaying,
            tittle1: 'Peliculas ',
            tittle2: 'estrenos',
            index: 2,
          ),

          // Upcoming movies
          CarouselMovies(
            listMovie: movieProvider.movieUpComing,
            tittle1: 'Peliculas ',
            tittle2: 'proximas',
          ),

          //TV Popular
          _TVPopular(),
        ],
      ),
    ));
  }
}

class _TVPopular extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final listTop = Provider.of<TvProvider>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              RichText(
                text: TextSpan(children: [
                  TextSpan(
                      text: 'TV ',
                      style: GoogleFonts.dongle(
                          fontSize: sizeTitle1, fontWeight: FontWeight.bold)),
                  TextSpan(
                      text: 'populares',
                      style: GoogleFonts.dongle(
                          fontSize: sizeTitle1, fontWeight: FontWeight.w300)),
                ]),
              ),
              const Spacer(),
              InkWell(
                  onTap: () {
                    final uiProvider =
                        Provider.of<UIProvider>(context, listen: false);
                    uiProvider.selectOnTap = 1;
                  },
                  child: Text(
                    'ver más',
                    style: TextStyle(color: Colors.red[400]),
                  ))
            ],
          ),

          if (listTop.tvTop1 == null) Container(),
          if (listTop.tvTop1 != null) CardList(tvModel: listTop.tvTop1!),

          // top2
          if (listTop.tvTop2 == null) Container(),
          if (listTop.tvTop2 != null) CardList(tvModel: listTop.tvTop2!),

          //top 3

          if (listTop.tvTop3 == null) Container(),
          if (listTop.tvTop3 != null) CardList(tvModel: listTop.tvTop3!),
        ],
      ),
    );
  }
}

class _Carousel extends StatefulWidget {
  const _Carousel({Key? key}) : super(key: key);

  @override
  State<_Carousel> createState() => _CarouselState();
}

class _CarouselState extends State<_Carousel> {
  late final PageController _pageController;
  double _indeCard = 0.0;
  int _index = 0;

  @override
  void initState() {
    _pageController = PageController(viewportFraction: 0.7)
      ..addListener(_pageControllerListener);
    super.initState();
  }

  _pageControllerListener() {
    setState(() {
      _indeCard = _pageController.page!;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final provider = Provider.of<ProviderMovie>(context);
    final moviePopular = provider.moviesPopular;

    return Stack(
      children: [
        (provider.isBool)
            ? Container()
            : AnimatedSwitcher(
                duration: const Duration(milliseconds: 900),
                child: Container(
                  height: 500,
                  key: ValueKey<int>(moviePopular[_index].id),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                            'https://image.tmdb.org/t/p/w500${moviePopular[_index].posterPath!}')),
                  ),
                ),
              ),
        SizedBox(
          width: double.infinity,
          height: 500,
          child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 20.0, sigmaY: 20.0),
              child: Container(
                  width: 200.0,
                  height: 100.0,
                  decoration:
                      BoxDecoration(color: Colors.black.withOpacity(0.2)))),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: Container(
            width: size.width,
            height: size.height * 0.4,
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [0, 1],
                    colors: [Colors.transparent, Colors.black])),
          ),
        ),
        SizedBox(
          width: double.infinity,
          height: 500,
          child: PageView.builder(
            onPageChanged: (value) {
              setState(() {
                _index = value;
              });
            },
            controller: _pageController,
            itemCount: moviePopular.length,
            itemBuilder: (context, index) {
              final movie = moviePopular[index];
              final idmovie = '${moviePopular[index].id.toString()}P';
              final progress = (_indeCard - index);
              final scale = lerpDouble(1, 0.8, progress.abs());
              final isCurrentIndex = index == _index;

              return Transform.scale(
                alignment: Alignment.lerp(
                    Alignment.bottomLeft, Alignment.bottomCenter, -progress),
                scale: scale,
                child: AnimatedContainer(
                  curve: Curves.easeInOut,
                  duration: const Duration(milliseconds: 300),
                  transform: Matrix4.identity()
                    ..translate(
                      isCurrentIndex ? -20.0 : 0.0,
                      isCurrentIndex ? 0.0 : 0.0,
                    ),
                  margin: const EdgeInsets.only(
                      top: 80, bottom: 80, left: 15, right: 15),
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
                                      const Duration(milliseconds: 700),
                                  pageBuilder: (_, __, ___) =>
                                      MovieDetailsPages(
                                          idMovie: idmovie,
                                          id: movie.id.toString())));
                        },
                        child: FadeInImage(
                            fit: BoxFit.cover,
                            placeholder: const AssetImage('assets/loading.gif'),
                            image: NetworkImage(
                                'https://image.tmdb.org/t/p/w500${movie.posterPath!}')),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
