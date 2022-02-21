import 'package:app_movies/model/model_credits.dart';
import 'package:app_movies/provider/movies_provider.dart';
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
      builder: (_, AsyncSnapshot<List<Cast>> snapshot) {
        if (snapshot.data == null) {
          return Container();
        }

        final List<Cast> cast = snapshot.data!;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Elenco',
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold)),
            SizedBox(
              width: double.infinity,
              height: 180,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: cast.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: 100,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: FadeInImage(
                            fit: BoxFit.cover,
                            placeholder: const AssetImage('assets/loading.gif'),
                            image: NetworkImage(cast[index].fullProfilePath)),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
