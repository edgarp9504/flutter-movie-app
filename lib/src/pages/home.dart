import 'dart:ui';
import 'package:app_movies/src/widget/card_list.dart';
import 'package:app_movies/utils/text_format.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:provider/provider.dart';

import 'package:app_movies/provider/provider_movies.dart';
import 'package:app_movies/src/widget/carousel_movies.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    //Provider
    final provider = Provider.of<ProviderMovie>(context);

    return Scaffold(
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _Carousel(),

              //Popular Movies
              CarouselMovies(
                listMovie: provider.moviesPopular,
                tittle1: 'Peliculas ',
                tittle2: 'populares',
              ),

              // Upcoming movies
              CarouselMovies(
                listMovie: provider.movieUpComing,
                tittle1: 'Peliculas ',
                tittle2: 'proximas',
              ),

              //TV Popular
              const _TVPopular(),
            ],
          ),
        )));
  }
}

class _TVPopular extends StatelessWidget {
  const _TVPopular({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
          const CardList(),
          //2
          const Padding(
            padding: EdgeInsets.only(top: 20.0),
            child: CardList(),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 20.0),
            child: CardList(),
          ),
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
  final _pageController = PageController(viewportFraction: 0.7);
  String? primerPath;

  @override
  void initState() {
    super.initState();
    final provider = Provider.of<ProviderMovie>(context, listen: false);
    provider.getPosterInitial().then((value) {
      setState(() {
        primerPath = value;
      });
    });
  }

  int index = 0;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final provider = Provider.of<ProviderMovie>(context);
    final moviePopular = provider.moviesPopular;

    return AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: Stack(
          children: [
            if (primerPath == null) Container(),
            if (primerPath != null)
              AnimatedSwitcher(
                duration: const Duration(microseconds: 300),
                child: SizedBox(
                  width: double.infinity,
                  height: 500,
                  child: FadeInImage(
                      fit: BoxFit.cover,
                      placeholder: const AssetImage('assets/loading.gif'),
                      image: NetworkImage(
                          'https://image.tmdb.org/t/p/w500${moviePopular[index].posterPath}')),
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
                    index = value;
                  });
                },
                controller: _pageController,
                itemCount: moviePopular.length,
                itemBuilder: (context, index) {
                  final movie = moviePopular[index];

                  return Container(
                    margin: const EdgeInsets.only(
                        top: 80, bottom: 80, left: 15, right: 15),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: FadeInImage(
                          fit: BoxFit.cover,
                          placeholder: const AssetImage('assets/loading.gif'),
                          image: NetworkImage(
                              'https://image.tmdb.org/t/p/w500${movie.posterPath!}')),
                    ),
                  );
                },
              ),
            ),
          ],
        ));
  }
}
