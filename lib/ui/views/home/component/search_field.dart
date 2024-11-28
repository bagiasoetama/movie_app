import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/ui/common/app_colors.dart';

class SearchField extends StatelessWidget {
  const SearchField({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      // width: double.infinity,
      // height: 52,
      decoration: BoxDecoration(
        color: kcTextSearchBgColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: GestureDetector(
        onTap: () {
          print("HELLOOO PRINTED");
        },
        child: TextField(
          enabled: false,
          style: GoogleFonts.poppins(
            textStyle: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
          decoration: InputDecoration(
            filled: true,
            fillColor: kcTextSearchBgColor,
            hintText: 'Search',
            hintStyle: GoogleFonts.poppins(
              textStyle: const TextStyle(
                color: kcTextSearchColor,
                fontSize: 12,
                fontWeight: FontWeight.w200,
              ),
            ),
            suffixIcon: const Icon(
              Icons.search,
              color: kcTextSearchColor,
              size: 20.0,
              semanticLabel: 'Text to announce in accessibility modes',
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),
    );
  }
}
