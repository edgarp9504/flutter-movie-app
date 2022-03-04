import 'dart:ui';

import 'package:app_movies/provider/movies_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CarouselWidget extends StatefulWidget {
  const CarouselWidget({Key? key}) : super(key: key);

  @override
  State<CarouselWidget> createState() => _CarouselWidgetState();
}

class _CarouselWidgetState extends State<CarouselWidget> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final dataProvider = Provider.of<ProviderMovie>(context);
    final moviePopular = dataProvider.moviesPopular;
    return Scaffold(
      body: Stack(children: [
        (dataProvider.isBool)
            ? Container()
            : AnimatedSwitcher(
                duration: const Duration(milliseconds: 900),
                child: Container(
                  key: ValueKey<int>(moviePopular[index].id),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                            'https://image.tmdb.org/t/p/w500${moviePopular[index].posterPath!}')),
                  ),
                ),
              ),
        SizedBox(
          child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 20.0, sigmaY: 20.0),
              child: Container(
                  decoration:
                      BoxDecoration(color: Colors.black.withOpacity(0.2)))),
        ),
        Center(
          child: SizedBox(
            height: size.height * 0.5,
            width: size.width,
            child: PageView.builder(
              onPageChanged: (value) {
                setState(() {
                  index = value;
                });
              },
              scrollDirection: Axis.horizontal,
              itemCount: dataProvider.moviesPopular.length,
              itemBuilder: (context, index) {
                final movie = dataProvider.moviesPopular[index];
                return Container(
                  margin: const EdgeInsets.only(left: 60, right: 60),
                  width: size.width * 0.8,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
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
        )
      ]),
    );
  }
}
