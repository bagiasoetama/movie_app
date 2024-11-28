import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/ui/common/app_colors.dart';
import 'package:movie_app/ui/views/search/component/search_icon_label.dart';

class SearchMovieDetail extends StatelessWidget {
  final String title;
  final String voteAverage;
  final String releaseDate;
  final String popularity;
  final String overview;
  const SearchMovieDetail({
    super.key,
    required this.title,
    required this.voteAverage,
    required this.releaseDate,
    required this.popularity,
    required this.overview,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 5),
        Text(
          title,
          style: GoogleFonts.poppins(
            textStyle: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        const SizedBox(height: 5),
        SearchIconLabel(
          text: voteAverage,
          icon: Icons.star_border,
          color: kcColorStar,
        ),
        const SizedBox(width: 5),
        SearchIconLabel(
          text: releaseDate,
          icon: Icons.calendar_today,
          color: Colors.white,
        ),
        const SizedBox(width: 5),
        SearchIconLabel(
          text: popularity,
          icon: Icons.remove_red_eye_outlined,
          color: Colors.white,
        ),
        const SizedBox(width: 5),
        Text(
          "Overview: ",
          style: GoogleFonts.poppins(
            textStyle: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Flexible(
          child: Text(
            overview,
            overflow: TextOverflow.ellipsis,
            maxLines: 6,
            style: GoogleFonts.poppins(
              textStyle: const TextStyle(
                color: Colors.white,
                fontSize: 8,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
