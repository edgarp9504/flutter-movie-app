import 'package:app_movies/provider/ui_provider.dart';
import 'package:app_movies/src/pages/tv_pages.dart';
import 'package:app_movies/src/widget/test.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:app_movies/provider/movies_provider.dart';
import 'package:app_movies/provider/tv_provider.dart';

import 'package:app_movies/src/pages/home.dart';
//import 'package:app_movies/src/pages/movie_detail.dart';
import 'package:app_movies/src/pages/tv_details.dart';

void main() => runApp(const AppProvider());

class AppProvider extends StatelessWidget {
  const AppProvider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Initial Provider
        ChangeNotifierProvider(create: (_) => ProviderMovie(), lazy: false),
        ChangeNotifierProvider(create: (_) => TvProvider(), lazy: false),
        ChangeNotifierProvider(create: (_) => UIProvider(), lazy: false),
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '',
      debugShowCheckedModeBanner: false,
      initialRoute: 'tv-test',
      routes: {
        '/': (_) => const Home(),
        //'movie-details': (_) => const MovieDetailsPages(),
        'tv-details': (_) => const TvDetailsPages(),
        //'tv-test': (_) => const VideoScreen(),
        //'url-launcher': (_) => const MyHomePage()
        'tv-popular': (_) => const TvPages(),
      },
    );
  }
}
