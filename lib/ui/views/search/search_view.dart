import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/ui/common/app_colors.dart';
import 'package:movie_app/ui/views/search/component/search_bar_field.dart';
import 'package:movie_app/ui/views/search/component/search_movie_list.dart';
import 'package:movie_app/ui/views/search/component/search_no_result.dart';
import 'package:stacked/stacked.dart';

import 'search_viewmodel.dart';

class SearchView extends StackedView<SearchViewModel> {
  const SearchView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    SearchViewModel viewModel,
    Widget? child,
  ) {
    final searchMovieList = viewModel.movieSearchResponse?.results ?? [];
    final double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: kcColorFilterBackground,
      appBar: AppBar(
        title: Text(
          'Search',
          style: GoogleFonts.montserrat(
            textStyle: const TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        centerTitle: true,
        backgroundColor: kcColorFilterBackground,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          child: RefreshIndicator(
            onRefresh: () async {},
            child: searchMovieList.length == 0
                ? Column(
                    children: [
                      SearchBarField(viewModel: viewModel),
                      const SizedBox(height: 10),
                      const Expanded(
                        child: SearchNoResult(),
                      )
                    ],
                  )
                : SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SearchBarField(viewModel: viewModel),
                        const SizedBox(height: 10),
                        SearchMovieList(
                          searchMovieList: searchMovieList,
                          width: width,
                          itemsPerRow: 1,
                        ),
                      ],
                    ),
                  ),
          ),
        ),
      ),
    );
  }

  @override
  SearchViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      SearchViewModel();
}
