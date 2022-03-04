import 'package:app_movies/model/model_credits.dart';
import 'package:app_movies/provider/movies_provider.dart';
import 'package:app_movies/provider/tv_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CardCasting extends StatelessWidget {
  const CardCasting({Key? key, required this.idMovie}) : super(key: key);
  final String idMovie;

  @override
  Widget build(BuildContext context) {
    final movieProvider = Provider.of<ProviderMovie>(context);

    return FutureBuilder(
      future: movieProvider.getMovieCast(idMovie),
      builder: (_, AsyncSnapshot snapshot) {
        if (snapshot.data == null) {
          return Container();
        }

        final cast = snapshot.data!;

        return _CardDecoration(cast: cast);
      },
    );
  }
}

class CardCastingTV extends StatelessWidget {
  const CardCastingTV({Key? key, required this.idTV}) : super(key: key);
  final String idTV;

  @override
  Widget build(BuildContext context) {
    final tvProvider = Provider.of<TvProvider>(context);
    return FutureBuilder(
      future: tvProvider.getCastTv(idTV),
      builder: (_, AsyncSnapshot snapshot) {
        if (snapshot.data == null) {
          return Container();
        }

        final cast = snapshot.data!;

        return _CardDecoration(cast: cast);
      },
    );
  }
}

class _CardDecoration extends StatelessWidget {
  const _CardDecoration({
    Key? key,
    required this.cast,
  }) : super(key: key);

  final List cast;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Elenco',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        SizedBox(
          width: double.infinity,
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: cast.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    SizedBox(
                      width: 100,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: FadeInImage(
                            fit: BoxFit.cover,
                            placeholder: const AssetImage('assets/loading.gif'),
                            image: NetworkImage(cast[index].fullProfilePath)),
                      ),
                    ),
                    Expanded(
                        child: Column(
                      children: [
                        Text(cast[index].name,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                                fontWeight: FontWeight.bold)),
                        Text(cast[index].character!,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 9)),
                      ],
                    ))
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
