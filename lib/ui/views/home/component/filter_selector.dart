import 'package:flutter/material.dart';
import 'package:movie_app/ui/views/home/component/filter_chips.dart';
import 'package:movie_app/ui/views/home/home_viewmodel.dart';

class FilterSelector extends StatelessWidget {
  final HomeViewModel viewModel;
  const FilterSelector({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return FilterChips(
      availableFilters: const [
        MovieFilter.nowPlaying,
        MovieFilter.upComing,
        MovieFilter.topRated,
        MovieFilter.popular
      ],
      selectedFilter: viewModel.selectedFilter,
      onSelected: (filter) {
        viewModel.setFilter(filter);
      },
    );
  }
}
