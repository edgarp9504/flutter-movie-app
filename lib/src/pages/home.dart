import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: double.infinity,
          height: 300,
          child: Swiper(
            itemBuilder: (BuildContext context, int index) {
              return Image.network(
                "https://via.placeholder.com/288x188",
                fit: BoxFit.fill,
              );
            },
            itemCount: 10,
            viewportFraction: 0.8,
            scale: 0.9,
          ),
        ),
        Column(
          children: [Text('Peliculas populares')],
        ),
        Column(
          children: [Text('Proximas peliculas')],
        ),
        Column(
          children: [Text('Tv Populares')],
        ),
      ],
    )));
  }
}
