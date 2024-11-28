import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/ui/common/app_colors.dart';

class TopMovies extends StatelessWidget {
  final int index;
  final int dataLength;
  final String posterPath;
  const TopMovies({
    super.key,
    required this.index,
    required this.dataLength,
    required this.posterPath,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 175,
          padding: EdgeInsets.fromLTRB(
            index == 0 ? 16 : 16 / 2,
            0,
            index == dataLength ? 16 : 16 / 2,
            0,
          ),
          child: Card(
            semanticContainer: true,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            elevation: 10,
            shadowColor: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: SizedBox(
              height: 250,
              child: Image.network(
                'https://image.tmdb.org/t/p/w500/$posterPath',
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Positioned(
          bottom: -20,
          left: 5,
          child: Text(
            '${index + 1}',
            style: GoogleFonts.montserrat(
              textStyle: const TextStyle(
                color: kcTextRankingColor,
                fontSize: 72,
                fontWeight: FontWeight.w700,
                shadows: [
                  Shadow(
                    offset: Offset(2.0, 2.0),
                    blurRadius: 25.0,
                    color: Colors.black,
                  ),
                  Shadow(
                    // bottomLeft
                    offset: Offset(-0.1, -0.1),
                    color: kcTextRankingStrokeColor,
                  ),
                  Shadow(
                    // bottomRight
                    offset: Offset(0.1, -0.1),
                    color: kcTextRankingStrokeColor,
                  ),
                  Shadow(
                    // topRight
                    offset: Offset(0.1, 0.1),
                    color: kcTextRankingStrokeColor,
                  ),
                  Shadow(
                    // topLeft
                    offset: Offset(-0.1, 0.1),
                    color: kcTextRankingStrokeColor,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
