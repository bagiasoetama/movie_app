import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/ui/common/app_colors.dart';

class SearchNoResult extends StatelessWidget {
  const SearchNoResult({super.key});

  @override
  Widget build(BuildContext context) {
    const String sorry = '''We are sorry, we can
not find the movie :(''';
    const String find = '''Find your movie by Type title, 
    categories, years, etc''';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          "assets/images/no-results.png",
          height: 120,
          width: double.infinity,
        ),
        Text(
          sorry,
          style: GoogleFonts.montserrat(
            textStyle: const TextStyle(
              color: kcTextBrokenWhiteColor,
              fontSize: 15,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        SizedBox(height: 10),
        Text(
          find,
          style: GoogleFonts.montserrat(
            textStyle: const TextStyle(
              color: kcTextMutedColor,
              fontSize: 10,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
