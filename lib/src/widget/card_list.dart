import 'package:app_movies/utils/text_format.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CardList extends StatelessWidget {
  const CardList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 100,
          height: 150,
          decoration: BoxDecoration(
              color: Colors.grey, borderRadius: BorderRadius.circular(20)),
        ),
        const SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Cobra Kai',
                style: GoogleFonts.dongle(
                    color: Colors.white, fontSize: sizeTitle2)),
            Row(
              children: [
                Text('8.1',
                    style: GoogleFonts.dongle(
                        color: Colors.white, fontSize: sizeText)),
                const Icon(Icons.star_rate_rounded, color: Colors.yellow),
              ],
            ),
            Text('4 temporadas',
                style: GoogleFonts.dongle(
                    color: Colors.white, fontSize: sizeText)),
            Text('20 episodios',
                style:
                    GoogleFonts.dongle(color: Colors.white, fontSize: sizeText))
          ],
        )
      ],
    );
  }
}
