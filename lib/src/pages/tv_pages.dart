import 'package:app_movies/provider/tv_provider.dart';
import 'package:app_movies/src/widget/card_list_tv.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TvPages extends StatelessWidget {
  const TvPages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tvPRovider = Provider.of<TvProvider>(context);

    return SizedBox(
        width: double.infinity,
        child: ListView.builder(
          itemCount: tvPRovider.lisTVPopular.length,
          itemBuilder: (context, index) {
            final tvModel = tvPRovider.lisTVPopular[index];
            return CardList(
              tvModel: tvModel,
            );
          },
        ));
  }
}
