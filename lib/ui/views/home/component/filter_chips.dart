import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/ui/common/app_colors.dart';

enum MovieFilter { nowPlaying, upComing, topRated, popular }

class FilterChips extends StatelessWidget {
  final List<MovieFilter> availableFilters;
  final MovieFilter selectedFilter;
  final ValueChanged<MovieFilter> onSelected;

  const FilterChips({
    super.key,
    required this.availableFilters,
    required this.selectedFilter,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          children: availableFilters.map((filter) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 4.0),
              child: ChoiceChip(
                label: Text(
                  _getLabelForFilter(filter),
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                selected: selectedFilter == filter,
                onSelected: (selected) => onSelected(filter),
                showCheckmark: false,
                backgroundColor: kcColorFilterBackground,
                selectedColor: kcDarkGreyColor,
                shape: RoundedRectangleBorder(
                  side: BorderSide.none, // Menghapus semua border
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  String _getLabelForFilter(MovieFilter filter) {
    switch (filter) {
      case MovieFilter.nowPlaying:
        return 'Now Playing';
      case MovieFilter.popular:
        return 'Popular';
      case MovieFilter.topRated:
        return 'Top Rated';
      case MovieFilter.upComing:
        return 'Upcoming';
      default:
        return '';
    }
  }
}
