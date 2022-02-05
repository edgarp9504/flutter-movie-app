import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:app_movies/provider/provider_movies.dart';
import 'package:app_movies/provider/tv_movies.dart';

import 'package:app_movies/src/pages/home.dart';
import 'package:app_movies/src/pages/movie_detail.dart';
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
        ChangeNotifierProvider(create: (_) => ProviderTV(), lazy: false),
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
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (_) => const HomePage(),
        'movie-details': (_) => const MovieDetailsPages(),
        'tv-details': (_) => const TvDetailsPages(),
      },
    );
  }
}
