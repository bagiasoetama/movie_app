import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/ui/common/app_colors.dart';
import 'package:movie_app/ui/views/search/search_viewmodel.dart';

class SearchBarField extends StatelessWidget {
  final SearchViewModel viewModel;
  const SearchBarField({
    super.key,
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      child: TextField(
        controller: viewModel.searchController,
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
        onChanged: (query) {
          viewModel.searchMovie(query);
        },
      ),
    );
  }
}
