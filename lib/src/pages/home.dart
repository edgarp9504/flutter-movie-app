import 'package:app_movies/src/pages/home_page.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:app_movies/provider/ui_provider.dart';

import 'package:app_movies/src/pages/movies_pages.dart';
import 'package:app_movies/src/pages/tv_pages.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Provider
    final uiProvider = Provider.of<UIProvider>(context);

    return Scaffold(
        bottomNavigationBar: bottomNavigatorDecoration(uiProvider),
        backgroundColor: Colors.black,
        body: _HomePages());
  }

  BottomNavigationBar bottomNavigatorDecoration(UIProvider provider) {
    return BottomNavigationBar(
      onTap: (index) => provider.selectOnTap = index,
      currentIndex: provider.selectOnTap,
      backgroundColor: Colors.transparent,
      selectedItemColor: Colors.red[700],
      selectedIconTheme: const IconThemeData(size: 30),
      selectedFontSize: 16,
      unselectedItemColor: Colors.white,
      unselectedIconTheme: const IconThemeData(size: 20),
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home_rounded), label: 'Home'),
        BottomNavigationBarItem(
            icon: Icon(Icons.tv_outlined), label: 'TV show'),
        BottomNavigationBarItem(
            icon: Icon(Icons.movie_creation_outlined), label: 'Movie'),
      ],
    );
  }
}

class _HomePages extends StatelessWidget {
  const _HomePages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UIProvider>(context);

    final index = uiProvider.selectOnTap;

    switch (index) {
      case 0:
        return const HomePage();

      case 1:
        return const TvPages();

      case 2:
        return const MoviePage();

      default:
        return const HomePage();
    }
  }
}
