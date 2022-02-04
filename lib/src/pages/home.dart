import 'dart:ui';

import 'package:app_movies/provider/provider_movies.dart';
import 'package:app_movies/utils/text_format.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _Carousel(),

            //Peliculas populares
            const _PopularMovies(),
            const _PopularMovies(),
            Column(
              children: [Text('Tv Populares')],
            ),
          ],
        )));
  }
}

class _Carousel extends StatefulWidget {
  const _Carousel({Key? key}) : super(key: key);

  @override
  State<_Carousel> createState() => _CarouselState();
}

class _CarouselState extends State<_Carousel> {
  final _pageController = PageController(viewportFraction: 0.7);

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
            Container(
              width: double.infinity,
              height: 500,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage('https://image.tmdb.org/t/p/w500' +
                      moviePopular[index].posterPath!),
                ),
              ),
              child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 30.0, sigmaY: 30.0),
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
                              'https://image.tmdb.org/t/p/w500' +
                                  movie.posterPath!)),
                    ),
                  );
                },
              ),
            ),
          ],
        ));
  }
}

class _PopularMovies extends StatelessWidget {
  const _PopularMovies({
    Key? key,
  }) : super(key: key);

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
                    text: 'Peliculas ',
                    style: GoogleFonts.dongle(
                        fontSize: sizeTitle1, fontWeight: FontWeight.bold)),
                TextSpan(
                    text: 'populares',
                    style: GoogleFonts.dongle(
                        fontSize: sizeTitle1, fontWeight: FontWeight.w300)),
              ]),
            ),
          ),
          SizedBox(
            height: 200,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 180,
                    height: 50,
                    decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(10)),
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
